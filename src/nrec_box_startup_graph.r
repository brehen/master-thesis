# Load necessary libraries
library(hrbrthemes)
library(jsonlite)
library(ggplot2)
library(dplyr)

# Function to load data from JSON and create a box plot
load_data_and_plot_box <- function(file_path) {
  # Read JSON data into a dataframe and flatten the nested 'metrics'
  data_raw <- fromJSON(file_path, flatten = TRUE)



  # Select and rename the metrics columns, convert types
  data <- data_raw %>%
    mutate(
      startup_time = as.numeric(metrics.startup_time),
      func_type = func_type,
      func_name = func_name,
      input = as.numeric(input)
    ) %>%
    select(startup_time, func_type, func_name, input)


  # Filter data for Docker environment
  docker_data <- data %>%
    filter(func_type == "Wasm") %>%
    filter(!(func_name == "fibonacci" | (func_name == "factorial" & input > 130) | (func_name == "exponential" & input > 710)))


  # Creating a ggplot with box plot
  gg <- ggplot(docker_data, aes(x = func_name, y = startup_time)) +
    geom_boxplot() +
    facet_wrap(~func_name, ncol = 2, scales = "free_y") +
    labs(x = "Function Name", y = "Startup Time (ms)", title = "Startup Time for Docker Functions") +
    theme_minimal()

  # Create dummy data
  data <- data.frame(
    cond = rep(c("condition_1", "condition_2"), each = 10),
    my_x = 1:100 + rnorm(100, sd = 9),
    my_y = 1:100 + rnorm(100, sd = 16)
  )

  # Basic scatter plot.
  p1 <- ggplot(data, aes(x = my_x, y = my_y)) +
    geom_point(color = "#69b3a2") +
    theme_ipsum()

  # with linear trend
  p2 <- ggplot(data, aes(x = my_x, y = my_y)) +
    geom_point() +
    geom_smooth(method = lm, color = "red", se = FALSE) +
    theme_ipsum()

  # linear trend + confidence interval
  p3 <- ggplot(data, aes(x = my_x, y = my_y)) +
    geom_point() +
    geom_smooth(method = lm, color = "red", fill = "#69b3a2", se = TRUE) +
    theme_ipsum(base_size = 18)
  print(p3)
}

# Example of using the function

# Example of using the function
load_data_and_plot_box("../thesis/assets/metrics/nrec_energy_data.json")
