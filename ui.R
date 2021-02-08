
library(shiny)

# Define UI for application 
shinyUI(fluidPage(

    # Application title
    titlePanel("Fit Regression Model for MPG using Selected Variables from mtcars Dataset"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h4("Response (outcome) variable: MPG"),
            h5("Check the boxes for predictors"),
            checkboxInput("cyl", "Use cyl as a predictor?", value = FALSE),
            checkboxInput("disp","Use disp as a predictor?", value = FALSE),
            checkboxInput("hp", "Use hp as a predictor?", value = FALSE),
            checkboxInput("drat", "Use drat as a predictor?", value = FALSE),
            checkboxInput("wt", "Use wt as a predictor?", value = FALSE),
            checkboxInput("qsec", "Use qsec as a predictor?", value = FALSE),
            checkboxInput("vs", "Use vs as a predictor?", value = FALSE),
            checkboxInput("am", "Use am as a predictor?", value = FALSE),
            checkboxInput("gear", "Use gear as a predictor?", value = FALSE), 
            checkboxInput("carb", "Use carb as a predictor?", value = FALSE),
            submitButton("Submit")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type="tabs",
                        tabPanel("Documentation",br(),textOutput("doc")),
            tabPanel("Model", br(),plotOutput("residPlot"),uiOutput('Summary'),textOutput("R2"),textOutput("MSE")))
        )
    )
))
