### Merge the N Grams
#Imports csv file to data table - merge and total counts
library(data.table)
#Also load R scripts mergeFunctions.R

output_dir <- "H:/Techstrat/Coursera DataSpecialisation/10. Capstone/R Code/Output"
wd <- getwd()

### Merge onegrams
setwd(output_dir)
d1 <- fread('findstr /V /C:"ENDOFFILEMARKER" word_B.csv')
d2 <- fread('findstr /V /C:"ENDOFFILEMARKER" word_N.csv')
d3 <- fread('findstr /V /C:"ENDOFFILEMARKER" word_T.csv')
colName <- "List"
nGrams <- merge_word_files(d2,d3,colName)
nGrams <- merge_word_files(nGrams,d1,colName)
#nGrams <- nGrams[!(ngrmFreq ==1)]
colnames(nGrams)[1] <- "predict"
fwrite(nGrams,"oneGrams.csv") #will write without quotes
setwd(wd)
rm(nGrams,d1,d2,d3)
gc()

### Merge twograms
setwd(output_dir)
d1 <- fread('findstr /V /C:"ENDOFFILEMARKER" 1_B.csv')
d2 <- fread('findstr /V /C:"ENDOFFILEMARKER" 1_N.csv')
d3 <- fread('findstr /V /C:"ENDOFFILEMARKER" 1_T.csv')
colName <- "List"
nGrams <- merge_files(d2,d3,colName)
nGrams <- merge_files(nGrams,d1,colName)
#nGrams <- nGrams[!(ngrmFreq ==1)]
colnames(nGrams)[1] <- "List"
fwrite(nGrams,"twoGrams.csv") #will write without quotes
setwd(wd)
rm(nGrams,d1,d2,d3)
gc()

## Merge threegrams
setwd(output_dir)
d1 <- fread('findstr /V /C:"ENDOFFILEMARKER" 2_B.csv')
d2 <- fread('findstr /V /C:"ENDOFFILEMARKER" 2_N.csv')
d3 <- fread('findstr /V /C:"ENDOFFILEMARKER" 2_T.csv')
colName <- "List"
nGrams <- merge_files(d2,d3,colName)
nGrams <- merge_files(nGrams,d1,colName)
#nGrams <- nGrams[!(ngrmFreq ==1)]
colnames(nGrams)[1] <- "List"
fwrite(nGrams,"threeGrams.csv") #will write without quotes
setwd(wd)
rm(nGrams,d1,d2,d3)
gc()

### Merge fourgrams
setwd(output_dir)
d1 <- fread('findstr /V /C:"ENDOFFILEMARKER" 3_B.csv')
d2 <- fread('findstr /V /C:"ENDOFFILEMARKER" 3_N.csv')
d3 <- fread('findstr /V /C:"ENDOFFILEMARKER" 3_T.csv')
colName <- "List"
nGrams <- merge_files(d2,d3,colName)
nGrams <- merge_files(nGrams,d1,colName)
#nGrams <- nGrams[!(ngrmFreq ==1)]
colnames(nGrams)[1] <- "List"
fwrite(nGrams,"fourGrams.csv") #will write without quotes
setwd(wd)
rm(nGrams,d1,d2,d3)
gc()
 
### Merge fivegrams
setwd(output_dir)
d1 <- fread('findstr /V /C:"ENDOFFILEMARKER" 4_B.csv')
d2 <- fread('findstr /V /C:"ENDOFFILEMARKER" 4_N.csv')
d3 <- fread('findstr /V /C:"ENDOFFILEMARKER" 4_T.csv')
colName <- "List"
nGrams <- merge_files(d2,d3,colName)
nGrams <- merge_files(nGrams,d1,colName)
#nGrams <- nGrams[!(ngrmFreq ==1)]
colnames(nGrams)[1] <- "List"
fwrite(nGrams,"fiveGrams.csv") #will write without quotes
setwd(wd)
rm(nGrams,d1,d2,d3)
gc()