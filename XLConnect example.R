## Example to read in an Excel worksheet 

## This is a very basic example assuming the spreadsheet to be read in is
## in a flat table with no skipped rows with one word headers

library(XLConnect)

wb=loadWorkbook("mushroom.xlsx")
mushroom=readWorksheet(wb,1)

## Coerce the variables that were read so they are class "factor"
for ( i in 1:4 ) mushroom[,i]=as.factor(mushroom[,i])

## The following script assigns easy to read levels to the 
## classification variables that are read in

levels(mushroom$Color)=c("B","C","G","O","P","W","Y")
levels(mushroom$Gills)=c("Broad","Narrow")
levels(mushroom$Rings)=c(0,1,2)

str(mushroom)

str(mushroom)
