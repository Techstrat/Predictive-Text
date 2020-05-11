library(quanteda)
#library(readtext)
#library(spacyr)
library(data.table)
#library(stringr)
#library(stringi)
#Also load R sctips readingAndWritingFiles.R and nGramStringManipulation.R

#file_dir <- "C:/Users/nnoel/Documents/DataAnalysis/10. Capstone/Coursera-SwiftKey/final/en_US"
#output_dir <- "C:/Users/nnoel/Documents/DataAnalysis/10. Capstone/R Code/Output"

file_dir <- "H:/Techstrat/Coursera DataSpecialisation/10. Capstone/Coursera-SwiftKey/final/en_US"
output_dir <- "H:/Techstrat/Coursera DataSpecialisation/10. Capstone/R Code/Output"

cleanBlogFile <- "Clean_en_US.blogs.txt"
cleanNewsFile <- "Clean_en_US.news.txt"
cleanTwitFile <- "Clean_en_US.twitter.txt"
lowF <- 0 #don't record frequencies of lowF and less
maxNG <- 4 #largest n-gram

## Convert Blog data sets to Corpus
Sys.time()
Blogs.corpus <- corpus(readCharvector(cleanBlogFile, file_dir)) # 899 288 lines
# Get single word
singleWordCount(Blogs.corpus,"word_B.csv",output_dir,lowF)
# Get all the Blogs n grams
for (nG in 1:maxNG) {
  createNGramFile(Blogs.corpus,nG,paste(nG,"_B.csv",sep=""),output_dir,lowF)
  gc()
}
rm(B.corpus)
gc()
Sys.time()

## Convert News data sets to Corpus
Sys.time()
News.corpus <- corpus(readCharvector(cleanNewsFile, file_dir)) #1 010 242 lines
# Get single word
singleWordCount(News.corpus,"word_N.csv",output_dir,lowF)
# Get all the News n grams
for (nG in 1:maxNG) {
 createNGramFile(News.corpus,nG,paste(nG,"_N.csv",sep=""),output_dir,lowF)
}
rm(News.corpus)
gc()
Sys.time()

## Convert Twitter data sets to Corpus
Sys.time()
Twitter.corpus <- corpus(readCharvector(cleanTwitFile, file_dir)) #2 360 148 documents
# Get single word
singleWordCount(Twitter.corpus,"word_T.csv",output_dir,lowF)
# Get all the Twitter n grams
for (nG in 1:maxNG) {
 createNGramFile(Twitter.corpus,nG,paste(nG,"_T.csv",sep=""),output_dir,lowF)
}
rm(Twitter.corpus)
gc()
Sys.time()



