# load shiny package
library(shiny)
# shiny UI 
shinyUI(navbarPage("Course Project: Shiny App",
# first tab
tabPanel("Documentation",
            # header
            h3("The accuracy of train() classification predictions."),
            # paragraph and bold text
            p("Here we will tune several parameters of the  train() function
            from caret the package to see their affect on accuracy of prediction.
            We will use simple iris data set for this purpose. This app serves
            as a convenient tool to visualize the results of your predictions
            and naturally can be extended to add different datasets and methods."),
            # break used to space sections
            br(), p("The tuning parameters include:"),
            br(),
            # ordered list
            tags$ol(
                 tags$li("Prediction method of the train() function: 
                         knn - k-nearest-neighbours,
                         nnet - neural network,
                         rf - random forest"),
                tags$li("Resampling method of trainControl() function:
                          bootstrapping or cross-validation"),
                tags$li("Either the number of folds or number of resampling iterations")
                    ),
            br(),
            p("PS1: this app illustrates the idea, and probably the result is not that variable 
               as it could be with more complex data set. If you reload the page, the train/test data
               sampling will be different so you may get a different result."),
            br(),
            p("PS2: after deployment I noticed that from shinyapps.io server gvisColumnChart() looks a
              bit weird in Safari and Chrome, but fine in Firefox. There is no problems if the app is run
              locally in all 3 browsers and in Rstudio built-in browser. Unfortunately, I didn't find a
              quick fix in internet, but still would like to use gvisColumnChart(). I hope it will not affect 
              your judgement and my score :-) .")
        ),
# second tab
tabPanel("Model tuning",
         # absolute panel
         #absolutePanel(
         fluidPage(
             # panel with predefined background
             #wellPanel(
              fluidRow(
                  column(4,
                         fluidRow(column(4, div(style = "height: 150px"))),
                         
                         #drop down list
                         fluidRow(selectInput("Method", "Select train algorithm", choices = c("knn","nnet","rf"), selected = "knn")),
                         fluidRow(column(4, div(style = "height: 30px"))),
                         
                         # radio button
                         fluidRow(radioButtons("cMethod","Train control resampling method",
                                               c("Bootstrapping"="boot","Cross Validation"="cv"))),
                         fluidRow(column(4, div(style = "height: 30px"))),
                         
                         # sliders
                         fluidRow(sliderInput("number", "K-folds/resampling iterations", min = 2, max = 25, value = 2)),
                         fluidRow(column(4, div(style = "height: 30px"))),
                         
                         # button
                         fluidRow(actionButton("accButton","Get accuracy")),
                         fluidRow(column(4, div(style = "height: 30px"))),
                         
                         # text output
                         fluidRow(p(strong("Accuracy: "), textOutput("acc", inline = TRUE)))
                  ),
                 
                 column(8,h4("Tune your model!"), tags$hr(), htmlOutput("frBar"))
                    ), style = "opacity: 0.92; z-index: 100;"
                )
             )
)
)
