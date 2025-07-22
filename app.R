# Load necessary libraries.
library(shiny)
library(bs4Dash)

# Set assets.
shiny::addResourcePath("assets", "assets/")

# Setup user interface.
ui <- dashboardPage(
  help=NULL,
  dark=NULL,
  scrollToTop=TRUE,
  
  title='HeatBite',
  header=dashboardHeader(
    title=dashboardBrand(
      title='HeatBite',
      image='assets/Logo.png'
    )
  ),
  sidebar=dashboardSidebar(
    sidebarMenu(
      id='sidebarMenuid',
      menuItem(
        'What',
        tabName='what',
        icon=ionicon('pizza')
      ),
      menuItem(
        'Why',
        tabName='why',
        icon=ionicon('stats-chart')
      ),
      menuItem(
        'How',
        tabName='how',
        icon=ionicon('laptop')
      ),
      menuItem(
        'Who',
        tabName='who',
        icon=ionicon('person')
      )
    )
  ),
  footer=dashboardFooter(
    left=a(
      href='https://www.linkedin.com/in/rentosaijo',
      '@RentoSaijo'
    ),
    right='2025'
  ),
  body=dashboardBody(
    tabItems(
      tabItem(
        tabName='what',
        jumbotron(
          title='Welcome to HeatBite!',
          status='info',
          lead='Your home for viewing NHL statistics available via the nhlscraper R-package.',
          btnName='Learn about nhlscraper',
          href='https://rentosaijo.github.io/nhlscraper/'
        )
      )
    )
  )
)

# Setup server.
server <- function(input, output, session) {
}

# Start shiny application.
shinyApp(ui, server)
