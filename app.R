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
        'Who is Rento Saijo?',
        tabName='who',
        icon=ionicon('person')
      ),
      menuItem(
        'Why this program?',
        tabName='why',
        icon=ionicon('code')
      ),
      menuItem(
        'Crave it, slide it, bite it.',
        tabName='what',
        icon=ionicon('pizza')
      )
    )
  ),
  footer=dashboardFooter(
    left=a(
      href='https://www.linkedin.com/in/rentosaijo/',
      'LinkedIn'
    ),
    right='@RentoSaijo | Developed with shiny & bs4Dash | 2025'
  ),
  dark=NULL,
  help=NULL,
  scrollToTop=TRUE,
  body=dashboardBody(
    tags$head(
      tags$style(HTML(
        '.card-title {
          text-align: center !important;
          width: 100%;
        }'
      )),
      tags$style(HTML(sprintf(
        '.card-body a.hb-link,
        .card-body a.hb-link:visited   { 
          color: %1$s; 
          text-decoration: underline;
        }
        .card-header a.hb-link,
        .card-title  a.hb-link,
        .card-header a.hb-link:visited { 
          color: %1$s; 
          text-decoration: underline; 
        }
        .card-body  a.hb-link:hover,
        .card-header a.hb-link:hover,
        .card-title  a.hb-link:hover,
        .card-body  a.hb-link:focus,
        .card-header a.hb-link:focus,
        .card-title  a.hb-link:focus   { 
          color: %1$s; 
          text-decoration: underline; 
        }', palette$secondary
      )))
    ),
    use_theme(heatbite_theme),
    tabItems(
      tabItem(
        tabName='who',
        fluidRow(
          class='align-items-stretch',
          column(
            width=4,
            bs4Card(
              id='who_text1',
              title='Biography',
              status='secondary',
              width=12,
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              'Rento Saijo, now a freshman at Connecticut College pursuing his career in sports analytics, spent his G9-G12 years at Cranbrook Kingswood to realize his high school dream of balancing both academics and competitive ice hockey. Upon winning the State Championship and discovering his passion in data science, he now looks to advance a field in the intersection of them, actively building meaningful connections and seeking excellence in all facets.'
            ),
            bs4Card(
              align='center',
              status='primary',
              width=12,
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              bs4Carousel(
                id='photo_gallery',
                indicators=TRUE,
                bs4CarouselItem(
                  caption='I love playing / coaching hockey!',
                  tags$img(
                    src='assets/Hockey.JPG', 
                    alt='Hockey',
                    style='width:80%; height:auto;'
                  )
                ),
                bs4CarouselItem(
                  caption='I workout 4-5 days a week!',
                  tags$img(
                    src='assets/Back.jpg', 
                    alt='Back',
                    style='width:77%; height:auto;'
                  )
                )
              )
            )
          ),
          column(
            width=4,
            bs4Card(
              align='center',
              title='カーソルを文章の上に置くと和訳が出ます!',
              width=12,
              status='primary',
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              tags$img(
                src='assets/RentoSaijo.jpeg',
                alt='Rento Saijo',
                style='max-width:360px; width:100%; height:auto;'
              )
            ),
            bs4Card(
              id='who_text2',
              title=tags$a(
                href='https://github.com/RentoSaijo/nhlscraper',
                target='_blank',
                class='hb-link',
                'Most Recent Completed Project'
              ),
              status='secondary',
              width=12,
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              tags$ul(
                tags$li(
                  tagList(
                    'Developed R-package to scrape NHL data from NHL and ESPN APIs with ',
                    tags$code('devtools'), 
                    ' & ', 
                    tags$code('usethis'),
                    ', reverse-engineering 50+ undocumented endpoints with ',
                    tags$code('mitmproxy'),
                    ' & decoding ',
                    tags$code('client.bundle.js'),
                    ' with ',
                    tags$code('LLM')
                  )
                ),
                tags$li(
                  tagList(
                    'Documented with ', 
                    tags$code('roxygen2'),
                    ' & maintained ', 
                    tags$code('pkgdown'), 
                    ' ',
                    tags$a(
                      href='https://rentosaijo.github.io/nhlscraper/',
                      target='_blank',
                      class='hb-link',
                      'website'
                    ),
                    ' for CRAN approval, being inducted into the ',
                    tags$a(
                      href='https://cran.r-project.org/web/views/SportsAnalytics.html',
                      target='_blank',
                      class='hb-link',
                      'SportsAnalytics'
                    ),
                    ' CRAN Task View & reaching 400+ downloads'
                  )
                )
              )
            )
          ),
          column(
            width=4,
            bs4Card(
              title='Programming Toolbox',
              width=12,
              status='secondary',
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              echarts4rOutput('programming_toolbox', height='240px')
            ),
            bs4Card(
              id='who_text3',
              title='Current Projects',
              status='primary',
              width=12,
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              tags$ul(
                tags$li(
                  tagList(
                    'Develop xG (expected goals) model with ', 
                    tags$code('logistic'), 
                    ' regression & ', 
                    tags$code('XGBoost'),
                    'trees'
                  )
                ),
                tags$li(
                  tagList(
                    'Analyze value of each possession with ', 
                    tags$code('linear'), 
                    ' & ', 
                    tags$code('Ridge-Lasso'),
                    'regressions'
                  )
                ),
                tags$li(
                  tagList(
                    'Write paper on "When should one (not) shoot at an empty net?" with ', 
                    tags$code('logistic'), 
                    ' regression & ', 
                    tags$code('Markov'),
                    'decision models'
                  )
                ),
                tags$li(
                  tagList(
                    'Investigate difference between analyst/fan sentiment on (social) media vs. objective statistics during a game with ', 
                    tags$code('NLP')
                  )
                ),
                tags$li(
                  tagList(
                    'Play with ', 
                    tags$code('MediaPipe'),
                    ' & ',
                    tags$code('OpenCV'),
                    ' (Image Classification) to answer "Do happier teams correlate with winning teams?"'
                  )
                )
              )
            )
          )
        )
      ),
      tabItem(
        tabName='why',
        fluidRow(
          class='align-items-stretch',
          column(
            width=4,
            bs4Card(
              id='why_text1',
              title='Technical Skills',
              status='primary',
              width=12,
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              'From reinforcement learning with ',
              tags$code('Thompson'),
              ' sampling for tutor-student matching project to optimizing ',
              tags$code('SQL'),
              ' queries for several sports analytics internships and time-series analysis with ',
              tags$code('ARIMA'), 
              'for an award-winning presentation at a data science competition, I\'ve had my fair share of experience with back-end development that I\'m looking to bring to the table and build upon; however, my sole exposure to the front-end has came from a ',
              tags$code('React'),
              ' audio memorization game for a contest years ago. I\'m looking to gain more insight from my peers and the experts throughout the program (the prep-seminars were great)!'
            ),
            bs4Card(
              title='Strengths & Weaknesses',
              width=12,
              status='secondary',
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              echarts4rOutput('technical_skills', height='240px')
            ),
          ),
          column(
            width=4,
            bs4Card(
              align='center',
              width=12,
              status='secondary',
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              tags$img(
                src='assets/Business.png',
                alt='Business',
                style='max-width:360px; width:100%; height:auto;'
              )
            ),
            bs4Card(
              id='why_text2',
              title='Entrepreneurship Skills',
              status='primary',
              width=12,
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              'I\'ve worked on many technical projects, packages, and even just ideas, both practical and silly alike, but I\'ve never thought about them through the lens of offering commercial service. After all, really how good is an idea if it can\'t at least self-sustain as a business model? I\'m looking to learn more about the business side of the technical world from much more experienced peers and mentors: how an idea can turn to service that is worthy of receiving financial compensation.' 
            )
          ),
          column(
            width=4,
            bs4Card(
              id='why_text3',
              title='Social Skills',
              status='primary',
              width=12,
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              'Passing Eiken Grade 1 at 13 and scoring 115/120 on TOEFL at 16, I now remotely work part-time as a high school tutor, but mere English is not my strong-suit; rather, I\'m much more proud of the vast network I\'ve been able to build, ranging from past teammates who\'ve recently been drafted to the NHL and middle-aged parents whom I met in my self-founded gaming ',
              tags$a(
                href='https://www.youtube.com/results?search_query=GuildRock+SMP',
                target='_blank',
                class='hb-link',
                'community'
              ),
              ' to developers and long-time friends across the coast. I look to continue expanding this web via the genuine connections I aim to build during this program.'
            ),
            bs4Card(
              align='center',
              width=12,
              status='secondary',
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              tags$img(
                src='assets/DataFest.png',
                alt='DataFest',
                style='max-width:360px; width:100%; height:auto;'
              )
            )
          )
        )
      ),
      tabItem(
        tabName='what',
        fluidRow(
          class='align-items-stretch',
          column(
            width=9,
            bs4Card(
              id='what_text1',
              title='Check out my business idea... What is HeatBite?',
              status='secondary',
              width=12,
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              'HeatBite is a mobile app that turns the split-second feeling of “What do I want to eat right now?” into a single, playful swipe. Each launch shows one nutritionally balanced dish; slide the Cold-to-Hot bar (or tap Select) to rate how tempting it feels, and the engine instantly learns, checks your remaining daily macros, and surfaces the next best option. When you choose a dish, HeatBite reveals a deeper macro breakdown, step-by-step cooking instructions with timers, and an auto-generated shopping list that merges ingredients across all meals you’ve lined up for the day or week. Over time, it spots patterns like “spicier food after workouts” and “lighter bowls on rest days”, so you never have to pre-plan menus or measure servings manually.'
            ),
            bs4Card(
              id='what_text2',
              title='Who is it for?',
              status='secondary',
              width=12,
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              'The experience is built for anyone who feels nutritional decision fatigue: beginners who want to lose weight but hate meal plans, athletes in bulking and cutting phases who must stay macro-accurate, busy professionals who hit 6 P.M. with zero mental energy left, and families or roommates who spend tens of minutes debating dinner every night. Because HeatBite’s AI personalizes suggestions based on body metrics, fitness goals, allergy flags, and real-time mood, the same interface can guide a college student looking for a quick high-protein lunch, a parent managing a child’s gluten sensitivity, or a powerlifter chasing an extra 500 kcal during a bulking block, all while keeping the interaction as simple as one thumb on a slider.'
            ),
            fluidRow(
              bs4Card(
                id='what_text3',
                title='of consumers want AI for healthy food suggestions',
                width=3,
                status='primary',
                solidHeader=FALSE,
                headerBorder=FALSE,
                elevation=3,
                collapsible=FALSE,
                echarts4rOutput('want_ai', height='100px')
              ),
              bs4Card(
                id='what_text4',
                title='of consumers think online tools can help in diet',
                width=3,
                status='primary',
                solidHeader=FALSE,
                headerBorder=FALSE,
                elevation=3,
                collapsible=FALSE,
                echarts4rOutput('online_tools', height='100px')
              ),
              bs4Card(
                id='what_text5',
                title='Why is it necessary?',
                width=6,
                status='primary',
                solidHeader=FALSE,
                headerBorder=FALSE,
                elevation=3,
                collapsible=FALSE,
                'In conjunction with the statistics from the ',
                tags$a(
                  href='https://ific.org/wp-content/uploads/2024/06/2024-IFIC-Food-Health-Survey.pdf',
                  target='_blank',
                  class='hb-link',
                  '2024 IFIC Food & Health Survey'
                ),
                ' on the left, another British study found that adults spend, on average, 43 minutes a day deciding what to eat; that is 37 hours a year! Imagine what you could be doing with that much more free time and a healthier body at the same time! I can\'t wait to get working on this!'
              )
            )
          ),
          column(
            width=3, 
            align='center',
            bs4Card(
              title='Prototype',
              width=12,
              status='primary',
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              tags$img(
                src='assets/Example3.png',
                alt='HeatBite Prototype',
                style='width:100%; height:auto;'
              )
            ),
            bs4Card(
              width=12,
              status='secondary',
              solidHeader=FALSE,
              headerBorder=FALSE,
              elevation=3,
              collapsible=FALSE,
              tags$img(
                src='assets/Logo2.png',
                alt='HeatBite Prototype',
                style='width:100%; height:auto;'
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
  languages <- data.frame(
    language=c('R', 'Python', 'SQL', 'Java', 'JavaScript', 'HTML', 'CSS'),
    percentage=c(30, 25, 15, 10, 10, 8, 2)
  )
  output$programming_toolbox <- renderEcharts4r({
    languages %>% 
      e_charts(language) %>% 
      e_pie(
        percentage,
        radius=c('40%', '60%'),
        label=list(show=FALSE),
        labelLine=list(show=FALSE)
      )
  })
  technicals <- data.frame(
    skill=c('Mining', 'Analysis', 'Modeling', 'Database', 'Application', 'Front-end'),
    score=c(7, 9, 7, 6, 6, 2)
  )
  output$technical_skills <- renderEcharts4r({
    technicals %>% 
      e_charts(skill) %>% 
      e_radar(
        score, 
        max=10, 
        legend=FALSE,
        lineStyle=list(color=palette$primary),
        itemStyle=list(color=palette$primary)
      ) %>%
      e_radar_opts(
        name=list(
          textStyle=list(
            color=palette$neutral,
            fontWeight='bold'
          )
        )
      )
  })
  want_ai <- data.frame(value=c(0.51, 0.36, 0.21))
  output$want_ai <- renderEcharts4r({
    want_ai %>% 
      e_charts() %>%
      e_liquid(value, radius='90%', center=c('50%', '50%'), label=list(fontSize=27))
  })
  online_tools <- data.frame(value=c(0.65, 0.50, 0.35))
  output$online_tools <- renderEcharts4r({
    online_tools %>% 
      e_charts() %>%
      e_liquid(value, radius='90%', center=c('50%', '50%'), label=list(fontSize=27))
  })
  addPopover(
    id='who_text1',
    options=list(
      title='バイオグラフィー',
      content='現在Connecticut College1年生の西城廉統は、高校時代の夢だった学業とVarsityレベルのアイスホッケーを両立させるため4年間、ミシガン州内ボーディングスクールランク1位のCranbrook Kingswood Upper Schoolへ通った。州大会での優勝を経験し、データサイエンスへの情熱を見出した彼は、現在その二つの分野が交差するスポーツアナリティクスをさらに深く探求し、積極的に人脈を広げながら、学問・ソーシャル・フィジカルと3つの面での卓越性を目指している。',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
  addPopover(
    id='who_text2',
    options=list(
      title='最も最近完成したプロジェクト',
      content='NHLとESPNのAPIからデータを取得するRパッケージをdevtoolsとusethisを用いて開発。client.bundle.jsをLLMで解析したり、mitmproxyを用いて50以上の未公開エンドポイントをリバースエンジニア。更に、roxygen2にに従ったドキュメンテーション生成とpkgdownサイトの運用を行い、CRANに承認され、SportsAnalytics CRAN Task Viewに掲載された。公開１ヶ月ほどで400回以上ダウンロードされている。',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
  addPopover(
    id='who_text3',
    options=list(
      title='進行中のプロジェクト',
      content='まず、ロジスティック回帰とXGBoostを用いたxG（期待得点）モデルの開発があり、さらに線形回帰とリッジ・ラッソ回帰で各ポゼッションの価値を定量化する分析にも挑戦している。また、「エンプティーネットにいつ撃つ・撃たないべきか？」をテーマに、ロジスティック回帰とマルコフ決定モデルを用いた論文の執筆を進めている。加えて、試合中におけるアナリストやファンの（ソーシャル）メディア上の感情と客観的な統計との乖離を自然言語処理で調査する研究、そしてMediaPipeとOpenCVによる画像分類で「よりハッピーなチームは勝利と相関するのか？」という問いにも取り組んでいる。',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
  addPopover(
    id='why_text1',
    options=list(
      title='テクニカルの面で活かしたい・習得したいスキル',
      content='強化学習のトンプソン・サンプリングを用いたチューターと学生のマッチングプロジェクトから、ゴルフやアイスホッケー分析に関するインターンシップでのSQLクエリ最適化、ASA DataFest 2025で受賞したARIMAによる時系列解析のプレゼンまで、バックエンド開発やデータ収集・分析には数多く携わってきた。これらの経験を土台にさらに成長したい一方で、フロントエンドの経験は数年前のCongressional App Challengeで制作したReact製の音声記憶ゲームのみだ。本プログラムを通じて（プレップセミナーはもちろん良い経験となり）、他参加者や専門家から多くの知見を得たいと考えている。',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
  addPopover(
    id='why_text2',
    options=list(
      title='ビジネスの面で活かしたい・習得したいスキル',
      content='実用的なものからちょっとユニークなものまで、数々の技術プロジェクトやパッケージ、そしてアイデアを形にしてきたが、それらを商業サービスとして提供する視点で考えたことはない。結局、自立したビジネスモデルにならないアイデアに、どれほどの価値があるのでしょうか？本プログラもを通じ、もっと経験豊富な仲間やメンターの力を借りて、技術の世界でアイデアを対価に値するサービスへと昇華させる「ビジネスの視点」 を学びたいと考えている。',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
  addPopover(
    id='why_text3',
    options=list(
      title='ソーシャルの面で活かしたい・習得したいスキル',
      content='13歳で英検1級に合格し、16歳でTOEFL115点を取得した僕は、現在バイトとして高校生の家庭教師を務めていますが、僕の強みは単なる英語力ではない。NHLにドラフトされた元チームメイト、自ら立ち上げたコミュニティで知り合っただいぶ歳が離れているゲーマー達、そして海を越えてつながる開発者や長年の友人に至るまで、幅広いネットワークを築いてきたことこそが誇りだ。本プログラムを通じて、背景が全く異なる仲間と協力し、こうした真のつながりをさらに広げていきたいと考えている。',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
  addPopover(
    id='what_text1',
    options=list(
      title='HeatBiteとは？',
      content='HeatBite は、「いま何を食べたい？」という一瞬の迷いを、軽快なワンスワイプで解決するモバイルアプリ。起動するたびに栄養バランスの取れた一皿が表示され、冷⇄熱バーをスライド（または「選択」をタップ）して「食欲度」を評価すると、エンジンが即座に学習して残りのマクロ栄養素をチェックし、次の最適な候補を提案。料理を決めると、より詳しいマクロ内訳やタイマー付きの手順、さらにその日や週に並べた全メニューの食材を統合した自動買い物リストまで提示。使い続けるほどに「ワークアウト後は辛め」「オフ日は軽め」といった傾向を掴み、献立の事前計画や分量調整に煩わされることはなくなる。',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
  addPopover(
    id='what_text2',
    options=list(
      title='誰のため？',
      content='この体験は、食事選択に疲れを感じるあらゆる人を想定している。たとえば、減量したいけれど細かなミールプランは苦手な初心者、バルク期とカット期を行き来しながらマクロを正確に管理したいアスリート、「いざ、作ろう・食べよう」と思った時にはすでに思考力が尽きるほど忙しいビジネスパーソン、そして毎晩何十分も夕食をめぐって議論する家族やルームメイトなど。HeatBiteのAIは体格データ、フィットネス目標、アレルギー情報、リアルタイムの気分を基に提案をパーソナライズするため、高タンパクの手早いランチを探す大学生にも、子どものグルテン不耐症を気遣う親にも、バルク期に＋500 kcalを狙うパワーリフターにも、同じインターフェースで寄り添うことができる。しかも操作は親指一本でスライダーを動かすだけというシンプルさ。',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
  addPopover(
    id='what_text3',
    options=list(
      title='51％',
      content='が、「健康的な食事の提案をしてくれるAI」を求めている',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
  addPopover(
    id='what_text4',
    options=list(
      title='65％',
      content='が、オンラインツールは食事管理に役立つと考えている',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
  addPopover(
    id='what_text5',
    options=list(
      title='必要性',
      content='左側にある2024年 IFIC「食と健康調査」の統計に加え、英国の別研究によれば、大人は「今日は何を食べようか」と考えるのに1日平均43分、年間でなんと37時間も費やしていることが分かった。この時間をそっくり自由時間に充てつつ、より健康な身体まで手に入れられたら、あなたなら何を成し遂げますか？ 僕はこのプロジェクトに取り組むのが今から待ちきれません！',
      placement='right',
      trigger='hover',
      delay=list(show=0, hide=100),
      html=TRUE
    )
  )
}

# Start shiny application.
shinyApp(ui, server)
