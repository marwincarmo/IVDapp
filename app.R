## libraries ----
suppressPackageStartupMessages({
  library(shiny)
  library(shinyjs)
  library(shinydashboard)
  library(shinyWidgets)
  library(ggplot2)
  library(dplyr)
  library(MASS)
  library(leaps)
  library(purrr)
  library(reactable)
  library(rmarkdown)
  library(markdown)
})

## Functions ----

# display debugging messages in R if local, 
# or in the console log if remote
debug_msg <- function(...) {
  is_local <- Sys.getenv('SHINY_PORT') == ""
  txt <- paste(...)
  if (is_local) {
    message(txt)
  } else {
    shinyjs::logjs(txt)
  }
}

## Tabs ----

source("ui/sidebar.R")
source("ui/main.R")
source("ui/info.R")

## UI ----
ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "IVD"),
  sidebar = sidebar, # if sourced above
  dashboardBody(
    shinyjs::useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"), # links to www/custom.css
      tags$script(src = "custom.js") # links to www/custom.js
    ),
    tabItems(
      sim_tab,
      info_tab
    )
  )
)


server <- function(input, output, session) {
  
  observeEvent(input$run, { 
    
    table <- read.csv("data/tab_saebm1.csv")
    
    output$res_table <- reactable::renderReactable({
      reactable(table)
    })
    
    })
  
  # sim_plot ----
  output$pip <- renderPlot({
    
    predictor <- input$pred_plot
    choice <- input$estimate_plot
    
    if (choice == "Parameter estimates") {
      estimate <- df$coefs_complete
    } else {
      estimate <- df$tvals_complete
    }
    
    plot_pred(estimate, predictor, choice)
    
  })
  
}

shinyApp(ui, server)