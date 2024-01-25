parent_dir = "/home/rebecca/Documents/mibi/Rosetta_Compensated_Images/";

input = "combined_images/";
output = "stitched_brightened/"; 

out_path = parent_dir + input + output;

if (!File.exists(out_path)) {
    File.makeDirectory(out_path);
    print("Directory created: " + out_path);
} else {
    print("Directory already exists: " + out_path);
}

function incr_brightness_label(input, output, filename){
    open(parent_dir + input + filename);
    getRawStatistics(nPixels, mean, min, max, std, histogram);
    max_mod = (max/4);
    setMinAndMax(min, max_mod);

    width = getWidth;
    width_4 = width/4;
    width_3 = width/3;

    setFont("Arial", 80, "plain");
    setColor("white");
    drawString(filename, 25, 95);

    bottom_loc = 2023;
    if (width == 8192) {
    drawString("v6", 25, bottom_loc);
    drawString("v7", width_4+25, bottom_loc);
    drawString("raw", width_4*2+25, bottom_loc);
    drawString("noodle_120", width_4*3+25, bottom_loc);
    } else {
    drawString("raw", 25, bottom_loc);
    drawString("v7", width_3+25, bottom_loc);
    drawString("noodle_120", width_3*2+25, bottom_loc);
    }


    run("8-bit");
    saveAs("Tiff", out_path + filename);
    close();
}

setBatchMode(true);
list = getFileList(parent_dir + input);
for (i = 0; i < list.length; i++){
    incr_brightness_label(input, output, list[i]);
}
setBatchMode(false);

print("Done! (:"
