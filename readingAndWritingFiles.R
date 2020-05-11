 
#Read a file from file_dir and return a char vector
readCharvector <- function(file_name,file_dir) {
  wd <- getwd()
  setwd(file_dir)
  con1 <- file(file_name, "rb") 
  charStr <- readLines(con1, skipNul = TRUE) 
  close(con1)
  setwd(wd)
  return(charStr)
}
  
#Read a file from file_dir and return a data frame
readTextFile <- function(file_name,file_dir) {
  wd <- getwd()
  setwd(file_dir)
  textStr <- readtext(file_name, encoding = "utf-8") 
  setwd(wd)
  return(textStr)
}
 
#Write to file
writeTofile <- function(write_object,write_file,file_dir) {
  wd <- getwd()
  setwd(file_dir)
  con2 <- file(write_file, "wb")   
  write.csv(write_object,con2)
  close(con2)
  setwd(wd)
}
 
#Write to file - no row name
writeTofileNoRN <- function(write_object,write_file,file_dir) {
  wd <- getwd()
  setwd(file_dir)
  con2 <- file(write_file, "wb")   
  write.csv(write_object,con2, row.names = FALSE)
  close(con2)
  setwd(wd)
}
 
#Save to RDS
writeToRDS <- function(write_object,write_file,file_dir) {
  wd <- getwd()
  setwd(file_dir)
  saveRDS(write_object,write_file)
  setwd(wd)
}  

#Read from RDS
readFromRDS <- function(read_file,file_dir) {
  wd <- getwd()
  setwd(file_dir)
  rdsObject <- readRDS(read_file)
  setwd(wd)
  return(rdsObject)
} 
