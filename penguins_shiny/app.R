#Attach packages

library(shiny)
library(tidyverse)
library(palmerpenguins)

#Create user interface (keep track of paraenthese)
ui <- fluidPage(
    titlePanel("I am adding a TITLE!"),
    sidebarLayout(
        sidebarPanel("put my widgets here!",
                     radioButtons(inputId = "penguin_species",
                                  label = "Choose penguin species:",
                                  choices = c("Adelie", "Cool chinstrap peguins" = "Chinstrap", "Gentoo"))
                     ),
        mainPanel("Here's my graph!",
                  plotOutput(outputId = "penguin_plot"))
    )
)

#Create server function
server <- function(input, output) {

    penguins_select <- reactive({
        penguins %>%
            filter(species == input$penguin_species)
    })

   output$penguin_plot <- renderPlot({

       ggplot(data = penguins_select(), aes(x = flipper_length_mm, y = body_mass_g)) +
           geom_point()

       #must be called back to user interface


   })
}

#Combine into app
shinyApp(ui = ui, server = server)
