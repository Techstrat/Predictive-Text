# Conversion function
# read in file, 
# call the clean text function, 
# write result to newfile
cleanFiles<-function(rawfile,cleanfile,stpwrds,badwords,bitwords){
  con1 <- file(rawfile, "rb") 
  charStr <- readLines(con1, skipNul = TRUE, encoding="UTF-8") #UTF-8 to get rid of special characters 
  close(con1)
  charStr <- clean.text(charStr) 
  con2 <- file(cleanfile, "wb")   
  writeLines(charStr,con2)
  close(con2) 
} 

# Function takes a character vector and clean up the text for NLP
# 1. Remove punctuation marks, special characters and digits
# 2. Convert all uppercase charaters to lower case
# 3. Remove stop words
# 4. Remove profane words
# 5. Remove any non-alphabetical characters
# 6. Remove all bits of words
# 7. Replace multiple spaces with single spaces
 
clean.text <- function(x) { 
  Sys.time()
  #convert back to ascii and get rid of special characters  
   x <- iconv(x,"UTF-8", "ascii", sub = " ") 
   #Convert all upper case to lower case
   x <- tolower(x)  
   #remove stop words and bad words
   x <- str_replace_all(x, stpwrds, '')
   #Remove bad words 
#   x <- str_replace_all(x, badwords, '')
   #Remove punctuation marks and special characters
   x <- str_replace_all(x, "[^a-z]", " ")
   #Remove bits of words 
   x <- str_replace_all(x, bitwords, '')      
   #Replace multiple spaces with single space
   x <- str_squish(x)
   #Remove non English words / single characters
  ### x <- unlist(lapply(x, is.word))
   #Return clean text
  return(x)
} 
# 
# ## Use gsub() to replace the bad words
# ## function replaces the words listed in the character vector bwords in the 
# ## text string called textstring with the value listed in replacestr
# 
# removeBad <- function(bwords, replacestr, textstring) {
#   for (w in bwords){
#     wordconcat <- paste("\\b",w,"\\b")
#     textstring<-gsub(wordconcat,replacestr,textstring, ignore.case = TRUE)
#   }
#   textstring
# }
#  
# ## Leaving out this step
# ## Ingest a character vector
# ## Returns a the character string containing only the English words
# is.word <- function(x) {
#   temp <- str_split(x, " ")[[1]] #split sentence into individual words
#   indexes <- which(temp %in% GradyAugmented) #true for each English word
#   x <- stri_paste(unlist(temp[indexes]), collapse = " ") 
# }
