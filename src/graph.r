library(tidyverse)
library(tidyjson)


wasm_data <- as.tbl_json(read_json("../data/wasm-0.2.1.json"))
docker_data <- as.tbl_json(read_json("../data/docker-0.2.1.json"))

data_frame <-
  docker_data %>%
  gather_array() %>%
  spread_all() %>%
  filter(func_name != "fibonacci-recursive") %>%
  filter(as.numeric(input) <= 20)


average <- data_frame %>%
  group_by(base_image, func_name) %>%
  summarise(
    avg_startup = mean(startup_time),
    avg_total_time = mean(total_runtime),
  ) %>%
  mutate(avg_runtime = avg_total_time - avg_startup) %>%
  pivot_longer(
    cols = c(avg_startup, avg_runtime),
    names_to = "time_type",
    values_to = "time_value"
  )

average




# ggplot(average, aes(x = func_name, y = avg_runtime, fill = func_name)) +
#   geom_bar(stat = "identity", position = "dodge") +
#   theme_minimal() +
#   labs(
#     title = "Average runtime by Function",
#     x = "Function Name",
#     y = "Average Runtime (us)"
#   ) +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#   scale_fill_viridis_d(begin = 0.5, end = 1, option = "C")
#
#
# ggplot(long_average, aes(x = func_name, y = time_value, fill = time_type)) +
#   geom_bar(stat = "identity", position = "stack") +
#   scale_fill_manual(
#     values = c("avg_startup" = "skyblue", "avg_runtime" = "orange")
#   ) +
#   theme_minimal() +
#   labs(
#     title = "Average Startup and Runtime by Function",
#     x = "Function Name",
#     y = "Time (μs)",
#     fill = "Time Type"
#   ) +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1))
#
# ggplot(long_average, aes(x = time_type, y = time_value, fill = time_type)) +
#   geom_bar(stat = "identity", position = "dodge") +
#   facet_wrap(~func_name) + # Create a separate plot for each function
#   labs(
#     title = "Startup vs. Runtime for WebAssembly Functions",
#     x = "", y = "Time (μs)"
#   ) +
#   theme_minimal() +
#   scale_fill_manual(values = c("avg_startup" = "skyblue", "avg_runtime" = "orange"))
