#######################################################################
#######################################################################
# Section 4
#######################################################################
#######################################################################

r=5
area=pi*r^2

# type area in console
area

# Exercise 4.1.1
#######################################################################
getwd()

# Section 4.2
#######################################################################

# read in a datafile using read.table command
iris=read.table('iris.csv',header=T,sep=',')


# use the str command to observe the structure of iris data
str(iris)

# use the class command 
class(iris)


# summarize the dataset
summary(iris)


#######################################################################
#######################################################################
# Section 5
#######################################################################
#######################################################################

# get info on summary command
help(summary)


# list arguments for the summary command
args(summary)

# summarize iris using 2 digits
summary(iris,digits=3)

# use the browser for tips
# you may need to find your browser exe file

browser="C:/Program Files/Internet Explorer/iexplore.exe" 
browseURL("http://www.statmethods.net/",browser)

#######################################################################
#######################################################################
# Section 6
#######################################################################
#######################################################################


browseURL("http://cran.r-project.org/web/packages/available_packages_by_name.html",
          browser)

# If you want to install JGR and Deducer remove the # sign from the next line
# install.packages(c('JGR','Deducer'),dependencies=T)

# use xlsx package

library(xlsx)
args(read.xlsx)
mushroom=read.xlsx("mushroom.xlsx",1,header=T)
str(mushroom) 

# this is much faster than xlsx 
require(RODBC) 
wb=odbcConnectExcel2007('mushroom.xlsx') # this opens a connection
mushroom=sqlFetch(wb,"Sheet1")           # this reads the sheet
odbcCloseAll()

#######################################################################
#######################################################################
# Section 7
#######################################################################
#######################################################################

# equivalent statements "=" and "<-" are the same
iris=read.table('iris.csv',header=T,sep=',')
iris<-read.table('iris.csv',header=T,sep=',')

# the ~ is used in a formuala for plotting 
library(lattice) 
xyplot(Sepal.Length~Sepal.Width|Species,data=iris)


# generate sequences from:to
1:4
4:1
1:4+4:1

# use brackets to select first 50 rows of iris 
setosa=iris[1:50,] 
str(setosa)
head(setosa,5)

# construct a vector by combining elements
x=c(1,2,5)
(x=c(1,2,5))

# extract the Length values from setosa
setosa$Sepal.Length

#######################################################################
#######################################################################
# Section 8
#######################################################################
#######################################################################


# mean of Sepal.Length
mean(setosa$Sepal.Length)

# standard deviation of Sepal.Length
sd(setosa$Sepal.Length)

# variance of Sepal.Length
var(setosa$Sepal.Length)

# Make 
attach(setosa)

# mean of Sepal.Length
mean(Sepal.Length)

# use the with command to extract variables from data.frames
with(setosa,mean(Sepal.Length))

# Section 8.1
#######################################################################

# create the function area based on radius r
area=function(r) pi*r^2
area(5)

# Exercise 8.1.1

stderr=function(x) sd(x,na.rm=T)/sqrt(length(na.exclude(x)))
with(setosa,stderr(Sepal.Length))


#######################################################################
#######################################################################
# Section 9
#######################################################################
#######################################################################

# select data for the Setosa species in iris
# not == is needed to match species with 'Setosa'
setosa=subset(iris,Species=='setosa')
str(setosa)

# use brackets to select first 50 rows of iris 
setosa=iris[1:50,] 
str(setosa)

# or specify a condition but print only first 5
setosa[setosa$Species=='setosa',][1:5,]

# variance-covariance of sepal and petal measurements
var(setosa[,1:4])

# create log of Sepal Length 
iris$logSL=with(iris,log(Sepal.Length)) 
iris$logSL=log(iris$Sepal.Length) 

# Section 9.1
#######################################################################

y=1:10 
class(y)

# change y from integer to numeric 
y = as.numeric(y) 
class(y)

# change y from numeric to factor 
y = as.factor(y) 
class(y) 

# Exercise 9.1.1
#######################################################################

painrelief=read.table('painrelief.csv',header=T,sep=',')
str(painrelief)
painrelief[,1]=as.numeric(painrelief[,1])
painrelief[,2]=as.factor(painrelief[,2])
painrelief[,3]=as.factor(painrelief[,3])
str(painrelief)
print(painrelief)
View(painrelief)

# Section 9.2
#######################################################################

# read data with missing values
iris.miss=read.table('iris missing.csv',header=T,sep=',') 
head(iris.miss,n=7)

# use the mean function but specify missing values are present
mean(iris.miss$Sepal.Length,na.rm=TRUE)

# compute correlations to three sig digits
options(digits=3)
cor(iris.miss[,1:4],use='complete.obs')

# Section 9.3
#######################################################################

# create a list
(MeanAndVar=list(   
  varnames=names(iris.miss[,1:4]),   
  means=colMeans(iris.miss[,1:4],na.rm=T),   
  variance=var(iris.miss[,1:4],na.rm=T)))
