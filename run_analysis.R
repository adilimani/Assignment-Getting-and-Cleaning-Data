##Downloading and unzipping the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./data/Assignment1.zip")
unzip("./data/Assignment1.zip",exdir="./data")
setwd("./UCI HAR Dataset")


##Loading libraries that are used in this code
library(dplyr); library(stringr);


##Importing Test Data files
X_test=read.delim("./test/X_test.txt",header=FALSE,sep="",blank.lines.skip = TRUE)
Y_test=read.delim("./test/Y_test.txt",header=FALSE,sep=" ",blank.lines.skip = TRUE)
subject_test=read.delim("./test/subject_test.txt",header=FALSE,sep=" ",blank.lines.skip = TRUE)


##Importing Train Data files
X_train=read.delim("./train/X_train.txt",header=FALSE,sep="",blank.lines.skip = TRUE)
Y_train=read.delim("./train/Y_train.txt",header=FALSE,sep=" ",blank.lines.skip = TRUE)
subject_train=read.delim("./train/subject_train.txt",header=FALSE,sep=" ",blank.lines.skip = TRUE)


## Merging the subject, activity, and training set for the test and train datasets
testMerge=cbind(subject_test,Y_test,X_test)
trainMerge=cbind(subject_train,Y_train,X_train)


#Combining the Test and Train Data into one data set
AllMerge=rbind(testMerge,trainMerge)


##Import the measure names and format them to look neat
features=read.delim("features.txt",header=FALSE,sep="",blank.lines.skip = TRUE)

Measures=as.vector(features[,2])

Measures=gsub("()","",Measures,fixed=TRUE);
Measures=gsub("("," ",Measures,fixed=TRUE); 
Measures=gsub(")"," ",Measures,fixed=TRUE);
Measures=gsub(","," and ",Measures,fixed=TRUE);
Measures=gsub("-"," ",Measures,fixed=TRUE);

Measures=gsub("^t","time ",Measures)
Measures=gsub("^f","frequency ",Measures)

names(AllMerge)<-c("Subject","Activity",Measures) #Appropriate column names for master dataset


## Inserting activity names in Activity columns
activity_labels=read.delim("activity_labels.txt",header=FALSE,sep="",blank.lines.skip = TRUE)
activity_labels$V2=gsub("_"," ",activity_labels$V2,fixed=TRUE);
AllMerge[,2] <- activity_labels$V2[AllMerge[,2]]


##Only selecting columns containing "mean()" or "sd()"
OnlyMeanSD=AllMerge[,c(1:8,43:48,83:88,123:128,163:168,203,204,216,217,229,230,242,243,255,256,268:273,
                       347:352,426:431,505,506,518,519,531,532,544,545)]


##Summarizing data such that only one entry per Subject/Activity combination
BySubjectActivity <- group_by(OnlyMeanSD,Subject,Activity)
TidyOutput <- summarize_each(BySubjectActivity,funs(mean))

##Export final tidy data
write.table(TidyOutput,file="./Final_Output.txt",row.names = FALSE)
