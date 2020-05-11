#Load libraries
library(shiny)
library(shinyjs)
library(data.table)
library(stringr)
library(stopwords)

appCSS <- "
#loading-content {
  position: absolute;
  background: #FFFFFF;
  opacity: 0.9;
  z-index: 100;
  left: 0;
  right: 0;
  height: 100%;
  text-align: center;
  color: #000000;
}
#instructions {
  position: absolute;
  background: #FFFFFF;
  opacity: 0.9;
  z-index: 100;
  left: 0;
  right: 0;
  height: 100%;
  text-align: center;
  color: #000000;
}
"
shinyUI(fluidPage(
    useShinyjs(),
    inlineCSS(appCSS),
    # Loading message
    div(
        id = "loading-content",
        h2(tags$small("Welcome to")," My Word"),
        #HTML("<h2><center><small>Welcome to</small> My Word</center></h2>"),
        hr(),
        p("In the ", strong("My Word")," applications you enter an incomplete sentence."),
        p("Once you've typed the sentence and clicked on ", strong("'PREDICT'")," the app gives you the most likely English word to follow."),
        p("The prediction is based on millions of sentences collected from snippets of US Twitter, Blogs and News items."),
        p("Chances are we've read your mind...if not have fun with proving us wrong !!"),
        hr(),
        p("Future enhancements we are planning include:"),
        p("* Text prediction in French and German."),
        p("* An option to select how many possible predictions you want to see."),
        p("* An option to expand the predictions with the words you use most."),
        hr(),
        p("If you have any suggestions for new functionality or feedback on the current functionality, please e-mail us at:"),
        a(href="mailto:myword@techstrat.co.za", "myword@techstrat.co.za"),
        hr(),
        p(em("Kindly wait a few seconds while we load the "), strong("My Word"), em(" app...its well worth the wait !")),
        HTML("<img src=\"Rplot_Blogs.gif\" alt=\"\">")	
    ),
    # The main app 
    hidden(
      div(
        id = "app-content",
        titlePanel(HTML("<h2><center><small>Welcome to</small> My Word</center></h2>")),        
        hr(),
        tabsetPanel(
          tabPanel("WordPredictor",
            fluidRow(
              column(7,
                     wellPanel(
                       h4("What sentence do you need to complete?"),
                       textInput("sentence", "Type here", 
                                 value = "", 
                                 width = "100%",
                                 placeholder = NULL),
                       h4("select PREDICT to see the most likely next word"),
                       submitButton("PREDICT") 
                     )      
              ),
              
              column(5,
                     h5(strong("See the results here")),
                     hr(),
                     h5("For the given sentence:"),
                     textOutput("given_sentence"),
                     hr(),
                     h5("the most likely next words is:"),
                     textOutput("text")
              )
            ),
            HTML("<center><img src=\"Rplot_Blogs.gif\" alt=\"\"></center>")	
          ),
          tabPanel("Instructions",
            div(id = "instructions",
                   br(),
                   p("In the ", strong("My Word")," application you enter an incomplete sentence."),
                   p("Once you've typed the sentence and clicked on ", strong("'PREDICT'")," the app gives you the most likely English word to follow."),
                   p("The prediction is based on millions of sentences collected from snippets of US Twitter, Blogs and News items."),
                   p("Chances are we've read your mind...if not have fun with proving us wrong !!"),
                   hr(),
                   p("Future enhancements we are planning include:"),
                   p("* Text prediction in French and German."),
                   p("* An option to select how many possible predictions you want to see."),
                   p("* An option to expand the predictions with the words you use most."),
                   hr(),
                   p("If you have any suggestions for new functionality or feedback on the current functionality, please e-mail us at:"),
                   a(href="mailto:myword@techstrat.co.za", "myword@techstrat.co.za"),
                   hr(),
                   HTML("<img src=\"Rplot_Blogs.gif\" alt=\"\">")
            )
          )
        )
      )    
    )
))
