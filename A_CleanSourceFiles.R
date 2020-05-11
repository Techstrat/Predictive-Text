## Install packages and load libraries
install.packages("quanteda")
install.packages("readtext")
install.packages("spacyr")
install.packages("data.table")
install.packages("stringr")
install.packages("stringi")
install.packages("qdapDictionaries") #check english word
install.packages("ggplot2")
install.packages("RColorBrewer")

library(quanteda)
library(readtext)
library(spacyr)
library(data.table)
library(stringr)
library(stringi)
library(qdapDictionaries)
library(ggplot2)
#library(dplyr)
library(RColorBrewer)
library(stopwords)
# Also laod the R scripts badwordfixes.R and readingAndWritingFiles.R

#### Clean up the text ######
##Clean data files
##file_dir <- "C:/Users/nnoel/Documents/DataAnalysis/10. Capstone/Coursera-SwiftKey/final/en_US"
file_dir <- "H:/Techstrat/Coursera DataSpecialisation/10. Capstone/Coursera-SwiftKey/final/en_US"

## Setup
wd <- getwd()
setwd(file_dir)
#Define stop words
stpwrds <- paste(rev(stopwords("en", source = "snowball")), collapse = '\\b|\\b')
stpwrds <- paste0('\\b',stpwrds,'\\b')
#Define bad words
badwords <- c("fucking","shit","piss","fuck","cunt","cocksucker","motherfucker","tits")
badwords <- paste(badwords,collapse = '\\b|\\b')
badwords <- paste0('\\b',badwords,'\\b')
#Define bitwords
bitwords <- c("th","rd","rt","didn","doesn","don","isn","ce","de","ll","sn","st","th","wasn","ve","re","b","c","d","e","f","g","h","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
bitwords <- paste(bitwords,collapse = '\\b|\\b')
bitwords <- paste0('\\b',bitwords,'\\b')
Sys.time()
#Clean Blogs
dirtyFile <- "en_US.blogs.txt"
cleanFile <- "Clean_en_US.blogs.txt"
cleanFiles(dirtyFile,cleanFile,stpwrds,badwords,bitwords)  # 13 min 4 sec
Sys.time()
#Clean News
dirtyFile <- "en_US.news.txt"
cleanFile <- "Clean_en_US.news.txt"
cleanFiles(dirtyFile,cleanFile,stpwrds,badwords,bitwords)  # 12 min 46 sec
Sys.time()
#Clean Twitter
dirtyFile <- "en_US.twitter.txt"
cleanFile <- "Clean_en_US.twitter.txt"
cleanFiles(dirtyFile,cleanFile,stpwrds,badwords,bitwords) # 10 min 28 sec
Sys.time()
setwd(wd)

# dirtyFile <- "sample_en_US.twitter.txt" cleanFile <-
# "clean_sample_en_US.twitter.txt"
# cleanFiles(dirtyFile,cleanFile,stpwrds,badwords) Sys.time()