dir = getDirectory("Select a directory containing TIFF files");
output = "8bit/"; 

setBatchMode(true);
count = 0;
countFiles(dir);
n = 0;

processFiles(dir);
print(count + " files processed");

function countFiles(dir) {
  list = getFileList(dir);
  for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], "/"))
      countFiles("" + dir + list[i]);
    else
      count++;
  }
}

function processFiles(dir) {
  list = getFileList(dir);
  for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], "/"))
      processFiles("" + dir + list[i]);
    else {
      showProgress(n++, count);
      path = dir + list[i];
      processFile(path);
    }
  }
}

function processFile(path) {
  if (endsWith(path, ".tiff")) {
    x = path;
    print(x);
    open(path);
    getRawStatistics(nPixels, mean, min, max, std, histogram);
    max_mod = (max/3);
    setMinAndMax(min, max_mod);
    run("8-bit");
    
    x = x.replace("\.tiff", "_brightened.tiff"); // Amend the filename before saving
    print(x);
    saveAs(x);
    
    close();
  }
}

print("Done! (:");
