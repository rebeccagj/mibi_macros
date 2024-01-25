fov_dir_list = newArray(0);

exp_dir = "/home/rebecca/Documents/mibi/toffy_dirs/Rosetta_Compensated_Images/v9_2/2023-12-12-PROJ88-PAN82-SLD142_ConnieTCF1Check_DSCOLAB/";

// Add items to the list
for (var i = 2; i <= 11; i++) {
    fov_dir_list = Array.concat(fov_dir_list, exp_dir + "fov-" + i + "-scan-1/");
}
Array.print(fov_dir_list);

function incr_brightness_8bit(source_dir, save_dir, filename){
    open(source_dir + filename);
    getRawStatistics(nPixels, mean, min, max, std, histogram);
    max_mod = (max/4);
    setMinAndMax(min, max_mod);
    run("8-bit");
    saveAs("Tiff", save_dir + filename);
    close();
}

// Print the list
print("begining brightening:");
setBatchMode(true);
for (i = 0; i < fov_dir_list.length; i++) {
    source_dir = fov_dir_list[i]+"rescaled/";
    save_dir = fov_dir_list[i]+"brightened/";

    if (!File.exists(save_dir)) {
        File.makeDirectory(save_dir);
        print("Directory created: " + save_dir);
    } else {
        print("Directory already exists: " + save_dir);
    }

    tiff_list = getFileList(source_dir);
    
    for (k = 0; k < tiff_list.length; k++) {
        incr_brightness_8bit(source_dir, save_dir, tiff_list[k]);
    }
}
setBatchMode(false);
