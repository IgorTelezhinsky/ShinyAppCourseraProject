# load libraries
library(shiny)
require(googleVis)
library(caret)
library(e1071)
library(MASS)
library(randomForest)

# shiny server
shinyServer(function(input, output) {
    #set.seed(123)
    data(iris)
    L <- nrow(iris)
    S <- sample(1:L,size = ceiling(0.7*L))
    TrainData    <- iris[S,-5]
    TrainClasses <- iris[S,5]
    TestData     <- iris[-S,-5]
    TestClasses  <- iris[-S,5]
    tTest<-table(TestClasses)
    Class<-names(tTest)
    Freqs<-as.vector(tTest)
    accur<-NULL
    # define reactive parameters
    result <- reactive(
    {   
         Fit <- train(TrainData, TrainClasses,
                         method = input$Method,
                         preProcess = c("center", "scale"),
                         trControl = trainControl(method = input$cMethod, number = input$number))
        
         Pred <- predict(Fit,TestData)
         cm<-confusionMatrix(Pred,TestClasses)
         accur<<-cm$overall['Accuracy']
         
         #print(confusionMatrix(Pred,TestClasses))
         tPred<-diag(cm$table)
         #print(tTest)
         #print(tPred)
         return(as.vector(tPred))
    })
    
    # print text through reactive funtion
    output$acc <- renderText({input$accButton; return(accur)})

    # google visualization histogram
    output$frBar <- renderGvis({
        frBar <- 
            gvisColumnChart(data.frame(Class = Class, 
                                       Real  = Freqs, 
                                       Predicted=result()), 
            options = list(
            height = "600px",
            title = "Real classes vs. predicted correctly",
           # subtitle = "This is subtitle",
            hAxis = "{ title: 'Classes', maxAlternation: 1, showTextEvery: 1}",
            vAxis = "{ title: 'Frequency'}")
        )
        return(frBar)
    })
})
