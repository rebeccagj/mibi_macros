// Macro to process each directory
macro "Process Directories" {
    // Define the directory path
    dirPath = getDirectory("Select a directory containing TIFF files");
    setBatchMode(true);

    // Get a list of directories
    list = getFileList(dirPath);

    // Loop through each directory
    for (i = 0; i < list.length; i++) {
        dir = list[i];
        if(File.isDirectory(dirPath + dir)) {
            processDirectory(dirPath, dir);
        }
    }
}

// Function to process a single directory
function processDirectory(dirPath, dir) {
    print("Processing directory: " + dirPath + dir);
    // Get a list of files in the directory
    dirFile = File(dirPath + dir);
    if (dirFile.isDirectory()) {
        fileList = dirFile.listFiles();
        if (fileList != null) {
            print("Found files: " + fileList.length);
            // Initialize filenames
            segBordersFilename = "";
            krt5Filename = "";
            ki67Filename = "";
            foxp3Filename = "";
            cd3Filename = "";
            dsDNADFilename = "";

            // Loop through files to find matching filenames
            for (file in fileList) {
                filename = file.getName();
                if (filename.endsWith("segmentation_borders.tiff")) {
                    segBordersFilename = filename;
                } else if (filename.endsWith("KRT5_brightened.tiff")) {
                    krt5Filename = filename;
                } else if (filename.endsWith("Ki-67_brightened.tiff")) {
                    ki67Filename = filename;
                } else if (filename.endsWith("FoxP3_AF488_brightened.tiff")) {
                    foxp3Filename = filename;
                } else if (filename.endsWith("CD3_brightened.tiff")) {
                    cd3Filename = filename;
                } else if (filename.endsWith("dsDNA_brightened.tiff")) {
                    dsDNADFilename = filename;
                }
            }

            // Merge channels and save composite images
            mergeAndSaveComposite(dirPath, dir, segBordersFilename, krt5Filename, ki67Filename, foxp3Filename, cd3Filename, dsDNADFilename);
        } else {
            print("No files found in the directory: " + dirPath + dir);
        }
    } else {
        print("Not a directory: " + dirPath + dir);
    }
}

// Function to merge channels and save composite images
function mergeAndSaveComposite(dirPath, dir, segBordersFilename, krt5Filename, ki67Filename, foxp3Filename, cd3Filename, dsDNADFilename) {
    run("Merge Channels...", "c4=" + segBordersFilename + " c5=" + krt5Filename + " c6=" + ki67Filename + " create keep");
    run("RGB Color");
    saveAs(dirPath + dir + "/krt5_ki67_seg_composite_image.tif");
    run("Merge Channels...", "c3=" + dsDNADFilename + " c4=" + segBordersFilename + " create keep");
    run("RGB Color");
    saveAs(dirPath + dir + "/dsDNA_seg_composite_image.tif");
    run("Merge Channels...", "c2=" + foxp3Filename + " c4=" + segBordersFilename + " c7=" + cd3Filename + " create keep");
    run("RGB Color");
    saveAs(dirPath + dir + "/foxp3_cd3_seg_composite_image.tif");
}
