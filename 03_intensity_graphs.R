library(tidyverse)
library(purrr)
library(patchwork)

### 1.  Provide the script with the directory with Cell Profiler output files and the prefix in the title to remove
directory <- "~/Library/CloudStorage/OneDrive-BABRAHAM/experiments/OOPS_AB023_titration/tiff_for_cell_profiler"
prefix <- "OOPS_AB023_G3Bp1_intensities_"

### 2.  Read the files as tibbles and remove the prefix from the titles.

csv_files <- list.files(path = directory, pattern = ".csv", full.names = TRUE)

data_list <- map(csv_files, read_csv)

for (i in seq_along(csv_files)) {
  # Extract the file name without extension
  file_name <- tools::file_path_sans_ext(basename(csv_files[i]))
  # Assign the tibble to a variable with the file name
  assign(file_name, data_list[[i]])
}

# (optional) rename variables by removing the experiment prefix

var_names <- ls(pattern = prefix)
for (old_name in var_names) {
  # Generate the new name by removing "prefix"
  new_name <- gsub(prefix, "", old_name)
  
  # Use assign to rename the variable
  assign(new_name, get(old_name))
  rm(list = old_name)
}

rm(old_name, csv_files, data_list, directory, file_name, i, new_name, prefix, var_names)
ls()

### Filter the data and include metadata

DAPI_intensities <- nuclei |> select(ImageNumber, ObjectNumber, Intensity_IntegratedIntensity_DAPI)
#DAPI_intensities |> group_by(ImageNumber) |> count()

colnames(metadata)[2] <- "ImageNumber"
DAPI_intensities <- left_join(DAPI_intensities, metadata, by = "ImageNumber")
DAPI_intensities |> group_by(Name) |> count()

Abs_intensities <- Cells |> select(ImageNumber, ObjectNumber, Intensity_IntegratedIntensity_G3Bp1, Intensity_IntegratedIntensity_HUR, Intensity_IntegratedIntensity_TIAR)
Abs_intensities <- left_join(Abs_intensities, metadata, by = "ImageNumber")

### Create plots

DAPI_intensity_plot <- DAPI_intensities |> group_by(Name) |> summarize(Mean_DAPI_Intensity = mean(Intensity_IntegratedIntensity_DAPI), SD_DAPI_Intensity = sd(Intensity_IntegratedIntensity_DAPI)) |>  ggplot(aes(x = factor(Name), y = Mean_DAPI_Intensity)) + geom_bar(stat = "identity", fill="cornflowerblue") + labs(x = "Image Number", y = "Mean DAPI Intensity") + geom_errorbar(aes(ymin = Mean_DAPI_Intensity - SD_DAPI_Intensity, ymax = Mean_DAPI_Intensity + SD_DAPI_Intensity), width = 0.2)  + ggtitle("Mean DAPI Intensity per Cell") + theme_bw()

G3Bp1_intensities_plot <- Abs_intensities |> group_by(Name) |> summarize(Mean_G3Bp1_Intensity = mean(Intensity_IntegratedIntensity_G3Bp1), SD_G3Bp1_Intensity = sd(Intensity_IntegratedIntensity_G3Bp1)) |> ggplot(aes(x = factor(Name), y = Mean_G3Bp1_Intensity)) + geom_bar(stat = "identity") + labs(x = "Image Number", y = "Mean G3Bp1 Intensity") + geom_errorbar(aes(ymin = Mean_G3Bp1_Intensity - SD_G3Bp1_Intensity, ymax = Mean_G3Bp1_Intensity + SD_G3Bp1_Intensity), width = 0.2)  + ggtitle("Mean G3Bp1 Intensity per Cell") + theme_bw()

HuR_intensities_plot <- Abs_intensities |> group_by(Name) |> summarize(Mean_HuR_Intensity = mean(Intensity_IntegratedIntensity_HUR), SD_HuR_Intensity = sd(Intensity_IntegratedIntensity_HUR)) |>  ggplot(aes(x = factor(Name), y = Mean_HuR_Intensity)) + geom_bar(stat = "identity") + labs(x = "Image Number", y = "Mean HuR Intensity") + geom_errorbar(aes(ymin = Mean_HuR_Intensity - SD_HuR_Intensity, ymax = Mean_HuR_Intensity + SD_HuR_Intensity), width = 0.2)  + ggtitle("Mean HuR Intensity per Cell") + theme_bw()

TIAR_intensities_plot <- Abs_intensities |> group_by(Name) |> summarize(Mean_TIAR_Intensity = mean(Intensity_IntegratedIntensity_TIAR), SD_TIAR_Intensity = sd(Intensity_IntegratedIntensity_TIAR)) |>  ggplot(aes(x = factor(Name), y = Mean_TIAR_Intensity)) + geom_bar(stat = "identity") + labs(x = "Image Number", y = "Mean TIAR Intensity") + geom_errorbar(aes(ymin = Mean_TIAR_Intensity - SD_TIAR_Intensity, ymax = Mean_TIAR_Intensity + SD_TIAR_Intensity), width = 0.2)  + ggtitle("Mean TIAR Intensity per Cell") + theme_bw()

DAPI_intensity_plot / G3Bp1_intensities_plot / HuR_intensities_plot / TIAR_intensities_plot
