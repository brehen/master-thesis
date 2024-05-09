rpi_table_data <- rpi_data %>%
  filter(!(func_name == "fibonacci-recursive" & input > 30)) %>%
  filter(!(func_name == "prime-number" & input > 1500))

rpi_avg_data <- rpi_table_data %>%
  group_by(func_type) %>%
  summarise(
    avg_startup_time = round(mean(startup_time), digits = 2),
    avg_runtime = round(mean(runtime), digits = 2), avg_energy_consumption_wh =
      round(mean(energy_consumption_wh), digits = 2)
  )

rpi_table <- data.frame(
  Docker = c(
    rpi_avg_data$avg_startup_time[rpi_avg_data$func_type == "Docker"],
    rpi_avg_data$avg_runtime[rpi_avg_data$func_type == "Docker"],
    rpi_avg_data$avg_energy_consumption_wh[rpi_avg_data$func_type == "Docker"]
  ),
  Wasm = c(
    rpi_avg_data$avg_startup_time[rpi_avg_data$func_type == "Wasm"],
    rpi_avg_data$avg_runtime[rpi_avg_data$func_type == "Wasm"],
    rpi_avg_data$avg_energy_consumption_wh[rpi_avg_data$func_type == "Wasm"]
  ),
  row.names = c("Cold start", "Runtime", "Energy consumption")
)

rpi_table$`vs Docker` <- paste0(round(rpi_table$Docker / rpi_table$Wasm), "×")


rpi_table[1:2, 1:2] <- sapply(rpi_table[1:2, 1:2], function(x) paste0(x, "ms"))
rpi_table[3, 1:2] <- sapply(rpi_table[3, 1:2], function(x) paste0(x, "μWh"))


kbl(rpi_table,
  booktabs = T,
  caption = "Comparison of Wasm vs. Docker cold starts for rpi.\\\\label{tab:rpi}",
  align = "lrrr",
) %>%
  kableExtra::kable_styling(
    full_width = T,
    latex_options = c("HOLD_position", "striped")
  )
