# Load necessary libraries
library(hrbrthemes)
library(jsonlite)
library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)

# Function to load data from JSON and create a box plot
load_data_and_plot_box <- function(file_path) {
  # Read JSON data into a dataframe and flatten the nested 'metrics'
  data_raw <- fromJSON(file_path, flatten = TRUE)


  # Select and rename the metrics columns, convert types
  data <- data_raw %>%
    mutate(
      startup_time = metrics.startup_time,
      runtime = metrics.total_runtime - metrics.startup_time,
      total_runtime = metrics.total_runtime,
      func_type = func_type,
      func_name = func_name,
      input = as.numeric(input)
    ) %>%
    select(startup_time, total_runtime, runtime, func_type, func_name, input)

  data <- data %>%
    # filter(func_type == "Wasm") %>%
    filter(!(func_name == "fibonacci-recursive" & input > 30)) %>%
    filter(!(func_name == "prime-number" & input > 1500))

  print(data[100, c("runtime", "total_runtime", "input")])

  # Filter data for Docker environment
  # docker_data <- data %>%
  #   # filter(func_type == "Wasm") %>%
  #   filter(!(func_name == "fibonacci" | (func_name == "factorial" & input > 130) | (func_name == "exponential" & input > 710)))


  averaged_data <- data %>%
    group_by(func_name, func_type) %>%
    summarize(
      avg_startup_time = round(median(startup_time)),
      avg_runtime = round(median(runtime))
    ) %>%
    ungroup() %>%
    pivot_longer(cols = c("avg_runtime", "avg_startup_time"), names_to = "metric", values_to = "value") %>%
    mutate(Metric = case_when(
      metric == "avg_startup_time" & func_type == "Docker" ~ "Docker Startup",
      metric == "avg_runtime" & func_type == "Docker" ~ "Docker Runtime",
      metric == "avg_startup_time" & func_type == "Wasm" ~ "Wasm Startup",
      metric == "avg_runtime" & func_type == "Wasm" ~ "Wasm Runtime",
    ))

  print(head(averaged_data))


  # Creating a ggplot with stacked bar chart
  gg <- ggplot(averaged_data, aes(x = interaction(func_name, func_type), y = value / 1000, fill = Metric)) +
    geom_col(position = "stack") +
    ggtitle("Startup and Runtimes on NREC virtual machine") +
    scale_x_discrete(labels = c("Exponential", "Factorial", "Fibonacci", "Prime\nNumber")) +
    scale_fill_manual(values = c("Docker Startup" = "#089CEC", "Wasm Startup" = "#6B54F1", "Docker Runtime" = "#EC5808", "Wasm Runtime" = "#F1548C")) +
    facet_wrap(~func_type, scales = "free") +
    labs(x = "Function Name", y = "Time (ms)") +
    theme_ipsum(base_family = "Avenir", base_size = 20, axis_text_size = 18, plot_title_size = 24, axis_title_size = 20, strip_text_size = 30) +
    theme(legend.position = "bottom")

  print(gg)
}

# Example of using the function

# Example of using the function
load_data_and_plot_box("../thesis/assets/metrics/nrec_energy_data.json")
