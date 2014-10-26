## This is the R script to create a tidy dataset from wearble computing dataset found at
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## The script assumes this dataset has been extracted into your working directory

## The lines below read the data into R
features<-read.table("UCI HAR Dataset/features.txt",header=FALSE)
xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
ytrain<-read.table("UCI HAR Dataset/train/y_train.txt")
subtrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
subtest<-read.table("UCI HAR Dataset/test/subject_test.txt")
ytest<-read.table("UCI HAR Dataset/test/y_test.txt")

## These lines merges the data into one dataset called rawdata
test<-cbind(subtest,ytest)
rm("subtest","ytest")
train<-cbind(subtrain,ytrain)
rm("subtrain","ytrain")
dat2<-rbind(train,test)
rm("train","test")
dat<-rbind(xtrain,xtest)
rm("xtrain","xtest")
colnames(dat)<-features[,2]
rm("features")
colnames(dat2)<-c("Subject","Activity")
rawdata<-cbind(dat2,dat)
rm("dat2","dat")

## These lines extracts out only the measurement of Means and Standard Deviations
## and saves it as data frame selectdata
meanstd<-c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543,562:563)
selectdata<-rawdata[,meanstd]
rm("meanstd")

## These lines rename the Activity column in selectdata to readable names.
selectdata$Activity<-as.character(selectdata$Activity)
selectdata$Activity[selectdata$Activity=="1"] <- "WALKING"
selectdata$Activity[selectdata$Activity=="2"] <- "WALKING_UPSTAIRS"
selectdata$Activity[selectdata$Activity=="3"] <- "WALKING_DOWNSTAIRS"
selectdata$Activity[selectdata$Activity=="4"] <- "SITTING"
selectdata$Activity[selectdata$Activity=="5"] <- "STANDING"
selectdata$Activity[selectdata$Activity=="6"] <- "LAYING"

## These lines change the activity and subject columns of selectdata into factors
selectdata$Activity<-as.factor(selectdata$Activity)
selectdata$Subject<-as.factor(selectdata$Subject)

## These lines melt the dataset and dcasts it back into a tidy dataset called tidydata with
## the average of each variable by each activity and each subject.
library(reshape2)
datamelt<-melt(selectdata,id=c("Subject","Activity"))
tidydata<-dcast(datamelt,Subject + Activity~variable,mean)
rm("datamelt")

## This line writes the tidy set to a file called tidydata.txt
write.table(tidydata,"tidydata.txt",row.name=FALSE)