merge_files <- function(f1,f2,colName) {
  data_both <- merge(f1, f2, by=c(colName,"predict"),all=TRUE, sort = FALSE)
  data_both <- merge(f1, f2, by=c(colName,"predict"),all=TRUE, sort = FALSE)
  data_both <- data_both[,ngrmFreq := rowSums(.SD, na.rm = TRUE), .SDcols = c("ngrmFreq.x", "ngrmFreq.y")]
  data_both <- data_both[,-c(3,4)]
  return(data_both)
}

merge_word_files <- function(f1,f2,colName) {
  #data_both <- merge(f1, f2, by=c("List"),all=TRUE, sort = FALSE)
  data_both <- merge(f1, f2, by=c(colName),all=TRUE, sort = FALSE)
  data_both <- data_both[,ngrmFreq := rowSums(.SD, na.rm = TRUE), .SDcols = c("ngrmFreq.x", "ngrmFreq.y")]
  data_both <- data_both[,-c(2,3)]
  return(data_both)
}
