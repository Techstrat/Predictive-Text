# seperate out substring Right
substrRight <- function(x,n){
  substr(x,nchar(x)-n+1,nchar(x))
} 
 
createNGramFile <- function(used.corpus,ngSize,output_file,output_dir,lowF) {
  frq_df <- textstat_frequency(dfm(tokens_ngrams(tokens(used.corpus),n = ngSize+1, concatenator = " ")))
  ngrmWords <- do.call(rbind,strsplit(frq_df[[1]], ' (?=[^ ]+$)', perl = TRUE)) #2 column, 311362 row matrix
  colnames(ngrmWords)<- c("List","predict")
  ngrmFreq <- frq_df[[2]]
  ngrmAll <- cbind(ngrmWords,ngrmFreq)
  #remove low frequency
  ngrmAll <- subset(ngrmAll,ngrmFreq >lowF)
  #writeTofileNoRN(ngrmAll,output_file,output_dir)
  wd <- getwd()
  setwd(output_dir)
  fwrite(ngrmAll,output_file) #will write without quotes
  setwd(wd)
  #clean up memory
  rm(frq_df,ngrmWords,ngrmFreq,ngrmAll)
  gc(verbose = FALSE)
} 

singleWordCount <- function(used.corpus,output_file,output_dir,lowF) {
  ngrmWords <- dfm(used.corpus, ngrams=1, what = "fasterword", verbose = FALSE)
  ngrmAll <- textstat_frequency(ngrmWords)[,-c(3,4,5)]
  names(ngrmAll)[1] <- "List"
  names(ngrmAll)[2] <- "ngrmFreq"
  #remove low frequency
  ngrmAll <- subset(ngrmAll,ngrmFreq >lowF)
  writeTofileNoRN(ngrmAll,output_file,output_dir)
  #clean up memory
  rm(ngrmWords,ngrmAll)
  gc(verbose = FALSE)
} 

merge_files <- function(f1,f2) {
  data_both <- merge(f1, f2, by=c("List","predict"),all=TRUE, sort = FALSE)
  data_both <- data_both[,ngrmFreq := rowSums(.SD, na.rm = TRUE), .SDcols = c("ngrmFreq.x", "ngrmFreq.y")]
  data_both <- data_both[,-c(3,4)]
  return(data_both)
}
 
merge_word_files <- function(f1,f2) {
  data_both <- merge(f1, f2, by=c("List"),all=TRUE, sort = FALSE)
  data_both <- data_both[,ngrmFreq := rowSums(.SD, na.rm = TRUE), .SDcols = c("ngrmFreq.x", "ngrmFreq.y")]
  data_both <- data_both[,-c(2,3)]
  return(data_both)
}
minusOne <- function(ngCSV,ngFile,dirOut) {
  ngFile <- subset(ngFile,ngrmFreq >1)#remove single frequencies
  writeTofileNoRN(ngFile,ngCSV,dirOut)
}