str(MeanAndVar)

# inspect classes
class(MeanAndVar[[1]])
class(MeanAndVar[[2]])
class(MeanAndVar[[3]])

# split a data.frame into a list
iris.list=split(iris,iris$Species)
str(iris.list)

# Exercise 9.3.1
#######################################################################

# correlations
lapply(iris.list,function(x) cor(x[,1:4],use='complete.obs'))

# variance covariance
lapply(iris.list,function(x) var(x[,1:4],na.rm=T))

# means
lapply(iris.list,function(x) colMeans(x[,1:4],na.rm=T))

# standard deviations
lapply(iris.list,function(x) sqrt(diag(var(x[,1:4],na.rm=T))))

#######################################################################
#######################################################################
# Section 10
#######################################################################
#######################################################################

# save the iris data
save(iris,file="iris.RData")

# load the iris data that has been previously saved
load("iris.RData")


# Exercise 10.1.1
#######################################################################

# You need to have installed JGR and Deducer

# remove # in the next two lines to run JGR
# library(JGR)
# JGR()

#######################################################################
#######################################################################
# Section 11
#######################################################################
#######################################################################

args(plot)

# read the ozone data
ozone<-read.table("http://statweb.stanford.edu/~tibs/ElemStatLearn/datasets/ozone.data",header=T)
str(ozone)

# read bone density data
bonedens<-read.table("http://statweb.stanford.edu/~tibs/ElemStatLearn/datasets/bone.data",header=T)
str(bonedens)

with(ozone,plot(wind,ozone))
lines(with(ozone,loess.smooth(wind,ozone)))

# use ~ for formula in plotting
# you can get the same thing with
# with(ozone,plot(ozone~wind))

library(lattice)
xyplot(spnbmd~age|gender,bonedens,
       panel=function(x,y){panel.xyplot(x,y,pch=20);
                           panel.loess(x,y,span=.4,lwd=2,col="red4")})

#######################################################################
#######################################################################
# Section 12
#######################################################################
#######################################################################


# Section 12.1.1
#######################################################################


# independent samples t test

setosa=subset(iris,Species=='setosa') 
virginica=subset(iris,Species=='virginica') 
t.test(setosa$Sepal.Length,virginica$Sepal.Length,var.equal=T)

iris.new=subset(iris,Species=='setosa'|Species=='virginica') 
t.test(Sepal.Length~Species,data=iris.new,var.equal=T)

# linear models approach

lm.fit=lm(Sepal.Length~Species,data=iris.new) 
summary(lm.fit)


# Section 12.2.1
#######################################################################

twins=read.table("twins.csv",header=T)
with(twins,t.test(IQb,IQf,paired=T))


# Section 12.2.2
#######################################################################

load('twins.RData')
str(twins.long)

fit=lm(IQ~type+pair,twins.long)
anova(fit)


fit=aov(IQ~type+pair,twins.long) 
summary(fit) 

fit=aov(IQ~type+Error(pair),twins.long) 
summary(fit) 


# load the mushroom data using XLConnect

library(XLConnect)
wb=loadWorkbook("mushroom.xlsx")
mushroom=readWorksheet(wb,1)
for ( i in 1:4 ) mushroom[,i]=factor(mushroom[,i])
saveWorkbook(wb)

levels(mushroom$Color)=c("B","C","G","O","P","W","Y")
levels(mushroom$Gills)=c("Broad","Narrow")
levels(mushroom$Rings)=c(0,1,2)

# need the itree package for the following
# install.packages("itree",dependencies=T)

part=itree(Edibility~Gills+Rings+Color,data=mushroom)
summary(part)
print(part)
plot(part,uniform=T)
text(part,pretty=1)


# this is much faster than xlsx
require(RODBC)
wb=odbcConnectExcel2007('mushroom.xlsx')
mushroom=sqlFetch(wb,"Sheet1")
odbcCloseAll()

# extra code beyond here


ozone<-read.table("http://statweb.stanford.edu/~tibs/ElemStatLearn/datasets/ozone.data",header=T)
splom(ozone,cex=.5)
with(ozone,xyplot(ozone~wind))
temp=as.ordered(with(ozone,cut(temperature,breaks=c(0,quantile(temperature,(1:4)/4)))))
levels(temp)=c('Q1','Q2','Q3','Q4')
xyplot(ozone~wind|temp,data=ozone,layout=c(4,1),aspect=1)
bonedens<-read.table("http://statweb.stanford.edu/~tibs/ElemStatLearn/datasets/bone.data",header=T)
if ( require(lattice) ) xyplot(spnbmd~age|gender,bonedens)


xyplot(spnbmd~age|gender,bonedens,panel=function(x,y)
  {panel.xyplot(x,y,pch=20);panel.loess(x,y,span=.4,lwd=2,col="red4")})


