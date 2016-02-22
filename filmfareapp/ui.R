# ui.R
library(ggvis)

shinyUI(fluidPage(
  titlePanel("Adding Up the Filmfare Best Movies"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Oscars 2016 are around the corner and the internet is abuzz with all sorts of predictions"),
      helpText("(Hope Leo finally wins this time around!)"),
      helpText("Inspired by the enormous amount of analysis done for Hollywood movies, I wanted to do some for their Indian counterparts i.e Filmfares"),
      helpText("So, here are some trends and facts about movies who were awarded the Best movie award at the desi version of Oscars"),
      
      selectInput("var", 
        label = "Choose a variable to analyse upon",
        choices = c("Length", "Rating", "Cast", "Director"),
        selected = "Length"),
      
      helpText("Hover over the blue boxes to find out information about individual elements"),
      br(),
      br(),
      helpText("Powered by: Shiny")
      
    ),
    
    mainPanel(
      uiOutput("text1"),
      fluidRow(
        splitLayout(cellWidths = c("25%", "25%", "25%", "25%"), textOutput("head1"), textOutput("head2"), textOutput("head3"), textOutput("head4"))
      ),
      fluidRow(
        splitLayout(cellWidths = c("25%", "25%", "25%", "25%"), ggvisOutput("ggvisplot1"), ggvisOutput("ggvisplot2"), ggvisOutput("ggvisplot3"), ggvisOutput("ggvisplot4"))
      ),
      uiOutput("infotext"),
      fluidRow(
        splitLayout(cellWidths = c("50%", "50%"), plotOutput("figure1"), plotOutput("figure2"))
    )
  )
)))