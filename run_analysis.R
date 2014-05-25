
#=======================================================
#    merging the data files   
#=======================================================

if (!file.exists("./merged")) {dir.create("./merged")};

# create tidy data


dfX1 <- read.table("./test/X_test.txt");
dfX2 <- read.table("./train/X_train.txt");
dfX  <- rbind(dfX1, dfX2);
write.table(dfX, "./merged/X_merged.txt")

dfY1 <- read.table("./test/Y_test.txt");
dfY2 <- read.table("./train/Y_train.txt");
dfY  <- rbind(dfY1, dfY2);
write.table(dfY, "./merged/Y_merged.txt")

df <- dfX
df$Activity <- dfY$V1

dfS1 <- read.table("./test/subject_test.txt");
dfS2 <- read.table("./train/subject_train.txt");
dfS  <- rbind(dfS1, dfS2);
write.table(dfS, "./merged/subject_merged.txt")

df$userID <- dfS$V1

# take the average
tidy <- aggregate( .~ Activity + userID, data = df, FUN = mean)

labels <- read.table("activity_labels.txt");

write.table(tidy, "./tidy.txt")


# merge other files
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
