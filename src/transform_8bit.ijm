parent_dir = 

output = "8bit/"; 

dir = "/home/rebecca/Downloads/2023-10-26-PROJ80-PAN82-SLD126-DSCOLAB/Noodle_120_n_o_n_e_addedchannels_multiplenoodle_matrix_v7_1_1_mult_0.5/";
setBatchMode(true);
count = 0;
countFiles(dir);
n = 0;
processFiles(dir);
print(count+" files processed");

function countFiles(dir) {
  list = getFileList(dir);
  for (i=0; i<list.length; i++) {
    if (endsWith(list[i], "/"))
      countFiles(""+dir+list[i]);
    else
      count++;
  }
}

function processFiles(dir) {
  list = getFileList(dir);
  for (i=0; i<list.length; i++) {
    if (endsWith(list[i], "/"))
      processFiles(""+dir+list[i]);
    else {
      showProgress(n++, count);
      path = dir+list[i];
      processFile(path);
    }
  }
}

function processFile(path) {
  if (endsWith(path, ".tif")) {
    open(path);
    run("8-bit");
    save(path);
    close();
  }
}

print("Done! (:");
