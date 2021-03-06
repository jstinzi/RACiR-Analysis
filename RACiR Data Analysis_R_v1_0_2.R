#RACiR Data Analysis in R
#Author: Joseph Ronald Stinziano
#2018-09-10
#
#Contact Information
#jstinziano@unm.edu
#josephstinziano@gmail.com
#ORCID: 0000-0002-7628-4201
#
#RACiR is a trademark of LI-COR Biosciences, and used with permission.
#
#Need file name, check number of lines to be skipped to data start
#Check output for licor to make sure headers match
#Anywhere that "!!!" appears is something that requires attention and may need to be changed
#Take care with headers and column numbers as these can vary depending on the Licor settings
#
#Start of Code
#
#Calibration Curve
filename <- "Range_300-900_Rate_100_Calibration" #!!!Change as needed
headers <- read.delim(filename,sep="",skip = 53, header=FALSE, fill=TRUE) #!!!May need to change skip for the licor, skip until headers
colnames(headers) <- as.character(unlist(headers[1,])) #Assigns first row as column names
cal <- read.delim(filename,sep="",skip = 55, header=FALSE, fill=TRUE) #!!!Read in the calibration file
cal <- cal[,c(1:67,69:125)] #!!!May need to change length - have removed a coloumn associated with leaf type
colnames(cal) <- colnames(headers[,1:124])#!!!May need to change length in accordance with previous step
head(cal) #Check: do headers match up to what you expect?
plot(A~CO2_r, data = cal) #Look at plot to determine how to reduce curve
#
#STOP: LOOK AT THE DATA - what looks like an appropriate CO2_r cutoff?
#
mincut <- 380#!!!Data cutoff at the beginning of the response where chamber mixing is unpredictable
maxcut <- 880#!!!Data cutoff at the end of the response where the chamber mixing may not be predictable/CO2 ramp finished
cal <- cal[cal$CO2_r > mincut,]#Impose cutoff, selection of > and/or < depends on curve direction, range, and duration
cal <- cal[cal$CO2_r < maxcut,]#Impose cutoff, selection of > and/or < depends on curve direction, range, and duration
plot(A~CO2_r, data = cal)#Look at plot, make sure it looks okay
#
#STOP: LOOK AT THE DATA - does it look reasonable?
#
#Code below fits 1st to 5th order polynomials to the calibration curve and selects the best one according to Bayesian Information Criterion (BIC)
cal1st <- lm(A ~ CO2_r, data = cal)
cal2nd <- lm(A ~ poly(CO2_r,2), data = cal)
cal3rd <- lm(A ~ poly(CO2_r,3), data = cal)
cal4th <- lm(A ~ poly(CO2_r,4), data = cal)
cal5th <- lm(A ~ poly(CO2_r,5), data = cal)
predict1 <- predict(cal1st)
predict2 <- predict(cal2nd)
predict3 <- predict(cal3rd)
predict4 <- predict(cal4th)
predict5 <- predict(cal5th)
plot(cal$A ~ cal$CO2_r)
lines(cal$CO2_r,predict1,col='green')
lines(cal$CO2_r,predict2,col='blue')
lines(cal$CO2_r,predict3,col='red')
lines(cal$CO2_r,predict4,col='grey')
lines(cal$CO2_r,predict5,col='black') #Check plot, see how the calibration curves fit the data
bics <- BIC(cal1st, cal2nd, cal3rd, cal4th, cal5th)
best <- noquote(rownames(bics)[bics$BIC == min(bics$BIC)]) #!!!Determines the best model using BIC, can switch easily to AIC if desired
ifelse(best == "cal5th", cal$Acor <- cal$A - predict(cal5th, cal),
       ifelse(best == "cal4th", cal$Acor <- cal$A - predict(cal4th, cal),
              ifelse(best == "cal3rd", cal$Acor <- cal$A - predict(cal3rd, cal), 
                     ifelse(best == "cal2nd", cal$Acor <- cal$A - predict(cal2nd, cal), cal$Acor <- cal$A - predict(cal1st, cal))))) #Corrects A in the calibration curve. In this case the best fit is the 2nd order polynomial
