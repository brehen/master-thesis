library(jsonlite)
library(hrbrthemes)
library(ggplot2)
library(dplyr)
library(scales)
library(kableExtra)
library(tidyr)
library(stringr)
library(ggpattern)

nrec_data_raw <- fromJSON("../thesis/assets/metrics/nrec_energy_data.json", flatten = TRUE)
rpi_data_raw <- fromJSON("../thesis/assets/metrics/rpi_energy_data_0_5_0.json", flatten = TRUE)

nrec_data <- nrec_data_raw %>%
  mutate(
    startup_time = as.numeric(metrics.startup_time) / 1000,
    runtime = as.numeric(metrics.total_runtime - metrics.startup_time) / 1000,
    total_runtime = as.numeric(metrics.total_runtime) / 1000,
    func_type = func_type,
    func_name = func_name,
    input = as.numeric(input),
    source = "nrec"
  ) %>%
  select(
    startup_time, runtime, total_runtime, func_type, func_name, input,
    source
  )


nrec_data <- nrec_data %>%
  filter(!(func_name == "fibonacci-recursive" & input > 30)) %>%
  filter(!(func_name == "prime-number" & input > 1500))

nrec_avg_data <- nrec_data %>%
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



rpi_data <- rpi_data_raw %>%
  mutate(
    startup_time = as.numeric(metrics.startup_time) / 1000,
    runtime = as.numeric(metrics.total_runtime - metrics.startup_time) / 1000,
    total_runtime = as.numeric(metrics.total_runtime) / 1000,
    average_power = as.double(metrics.average_power),
    energy_consumption_wh = as.double(metrics.energy_consumption_wh) * 1000 * 1000,
    func_type = func_type,
    func_name = func_name,
    input = as.numeric(input),
    source = "rpi"
  ) %>%
  select(startup_time, runtime, total_runtime, average_power, energy_consumption_wh, func_type, func_name, input, source)

rpi_data <- rpi_data %>%
  filter(!(func_name == "fibonacci-recursive" & input > 30)) %>%
  filter(!(func_name == "prime-number" & input > 1500))



kbl_nrec <- kbl(nrec_table,
  booktabs = T,
  caption = "Comparison of Wasm vs. Docker cold starts for rpi.\\\\label{tab:rpi}",
  align = "lrrr",
) %>%
  kableExtra::kable_styling(
    full_width = T,
    latex_options = c("HOLD_position", "striped")
  )

print(kbl_nrec)




rpi_avg_data <- rpi_data %>%
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


kbl_rpi <- kbl(rpi_table,
  booktabs = T,
  caption = "Comparison of Wasm vs. Docker cold starts for rpi.\\\\label{tab:rpi}",
  align = "lrrr",
) %>%
  kableExtra::kable_styling(
    full_width = T,
    latex_options = c("HOLD_position", "striped")
  )

print(kbl_rpi)
