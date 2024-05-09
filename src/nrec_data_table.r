nrec_avg_data <- nrec_data %>%
  filter(!(func_name == "fibonacci-recursive" & input > 30)) %>%
  filter(!(func_name == "prime-number" & input > 1500) %>%
  group_by(func_type) %>%
  summarise(
    avg_startup_time = round(mean(startup_time), digits = 2),
    avg_runtime = round(mean(runtime), digits = 2),
    avg_total_runtime = round(mean(total_runtime), digits = 2),
  )

nrec_table <- data.frame(
  Docker = c(
    nrec_avg_data$avg_startup_time[nrec_avg_data$func_type == "Docker"],
    nrec_avg_data$avg_runtime[nrec_avg_data$func_type == "Docker"],
    nrec_avg_data$avg_total_runtime[nrec_avg_data$func_type == "Docker"]
  ),
  Wasm = c(
    nrec_avg_data$avg_startup_time[nrec_avg_data$func_type == "Wasm"],
    nrec_avg_data$avg_runtime[nrec_avg_data$func_type == "Wasm"],
    nrec_avg_data$avg_total_runtime[nrec_avg_data$func_type == "Wasm"]
  ),
  row.names = c("Cold start", "Runtime", "Total runtime")
)

nrec_table$`vs Docker` <- paste0(round(nrec_table$Docker / nrec_table$Wasm), "×")

nrec_table[, 1:2] <- sapply(nrec_table[, 1:2], function(x) paste0(x, " ms"))




kbl(nrec_table,
  booktabs = T,
  caption = "Comparison of Wasm vs. Docker cold starts for rpi.\\\\label{tab:rpi}",
  align = "lrrr",
) %>%
  kableExtra::kable_styling(
    full_width = T,
    latex_options = c("HOLD_position", "striped")
  )

