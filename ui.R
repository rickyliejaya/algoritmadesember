header <- dashboardHeader(title = "Top 2000 Company")

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem(text = "Dataset", 
                 tabName = "data", 
                 icon = icon("database")),
        menuItem(text = "Ranking",
                 tabName = "top10id",
                 icon = icon("award")),
        sliderInput("bins",
                    "Number of bins:",
                    min = 1,
                    max = 30,
                    value = 10),
        menuItem(text = "Top 5 of Each Industries",
                 tabName = "investmentid",
                 icon = icon("bahai")),
        selectInput(inputId = "Industry", 
                    label = "Select Industry",
                    choices = unique(forbes_clean$Industry)),
        menuItem(text = "Top 5 of Each Countries",
                 tabName = "investmentidd",
                 icon = icon("atom")),
        selectInput(inputId = "Country", 
                    label = "Select Country",
                    choices = unique(forbes_clean$Country)),
        menuItem(text = "Industry and Country Mapping",
                 tabName = "incountryid",
                 icon = icon("globe")),
        menuItem(text = "Company Distribution",
                 tabName = "incountryidd",
                 icon = icon("bookmark"))
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "data",
                h2("Real Data", align = "center"),
                dataTableOutput(outputId = "data_forbes"),
                textOutput(outputId = "text_forbes")),
        tabItem(tabName = "top10id", 
                h2("Ranking by Asset, Profits and Revenue", align = "center"),
                plotlyOutput(outputId = "plot_rank"),
                plotlyOutput(outputId = "plot_rank1"),
                plotlyOutput(outputId = "plot_rank2")),
        tabItem(tabName = "investmentid",
                h2("Top 5 of Each Industries", align = "center"),
                plotlyOutput(outputId = "plot_rank4")),
        tabItem(tabName = "investmentidd",
                h2("Top 5 of Each Countries", align = "center"),
                plotlyOutput(outputId = "plot_rank8")),
        tabItem(tabName = "incountryid",
                h2("Distributin Around the World", align = "center"),
                plotlyOutput(outputId = "plot_map"),
                plotlyOutput(outputId = "plot_abc")),
        tabItem(tabName = "incountryidd",
                h2("Company Distribution Based ROA and NPM", align = "center"),
                plotlyOutput(outputId = "plot_xyz"),
                plotlyOutput(outputId = "plot_jkl"),
                textOutput(outputId = "text_forbess"))
    )
)

dashboardPage(
    header = header,
    body = body,
    sidebar = sidebar
)