summary(cal$Acor) #Mean and median should be close to 0, range should be small, if not, there could be an issue
maxcal <- max(cal$CO2_r) #Maximum value of CO2_r for which the calibration is valid
mincal <- min(cal$CO2_r) #Minimum value of CO2_r for which the calibration is valid
#
#Correcting data
#
filename <- "Range_300-900_Rate_100_Poplar_3" #Change as needed
headers <- read.delim(filename,sep="",skip = 53, header=FALSE, fill=TRUE) #May need to change skip for the licor, skip until headers
colnames(headers) <- as.character(unlist(headers[1,])) #Assigns first row as column names
id <- read.delim(filename,sep="",skip = 55, header=FALSE, fill=TRUE) #Read in data file
id <- id[,c(1:67,69:length(id))] #May need to change length - have removed a coloumn associated with leaf type
colnames(id) <- colnames(headers[,1:length(id)])
id <- id[id$CO2_r > mincal,] #Restricts lower limit to calibration range
id <- id[id$CO2_r < maxcal,] #Restricts upper limit to calibration range
ifelse(best == "cal5th", id$Acor <- id$A - predict(cal5th, id), 
       ifelse(best == "cal4th", id$Acor <- id$A - predict(cal4th, id), 
              ifelse(best == "cal3rd", id$Acor <- id$A - predict(cal3rd, id), 
                     ifelse(best == "cal2nd", id$Acor <- id$A - predict(cal2nd, id), id$Acor <- id$A - predict(cal1st, id))))) #Corrects A
id$Cicor <- (((id$gtc-id$E/2)*id$Ca-id$Acor)/(id$gtc+id$E/2)) #!!!Corrects Ci
plot(Acor ~ Cicor, data = id) #Plots the corrected data
#
#STOP: do you see any odd points? If logging continues after the RACiR ramp, data may need to be further removed off the end. Use one of the lines below to do this, depending on the directionality of the RACiR.
#id <- id[id$Cicor < X,]
#id <- id[id$Cicor > X,]
#
id$ID <- rep(filename,length(id$obs)) #!!!Adds a column to the data with the file name
#To write to file, use:
write.csv(id,"File Name.csv")#!!!
#To prepare for compiling, use:
compileddata <- id#!!!
#
#Correcting data file 2
#Note: this section adds to the previous 'compileddata' dataframe, and is thus suitable for copy-paste expansion of the code for many RACiRs 
#
filename <- "Range_300-900_Rate_100_Poplar_4" #!!!Change as needed
headers <- read.delim(filename,sep="",skip = 53, header=FALSE, fill=TRUE) #!!!May need to change skip for the licor, skip until headers
colnames(headers) <- as.character(unlist(headers[1,])) #Assigns first row as column names
id <- read.delim(filename,sep="",skip = 55, header=FALSE, fill=TRUE) #!!!Read in data file
id <- id[,c(1:67,69:length(id))] #!!!May need to change length - have removed a coloumn associated with leaf type
colnames(id) <- colnames(headers[,1:length(id)])
id <- id[id$CO2_r > mincal,] #Restricts lower limit to calibration range
id <- id[id$CO2_r < maxcal,] #Restricts upper limit to calibration range
ifelse(best == "cal5th", id$Acor <- id$A - predict(cal5th, id), 
       ifelse(best == "cal4th", id$Acor <- id$A - predict(cal4th, id), 
              ifelse(best == "cal3rd", id$Acor <- id$A - predict(cal3rd, id), 
                     ifelse(best == "cal2nd", id$Acor <- id$A - predict(cal2nd, id), id$Acor <- id$A - predict(cal1st, id))))) #Corrects A
id$Cicor <- (((id$gtc-id$E/2)*id$Ca-id$Acor)/(id$gtc+id$E/2)) #!!!Corrects Ci
plot(Acor ~ Cicor, data = id) #Plots the corrected data
#
#STOP: do you see any odd points? If logging continues after the RACiR ramp, data may need to be further removed off the end. Use one of the lines below to do this, depending on the directionality of the RACiR.
#id <- id[id$Cicor < X,]
#id <- id[id$Cicor > X,]
#
id$ID <- rep(filename,length(id$obs)) #!!!Adds a column to the data with the file name
#To write to file, use:
write.csv(id,"File Name.csv") #!!!
#To prepare for compiling, use:
compileddata <- rbind(id, compileddata) #!!!
#To write compiled data:
write.csv(compileddata,"File Name.csv") #!!!
#
#END OF CODE
#

#License CC-BY-SA 4.0
