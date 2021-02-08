library(shiny)


shinyServer(function(input, output) {
   
        
        predictModR2 <- reactive({
            predVar <- data.frame(Var = c("cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb"), Log = 
                                      rep(TRUE,10))
            varSelected <- c(input$cyl,input$disp,input$hp,input$drat,input$wt,input$qsec,input$vs,
                             input$am,input$gear,input$carb)
            indSelected <- predVar$Log == varSelected
            data(mtcars)
            mtcars$cyl <- factor(mtcars$cyl)
            mtcars$gear <- factor(mtcars$gear)
            mtcars$carb <- factor(mtcars$carb)
            if(sum(indSelected)==0){
                lmModel <- lm("mpg ~ 1",data=mtcars)
            } else {
                lmModel <- lm(paste(c("mpg ~ 1",predVar$Var[indSelected]),sep="+",collapse="+"),data=mtcars)
            }
            roundR2 <- round(summary(lmModel)$r.squared,digit=3)
            R2 <- paste("Model R^2 is: ",roundR2)
        })
        
        predictModMSE <- reactive({
            predVar <- data.frame(Var = c("cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb"), Log = 
                                      rep(TRUE,10))
            varSelected <- c(input$cyl,input$disp,input$hp,input$drat,input$wt,input$qsec,input$vs,
                             input$am,input$gear,input$carb)
            indSelected <- predVar$Log == varSelected
            data(mtcars)
            mtcars$cyl <- factor(mtcars$cyl)
            mtcars$gear <- factor(mtcars$gear)
            mtcars$carb <- factor(mtcars$carb)
            if(sum(indSelected)==0){
                lmModel <- lm("mpg ~ 1",data=mtcars)
            } else {
                lmModel <- lm(paste(c("mpg ~ 1",predVar$Var[indSelected]),sep="+",collapse="+"),data=mtcars)
            }
            roundMSE <- round(mean(lmModel$residuals^2),digit=3)
            MSE <- paste("Model MSE is: ",roundMSE)
            
        })
        
        predictModSummary <- reactive({
            predVar <- data.frame(Var = c("cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb"), Log = 
                                      rep(TRUE,10))
            varSelected <- c(input$cyl,input$disp,input$hp,input$drat,input$wt,input$qsec,input$vs,
                             input$am,input$gear,input$carb)
            indSelected <- predVar$Log == varSelected
            data(mtcars)
            mtcars$cyl <- factor(mtcars$cyl)
            mtcars$gear <- factor(mtcars$gear)
            mtcars$carb <- factor(mtcars$carb)
            if(sum(indSelected)==0){
                lmModel <- lm("mpg ~ 1",data=mtcars)
            } else {
                lmModel <- lm(paste(c("mpg ~ 1",predVar$Var[indSelected]),sep="+",collapse="+"),data=mtcars)
            }
            modelSummary <- summary(lmModel)$coefficients

            
        })
        
        output$Summary <- renderTable({
            predictModSummary()
        },include.rownames=TRUE,digits=3)

        output$R2 <- renderText({
            predictModR2()
     
        })
        
        output$MSE <- renderText({
            predictModMSE()
            
        })
        
        output$residPlot <- renderPlot({
            predVar <- data.frame(Var = c("cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb"), Log = 
                                      rep(TRUE,10))
            varSelected <- c(input$cyl,input$disp,input$hp,input$drat,input$wt,input$qsec,input$vs,
                             input$am,input$gear,input$carb)
            indSelected <- predVar$Log == varSelected
            data(mtcars)
            mtcars$cyl <- factor(mtcars$cyl)
            mtcars$gear <- factor(mtcars$gear)
            mtcars$carb <- factor(mtcars$carb)
            if(sum(indSelected)==0){
                lmModel <- lm("mpg ~ 1",data=mtcars)
            } else {
                lmModel <- lm(paste(c("mpg ~ 1",predVar$Var[indSelected]),sep="+",collapse="+"),data=mtcars)
            }
            res <- resid(lmModel)
            plot(mtcars$mpg, res, ylab="Residuals", xlab="mpg", main="Residuals for mtcars mpg") 
            abline(h=0,col="red")   
        })
        
        output$doc <- renderText({
                "This Shiny app fits linear regression models using the Motor Trend (mtcars) dataset. The models predict miles per gallon as a function of the predictors selected by the user. The user can select as many or as few of the predictors. The cyl, gear, and carb variables are treated as factors. The model always includes an intercept and does not include interactions. 

                The Model tab shows a residual plot for the current model, its coefficients and their p-values, and the model R-squared and mean squared error statistics."
        })

})
