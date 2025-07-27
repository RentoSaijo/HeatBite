# Load necessary libraries.
library(shiny)
library(bs4Dash)
library(fresh)
library(echarts4r)
library(magrittr)

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
  title = 'HeatBite',
  header = dashboardHeader(
    title = dashboardBrand(
      title = 'HeatBite',
      image = 'assets/Logo.png'
    )
  ),
  sidebar = dashboardSidebar(
    sidebarMenu(
      id = 'sidebarMenuid',
      menuItem(
        'Who is Rento Saijo?',
        tabName = 'who',
        icon    = ionicon('person')
      ),
      menuItem(
        'Why for TOMODACHI?',
        tabName = 'why',
        icon    = ionicon('people')
      ),
      menuItem(
        'Crave it, slide it, bite it.',
        tabName = 'what',
        icon    = ionicon('pizza')
      )
    )
  ),
  footer = dashboardFooter(
    left  = a(
      href = 'https://www.linkedin.com/in/rentosaijo/',
      'LinkedIn'
    ),
    right = '2025'
  ),
  dark        = NULL,
  help        = NULL,
  scrollToTop = TRUE,
  
  body = dashboardBody(
    # Inject CSS to center all .card-title elements.
    tags$head(
      tags$style(HTML(
        '.card-title {
          text-align: center !important;
          width: 100%;
        }'
      )),
      tags$style(HTML(sprintf("
    /* Body links you flag with class='hb-link' ------------------------*/
    .card-body a.hb-link,
    .card-body a.hb-link:visited   { 
      color: %1$s; 
      text-decoration: underline;      /* ← always underlined */
    }

    /* Title / header links -------------------------------------------*/
    .card-header a.hb-link,
    .card-title  a.hb-link,
    .card-header a.hb-link:visited { 
      color: %1$s; 
      text-decoration: underline; 
    }

    /* Optional: tweak hover focus tint (keeps underline) -------------*/
    .card-body  a.hb-link:hover,
    .card-header a.hb-link:hover,
    .card-title  a.hb-link:hover,
    .card-body  a.hb-link:focus,
    .card-header a.hb-link:focus,
    .card-title  a.hb-link:focus   { 
      color: %1$s; 
      text-decoration: underline; 
    }
  ", palette$secondary)))
    ),
    
    # your theme
    use_theme(heatbite_theme),
    
    # your tabs
    tabItems(
      tabItem(
        tabName = 'who',
        fluidRow(
          class = 'align-items-stretch',
          
          column(
            width = 4,
            bs4Card(
              title        = 'Biography',
              status       = 'secondary',
              width        = 12,
              solidHeader  = FALSE,
              headerBorder = FALSE,
              elevation    = 3,
              collapsible  = FALSE,
              'Rento Saijo, now a freshman at Connecticut College pursuing his career in sports analytics, spent his G9-G12 years at Cranbrook Kingswood to realize his high school dream of balancing both academics and competitive ice hockey. Upon winning the State Championship and discovering his passion in data science, he now looks to advance a field in the intersection of them, actively building meaningful connections and seeking excellence in all facets.'
            ),
            bs4Card(
              status       = "primary",
              width        = 12,
              solidHeader  = FALSE,
              headerBorder = FALSE,
              elevation    = 3,
              collapsible  = FALSE,
              
              bs4Carousel(
                id         = "photo_gallery",
                indicators = TRUE,        # little dots
                
                bs4CarouselItem(
                  caption = "I love playing / coaching hockey!",
                  tags$img(src = "assets/Hockey.JPG",
                           style = "width:100%;height:auto;")
                ),
                bs4CarouselItem(
                  caption = "I workout 4-5 days a week!",
                  tags$img(src = "assets/Back.jpg",
                           style = "width:100%;height:auto;")
                )
              )
            )
          ),
          
          column(
            width = 4, 
            align = 'center',
            bs4Card(
              title='カーソルを文章の上に置くと和訳が出ます!',
              width        = 12,
              status       = 'primary',
              solidHeader  = FALSE,
              headerBorder = FALSE,
              elevation    = 3,
              collapsible  = FALSE,
              tags$img(
                src   = 'assets/RentoSaijo.jpeg',
                alt   = 'Rento Saijo',
                style = 'max-width: 360px; width: 100%; height: auto;'
              )
            )
          ),
          column(
            width = 4,
            bs4Card(
              title        = 'Programming Toolbox',
              width        = 12,
              status       = 'secondary',
              solidHeader  = FALSE,
              headerBorder = FALSE,
              elevation    = 3,
              collapsible  = FALSE,
              echarts4rOutput('programming_toolbox', height='320px')
            ),
            bs4Card(
              id='text3',
              title=tags$a(
                href='https://github.com/RentoSaijo/nhlscraper',
                target='_blank',
                class='hb-link',
                'Most Recent Project'
              ),
              status       = 'primary',
              width        = 12,
              solidHeader  = FALSE,
              headerBorder = FALSE,
              elevation    = 3,
              collapsible  = FALSE,
              tags$ul(
                tags$li(
                  tagList(
                    "Developed R-package to scrape NHL data from NHL and ESPN APIs with ",
                    tags$code("devtools"), " & ", tags$code("usethis"),
                    ", reverse-engineering 50+ undocumented endpoints with ",
                    tags$code("mitmproxy")
                  )
                ),
                tags$li(
                  tagList(
                    "Documented with ", tags$code("roxygen2"),
                    " & maintained ", tags$code("pkgdown"), " ",
                    tags$a(
                      href   = "https://rentosaijo.github.io/nhlscraper/",
                      target = "_blank",
                      class='hb-link',
                      "website"
                    ),
                    " for CRAN approval, being inducted into the ",
                    tags$a(
                      href   = "https://cran.r-project.org/web/views/SportsAnalytics.html",
                      target = "_blank",
                      class='hb-link',
                      "SportsAnalytics"
                    ),
                    " CRAN Task View and reaching 400+ downloads"
                  )
                )
              )
            )
          )
        )
      ),
      tabItem(
        tabName = 'what',
        fluidRow(
          class = 'align-items-stretch',
          
          column(
            width = 8,
            bs4Card(
              id='text1',
              title        = 'What is HeatBite?',
              status       = 'secondary',
              width        = 12,
              solidHeader  = FALSE,
              headerBorder = FALSE,
              elevation    = 3,
              collapsible  = FALSE,
              'HeatBite is a mobile app that turns the split-second feeling of “What do I want to eat right now?” into a single, playful swipe. Each launch shows one nutritionally balanced dish; slide the Cold-to-Hot bar (or tap Select) to rate how tempting it feels, and the engine instantly learns, checks your remaining daily macros, and surfaces the next best option. When you choose a dish, HeatBite reveals a deeper macro breakdown, step-by-step cooking instructions with timers, and an auto-generated shopping list that merges ingredients across all meals you’ve lined up for the day or week. Over time, it spots patterns like “spicier food after workouts” and “lighter bowls on rest days”, so you never have to pre-plan menus or measure servings manually.'
            ),
            bs4Card(
              id='text2',
              title        = 'Who is it for?',
              status       = 'secondary',
              width        = 12,
              solidHeader  = FALSE,
              headerBorder = FALSE,
              elevation    = 3,
              collapsible  = FALSE,
              'The experience is built for anyone who feels nutritional decision fatigue: beginners who want to lose weight but hate meal plans, athletes cycling between bulking and cutting phases who must stay macro-accurate, busy professionals who hit 6 P.M. with zero mental energy left, and families or roommates who spend fifteen minutes debating dinner every night. Because HeatBite’s AI personalizes suggestions based on body metrics, fitness goals, allergy flags, and real-time mood, the same interface can guide a college student looking for a quick high-protein lunch, a parent managing a child’s gluten sensitivity, or a powerlifter chasing an extra 500 kcal during a bulking block, all while keeping the interaction as simple as one thumb on a slider.'
            )
          ),
          
          column(
            width = 4, 
            align = 'center',
            bs4Card(
              title        = 'Prototype / プロトタイプ',
              width        = 12,
              status       = 'primary',
              solidHeader  = FALSE,
              headerBorder = FALSE,
              elevation    = 3,
              collapsible  = FALSE,
              tags$img(
                src   = 'assets/Example3.png',
                alt   = 'HeatBite Prototype',
                style = 'max-width: 360px; width: 100%; height: auto;'
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
  addPopover(
    id = "text1",
    options = list(
      title     = 'HeatBiteとは？',
      content   = 'HeatBiteは、「今、何を食べたいか」という瞬間的な欲求を、たった一度の直感的なスワイプで形にするモバイルアプリです。アプリを起動すると栄養バランスの取れた一皿が表示され、Cold-to-Hotバーをスライドするか「選択」をタップして魅力度を評価すると、エンジンが即座に学習し、残りの一日のマクロ栄養素を確認したうえで次に最適なメニューを提案します。料理を決定すると、HeatBiteは詳細なマクロ内訳、タイマー付きのステップごとの調理手順、さらに当日または一週間分の食事に必要な食材を統合した自動買い物リストを提示します。使い続けるほどに「ワークアウト後はスパイシーな料理」「休養日は軽めのボウル」といった傾向を学習するため、献立の事前計画や分量の手計測に煩わされることがなくなります。',
      placement = 'right',
      trigger   = 'hover',
      delay     = list(show = 0, hide = 100),
      html      = TRUE
    )
  )
  
  addPopover(
    id = "text2",
    options = list(
      title     = '誰のため？',
      content   = 'HeatBiteのユーザー体験は、栄養に関する意思決定で疲れを感じるあらゆる人を想定しています。減量を望みつつ献立作成が苦手な初心者、増量期と減量期を行き来しながらもマクロを厳密に管理したいアスリート、午後6時には思考力がほぼ残っていない多忙なビジネスパーソン、そして毎晩15分間夕食を巡って議論する家族やルームメイト。こうした人々が対象です。HeatBiteのAIは体格指標、フィットネス目標、アレルギー情報、リアルタイムの気分に基づいて提案をパーソナライズするため、同じインターフェースで、手早く高タンパクの昼食を探す大学生、子どものグルテン制限を管理する保護者、増量期に追加の500 kcalを確保したいパワーリフターといった多様なニーズを、指一本でスライダーを動かすだけでサポートできます。',
      placement = 'right',
      trigger   = 'hover',
      delay     = list(show = 0, hide = 100),
      html      = TRUE
    )
  )
  
  languages <- data.frame(
    language=c('R', 'Python', 'Java', 'JavaScript', 'HTML', 'CSS'),
    percentage=c(35, 25, 15, 20, 2.5, 2.5)
  )
  
  output$programming_toolbox <- renderEcharts4r({
    languages %>% 
      e_charts(language) %>% 
      e_pie(
        percentage,
        radius=c('40%', '65%'),
        label     = list(show = FALSE),     # no text
        labelLine = list(show = FALSE)
      )
  })
}

# Start shiny application.
shinyApp(ui, server)

