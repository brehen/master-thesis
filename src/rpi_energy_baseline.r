# Load necessary libraries
library(hrbrthemes)
library(jsonlite)
library(ggplot2)
library(dplyr)

# Function to load data from JSON and create a scatter plot with bubble size
load_data_and_plot_scatter <- function(data) {
  # Read JSON data into a dataframe and flatten the nested 'metrics'



  # # Select and rename the metrics columns, convert types
  # data <- data_raw %>%
  #   mutate(
  #     startup_time = as.numeric(metrics.startup_time) / 1000,
  #     total_runtime = as.numeric(metrics.total_runtime) / 1000,
  #     func_type = func_type,
  #     func_name = func_name,
  #     input = as.numeric(input)
  #   ) %>%
  #   select(startup_time, total_runtime, func_type, func_name, input)

  # Filter data for Docker environment and apply specified conditions
  docker_data <- data %>%
    # filter(func_type == "Wasm") %>%
    # filter(!(func_name == "fibonacci" | (func_name == "factorial" & input > 130) | (func_name == "exponential" & input > 710))) %>%
    group_by(func_name) %>%
    mutate(input_percent = input / max(input) * 100) %>%
    ungroup()


  print(head(docker_data))

  # Creating a ggplot with scatter plot and bubble size
  gg <- ggplot(docker_data, aes(x = input, y = total_runtime, color = func_type)) +
    geom_point(alpha = 0.4) + # Adjust transparency with alpha
    ggtitle("") +
    scale_color_manual(values = c("Docker" = "#089CEC", "Wasm" = "#6B54F1")) +
    geom_smooth(aes(label = func_type),
      fill = "#69b3a2",
      method = "loess", formula = y ~ x,
      size = 3, linewidth = 1, boxlinewidth = 0.4,
      se = TRUE
    ) +
    labs(
      x = "Input", y = "Total execution time (ms)", color = "Function Type",
    ) +
    facet_wrap(~func_name, scales = "free") +
    theme_ipsum(base_size = 30, caption_size = 30, axis_title_size = 24, plot_title_size = 24, strip_text_size = 25) +
    theme(legend.position = "bottom")

  # gg <- gg +
  #   guides(color = guide_legend(override.aes = list(
  #     shape = rep("square", length(unique(docker_data$func_type))),
  #     size = 5,
  #     keywidth = 2,
  #     keyheight = 2,
  #     fill = c("#089CEC", "#6B54F1") # Color squares according to your palette
  #   )))

  print(gg)
}

print_power_graph <- function(data_set, title) {
  gg <- ggplot(data_set, aes(
    x = input, y = average_power_isolated, color = func_type,
    shape = func_type
  )) +
    geom_point(alpha = 0.15) + # Adjust transparency with alpha
    ggtitle(title) +
    scale_shape_manual(values = c("Docker" = 3, "Wasm" = 16), name = "") +
    scale_color_manual(values = c("Docker" = "#089CEC", "Wasm" = "#6B54F1")) +
    geom_smooth(
      method = "loess", formula = y ~ x, size = 3, linewidth = 2, boxlinewidth = 0.9, se = TRUE
    ) +
    labs(
      x = "Input (n)", y = "Power in Watts (W)", color = "Function Type",
    ) +
    # facet_wrap(~func_name, scales = "free", labeller = function_labeller) +
    theme_ipsum() +
    guides(
      shape = guide_legend(
        override.aes = list(color = c("#089CEC", "#6B54F1")),
        title = "Function Type",
        label = c("Docker", "Wasm"),
        keywidth = 2,
        keyheight = 1,
        byrow = TRUE,
        nrow = 1
      )
    ) +
    theme(legend.position = "bottom")

  print(gg)
}

print_energy_graph <- function(data_set, title) {
  gg <- ggplot(data_set, aes(x = input, y = energy_consumption_isolated_wh, color = func_type, shape = func_type)) +
    geom_point(alpha = 0.15) + # Adjust transparency with alpha
    ggtitle(title) +
    scale_color_manual(values = c("Docker" = "#089CEC", "Wasm" = "#6B54F1")) +
    scale_shape_manual(values = c("Docker" = 3, "Wasm" = 16), name = "") +
    geom_smooth(
      fill = "#69b3a2",
      method = "loess", formula = y ~ x,
      size = 3, linewidth = 2, boxlinewidth = 0.4,
      se = TRUE
    ) +
    labs(
      x = "Input (n)", y = "Energy in microwatt-hours (μWh)", color = "Function Type",
    ) +
    theme_ipsum() +
    theme(legend.position = "bottom") +
    guides(shape = guide_legend(override.aes = list(fill = c(
      "#089CEC",
      "#EC5808"
    ), size = 5)))

  print(gg)
}

rpi_data_raw <- fromJSON("thesis/assets/metrics/rpi_energy_data_0_5_0.json", flatten = TRUE)

rpi_data <- rpi_data_raw %>%
  mutate(
    startup_time = as.numeric(metrics.startup_time) / 1000,
    runtime = as.numeric(metrics.total_runtime - metrics.startup_time) / 1000,
    total_runtime = as.numeric(metrics.total_runtime) / 1000,
    average_power = as.double(metrics.average_power),
    average_power_isolated = as.double(metrics.average_power_isolated),
    energy_consumption_wh = as.double(metrics.energy_consumption_wh) * 1000 * 1000,
    energy_consumption_isolated_wh = as.double(metrics.energy_consumption_isolated_wh) * 1000 * 1000,
    func_type = func_type,
    func_name = func_name,
    input = as.numeric(input),
    source = "rpi"
  ) %>%
  select(startup_time, runtime, total_runtime, average_power,average_power_isolated, energy_consumption_wh, energy_consumption_isolated_wh, func_type, func_name, input, source)

function_labeller <- function(variable, value) {
  value <- str_replace(value, "fibonacci-recursive", "Fibonacci")
  value <- str_replace(value, "exponential", "Exponential")
  value <- str_replace(value, "factorial", "Factorial")
  value <- str_replace(value, "prime-number", "Prime Number")
  return(value)
}

rpi_data <- rpi_data %>%
  filter(func_name == "fibonacci-recursive")


print_power_graph(rpi_data, "Isolated Power drawn during Fibonacci functions")
