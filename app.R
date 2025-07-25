# Load necessary libraries.
library(shiny)
library(bs4Dash)
library(fresh)

# Set assets.
shiny::addResourcePath('assets', 'assets/')

# Define palette.
palette <- list(
  primary='#EA5B4B',
  secondary='#79BDDD',
  neutral='#3C4348'
)

# Build theme.
heatbite_theme <- create_theme(
  bs4dash_status(
    primary=palette$primary,
    secondary=palette$secondary,
    info=palette$secondary,
    success=palette$secondary,
    danger=palette$primary,
    light='#FFFFFF',
    dark=palette$neutral
  ),
  
  bs4dash_vars(
    navbar_light_color=palette$neutral,
    navbar_light_hover_color=palette$secondary,
    navbar_light_active_color=palette$primary
  ),
  
  bs4dash_sidebar_light(
    bg='#FFFFFF',
    color=palette$neutral,
    hover_color=palette$primary,
    submenu_color=palette$neutral,
    submenu_hover_color=palette$primary,
    active_color=palette$primary
  ),
  
  bs4dash_yiq(
    contrasted_threshold=10,
    text_dark=palette$neutral,
    text_light='#FFFFFF'
  )
)

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
        'Crave it, slide it, bite it.',
        tabName='what',
        icon=ionicon('pizza')
      ),
      menuItem(
        'Why for TOMODACHI?',
        tabName='why',
        icon=ionicon('people')
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
    use_theme(heatbite_theme),
    tabItems(
      tabItem(
        tabName = 'what',
        fluidRow(
          class = "align-items-stretch",
          column(
            width=8,
            class = "d-flex flex-column h-100",
            # ---------- WHAT IT DOES -------------------------------------------------
            bs4Card(
              title         = 'What is HeatBite?',
              status        = 'secondary',
              width=12,
              solidHeader   = FALSE,
              headerBorder  = FALSE,
              elevation     = 3,
              class        = "mb-3",
              collapsible   = FALSE,
              p(
                'HeatBite is a mobile app that turns the split-second feeling of',
                ' “What do I want to eat right now?” into a single, playful ', 
                'swipe. Each launch shows one nutritionally balanced dish; slide',
                'the Cold-to-Hot bar (or tap Select) to rate how tempting it ',
                'feels, and the engine instantly learns, checks your remaining ',
                'daily macros, and surfaces the next best option. When you ',
                'choose a dish, HeatBite reveals a deeper macro breakdown, ',
                'step-by-step cooking instructions with timers, and an auto-',
                'generated shopping list that merges ingredients across all ',
                'meals you’ve lined up for the day or week. Over time, it spots ',
                'patterns like "spicier food after workouts" and "lighter bowls ',
                'on rest days", so you never have to pre-plan menus or measure ',
                'servings manually.'
              )
            ),
            # ---------- WHO IT’S FOR -------------------------------------------------
            bs4Card(
              title         = 'Who is it for?',
              status        = 'secondary',
              width         = 12,
              solidHeader   = FALSE,
              headerBorder  = FALSE,
              elevation     = 3,
              class        = "flex-grow-1",
              collapsible   = FALSE,
              p(
                'The experience is built for anyone who feels nutritional decision fatigue: beginners who want to lose weight but hate meal plans, athletes cycling between bulking and cutting phases who must stay macro-accurate, busy professionals who hit 6 p.m. with zero mental energy left, and families or roommates who spend fifteen minutes debating dinner every night. Because HeatBite’s AI personalizes suggestions based on body metrics, fitness goals, allergy flags, and real-time mood, the same interface can guide a college student looking for a quick high-protein lunch, a parent managing a child’s gluten sensitivity, or a powerlifter chasing an extra 500 kcal during a bulking block, all while keeping the interaction as simple as one thumb on a slider.'
              )
            ),
          ),
          
          column(
            width = 4,
            class = "d-flex",              # allow the child card to stretch to full column height
            
            bs4Card(
              width        = 12,
              status       = 'primary',         # neutral frame
              solidHeader  = FALSE,
              headerBorder = FALSE,
              elevation    = 3,
              collapsible   = FALSE,
              class        = "flex-fill p-0",  # flex-fill: take all vertical space; p-0: no padding
              tags$img(
                src   = "assets/Example3.png",
                alt   = "HeatBite prototype – swipe-to-select screen",
                class = "w-100 h-100",
                style = "object-fit: cover;"
              )
            )
          )
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

