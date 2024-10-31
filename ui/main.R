# sim_tab ----
sim_tab <- tabItem(
  tabName = "sim_tab",
  fluidRow(
    column(width = 6,
           box(width = NULL,
               title = "Generate the model",
               status = "primary",
               solidHeader = TRUE,
               selectInput(inputId = "dataset",
                           label = "Dataset",
                           choices = c("SAEB")
               ),
               # Placeholder for variable information
               uiOutput("var_info"),
               selectInput(inputId = "model",
                           label = "Select scale model",
                           choices = c("~ 1 + (1|school_id)",
                                       "~ student_ses * school_ses + (1|school_id)",
                                       "~ student_ses * school_ses + (student_ses|school_id)"
                                       )
               ),
               actionButton("run", "Run"))),
    column(width = 6,
           box(width = NULL,
               title = "PIP",
               solidHeader = TRUE,
               status = "primary",
               collapsible = TRUE,
               collapsed = TRUE,
               plotOutput("pip")
           ),
           box(width = NULL,
               title = "SD",
               solidHeader = TRUE,
               status = "primary",
               collapsible = TRUE,
               collapsed = TRUE,
               plotOutput("sd")
           ),
           box(width = NULL,
               title = "Outcome",
               solidHeader = TRUE,
               status = "primary",
               collapsible = TRUE,
               collapsed = TRUE,
               plotOutput("outcome")
           )
    )
  ),
  fluidRow(
    column(width = 6,
           box(width = NULL,
               title = "Results",
               solidHeader = TRUE,
               status = "primary",
               #uiOutput("rsq_output"),
               reactableOutput("res_table"))
    )
    # ,
    # column(width = 6,
    #        box(width = NULL,
    #            title = "Sampling distribution",
    #            solidHeader = TRUE,
    #            status = "primary",
    #            radioGroupButtons(inputId = "estimate_plot",
    #                              #label = "Sampling distribution of",
    #                              choices = c("Parameter estimates", "t-values"),
    #                              justified = TRUE),
    #            selectInput(inputId = "pred_plot",
    #                        label = "For regressor",
    #                        choices = NULL,
    #            ),
    #            plotOutput("sim_plot")))
  )
)