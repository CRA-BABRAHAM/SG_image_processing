# SG_image_processing
Confocal images analysed by CellProfiler to locate stress granules (or other cellular structures) and R scripts for statistical analysis of them.

## Titrating antibodies
If dealing with z-stack images in .nd2 file format (captured with Nikon microscopes), start with 01_fiji_macro_process_Nikon_nd2_zstacks_for_CP.ijm to create tiff files with z-projections for each channel and follow with 02_CP_measure_intensities.cppipe.
If images only contain single plane, us 01_fiji_macro_process_Nikon_nd2_single_plane_for_CP script.

If imaging with HT.ai omit FiJi script and start with 02_CP_measure_intensities.cppipe.

To assess the overall signal intensity per cell per sample, follow the instructions in 03_Intensities_graphs.Rmd or 03_Intensity_graphs.R.

## Assesing number and distribution of stress granules
To visualise the disctribution of stress granules in cells use 04_plot_stress_granules.Rmd

![image](https://github.com/user-attachments/assets/3f4e978b-70e4-476c-9ce7-2ac78946a8c9)
