// Macro to process each directory
macro "Process Directories" {
    // Define the directory path
    dirPath = getDirectory("Select a directory containing TIFF files");
    
    // Get a list of directories
    list = getFileList(dirPath);

    seg_tiff_vec = newArray(
                "99_set3_fov3_T10-99a-2_segmentation_borders.tiff"
    );

    // Loop through each directory
    for (i = 0; i < 1; i++) {/*  */
        dir = list[i];
        if(File.isDirectory(dirPath + dir)) {
            // Open the images

            open(dirPath + dir + seg_tiff_vec[i]);
            open(dirPath + dir + "/KRT5_brightened.tiff");
            open(dirPath + dir + "/Ki-67_brightened.tiff");
            open(dirPath + dir + "/FoxP3_AF488_brightened.tiff");
            open(dirPath + dir + "/CD3_brightened.tiff");
            open(dirPath + dir + "/dsDNA_brightened.tiff");

            // Red: Channel 1
            // Green: Channel 2
            // Blue: Channel 3
            // Grey: Channel 4
            // Cyan: Channel 5
            // Magenta: Channel 6
            // Yellow: Channel 7
        }
    }
}
