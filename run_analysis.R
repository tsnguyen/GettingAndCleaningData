
#=======================================================
#    merging the data files   
#=======================================================

if (!file.exists("./merged")) {dir.create("./merged")};
df1 = read.table("./test/X_test.txt");
df2 = read.table("./train/X_train.txt");
write.table(rbind(df1, df2), "./merged/X_merged.txt")

df1 = read.table("./test/Y_test.txt");
df2 = read.table("./train/Y_train.txt");
write.table(rbind(df1, df2), "./merged/Y_merged.txt")

df1 = read.table("./test/subject_test.txt");
df2 = read.table("./train/subject_train.txt");
write.table(rbind(df1, df2), "./merged/subject_merged.txt")

if (!file.exists("./merged/Inertial Signals")) {dir.create("./merged/Inertial Signals")}

pathTest  = "./test/Inertial Signals";
pathTrain = sub("test", "train",  pathTest);
pathMerged= sub("test", "merged", pathTest);

inertListTest = list.files(pathTest)
for (fileTest in inertList){
    df1       = read.table(paste(pathTest, fileTest, sep = "/"));
    fileTrain = sub("test", "train", fileTest);
    df2       = read.table(paste(pathTrain, fileTrain, sep = "/"));    
    fileMerged= sub("test", "merged", fileTest);
    write.table(rbind(df1, df2), paste(pathMerged, fileMerged, sep = "/"));
}
