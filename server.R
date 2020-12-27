function(input,output){
    
    output$data_forbes <- renderDataTable({
        DT::datatable(data = forbes_clean, options = list(scrollX = T)
        )
    })
    output$text_forbes <- renderText({
        "*Asset, Profit, Revenue, Market Value Show in Billions"
    })
    
    output$indonesia <- renderImage({
        "gudanggaram.jpg"
    })
    output$text_forbess <- renderText({
        "*Return on Asset and Net Profit Margin was the most accurate in profitability ratio,
    which is higher value was better, but for investment 
    the minimum ratio for Return on Asset was 5%, and the minimum ratio for Net Prrofit Margin was 10%,
    companies that has ROA more than 5% and NPM more than 10% are good Company for invest"
    })
    
    output$plot_rank <- renderPlotly({
        data_agg3 <- forbes_clean %>% 
            select(Company, Profits) %>% 
            arrange(desc(Profits)) %>% 
            head(input$bins)
        
        plot_ranking2 <- data_agg3 %>% 
            ggplot(aes(x = Profits, 
                       y = reorder(Company, Profits),
                       text = glue("Total Profits : {Profits} Billion"))) +
            geom_col(fill = "#00CCCC") +
            labs( x = NULL,
                  y = NULL,
                  title = "Company With Most Profit") +
            scale_y_discrete(labels = wrap_format(30)) +
            theme_algoritma 
        
        ggplotly(plot_ranking2, tooltip = "text")
    })
    
    output$plot_rank1 <- renderPlotly({
        data_agg4 <- forbes %>% 
            select(Company, Revenue) %>% 
            arrange(desc(Revenue)) %>% 
            head(input$bins)
        
        plot_ranking3 <- data_agg4 %>% 
            ggplot(aes(x = Revenue,
                       y = reorder(Company, Revenue),
                       text = glue("Total Sales : {Revenue} Billion"))) +
            geom_col(fill = "green") +
            labs( x = NULL,
                  y = NULL,
                  title = "Company With Most Sales") +
            scale_y_discrete(labels = wrap_format(30)) +
            theme_algoritma
        ggplotly(plot_ranking3, tooltip = "text")
    })
    
    output$plot_rank2 <- renderPlotly({
        data_agg5 <- forbes %>% 
            select(Company, Assets) %>% 
            arrange(desc(Assets)) %>% 
            head(input$bins)
        plot_ranking4 <- data_agg5 %>% 
            ggplot(aes(x = Assets,
                       y = reorder(Company, Assets),
                       text = glue("Total Sales : {Assets} Billion"))) +
            geom_col(fill = "yellow") +
            labs( x = NULL,
                  y = NULL,
                  title = "Company With Biggest Assets") +
            scale_y_discrete(labels = wrap_format(30)) +
            theme_algoritma
        ggplotly(plot_ranking4, tooltip = "text")
    })
    
    
    output$plot_rank4 <- renderPlotly({
        king <- forbes_clean %>% 
            filter(Industry == input$Industry) %>% 
            group_by(Company) %>%
            summarise(`ReturnonAsset(%)`) %>%
            arrange(desc(`ReturnonAsset(%)`)) %>% 
            head(5)
        
        plot_investment <- king %>% 
            ggplot(aes(x = `ReturnonAsset(%)`, 
                       y = reorder(Company, `ReturnonAsset(%)`),
                       text = glue("Company: {Company}
                          ROA: {`ReturnonAsset(%)`}"))) +
            geom_col(fill = "blue") +
            labs( x = NULL,
                  y = NULL,
                  title = "Top 5 of Each Industries") +
            scale_y_discrete(labels = wrap_format(30)) +
            theme_algoritma
        ggplotly(plot_investment, tooltip = "text")
    })
    
    output$plot_rank8 <- renderPlotly({
        queen <- forbes_clean %>%
            filter(Country == input$Country) %>% 
            group_by(Company) %>%
            summarise(`ReturnonAsset(%)`) %>%
            arrange(desc(`ReturnonAsset(%)`)) %>% 
            head(5)
        
        plot_investmentt <- queen %>% 
            ggplot(aes(x = `ReturnonAsset(%)`, 
                       y = reorder(Company, `ReturnonAsset(%)`),
                       text = glue("ROA: {`ReturnonAsset(%)`}"))) +
            geom_col(fill = "red") +
            labs( x = NULL,
                  y = NULL,
                  title = "Top 5 of Each Countries") +
            scale_y_discrete(labels = wrap_format(30)) +
            theme_algoritma
        ggplotly(plot_investmentt, tooltip = "text")
    })
    
    output$plot_map <- renderPlotly({
        data_agg2 <- forbes_clean %>% 
            group_by(Country) %>% 
            summarise(total_company = n()) %>% 
            arrange(desc(total_company)) %>% 
            rename(region = Country) %>% 
            mutate(
                region = ifelse(region == "United States", "USA", region)
            ) %>% 
            mutate(
                region = ifelse(region == "United Kingdom", "UK", region)
            )
        
        world_map <- map_data("world")
        company_map <- full_join(data_agg2, world_map)
        plot_map <- ggplot(company_map, aes(long, lat, group = group,
                                            text = glue("Country: {region}
                               Total Company: {total_company}")))+
            geom_polygon(aes(fill = total_company), color = "white")+
            scale_fill_viridis_c(option = "C") + 
            labs( x = NULL,
                  y = NULL,
                  title = "Distribution by Country") +
            theme_algoritma
        ggplotly(plot_map, tooltip = "text")
    })
    
    output$plot_abc <- renderPlotly({
        data_agg1 <- forbes_clean %>%
            group_by(Industry) %>%
            summarise(total_companies = n()) %>% 
            arrange(desc(total_companies))
        
        plot_industry <- data_agg1 %>% 
            ggplot(aes(x = total_companies, y = Industry,
                       text = glue("Industry: {Industry}
                         Total Company: {total_companies}"))) +
            geom_col(aes(fill = Industry), show.legend = FALSE) +
            labs( x = NULL,
                  y = NULL,
                  title = "Distribution by Industry") +
            scale_y_discrete(labels = wrap_format(30)) +
            theme_algoritma
        ggplotly(plot_industry, tooltip = "text")
    })
    output$plot_xyz <- renderPlotly({
        data_agg9 <- forbes_clean %>% 
            filter(`ReturnonAsset(%)`> -50)
        
        plot_dist1 <- data_agg9 %>% 
            ggplot(aes(x = "", y = `ReturnonAsset(%)`,
                       text = glue("{Company} : {`ReturnonAsset(%)`} %"))) +
            geom_boxplot() +
            geom_jitter(color= "blue", size=0.5, alpha=0.9) +
            labs(y= "Return on Assets(%)", x="Company", 
                 title= "Distribution Company by Return on Asset", 
                 caption = "Source: Forbes") +
            theme_algoritma 
        
        ggplotly(plot_dist1, tooltip = "text")
    })
    
    output$plot_jkl <- renderPlotly({
        data_agg6 <- forbes_clean %>% 
            filter(`NetProfitMargin(%)`< 200)
        
        plot_dist2 <- data_agg6 %>% 
            ggplot(aes(x = "", y = `NetProfitMargin(%)`,
                       text = glue("{Company} : {`NetProfitMargin(%)`} %"))) +
            geom_boxplot() +
            geom_jitter(color= "black", size=0.5, alpha=0.9) +
            labs(y= "NetProfitMargin(%)", x="Company", 
                 title= "Distribution Company by Net Profit Margin", 
                 caption = "Source: Forbes") +
            theme_algoritma 
        
        ggplotly(plot_dist2, tooltip = "text")
    })
    
    
}