# server.R

library(ggvis)
source("helpers.R")

shinyServer(
  function(input, output) {

    output$figure1 <- renderPlot({ 
      plotType(input$var)
    })
    output$figure2 <- renderPlot({
      timeplot(input$var)
      
    })
    
    observeEvent(input$var, {
      cat("Showing", input$var, "\n")
      if (input$var == "Cast"){
        output$text1 <- renderUI({ 
          HTML(paste(
            " <p style='text-align:center;'>Number of wins for each actor</p>"))
        })
        plotter(dft1,1.4,0.45) %>% bind_shiny("ggvisplot1")
        plotter(dft2,0.35,0.45) %>% bind_shiny("ggvisplot2")
        plotter(dft3,0.178,0.45) %>% bind_shiny("ggvisplot3")
        plotter(dft4,0.126,0.45) %>% bind_shiny("ggvisplot4")
        output$head1 <- renderText({"One"})
        output$head2 <- renderText({"Two"})
        output$head3 <- renderText({"Three"})
        output$head4 <- renderText({"Four or more"})
        output$infotext <- renderUI({
          HTML(paste(
            " ",
            "Aamir Khan (8) has acted in most number of Filmfare best picture movies, followed by Shahrukh Khan (5)",
            "However, when it comes to Filmfare Best Actor awards, Shahrukh Khan & Dilip Kumar (8) have won it for the maximum number of times",
            "In case of actresses, Nutan (4) has acted in most number of Filmfare best pictures",
            "Nutan & Kajol (5) have won Filmfare Best Actress awards for the maximum number of times",
            sep = '<br/>'))
        })
      }
      else if (input$var == "Director"){
        output$text1 <- renderUI({ 
          HTML(paste(
            " <p style='text-align:center;'>Number of wins for each director</p>"))
        })
        plotter(dfd1,0.466,0.45) %>% bind_shiny("ggvisplot1")
        plotter(dfd2,0.14,0.45) %>% bind_shiny("ggvisplot2")
        plotter(dfd3,0.0801,0.36) %>% bind_shiny("ggvisplot3")
        nullplotter() %>% bind_shiny("ggvisplot4")
        output$head1 <- renderText({"One"})
        output$head2 <- renderText({"Two"})
        output$head3 <- renderText({"Three or more"})
        output$head4 <- renderText({" "})
        output$infotext <- renderUI({
          HTML(paste(
            " ",
            "Yash Chopra, Bimal Roy and Sanjay Leela Bhansali (4) have directed the most number of Filmfare best movie winners",
            "Bimal Roy (7) also happens to have won the Best director award for the most number of times with Yash Chopra (4) next in line",
            sep = '<br/>'))
        })
      } 
      else if (input$var == "Length"){
        output$text1 <- renderUI({ 
          HTML(paste(
            " <p style='text-align:center;'>Running time of movie</p>"))
        })
        altplotter(dfm1,0.14,0.45) %>% bind_shiny("ggvisplot1")
        altplotter(dfm2,0.35,0.45) %>% bind_shiny("ggvisplot2")
        altplotter(dfm3,0.356,0.45) %>% bind_shiny("ggvisplot3")
        altplotter(dfm4,0.126,0.45) %>% bind_shiny("ggvisplot4")
        output$head1 <- renderText({"100 - 130 mins"})
        output$head2 <- renderText({"130 - 160 mins"})
        output$head3 <- renderText({"160 - 190 mins"})
        output$head4 <- renderText({"190 - 230 mins"})
        output$infotext <- renderUI({
          HTML(paste(
            " ",
            "Lagaan - Once Upon a Time in India (224 mins) was the longest movie to win the Best Movie Award",
            "Madhumati & Rajnigandha (110 mins) were the shortest movies to win the award",
            "Average time of running for a Best Movie award winner turns out to be 161 mins",
            sep = '<br/>'))
        })
      } 
      else if (input$var == "Rating"){
        output$text1 <- renderUI({ 
          HTML(paste(
            " <p style='text-align:center;'>IMDB rating (out of 10)</p>"))
        })
        altplotter(dfr1,0.067,0.45) %>% bind_shiny("ggvisplot1")
        altplotter(dfr2,0.497,0.45) %>% bind_shiny("ggvisplot2")
        altplotter(dfr3,0.178,0.45) %>% bind_shiny("ggvisplot3")
        altplotter(dfr4,0.126,0.45) %>% bind_shiny("ggvisplot4")
        output$head1 <- renderText({"Lesser than 7"})
        output$head2 <- renderText({"7 - 8"})
        output$head3 <- renderText({"8 - 8.4"})
        output$head4 <- renderText({"Greater than 8.4"})
        output$infotext <- renderUI({
          HTML(paste(
            " ",
            "Anand (8.91/10) was the highest IMDB rated movie to win the Best Movie Award",
            "Raja Hindustani (6.1/10) was the lowest IMDB rated movie to win the award",
            "Average IMDB rating for a Best Movie award winner is 7.71",
            sep = '<br/>'))
        })
      } 
      else{
         nullplotter() %>% bind_shiny("ggvisplot1")
         nullplotter() %>% bind_shiny("ggvisplot2")
         nullplotter() %>% bind_shiny("ggvisplot3")
         nullplotter() %>% bind_shiny("ggvisplot4")
       }
      
      })
    

  }
)