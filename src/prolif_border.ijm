dirPath = "C:\\Users\\rebecca\\Desktop\\prolif-border\\image_data\\";
print(dirPath);

// Get a list of directories
fov_list = getFileList(dirPath);

for (i = 0; i < fov_list.length; i++) {
    print(fov_list[i]);
    
    open(dirPath + fov_list[i] + "/segmentation_borders.tiff");
    open(dirPath + fov_list[i] + "/KRT5_brightened.tiff");
    open(dirPath + fov_list[i] + "/Ki-67_brightened.tiff");
    open(dirPath + fov_list[i] + "/FoxP3_AF488_brightened.tiff");
    open(dirPath + fov_list[i] + "/CD3_brightened.tiff");
    open(dirPath + fov_list[i] + "/dsDNA_brightened.tiff");

    // Red: Channel 1
    // Green: Channel 2
    // Blue: Channel 3
    // Grey: Channel 4
    // Cyan: Channel 5
    // Magenta: Channel 6
    // Yellow: Channel 7
    
    // Merge channels
    run("Merge Channels...", "c4=segmentation_borders.tiff c5=KRT5_brightened.tiff c6=Ki-67_brightened.tiff create keep");
    run("RGB Color");
    saveAs(dirPath + fov_list[i] + "/krt5_cyan_ki67_mag_seg_composite_image.tif");

    run("Merge Channels...", "c3=dsDNA_brightened.tiff c4=segmentation_borders.tiff create keep");
    run("Merge Channels...", "c3=dsDNA_brightened.tiff c4=segmentation_borders.tiff create keep");
    run("RGB Color");
    saveAs(dirPath + fov_list[i] + "/dsDNA_blue_seg_composite_image.tif");

    run("Merge Channels...", "c2=FoxP3_AF488_brightened.tiff c4=segmentation_borders.tiff c7=CD3_brightened.tiff create keep");
    run("RGB Color");
    saveAs(dirPath + fov_list[i] + "/foxp3_green_cd3_yellow_seg_composite_image.tif");
    close("*");
}
