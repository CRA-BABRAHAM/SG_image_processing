// Define the directory containing the ND2 files
dir = getDirectory("/Users/beliavsa/Library/CloudStorage/OneDrive-BABRAHAM/experiments/OOPS_AB025_CN_WT_and_G3Bp1_KO/z-stacks");

// Get a list of all files in the directory
list = getFileList(dir);

// Loop through all files in the directory
for (i = 0; i < list.length; i++) {
    // Check if the file has the ND2 extension
    filePath = dir + list[i];
    run("Bio-Formats Importer", "open=[" + filePath + "] color_mode=Composite split_channels view=Hyperstack stack_order=XYCZT open_files");
    selectWindow(list[i] + " - C=0");
	saveAs("Tiff", dir + "/test/" + list[i] + "_Zproj_DAPI.tiff");
	close();
	selectWindow(list[i] + " - C=1");
	saveAs("Tiff", dir + "/test/" + list[i] + "_Zproj_G3BP1.tiff");
	close();
	selectWindow(list[i] + " - C=2");
	saveAs("Tiff", dir + "/test/" + list[i] + "_Zproj_HUR.tiff");
	close();
	selectWindow(list[i] + " - C=3");
	saveAs("Tiff", dir + "/test/" + list[i] + "_Zproj_CD19.tiff");
	close();
}