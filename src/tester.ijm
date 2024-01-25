fov_dir_list = newArray(0);

exp_dir = "/home/rebecca/Documents/mibi/toffy_dirs/Rosetta_Compensated_Images/v8_2/2023-12-01-PROJ88-PAN82-SLD138-TMA10Titration-DSCOLAB/";

// Add items to the list
fov_dir_list = Array.concat(fov_dir_list, exp_dir+"fov-10-scan-1/");
fov_dir_list = Array.concat(fov_dir_list, exp_dir+"fov-11-scan-1/");
fov_dir_list = Array.concat(fov_dir_list, exp_dir+"fov-2-scan-1/");
fov_dir_list = Array.concat(fov_dir_list, exp_dir+"fov-2-scan-1/");
fov_dir_list = Array.concat(fov_dir_list, exp_dir+"fov-3-scan-1/");
fov_dir_list = Array.concat(fov_dir_list, exp_dir+"fov-4-scan-1/");
fov_dir_list = Array.concat(fov_dir_list, exp_dir+"fov-5-scan-1/");
fov_dir_list = Array.concat(fov_dir_list, exp_dir+"fov-6-scan-1/");
fov_dir_list = Array.concat(fov_dir_list, exp_dir+"fov-8-scan-1/");
fov_dir_list = Array.concat(fov_dir_list, exp_dir+"fov-9-scan-1/");

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