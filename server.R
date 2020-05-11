
shinyServer(function(input, output, session) {
  ### Read in grams
    unoGram <- fread('oneGrams.csv')
    setkey(unoGram,"predict")
    biGram <- fread('twoGrams.csv')
    setkey(biGram,"List")
    triGram <- fread('threeGrams.csv')
    setkey(triGram,"List")
    fourGram <- fread('fourGrams.csv')
    setkey(fourGram,"List")
    fiveGram <- fread('fiveGrams.csv')
    setkey(fiveGram,"List")
    ## Set values
    # Define bitwords
    bitwords <- c("th","rd","rt","didn","doesn","don","isn","ce","de","ll","sn","st","th","wasn","ve","re","b","c","d","e","f","g","h","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
    bitwords <- paste(bitwords,collapse = '\\b|\\b')
    bitwords <- paste0('\\b',bitwords,'\\b')
    # Define stop words
    stpwrds <- paste(rev(stopwords("en", source = "snowball")), collapse = '\\b|\\b')
    stpwrds <- paste0('\\b',stpwrds,'\\b')
    # Discount parameters
    disc2 <- 0.05 #can adjust
    disc3 <- 0.05 #can adjust
    disc4 <- 0.05 #can adjust
    disc5 <- 0.05 #can adjust
    
    # Hide the loading message once data is loaded
    hide(id = "loading-content", anim = TRUE, animType = "fade")    
    show("app-content")
    
  getPredStr <- reactive({
    biObs <- data.table(predict = character(),prob = numeric())
    triObs <- data.table(predict = character(),prob = numeric())
    fourObs <- data.table(predict = character(),prob = numeric())
    fiveObs <- data.table(predict = character(),prob = numeric())    
    allObs <- data.table(predict = character(),prob = numeric())
    
    given <- toString(input$sentence)
    ### Clean up string 
    given <- iconv(given,"UTF-8", "ascii", sub = " ") 
    given <- tolower(given)  
   # given <- str_replace_all(given, stpwrds, '')
    given <- str_replace_all(given, "[^a-z]", " ")
    given <- str_replace_all(given, bitwords, '')      
    given <- str_squish(given)
    nWords <- length(strsplit(given, " ")[[1]])
    ### Start work with n-grams
    ####--------------biGrams---------------------------
    if (nWords>0) {
      given2 <- word(given,-1)
      biObs <- biGram[List == given2]
      dP2 <- 1
      if (nrow(biObs) > 0) 
      {
        biObs <- biObs[, prob := ((ngrmFreq - disc2)/sum(biObs$ngrmFreq))]
        dP2 <- 1- sum(biObs$prob) #discount probability mass to be given to unobserved
      }
      unobs2 <- unoGram[!(unoGram$predict %in% biObs$predict),]
      unobs2 <- unobs2[, prob := dP2*(ngrmFreq/sum(unobs2$ngrmFreq))]
      
      if (nrow(biObs) > 0) {
        allObs2 <- rbind(biObs[,c("predict","prob")], unobs2[,c("predict","prob")])
      } else {
        allObs2 <- unobs2[,c("predict","prob")]
      }
      allObs = allObs2
  
      ####--------------triGrams---------------------------
      if (nWords>1) {
        given3 <- word(given,-2,-1)
        triObs <- triGram[List == given3]
        dP3 <- 1
        if (nrow(triObs) > 0) 
        { 
          triObs <- triObs[, prob := ((ngrmFreq - disc3)/sum(triObs$ngrmFreq))]
          dP3 <- 1- sum(triObs$prob) 
          unobs3 <- allObs2[!(allObs2$predict %in% triObs$predict),]
          unobs3 <- unobs3[, prob := dP3*(prob/sum(unobs3$prob))] 
          allObs3 <- rbind(triObs[,c("predict","prob")], unobs3[,c("predict","prob")])
          allObs = allObs3
        } 

        ####--------------fourGrams---------------------------
        if (nWords>2) {
          given4 <- word(given,-3,-1)
          fourObs <- fourGram[List == given4]
          dP4 <- 1
          if (nrow(fourObs) > 0) 
          { 
            fourObs <- fourObs[, prob := ((ngrmFreq - disc4)/sum(fourObs$ngrmFreq))]
            dP4 <- 1- sum(fourObs$prob) 
            unobs4 <- allObs3[!(allObs3$predict %in% fourObs$predict),]
            unobs4 <- unobs4[, prob := dP4*(prob/sum(unobs4$prob))] 
            allObs4 <- rbind(fourObs[,c("predict","prob")], unobs4[,c("predict","prob")])
            allObs = allObs4
          } 
        
          ####--------------fiveGrams---------------------------
          if (nWords>3) {
            given5 <- word(given,-4,-1)
            fiveObs <- fiveGram[List == given5]
            dP5 <- 1
            if (nrow(fiveObs) > 0) 
            { 
              fiveObs <- fiveObs[, prob := ((ngrmFreq - disc5)/sum(fiveObs$ngrmFreq))]
              dP5 <- 1- sum(fiveObs$prob) 
              unobs5 <- allObs4[!(allObs4$predict %in% fiveObs$predict),]
              unobs5 <- unobs5[, prob := dP5*(prob/sum(unobs5$prob))] 
              allObs5 <- rbind(fiveObs[,c("predict","prob")], unobs5[,c("predict","prob")])
              allObs = allObs5
            } 
          }
        }
      }
    allObs <- setorder(allObs, -prob)

    predictions <- allObs$predict[1]
    } else {
      predictions <- ""
    }
    return(predictions)
  })  

    g_sentence <- reactive(input$sentence)
 
    updateTextInput(session, "sentence", value=" ")
    output$text <- renderText(getPredStr())
    output$given_sentence <- renderText(g_sentence())

})
