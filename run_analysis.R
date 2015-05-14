##Part1:load required packages for this project 
library(plyr)
library(dplyr)
library(gdata)

## Part2:read features and activity files 
features = read.table("./UCI HAR Dataset/features.txt")  
features=as.vector(features[,2])
activity_labels=read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity_labels) = c("Activity_id","Activity_type")

##Part3:Load and read data sets
x_test = read.table("./UCI HAR Dataset/test/X_test.txt")
names(x_test)=features
y_test=read.table("./UCI HAR Dataset/test/y_test.txt")
names(y_test)=c("Activity_id")
subject_test=read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test)=c("Subject")
x_train=read.table("./UCI HAR Dataset/train/x_train.txt")
names(x_train)=features
y_train=read.table("./UCI HAR Dataset/train/y_train.txt")
names(y_train)=c("Activity_id")
subject_train=read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train)=c("Subject")


##Part4:Merge Train Data 
x_subject_train = cbind(x_train,subject_train)
train_data = cbind(x_subject_train,y_train)

##Part5:Merge Test data
x_subject_test=cbind(x_test,subject_test)
test_data=cbind(x_subject_test,y_test)

##Part6:Merge Train and test data with required variables(mean & std type) to create sensor data
final_data=rbind(train_data,test_data)
sensor=final_data[,as.vector(unlist(matchcols(final_data,with=c("mean","std","Subject","Activity"),method="or")))]

##Part7:adding activity labels to sensor data and dropping activity_id 
sensor = merge(sensor,activity_labels,by="Activity_id",all=TRUE)
sensor=sensor[,-1]

## Part8:Correction of column names in sensor data  
names_sense=names(sensor)
names_sense=gsub("mean","Mean",names_sense,ignore.case=TRUE,perl=TRUE)
names_sense=gsub("std","StandardDeviation",names_sense,ignore.case=TRUE,perl=TRUE)
names_sense=gsub("freq","Frequency",names_sense,ignore.case=TRUE,perl=TRUE)
names_sense=gsub("Acc","Acceleration",names_sense,ignore.case=TRUE,perl=TRUE)
names_sense=gsub("Mag","Magnitude",names_sense,ignore.case=TRUE,perl=TRUE)
names_sense=gsub("GyroJerk","AngularAcceleration",names_sense,ignore.case=TRUE,perl=TRUE)
names_sense=gsub("Gyro","AngularSpeed",names_sense,ignore.case=TRUE,perl=TRUE)
names_sense=gsub("^t","TimeDomain.",names_sense)
names_sense=gsub("^f","FrequencyDomain.",names_sense)
names_sense=gsub("$","",names_sense,ignore.case=TRUE,perl=TRUE)
names_sense=gsub('\\(|\\)',"",names_sense,perl=TRUE)
names_sense=gsub("-","",names_sense,ignore.case=TRUE,perl=TRUE)
names_sense=make.names(names_sense)

## part9:Assign correct column names created above in names_sense to sensor data 
names(sensor)=names_sense

## part10:Create tidy data set with average for each variable by subject and activity type and export to a tab delimited file
sensor_avg_sub_act_tidy = ddply(sensor, c("Subject","Activity_type"), numcolwise(mean))
write.table(sensor_avg_sub_act_tidy,file="./UCI HAR Dataset/sensor_average_tidy.txt",sep="\t",row.name=FALSE)







