# SG_image_processing
Confocal images analysed by CellProfiler to locate stress granules (or other cellular structures) and R scripts for statistical analysis of them.

## Titrating antibodies
If dealing with z-stack images in .nd2 file format (captured with Nikon microscopes), start with 01_fiji_macro_process_Nikon_nd2_for_CP.ijm to create tiff files with z-projections for each channel and follow with 02_CP_measure_intensities.cppipe.

If imaging with HT.ai omit FiJi script and start with 02_CP_measure_intensities.cppipe.

To assess the overall signal intensity per cell per sample, follow the instructions in 03_Intensities_graphs.Rmd or 03_Intensity_graphs.R.
