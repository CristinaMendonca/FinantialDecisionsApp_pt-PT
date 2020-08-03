#####PACKAGES##########
library(shiny)
library(ggplot2)
library(shinydashboard)

#######SERVER###############
server = function(input, output, session) {
  
  options(scipen=999) # Remove scientific notation
  
  ##
  cleanToP <- function(x) {
    x <- round(x, 2)
    gsub(".", ",", x, fixed = TRUE)
  }
  cleanToR <- function(x) {
    x <- gsub(".", "", x, fixed = TRUE)
    x <- gsub(",", ".", x, fixed = TRUE)
    as.numeric(x)
  }
  
  
  ## The other takes values from R and presents them to the user
  
  observeEvent(input$Next1, {updateTabsetPanel(session, "tabPE", "pe")})
  observeEvent(input$Next2, {updateTabsetPanel(session, "tabPE", "prat1")})
  observeEvent(input$Next3, {updateTabsetPanel(session, "tabIN", "ine1")})
  observeEvent(input$Next4, {updateTabsetPanel(session, "tabIN", "prat2")})
  observeEvent(input$Next5, {updateTabsetPanel(session, "tabAN", "anc1")})
  observeEvent(input$Next6, {updateTabsetPanel(session, "tabAN", "prat3")})
  observeEvent(input$Next7, {updateTabsetPanel(session, "tabFA", "fa1")})
  observeEvent(input$Next8, {updateTabsetPanel(session, "tabFA", "prat4")})
  observeEvent(input$Next9, {updateTabsetPanel(session, "tabEB", "eb1")})
  observeEvent(input$Next10, {updateTabsetPanel(session, "tabEB", "prat5")})
  observeEvent(input$Next11, {updateTabsetPanel(session, "tabHD", "hd1")})
  observeEvent(input$Next12, {updateTabsetPanel(session, "tabHD", "prat6")})
  observeEvent(input$Next13, {updateTabsetPanel(session, "tabOI", "oi1")})
  observeEvent(input$Next14, {updateTabsetPanel(session, "tabOI", "prat7")})
  observeEvent(input$Next15, {updateTabsetPanel(session, "tabCM", "cm1")})
  observeEvent(input$Next16, {updateTabsetPanel(session, "tabCM", "prat8")})
  observeEvent(input$Next17, {updateTabsetPanel(session, "tabDA", "da1")})
  observeEvent(input$Next18, {updateTabsetPanel(session, "tabDA", "prat9")})
  observeEvent(input$Next19, {updateTabsetPanel(session, "tabCO", "co1")})
  observeEvent(input$Next20, {updateTabsetPanel(session, "tabCO", "prat10")})
  observeEvent(input$Next21, {updateTabsetPanel(session, "tabDP", "dp1")})
  observeEvent(input$Next22, {updateTabsetPanel(session, "tabDP", "prat11")})
  observeEvent(input$Next23, {updateTabsetPanel(session, "tabAH", "ah1")})
  observeEvent(input$Next24, {updateTabsetPanel(session, "tabAH", "prat12")})
  
  observeEvent(input$NextP1A, {updateTabItems(session, "tabs", "introO")})
  observeEvent(input$NextP1B, {updateTabItems(session, "tabs", "introH")})
  observeEvent(input$NextP1C, {updateTabItems(session, "tabs", "introR")})
  observeEvent(input$NextP1D, {updateTabItems(session, "tabs", "introC")})
  
  observeEvent(input$NextP2A, {updateTabItems(session, "tabs", "fauto")})
  observeEvent(input$NextP2B, {updateTabItems(session, "tabs", "contm")})
  observeEvent(input$NextP2C, {updateTabItems(session, "tabs", "custop")})
  
  observeEvent(input$NextP3A, {updateTabItems(session, "tabs", "narrow")})
  observeEvent(input$NextP3B, {updateTabItems(session, "tabs", "opir")})
  observeEvent(input$NextP3C, {updateTabItems(session, "tabs", "disp")})
  
  observeEvent(input$NextP4A, {updateTabItems(session, "tabs", "inertia")})
  observeEvent(input$NextP4B, {updateTabItems(session, "tabs", "exponential")})
  observeEvent(input$NextP4C, {updateTabItems(session, "tabs", "discounting")})
  
  observeEvent(input$NextP5A, {updateTabItems(session, "tabs", "anchor")})
  observeEvent(input$NextP5B, {updateTabItems(session, "tabs", "debtA")})
  observeEvent(input$NextP5C, {updateTabItems(session, "tabs", "pain")})
  
  ######## GET USER CHOICES ########
  
  rv <- reactiveValues()


  #|######################|#
  #|##### ORÇAMENTO ######|#
  #|######################|#
  
  output$orcplot <- renderPlot({
    labs <- c("Others","Education","Health","Clothing and footwear",
              "Restaurants and Hotels","Leisure, recreation and culture", 
              "Transports and communications", "Food, drinks and tobacco", 
              "Housing, water, electricity, gas")
    vals <- c(16.8,1,4.4,4.8,
              8.2,8.6,
              (12.6+2.5),(13.2+4.1),
              23.8)
    par(mar=c(4,14,0,1))
    barplot(vals, xlab="%", xlim=c(0,25), names = labs, las=1, cex.names=1, col="blue", horiz = T)
  })
  
  
      ########################
      ###### Impulsive #######
      ########################
  
  faP1Radio <- eventReactive(input$faButton, {input$radioFA})
  
  output$feedbackFA <- renderUI({
    if (is.null(faP1Radio())) {HTML("Please answer the question before pressing the \"Confirm\" button.")} 
    else if (faP1Radio() < 3) {"Well done! Your answer suggests you have good behavioural self-regulation." }
    else {"Your answer suggests you have a lack of behavioural self-regulation. Press on  \"Continue\" to find out more about this bias."}
  })
  
  ### Legenda ###
  
  output$noteFA <- renderUI({
    if (!input$faButton || is.null(faP1Radio()) || faP1Radio() == 3) {HTML('<img src="Sweat.png" width="100%"><br><br>Given that Maria only had €25 to pay for her expenses, she planned to make a purchase for €4. If she uses the credit card to buy the socks (€4) and the shirt (€75), she still has €25 in cash to spend at the weekend, but the next month starts with a negative balance of €79!')}
    else if (faP1Radio() == 4) {HTML('<img src="Sweat2.png" width="100%"><br><br>Given that Maria only had €25 to pay for her expenses, she planned to make a purchase for €4. If she uses the credit card to buy the socks (€4), the shirt (€75), and a blouse (€20), she still has €25 in cash to spend at the weekend, but the next month starts with a negative balance of €129!')}
    else {HTML('<img src="Sweat.png" width="100%"><br><br>Given that Maria only had €25 to pay for her expenses, she planned to make a purchase for €4. If she only buys the socks, she meets her budget and she still have €21 to spend on food in the remaining two days.')}
  })
  
  ## Prática ##
  
  butFAP <- eventReactive(input$FApButton, {1})
  
  faP2Check <- eventReactive(input$FApButton, {
    as.numeric(input$part4cg)
  })
  
  output$checkPracticeFA <- renderUI({
    if (butFAP()) {
      answerK <- c("1", "6", "7", "8", "10")
      answerF <- c("2", "3", "4", "5", "9")
      dic1 <- vector(mode="list", length=5)
      names(dic1) <- answerK
      dic1[answerK] <- c("Taking a shopping list.", "Being able to distinguish between a bargain discount to save money and a discount which leads you to spend more money.",
                         "Keeping note of non-essential items you would like to buy and postponing their purchase to a later date (for instance, when you have saved enough money for them).",
                         "Leaving your card at home and taking only the amount you are prepared to spend.", "Committing to only buying something new when the older item you have is actually broken or damaged.")
      dic2 <- vector(mode="list", length=5)
      names(dic2) <- answerF
      dic2[answerF] <- c("Going shopping when you are hungry.", "Going shopping when you are feeling frustrated/tired/irritated/depressed, etc.",
                         "Going around/unwinding in shopping centres or shops.", "Thinking \"once won’t do any harm\".", "Leaving your credit card details on the Internet browser to facilitate future purchases.")
      clear1 <- intersect(faP2Check(), answerK)
      for (i in clear1) {dic1[i] <- NULL}
      clear2 <- intersect(faP2Check(), answerF)
      
      if(5-length(clear1)>0){
        intro1 <- "The behaviours/thoughts you did not choose that help to avoid impulsive buying are:<br><ul><li>"
        mid1 <- paste(dic1, collapse="</li><li>")
        end1 <- "</li></ul>"
        in1 <- paste0(intro1, mid1, end1)
      } else {in1 <- ""}
      
      if(length(clear2)>0) {
        intro2 <- "The behaviours/thoughts you choose that <b>do not</b> help to avoid impulsive buying are:<br><ul><li>"
        mid2 <- paste(dic2[clear2], collapse="</li><li>")
        end2 <- "</li></ul>"
        ex1 <- paste0(intro2, mid2, end2)
      } else {ex1 <- ""}
      included <- length(intersect(faP2Check(), answerK))
      excluded <- 5 - length(intersect(faP2Check(), answerF)) 
      if (included+excluded == 10) {ex1 <- "<b>You have selected all the correct answers and none of the incorrect ones, congratulations!</b><br>"}
      HTML(paste0("<b>You chose ", included, " of the 5 correct options and correctly rejected ", 
                  excluded, " of the 5 incorrect options.</b><br>",
                 in1, ex1, "Use the sidebar menu to discover more heuristics and biases!"))
    }
    else{}
  })
  
  
  ########################
  ###### Accounting ######
  ########################
  
  mabP1Radio <- eventReactive(input$cmButton, {
    input$radio1CM
  })
  
  output$feedbackCM <- renderUI({
    if (is.null(mabP1Radio())) {
      HTML("Please give your answer, before pressing the \"Confirm\" button.")
    }  
    else if (mabP1Radio() == "0"){
      HTML("<b>Congratulations, you made the right choice!</b> By using the money you had saved for your holidays to pay off your credit card debt, you avoided paying interest. Go to the next tab to find out more about the bias that leads many people to choose options b) or c).")
    }
    else if (mabP1Radio() != "0"){
      HTML("<b>Your choice of answer shows that your mental accounting may be jeopardising your personal finances.</b> Go to the next tab to find out more about this bias.")
    }
    else {HTML("")}
  })
  
  
  output$plotCM <- renderPlot({
      par(mar=c(4,4,4,2))
      barplot(c(600,754.83,1076.61), ylim=c(0,1100), ylab="Total cost (€)", names=c("Option a)", "Option b)", "Option c)"), col="blue", yaxt ='n')
      axis(2, at=seq(0, 1100, 100), labels=seq(0, 1100, 100))
      
  })

  maP2Radio1 <- eventReactive(input$CMpButton, {input$radioP1CM})
  maP2Radio2 <- eventReactive(input$CMpButton, {input$radioP2CM})
  maP2Radio3 <- eventReactive(input$CMpButton, {input$radioP3CM})


  output$checkPracticeCM <- renderUI({
      if (is.null(maP2Radio1())||is.null(maP2Radio2())||is.null(maP2Radio3())) {
        HTML("Please answer every question before pressing the \"Confirm\" button.")
      }
      else if (maP2Radio1() == maP2Radio2() & maP2Radio2() == maP2Radio3()) {
        HTML("<b>Your answer does not reveal that you do mental accounting, congratulations!</b><br>Use the sidebar menu to explore other biases available in this app.")
      }
      else {
        HTML("<b>Your answers reveal that you do mental accounting</b>, since you assigned different weights to a pair of shoes that in fact always cost the same (€75). <br> Go back to the previous tab to reread the explanation for why this may be a bias or use the sidebar menu to explore other biases available in this app.")
      }
  })

  
  ###############################
  ###### Opportunity costs ######
  ###############################
  
  coP1Radio1 <- eventReactive(input$coButton, {input$radioCO1})
  coP1Radio2 <- eventReactive(input$coButton, {input$radioCO2})
  
  output$feedbackCO <- renderUI({
    if (is.null(coP1Radio1()) || is.null(coP1Radio2())) {
      HTML("Please answer every question before pressing the \"Confirm\" button.")
    }
    else{
      if (coP1Radio1() == "0") {
        felc1 <- "not "
        cost1 <- 0
        }
      else {
        felc1 <- ""
        cost1 <- 14.99}
      if (coP1Radio2() == "0") {
        felc2 <- "€3,99 "
        cost2 <- 3.99}
      else {
        felc2 <- "€10 "
        cost2 <- 10
      }
      HTML(paste0("You chose ", felc1, "to spend €14,99 the first scenario and to spend ", felc2, 
            "in the second scenario, spending a total of €", gsub("\\.", ",",(cost1+cost2)) , ". 
            Do you remember having thought of other ways of spending the amount of €", gsub("\\.", ",",(cost1+cost2)), "?"))
    }
  })
  
  output$plotCO1 <- renderPlot({
    par(mar=c(4,4,4,2))
    barplot(c(75,25,55,45), ylim=c(-10,100), ylab="% that choose this option", names=c("Would buy \nthe record", "Would not buy \nthe record", "Would buy \nthe record", "Would not buy the \nrecord, saving the \n money for other things"), col="blue", yaxt ='n')
    axis(2, at=seq(0, 100, 10), labels=seq(0, 100, 10))
    lines(c(2.5,2.5), c(0,100))
    abline(h=0)
  })
  
  output$plotCO2 <- renderPlot({
    par(mar=c(4,4,4,2))
    barplot(c(40,60,60,40), ylim=c(-10,100), ylab="% that choose this option", names=c("Buy the\n€10 bottle", "Buy the €3,99\n bottle, saving\n€6,01 for other things", "Buy the €10\nbottle", "Buy the €3,99\nbottle"), col="blue", yaxt ='n')
    axis(2, at=seq(0, 100, 10), labels=seq(0, 100, 10))
    lines(c(2.5,2.5), c(0,100))
    abline(h=0)
  })
  
  output$plotnoteOC1 <- renderUI({
    if (!input$coButton || is.null(coP1Radio1())) {
      HTML("Approximately 75% of the participants who answered the question presented in the previous tab chose to buy the record. However, when the option of not buying the record is presented as “not buying the record and saving the €14,99 for other purchases”, the percentage of participants who chooses to buy the record drops to 55%.<br>")
    } else {
      if (input$radioCO1 == "0") {elif1 <- " not to buy the record. Approximately 25% "}
      else {elif1 <- " to buy the record. Approximately 75% "}
      HTML(paste0("In the scenario of buying a record you chose", elif1, "of participants presented with this scenario tend to give this same answer. However, when the option of not buying the record is presented as “not buying the record and saving the €14,99 for other purchases”, the percentage of participants who chooses to buy the record drops to 55%.<br>"))
    }
  })
  
  output$plotnoteOC2<- renderUI({
    if (!input$coButton || is.null(coP1Radio2())) {
      HTML("Approximately 40% of the participants who answered the second question presented in the previous tab chose to buy the bottle that costs €10. However, when the option of buying the bottle that costs €3,99 is presented without explicitly stating that this option saves €6,01 for other purchases, the percentage of participants who choses to buy the €10 bottle raises to 60%.")
    }
    else {
      if (input$radioCO2 == "0") {elif2 <- " to buy the €3,99 bottle and saving €6,01 for other purchases. Approximately 60% "}
      else {elif2 <- " to buy the €10 bottle. Approximately 40% "}
      HTML(paste0("In the scenario of buying the bottle you chose",
                  elif2,"of participants presented with this scenario tend to give this same answer. However, when the option of buying the bottle that costs €3,99 is presented without explicitly stating that this option saves €6,01 for other purchases, the percentage of participants who choses to buy the €10 bottle raises to 60%."))
    }
  })
  
  cob2 <- eventReactive(input$copButton, 1)
  
  coP2Radio1 <- eventReactive(input$copButton, {input$radioCOP1})
  coP2Radio2 <- eventReactive(input$copButton, {input$radioCOP2})
  
  output$checkPracticeCO <- renderUI({
    if (is.null(coP2Radio1)||is.null(coP2Radio2())) {
      HTML("Please answer every question before pressing the \"Confirm\" button.")
    }
    else{
      if (coP2Radio1() == coP2Radio2()) {
      HTML("<b>Congratulations! Your answers do not suggest that you ignore opportunity costs.</b><br>
            Use the sidebar menu to explore the other biases available in this app.
           ")}
      else {
        HTML("<b>Your answers suggest that you ignored opportunity costs, as you changed your judgment after receiving information about other uses for your saved €1.500.</b><br>
            Go back to the previous tab to reread the explanation of opportunity costs or use the sidebar menu to explore the other biases available in this app.")
      }
    }
  })
    
  
  #|###################|#
  #|###### CASA #######|#
  #|###################|#
  
  output$casaplot <- renderPlot({
    par(mar=c(2,3,2,2))
    perEU <- matrix(c(43.35, 8.18,(41.81+6.87), 
                      48.64, 7.62,(37.71+6.03)), nrow = 3, dimnames = list(c("Housing \nloans", "Consumer \ncredit","Other \ncredit"),c("2007","2017")))
    perEU <- t(perEU)
    barplot(perEU,ylim=c(0,50),xlim=c(1,10),beside=TRUE)
    abline(h=seq(0, 50, 5))
    barplot(perEU, col = c("#08088A", "#2E2EFE"),ylim=c(0,50),xlim=c(1,10),
            legend = c("2007","2017"),beside=TRUE,add=T)
  })
  

      ########################
      ######## Narrow ########
      ########################
  
  sizeBT <- eventReactive(input$banksButton, {
    cleanBT <- gsub("[[:space:]]", "", input$banksText)
    length(strsplit(cleanBT, ",")[[1]])
  })
  
  output$feedbackBanks <- renderUI({
    if (sizeBT() == 0) {
      HTML("Please give your answer before pressing the \"Confirm\" button.")
    } else if (sizeBT() >= 44) {
      HTML("Very well! You have provided a number equal to (or above) the median number of banks in 40 European countries and territories, which is 44. Use the following link to check whether you got the number of banks in your country (and their names) correctly: <a href=\"https://thebanks.eu/banks-by-country\">The Banks.eu</a>.")
    } else if (sizeBT() > 0) {
      HTML(paste("You have provided a number smaller than the median number of banks in 40 European countries and territories, which is 44. Use the following link to check whether you got the number of banks in your country (and their names) correctly: <a href=\"https://thebanks.eu/banks-by-country\">The Banks.eu</a>."))
    }
    })
  
  #### NARROW PLOT ####
  output$narrowplot <- renderPlot({
    # Create the structure of the plot as a 6 by 5 grid
    par(mar=c(0,2,0,2))
    x <- rep(seq(1,11), 4)
    y <- rep(seq(1,4), 11)
    y <- y[order(y)]
    
    # Create the empty plot area
    plot(NULL, xlim=c(0.50,11.50), ylim=c(0.50,4.50), xaxt = 'n', yaxt = 'n', 
         bty = 'n', pch = '', ylab = '', xlab = '', xaxs="i", yaxs="i")
    
    # Now, populate the graph with the basic structure of the graph
    points(x, y, pch=21, lwd=12)
    
    # Figure out which points to turn red
    if (!input$banksButton || is.null(sizeBT()) || sizeBT() < 1) {uc <- 7}
    else if (sizeBT() > 44) {uc <- 44}
    else {uc <- sizeBT()}
    
    xS <- x[1:(uc)]
    yS <- y[1:(uc)]
    
    # And paint them
    points(xS, yS, pch=21, col="red", lwd=12)    
  })
  
  ### Narrow plot note ###
  output$narrownote <- renderUI({
    if (!input$banksButton || is.null(sizeBT()) || sizeBT() < 1) {
      HTML("<p style=\"margin-left: 10%;\">Imagining you knew only seven banks (red circles), the bank with the best offer could be one of the others you did not consider (black circles).</p>")
    } else if (sizeBT() >= 44) {
      HTML(paste('If you are aware of all possible options (red circles), then you can be sure that you can choose the best offer.'))
    } else if (sizeBT() == 43){
      HTML(paste0('If you know 43 banks (red circles), the bank with the best offer could still be the bank (black circle) you did not consider.'))
    } else if (sizeBT() == "1"){
      HTML(paste('If you know only one bank (red circle), the bank with the best offer could well be any of the banks you did not consider (black circles).'))
    } else {
      HTML(paste0('If you know ', sizeBT(), ' bank(s) (red circles), the bank with the best offer could well be any of the ', 44-sizeBT(), ' banks (black circles) you did not consider.'))
    }
    })
  
  ### Feedback Buy ###
  
  sizeBT1 <- eventReactive(input$buyButton, {
    cleanBT1 <- gsub("[[:space:]]", "", input$buyText)
    length(strsplit(cleanBT1, ",")[[1]])
  })
  
  output$feedbackBuy <- renderUI({
    intro <- "<ul>
              <li>Estate agencies</li><li>Bank real estate stocks</li>
              <li>Public auctions</li><li>Newspapers and magazines</li>
              <li>Private property auctions</li>
              <li>Auctions of real estate seized by Public Finances</li>
              <li>Auctions of real estate seized by Social Security</li>
              <li>Asking friends or people you know for opportunities</li>
              <li>Being attentive in the street to advertisements placed directly on properties</li>
              <li>Online sites</li>
            </ul>
            <p>Use the sidebar menu to explore the other biases available in this app.</p>"
    if (sizeBT1() == 0) {
      HTML("Please give your answer, before pressing the \"Confirm\" button.")
    } else if (sizeBT1() >= 10) {
      HTML(paste0("Well done! You listed, at least, as many options as we did! Can it be the case that you still show narrow thinking? Please find out if any of the 10 options below would complement your answer:",
                  intro))
    } else if (sizeBT1() == 1){
      HTML(paste0('You listed only one option! Can it be the case that you still show narrow thinking?  Please find out if any of the 10 options below would complement your answer:',
                  intro))
    } else {
      HTML(paste0('You listed ', sizeBT1(), 'options! Are you still showing signs of a narrow view? To find out, see if any of the 10 options below could complement your answer:',
                  intro))
    } 
    })
  
  
  #######################
  ###### Optimism #######
  #######################
  
  opP1Radio1 <- eventReactive(input$OIpButton, {input$radioOP1})
  opP1Radio2 <- eventReactive(input$OIpButton, {input$radioOP2})
  opP1Radio3 <- eventReactive(input$OIpButton, {input$radioOP3})
  opP1Radio4 <- eventReactive(input$OIpButton, {input$radioOP4})
  opP1Radio5 <- eventReactive(input$OIpButton, {input$radioOP5})
  opP1Radio6 <- eventReactive(input$OIpButton, {input$radioOP6})
  opP1Radio7 <- eventReactive(input$OIpButton, {input$radioOP7})
  opP1Radio8 <- eventReactive(input$OIpButton, {input$radioOP8})
  
  output$checkPracticeOI <- renderUI({
    if (is.null(opP1Radio1()) | is.null(opP1Radio2()) | is.null(opP1Radio3())
        | is.null(opP1Radio4()) | is.null(opP1Radio5()) | is.null(opP1Radio6())
        | is.null(opP1Radio7()) | is.null(opP1Radio8())) {
      HTML("Please answer every question before clicking \"Confirm\".<br><br>")
    }
    else if ((as.numeric(opP1Radio1()) + as.numeric(opP1Radio2()) + 
              as.numeric(opP1Radio3()) + as.numeric(opP1Radio4())) <
             (as.numeric(opP1Radio5()) + as.numeric(opP1Radio6()) + 
              as.numeric(opP1Radio7()) + as.numeric(opP1Radio8()))) {
      HTML("<b>Your answers reveal some tendency towards unrealistic optimism!</b> Press the continue button to learn more about this bias.")
    }
    else {
      HTML("<b>Congratulations, your answers do not reveal a tendency towards unrealistic optimism!</b> Even so, since most people reveal such a bias, press the continue button to learn more about this bias.")
    }
  })
  
  
  output$plotOI <- renderPlot({
    if (!input$OIpButton || is.null(opP1Radio1()) || is.null(opP1Radio2()) || is.null(opP1Radio3())
        || is.null(opP1Radio4()) || is.null(opP1Radio5()) || is.null(opP1Radio6())
        || is.null(opP1Radio7()) || is.null(opP1Radio8())){
      par(mar=c(2.5,4,2,4))
      barplot(c(2,9), ylim=c(1,10), xpd=F, names=c("Positive \nevents", "Negative \nevents"), col="blue", yaxt ='n')
      axis(2, at=seq(1, 10), labels=seq(1, 10))
    }
    else {
      posiT <- (as.numeric(opP1Radio1()) + as.numeric(opP1Radio2()) + 
                as.numeric(opP1Radio3()) + as.numeric(opP1Radio4())) / 4
      negaT <- (as.numeric(opP1Radio5()) + as.numeric(opP1Radio6()) + 
                as.numeric(opP1Radio7()) + as.numeric(opP1Radio8())) / 4
      par(mar=c(2.5,4,2,4))
      barplot(c(posiT,negaT), ylim=c(1,10), xpd=F, names=c("Positive \nevents", "Negative \nevents"), col="blue", yaxt ='n')
      axis(2, at=seq(1, 10), labels=seq(1, 10))
    }
    })
  
  output$noteplotOI <- renderUI({
    if (!input$OIpButton || is.null(opP1Radio1()) || is.null(opP1Radio2()) || is.null(opP1Radio3())
        || is.null(opP1Radio4()) || is.null(opP1Radio5()) || is.null(opP1Radio6())
        || is.null(opP1Radio7()) || is.null(opP1Radio8())){
      HTML("For instance, imagine that after answering all the questions in the previous tab, the mean answers for positive and negative events were equal/similar to the above present chart. This would be an example of unrealistic optimism. This bias is present when the bar of the positive events is lower than that of the negative ones. The greater the difference between positive and negative events, the greater the bias/unrealistic optimism.")
    }
    else {
      HTML("Based on the previous exercise, in the graph above your average responses to positive and negative events are depicted. Unrealistic optimism tends to emerge when the positive events bar is lower than that of the negative events and will be all the higher the greater this difference is.")
    }
    })
  
  
  opP2Slide1 <- eventReactive(input$oiButton, {input$oiN1})
  opP2Slide2 <- eventReactive(input$oiButton, {input$oiN2})
  opP2Slide3 <- eventReactive(input$oiButton, {input$oiN3})
  opP2Slide4 <- eventReactive(input$oiButton, {input$oiN4})
  
  output$feedbackOI <- renderUI({
    if (input$oiButton) {
      if (opP2Slide1() <= 50 & opP2Slide2() >= 10 & opP2Slide3() <= 8 & opP2Slide4() >= 2) {
        pre <- "<b>It seems that you are not prone to unrealistic optimism,</b> as your estimates were generally correct or they were more pessimistic than the actual cases.<br>"
      }
      else {
        pre <- "<b>Some of your answers reveal some tendency towards unrealistic optimism.</b><br><br>"
      }
      a1 <- paste0("<a href=\"https://ec.europa.eu/eurostat/web/products-eurostat-news/-/DDN-20190725-1\">The likelihood</a> of exceeding the average life expectancy for those born in 2017 (83.5 years for women or 78.3 years for men) is approximately 50%, you stated: ",opP2Slide1(), "%.<br>")
      a2 <- paste0("<a href=\"https://ec.europa.eu/eurostat/web/products-eurostat-news/-/DDN-20180529-1\">The likelihood</a> of defaulting on credit payment is approximately 10% (in 2016), you stated: ",opP2Slide2(), "%.<br>")
      a3 <- paste0("<a href=\"https://www.euro-millions.com/odds-of-winning\">The likelihood</a> of winning a prize in the EuroMillions is approximately 8%, you stated: ", opP2Slide3(), "%.<br>")
      a4 <- paste0("<a href=\"https://ec.europa.eu/eurostat/statistics-explained/index.php/Accidents_at_work_statistics\">The likelihood</a> of having an accident at work is approximately 2% (in 2017), you stated: ", opP2Slide4(), "%.<br><br>")
      HTML(paste0(pre, 
                 "In this exercise, we generally use EuroStat data, as a rough indicator of the likelihood of each of these events in the life of the European population.<br><br>",
                 a1,a2,a3,a4,"<b>Remember that the tendency to express unrealistic optimism has an impact on how you view your financial decisions!</b><br><br>Use the sidebar menu to explore the other biases available in this app."))
      }
  })
  
  
  ###########################
  ###### Availability #######
  ###########################
  
  ahP1Radio <- eventReactive(input$ahButton, {input$checkGroupAH})
  
  output$feedbackAH <- renderUI({
    if (is.null(ahP1Radio())) {
      HTML("Please answer the question before pressing the \"Confirm\" button.")
    }
    else if ("6" == ahP1Radio() | "8" == ahP1Radio()) {
      HTML("You have chosen one of the most suitable comparison criteria! Go to the next tab to learn more about the criteria that best enable the comparison of different credit proposals.")
    }
    else {
      HTML("Although you have chosen a valid criterion, this is not the most suitable one for comparing the different proposals. Go to the next tab to find out why.")
    }
  })
  
  ahP2Select <- eventReactive(input$AHpButton, {input$selectizeAH})
  
  output$checkPracticeAH <- renderUI({
      if (paste(ahP2Select(), collapse=" ") == "") {HTML("Please answer the question by ordering the four banks and then pressing the \"Confirm\" button.")}
      else if (paste(ahP2Select(), collapse=" ") ==  "Bank 1 Bank 2 Bank 4 Bank 3") {
        HTML("<b>You have resolved the exercise correctly, congratulations!</b> <br><br>Use the sidebar menu to explore the other biases available in this app.")
      }
      else {
        HTML("<b>The order is not yet correct</b>, as you did not do it according to the total payable amount or the subsidized APR. Go back to the previous tab to reread the explanation of why this could be an error, or use the sidebar menu to explore the other biases available in this app.")
      }
  })
  
  
  #|######################|#
  #|###### REFORMA #######|#
  #|######################|#
  
  
      ########################
      ####### Inertia ########
      ########################
  

  inP1Text1 <- eventReactive(input$ineButton, {
    cleanToR(input$ineN1)
    })
  inP1Text2 <- eventReactive(input$ineButton, {
    cleanToR(input$ineN2)
    })
  
  #### TRAIN 1 - Feedback ####
  
  output$feedbackine <- renderUI({
      if (is.na(inP1Text1()) || is.na(inP1Text2()) || inP1Text1() < 0 || inP1Text2() < 0) {
          HTML("You introduced an invalid value. To give your answer please use numbers equal to or higher than zero, and use comma for decimal points.")
    }
     else if (inP1Text2() == 0) {
       HTML("You have suggested that you save as much as you can, so <b>you do not appear to suffer from inertia</b> when it comes to preparing for your retirement! Learn more about this bias on the next page."
       )}
     else if (inP1Text2() > 0) {
       HTML("You have suggested that you could save more if you made the effort, so <b>you appear to suffer from inertia</b> when it comes to preparing for your retirement! Learn more about this bias on the next page."
       )}
    })

  
  #### INERTIA PLOT ####
  output$inertiaplot <- renderPlot({
    if (!input$ineButton || is.na(inP1Text1()) || is.na(inP1Text2()) || inP1Text1() < 0 || inP1Text2() < 0) 
      {
      val1 <- 0
      val2 <- 10
      }
    else {
      val1 <- inP1Text1()
      val2 <- inP1Text2()
    }
    # Create the vectors for saved and potential savings
    pres <- seq((val1*12), length.out = 40, (val1*12*40))
    max <- seq(((val2 + val1)*12), length.out = 40, ((val2 + val1)*12*40))
    # Create the empty plot area
    plot(max, type="l", lwd=2, col = "blue", xlab="Years", ylab="Euros", font.lab=2 )
    # Now, populate the graph with the basic structure of the graph
    lines(pres, col = "red", lwd = 2)
    
  })
  
  ### Narrow plot note ###
  output$inertianote <- renderUI({ 
    if(!input$ineButton || is.na(inP1Text1()) || is.na(inP1Text2()) || inP1Text1() < 0 || inP1Text2() < 0) {
      HTML("Imagine that you have answered, in the previous tab, that you save €0 per month, although you could save €10 if you wanted to. If you could save this €10 per month for 40 years, you would have <span style=\"color:blue\"> €4.800</span> to spend in your retirement. On the contrary, if you only save €0 per month, you would have <span style=\"color:red\">€0</span> for your retirement. In other words, your inertia would be costing you <b>€4.800</b>. <br><br><b>Note</b>: If, besides saving this amount, you invested your money in order to get some interest, the cost of your inertia would be even higher, in that you could make even more money (see also the tab about linear thinking).")
      }
    else {
      HTML(paste0("If you saved the €", cleanToP(inP1Text1()+inP1Text2()), " you were able to per month over 40 years, you would 
                 have <span style=\"color:blue\">€", cleanToP((inP1Text1() + inP1Text2())*12*40), "</span> 
                 to use in your retirement. If instead of this you saved only the €", 
                 cleanToP(inP1Text1()), " per month that you currently save, you would have <span style=\"color:red\">€",  
                 cleanToP(inP1Text1()*12*40), "</span> for your retirement. In other words, your inertia may be costing 
                 you <b>€", cleanToP(((inP1Text1() + inP1Text2())*12*40) - (inP1Text1()*12*40)), "</b>.
                 <br><br><b>Note</b>: If, in addition to just saving this money, you invested (for example, in a term deposit or 
                 savings certificate) to earn interest, the cost of inertia would be higher, since you could earn even more money (see also the page on linear thinking)."))
    }
    })
  
  #### TRAIN 2 - Feedback ####
  
  inP2Radio1 <- eventReactive(input$ine2Button, {input$ineN3})
  inP2Radio2 <- eventReactive(input$ine2Button, {input$ineN4})
  inP2Radio3 <- eventReactive(input$ine2Button, {input$ineN5})
  
  output$feedbackine2 <- renderUI({
      if (is.null(inP2Radio1()) || is.null(inP2Radio2()) || is.null(inP2Radio3())) {
        HTML("Please answer every question before clicking \"Confirm\".<br><br>")
      }
      else if (inP2Radio1() <= inP2Radio3() & inP2Radio2() <= inP2Radio3()) {
        HTML("<b>Congratulations! You do not appear to suffer from inertia when it comes to creating budgets</b>.<br>Use the sidebar menu to discover other heuristics and biases!")
      }        
      else {
        HTML("<b>You appear to suffer from inertia when it comes to creating budgets</b>. Consider the techniques mentioned on the previous page to overcome inertia. The use of reminders may be particularly useful in this case.")
      }
  })

  
      ############################
      ####### Exponential ########
      ############################
  
  ## Initial feedback ##
  
  egP1Text <- eventReactive(input$ebButton, {cleanToR(input$ebNum)})
  
  output$feedbackeb <- renderUI({
      if (is.na(egP1Text()) || egP1Text() < 0) {
        HTML("You introduced an invalid value. To give your answer please use numbers equal to or higher than zero, and use comma for decimal points.")
      }
      else if (egP1Text() < 65979) {
        HTML("<b>Your answer gave an amount lower than the real amount, which is: €65.979,18</b>. Explore the page on linear thinking to learn more about why it is sometimes difficult to estimate.")
      }
      else if (egP1Text() > 65980) {
        HTML("<b>Your answer gave an amount higher than the real amount, which is: €65.979,18</b>. Although your answer doesn't reveal the linear thinking heuristic, explore the page on linear thinking to learn more about why it is sometimes difficult to estimate.")
      }
      else {
        HTML("<b>Your answer gave the correct amount, which is: €65.979,18!</b> Explore the page on linear thinking to learn more about why it is sometimes difficult to estimate.")
      }
  })
  
  ## Plot ##
  
  output$egplot <- renderPlot({
    if(!input$ebButton || is.na(egP1Text()) || egP1Text() < 0){val1 <- 0}
    else if (egP1Text() > 75000) {val1 <- 75000}
    else {val1 <- egP1Text()}
    lin1 <- c(0, 6000, 12000, 18000, 24000, 30000, 36000, 42000, 48000)
    exp1<- c(0, 6342.26, 13070.38, 20322.17, 28138.40, 36562.99, 45643.30, 55430.36, 65979.18)
    plot(NULL, ylim=c(0, 75000), xlim = c(1,9), ylab ="Euros", xlab="Years", yaxt ='n', xaxt = 'n', yaxs = "i")
    lines(lin1, col="red", lwd=2)
    lines(exp1, col="blue", lwd=2)
    points(9, val1, pch=16, bg="black")
    axis(1, at=seq(1, 9, 1), labels=c(0, 5, 10, 15, 20, 25, 30, 35, 40))
    axis(2, at=c(0, 32500, 65000), labels=c("€0", "€32.500", "€65.000"))
    legend(1, 75000, legend=c("Zero interest savings", "1,5% (TANB)  interest savings"),
           col=c("red", "blue"), lty=1, bty="n")
    legend(1.57, 66000, legend="Your estimate", col="black", pch=16, bty="n")
  })
  
  
  ## Practice feedback ##
  
  egP2Text <- eventReactive(input$ebpButton, {cleanToR(input$ebpNum)})
  
  output$feedbackebp <- renderUI({
    if (is.na(egP2Text()) || egP2Text() < 0){
      HTML("You introduced an invalid value. To give your answer please use numbers equal to or higher than zero, and use comma for decimal points.")
    }
    else if (egP2Text() < 129000) {
      HTML("<b>Your answer shows linear thinking since you gave an amount lower than the real amount, which is: €133.642,80</b> (the exact value may vary depending on the assumptions of the calculator). Do not forget that you should use an app to perform these types of calculations.<br><br>Use the sidebar menu to discover other heuristics and biases!")
    }
    else if (egP2Text() > 134000) {
      HTML("<b>Your answer gave an amount higher than the real amount, which is: €133.642,80</b> (the exact value may vary depending on the assumptions of the calculator). Although your answer does not reveal the use of linear thinking, it shows that you would have benefited from using an app to perform the calculation.<br><br>Use the sidebar menu to discover other heuristics and biases!")
    }
    else {
      HTML("<b>Your answer is very close to the exact amount!</b> Use the sidebar menu to discover other heuristics and biases!")
    }
  })
  
  
      ############################
      ####### Discounting ########
      ############################
  
  hdP1Radio1 <- eventReactive(input$hdButton, {input$radiohd1})
  hdP1Radio2 <- eventReactive(input$hdButton, {input$radiohd2})
  
  
  output$feedbackhd <- renderUI({
    if(is.null(hdP1Radio1()) || is.null(hdP1Radio2())){
      HTML("Please answer every question before pressing the \"Confirm\" button.<br><br>")
    }
    else if (hdP1Radio1() == hdP1Radio2()) {
      HTML("Your answers reveal an <b>absence</b> of bias, suggesting that the value of waiting a day is constant, whether in the immediate or long term (a year later).
           <br>Go to the next page to learn more about temporal biases.")
    }
    else if (hdP1Radio1() < hdP1Radio2()) {
      HTML("Your answers reveal a <b>present bias</b>, suggesting that the value of waiting a day is higher in the immediate than in the long term (a year later).
           <br>Go to the next page to learn more about temporal biases.")
    }
    else if (hdP1Radio1() > hdP1Radio2()) {
      HTML("Your answers reveal a <b>future bias</b>, suggesting that the value of waiting a day is higher in a year’s time than in the immediate term.
           <br>Go to the next page to learn more about temporal biases.")
    }
  })
  
  ## Plot ##
  
  output$hdplot <- renderPlot({
    par(mar=c(4,4,2,2))
    if(!input$hdButton || is.null(hdP1Radio1()) || is.null(hdP1Radio2())){
      barplot(c(0,1), ylim=c(0,1), names=c("Now", "In a year"), col="blue", yaxt ='n')
      axis(2, at=c(0, 1), labels=c("No", "Yes"))
    }
    else { 
    barplot(c(as.numeric(hdP1Radio1()),as.numeric(hdP1Radio2())), ylim=c(0,1), names=c("Now", "In a year"), col="blue", yaxt ='n')
    axis(2, at=c(0, 1), labels=c("No", "Yes"))
    }
  })
  
  
  output$hdnote <- renderUI({
      if(!input$hdButton || is.null(hdP1Radio1()) || is.null(hdP1Radio2())){
        HTML("If your answer in the previous example was similar to that that most people give in this scenario, you would say that waiting one day to receive an extra amount of €5 would be worth it in the future but not in the present (present bias).")
      }
      else if (hdP1Radio1() == hdP1Radio2()) {
        HTML("You indicated that the value of waiting one day is the same, whether in the immediate or long term (a year later).")
      }
      else if (hdP1Radio1() < hdP1Radio2()) {
        HTML("You indicated that waiting one day to receive an extra €5 is worth it if it is in the future, but not in the present (present bias).")
      }
      else if (hdP1Radio1() > hdP1Radio2()) {
        HTML("You indicated that waiting one day to receive an extra €5 is worth it if it is in the present, but not in the future (future bias).")
      }
  })
  
  
  hdP2Radio1 <- eventReactive(input$hdpButton, {input$radiophd1})
  hdP2Radio2 <- eventReactive(input$hdpButton, {input$radiophd2})
  hdP2Radio3 <- eventReactive(input$hdpButton, {input$radiophd3})
  hdP2Radio4 <- eventReactive(input$hdpButton, {input$radiophd4})
  hdP2Radio5 <- eventReactive(input$hdpButton, {input$radiophd5})
  hdP2Radio6 <- eventReactive(input$hdpButton, {input$radiophd6})
  
  output$feedbackphd <- renderUI({
    if(is.null(hdP2Radio1()) || is.null(hdP2Radio2()) || is.null(hdP2Radio3()) 
    || is.null(hdP2Radio4()) || is.null(hdP2Radio5()) || is.null(hdP2Radio6())
       ){HTML("Please answer every question before pressing the \"Confirm\" button.")}
    else if ((as.numeric(hdP2Radio1()) + as.numeric(hdP2Radio2()) + as.numeric(hdP2Radio3())
              + as.numeric(hdP2Radio4()) + as.numeric(hdP2Radio5())) == 5) {
      HTML("<b>Congratulations! Your answers do not reveal temporal bias!</b>
           <br>Use the sidebar menu to discover the other biases available in this app.")
    }
    else {
      HTML("<b>Your answers reveal some tendency towards temporal bias.</b>
      <br>Go back to the previous tab to reread the explanation of why this is a bias, or use the sidebar menu to discover the other biases available in this app.")
    }
  })
  
  #|####################|#
  #|##### CRÉDITO ######|#
  #|####################|#
  
  
  output$cardplot <- renderPlot({
    par(mar=c(2,3,2,2))
    anos <- c(2013, 2014, 2015, 2016, 2017)
    cardpay <- c(54.4, 58.6, 63.4, 69.7, 75.2)
    debitcards <- c(69.1, 68.9, 67.9, 68.5, 68.6)
    creditcards <- 100-debitcards
    
    plot(NULL, ylim=c(0, 100), xlim = c(1,5), xlab="Years", ylab="", yaxt ='n', xaxt = 'n', yaxs = "i")
    abline(h=seq(0, 100, 10))
    lines(cardpay, col="red", lwd=2)
    lines(creditcards, col="blue", lwd=2)
    axis(1, at=seq(1, 5), labels=anos)
    axis(2, at=seq(0, 100, 10), labels=seq(0, 100, 10))
    legend(0.85, 100, legend=c("Average # of payments per cards per year", "Credit cards as % of all cards"),
           col=c("red", "blue"), lty=1, lwd=2)
  })
  
    
      ########################
      ###### Anchoring #######
      ########################
  
  anP1Text <- eventReactive(input$anchButton, {cleanToR(input$numAN)})
  
  output$feedbackanch <- renderUI({
    if (is.na(anP1Text()) || anP1Text() > 150 || anP1Text() < 0) { 
      HTML("Please enter a number between zero and 150 (and use a comma to enter decimals).")
    }
    else if (anP1Text() == 150) {HTML("Well done! If you allocate all the money you have available to pay off the debt, you will pay as little interest as possible and you will pay your debt off in the quickest amount of time.")}
    else if (anP1Text() > 58.08) {HTML(paste0("Your answer was €", cleanToP(anP1Text()-58.08), " better than the average of participants in a recent study to whom this question was asked. Even so, when paying a credit debt, you should try to pay as much as possible (in this case €150), in order to pay as little interest as possible and get out of debt as quickly as possible"))}
    else if (anP1Text() == 58.08) {HTML("Your answer was equal to the average of participants in a recent study to whom this question was asked. When paying a credit debt, you should try to pay as much as possible (in this case €150), in order to pay as little interest as possible and get out of debt as quickly as possible.")}
    else if (anP1Text() < 58.08) {HTML(paste0("Your answer was €", cleanToP(58.08-anP1Text()), " worse than the average of participants in a recent study to whom this question was asked. When paying a credit debt, you should try to pay as much as possible (in this case €150), in order to pay as little interest as possible and get out of debt as quickly as possible."))}
    })
  
  output$anchplot <- renderPlot({
    labAs <- c("Your answer", "Anchor: €36,43", "Anchor: €60,71")
    if(!input$anchButton || is.na(anP1Text()) || anP1Text() < 0 || anP1Text() > 150) {Yval <- 0}
    else {Yval <- anP1Text()}
    valAs <- c(Yval, 58.08, 77.01)
    barplot(valAs, ylab="Euros", col="blue", names.arg=labAs, ylim=c(0,150), yaxt='n')
    axis(2, at=seq(0, 150, 25), labels=seq(0, 150, 25))
  })
  
  output$anchnote <- renderUI({ 
    if(!input$anchButton || is.na(anP1Text()) || anP1Text() > 150 || anP1Text() < 0) {HTML("You entered an invalid answer for the example presented in the previous tab. Please return to the tab \"Put yourself to the test\" to enter a valid answer.")}
    else if (anP1Text() == 150) {
      HTML("Your answer indicates that you would use all the available money to pay off the credit. Well done! By doing so, you wouldn't be influenced by the anchor, it would only take 9 months to pay off the total amount and you would only pay €38 in interest.")
      }
    else if (anP1Text() <= 8) {
      HTML(paste0("You said that you would use ", cleanToP(anP1Text()), " of your €150 balance. With this amount you would never finish to pay your credit, given that this monthly payment would be equal to or smaller than the interest amount."))
    }
    else {
    # Calculate the number of months until payment
      i <- (0.08 / 12)
      A <- 1214.18
      P <- anP1Text()
      N <- (-log(1 - i * A / P)) / (log(1+i))
      P2 <- 150
      N2 <- (-log(1 - i * A / P2)) / (log(1+i))
    # Calculate total paid in interest
      Tot <- (N * P) - A
      Tot2 <- (N2 * P2) - A
      
      if (floor(N-N2) <= 1) {mes <- "month"}
      else {mes <- "months"}
      comparison <- paste0("<b>You could save €", cleanToP(Tot-Tot2)," and pay the credit off ", floor(N-N2), " ", mes, " earlier if you spent the €150 to pay off the credit.</b>")
      
    # Compare
      if (anP1Text() > 77.01) {
        HTML(paste0("You gave a better answer than the average of people who saw this problem with a minimum payment of €36,43 and even than those who saw a minimum payment of €60,71! ",
                    comparison))
      }
      else if (anP1Text() > 58.081) {
        HTML(paste0(fed <- "You gave a better answer than the average of people who saw this problem with a minimum payment of €36,43 but worse than those who saw a minimum payment of €60,71. ",
                    comparison))
      }
      else if (anP1Text() == 58.081) {
        HTML(paste0("Your answer was similar to the average answer of people who answered this problem with a minimum payment of €36,43, and worse than the average of those who answered the problem with a minimum payment of €60,71. ",
                    comparison))
      }
      else if (anP1Text() < 58.081) {
        HTML(paste0("You gave a worse answer than the average of people who saw this problem with a minimum payment of €36,43 and than the average of those who saw a minimum payment of €60,71. ",
                    comparison))
      }
    }
    })
  
  anP2Text <- eventReactive(input$anpButton, {
    as.numeric(cleanToR(input$textAN))
  })
  
  output$checkPracticeAN <- renderUI({
    intro <- "<br><br>The average price of the presented travel and accommodation package is €3.329. However, the results of a prior study showed that participants were influenced by the anchor value presented to them by the travel agency when they estimated the acceptable value for the same travel and accommodation package. In a clear demonstration of the anchoring effect, the average value estimated by participants exposed to a proposal worth €5.482,95 was €4.307,78, while for participants exposed to a proposal worth €1.165,15, it was €1.986,55.<br><br>"
    if (is.na(anP2Text())|| anP2Text() < 0) {
      HTML("You introduced an invalid value. To give your answer please use numbers equal to or higher than zero, and use comma for decimal points.")
    }
    else if (anP2Text() <= 3994) {
      HTML(paste0("<b>Your answer, €", cleanToP(anP2Text()), ", is within a range of values that suggests you were not very influenced by the travel agency's proposal.</b>", 
                  intro))
    }
    else {
      HTML(paste0("<b>Your answer, €", cleanToP(anP2Text()), ", is within a range of values that suggests you were influenced by the travel agency's proposal.</b>",
                  intro))
    }
  })
  
  output$anchPplot <- renderPlot({
      if (!is.na(anP2Text()) && anP2Text() >= 0) {
        labAs <- c("Your answer", "Anchor: \n€5.482,95", "Anchor: \n€1.165,15")
        Yval <- anP2Text()
        valAs <- c(Yval, 4307.78, 1986.55)
        barplot(valAs, ylab="Euros", col="blue", names.arg=labAs, ylim=c(0,5000), yaxt='n')
        axis(2, at=seq(0, 5000, 1000), labels=seq(0, 5000, 1000))
      }
  })
  
  
  ############################
  ###### Debt aversion #######
  ############################
  
  daP1Text1 <- eventReactive(input$daButton, {cleanToR(input$textDA1)})
  daP1Text2 <- eventReactive(input$daButton, {cleanToR(input$textDA2)})
  daP1Text3 <- eventReactive(input$daButton, {cleanToR(input$textDA3)})
  daP1Text4 <- eventReactive(input$daButton, {cleanToR(input$textDA4)})
  daP1Text5 <- eventReactive(input$daButton, {cleanToR(input$textDA5)})
  daP1Text6 <- eventReactive(input$daButton, {cleanToR(input$textDA6)})
  
  ### 1ST EXERCISE ###
  
  output$debSum <- renderUI({
    da1 <- cleanToR(input$textDA1)
    da2 <- cleanToR(input$textDA2)
    da3 <- cleanToR(input$textDA3)
    da4 <- cleanToR(input$textDA4)
    da5 <- cleanToR(input$textDA5)
    da6 <- cleanToR(input$textDA6)
    if(is.na(da1) || is.na(da2) || is.na(da3) || is.na(da4) || is.na(da5) || is.na(da6) ||
      da1 < 0 || da2 < 0 || da3 < 0 || da4 < 0 || da5 < 0 || da6 < 0 ) {
      HTML("<b>WARNING</b>: There is one (or more) invalid value(s) in your answer.")
    }
    else if (da1 > 3040 || da2 > 5108 || da4 > 12793 || da6 > 9694) {
      HTML("<b>WARNING</b>: One (or more) value(s) in your answer exceeds the outstanding amount of the credit. ")
    }
    else if ((da1+da2+da3+da4+da5+da6) > 15000) {
      HTML("<b>WARNING</b>: You chose a value that exceeds your available amount (€15.000).")
    }
    else{
      paste0("Total to be allocated: ",cleanToP(15000-(da1+da2+da3+da4+da5+da6)), "€")
    }
  })
  
  output$feedbackdebta <- renderUI({
    if (is.na(daP1Text1()) || is.na(daP1Text2()) || is.na(daP1Text3()) || is.na(daP1Text4()) || is.na(daP1Text5()) || is.na(daP1Text6()) ||
        daP1Text1() < 0 || daP1Text2() < 0 || daP1Text3() < 0 || daP1Text4() < 0 || daP1Text5() < 0 || daP1Text6() < 0 ||
        daP1Text1() > 3040 || daP1Text2() > 5108 || daP1Text4() > 12793 || daP1Text6() > 9694
        ) {
      HTML("You entered one or more invalid values. Please enter numbers equal or larger than zero but not larger than the debt value in each Credit. Use commas if you want to enter decimals.")
    }
    else if (daP1Text1() == 0 & daP1Text2() == 0 & daP1Text3() == 15000 &
        daP1Text4() == 0 & daP1Text5() == 0 & daP1Text6() == 0) {
      HTML("<b>Congratulations! You allocated your money appropriately</b>, minimizing your interest payments. Therefore, your debt stood at the lowest possible value: €102.244,40 next month.")
    } 
    else if (daP1Text1()+daP1Text2()+daP1Text3()+
             daP1Text4()+daP1Text5()+daP1Text6() > 15000){
      HTML(paste0("<b>You chose to use a total of €", cleanToP(daP1Text1()+daP1Text2()+daP1Text3()+
                  daP1Text4()+daP1Text5()+daP1Text6()), " when you only had €15.000 available.</b>
                 Please, try again, restricting your credit distributions to the available amount of €15.000."))}
    else {
      jdiv <- c(1.125, 1.1325, 1.14, 1.135, 1.1375, 1.12)
      actdiv <- c((3040-daP1Text1()), (5108-daP1Text2()), (47003-daP1Text3()), 
                  (12793-daP1Text4()), (27410-daP1Text5()), (9694-daP1Text6()))
      totdiv <- sum(jdiv * actdiv)
      HTML(paste0("<b>You did not allocate your money in a way to minimize interest payments</b>.
                 With your choices, you would still owe €", sub( '(?<=.{3})', '.', cleanToP(totdiv), perl=TRUE), ". 
                 If the interest payment had been maximized, that debt would have been only €102.244,40."))
    }
  })

  ### MAIN PAGE ###
  
  output$debplot <- renderPlot({
      if(!input$daButton || is.na(daP1Text1()) || is.na(daP1Text2()) || is.na(daP1Text3()) || is.na(daP1Text4()) || is.na(daP1Text5()) || is.na(daP1Text6()) ||
         daP1Text1() < 0 || daP1Text2() < 0 || daP1Text3() < 0 || daP1Text4() < 0 || daP1Text5() < 0 || daP1Text6() < 0 ||
         daP1Text1() > 3040 || daP1Text2() > 5108 || daP1Text4() > 12793 || daP1Text6() > 9694) {
        val1 <- 3040
        val2 <- 5108
        val3 <- 0
        val4 <- 0
        val5 <- 0
        val6 <- 6852
      }
      else {
        val1 <- daP1Text1()
        val2 <- daP1Text2()
        val3 <- daP1Text3()
        val4 <- daP1Text4()
        val5 <- daP1Text5()
        val6 <- daP1Text6()
      }
      jdiv <- c(1.125, 1.1325, 1.14, 1.135, 1.1375, 1.12)
      actdiv <- c((3040-val1), (5108-val2), (47003-val3), 
                  (12793-val4), (27410-val5), (9694-val6))
      totdiv <- sum(jdiv * actdiv)
      par(mar=c(3,4,4,2))
      barplot(c(102244.40,totdiv), ylim=c(100000,120000), xpd=F, ylab="Total debt (€)", names=c("Lowest remaining debt possible", "Your remaining debt"), col="blue", yaxt ='n')
      axis(2, at=seq(100000, 120000, 10000), labels=seq(100000, 120000, 10000))
  })
  
  output$debnote <- renderUI({
    if (!input$daButton || is.na(daP1Text1()) || is.na(daP1Text2()) || is.na(daP1Text3()) || is.na(daP1Text4()) || is.na(daP1Text5()) || is.na(daP1Text6()) ||
        daP1Text1() < 0 || daP1Text2() < 0 || daP1Text3() < 0 || daP1Text4() < 0 || daP1Text5() < 0 || daP1Text6() < 0 ||
        daP1Text1() > 3040 || daP1Text2() > 5108 || daP1Text4() > 12793 || daP1Text6() > 9694){
      HTML("If your answer in the previous tab was similar to the one most people give in this kind of scenarios (i.e., trying to pay off as many credits as possible, independently of the interest rates charged), you would have to pay €102.465,39, €220,99 more than the amount you would have to pay if you had used the €15,000 to pay the credits with the higher interest rates.")
    }
    else if (daP1Text1() == 0 & daP1Text2() == 0 & daP1Text3() == 15000 & 
             daP1Text4() == 0 & daP1Text5() == 0 & daP1Text6() == 0) {
      HTML("Your choices in the previous tab would have reduced your debts to the minimum amount of €102.244,40.")
      }
    else {
      jdiv <- c(1.125, 1.1325, 1.14, 1.135, 1.1375, 1.12)
      actdiv <- c((3040-daP1Text1()), (5108-daP1Text2()), (47003-daP1Text3()), 
                  (12793-daP1Text4()), (27410-daP1Text5()), (9694-daP1Text6()))
      totdiv <- sum(jdiv * actdiv)
      HTML(paste0("With the choices you made in the previous tab, you would have to pay €",
                 cleanToP(totdiv), ", €", cleanToP((totdiv-102244.40)), " more than if you 
                 had used the €15.000 to write off as much credit as possible from the higher interest debt."))
    }
  })
  
  ### 2ND EXERCISE ###
  
  daP2Selectize <- eventReactive(input$dapButton, {input$selectizeDA})
  
  output$checkPracticeDA <- renderUI({
    if (paste(daP2Selectize(), collapse=" ") ==  "Credit 1 Credit 2 Credit 4 Credit 5 Credit 3") {
      HTML("<b>You have correctly resolved the exercise, eliminating the credits with the highest interest rate to the lowest, congratulations!</b> Use the sidebar menu to explore the other biases available in this app.")
    }
    else {
      HTML("<b>The order is not yet correct</b>, as you have not eliminated credits from the highest to the lowest interest rate. Go back to the previous tab to reread the explanation of why this could be an error, or use the sidebar menu to explore the other biases available in this app.")
    }
  })
  
  #############################
  ###### Pain of paying #######
  #############################
  
  dpP1Radio1 <- eventReactive(input$dpButton, {input$dpN1})
  dpP1Radio2 <- eventReactive(input$dpButton, {input$dpN2})
  
  
  output$feedbackpaina <- renderUI({
    if (is.null(dpP1Radio1()) || is.null(dpP1Radio1())) {
     HTML("Please answer every question before pressing the \"Confirm\" button.") 
    }
    else if (dpP1Radio1() < dpP1Radio2()) {
      HTML("In line with the results usually obtained with similar scenarios, your psychological discomfort when paying with a credit card was less than the psychological discomfort or difficulty you have when paying in cash. Go to the next tab to learn more about this trend.")
    }
    else if (dpP1Radio1() == dpP1Radio2()) {
      HTML("Unlike the results usually obtained with similar scenarios, your psychological discomfort when paying with a credit card was equal to the psychological discomfort or difficulty you have when paying in cash. Go to the next tab to learn more about the typical response pattern in this type of scenario.")
    }
    else{
      HTML("Unlike the results usually obtained with similar scenarios, your psychological discomfort when paying with a credit card was higher than the psychological discomfort or difficulty you have when paying in cash. Go to the next tab to learn more about the typical response pattern in this type of scenario.")
    }
  })
  
  output$dpplot <- renderPlot({
    par(mar=c(4,4,4,2))
    barplot(c(145.56,175.16), ylim=c(0,200), ylab="Average cost estimate", names=c("Using cash", "Using the credit card"), col="blue", yaxt ='n')
    axis(2, at=seq(0, 200, 10), labels=seq(0, 200, 10))
  })
  
  ## Practice ###
  
  dpP2Text1 <- eventReactive(input$dppButton, {cleanToR(input$dppN1)})
  dpP2Text2 <- eventReactive(input$dppButton, {cleanToR(input$dppN2)})
  dpP2Text3 <- eventReactive(input$dppButton, {cleanToR(input$dppN3)})
  dpP2Text4 <- eventReactive(input$dppButton, {cleanToR(input$dppN4)})
  
  output$dpSum <- renderUI({
    dp1 <- cleanToR(input$dppN1)
    dp2 <- cleanToR(input$dppN2)
    dp3 <- cleanToR(input$dppN3)
    dp4 <- cleanToR(input$dppN4)
    if(is.na(dp1) || is.na(dp2) || is.na(dp3) || is.na(dp4) ||
       dp1 < 0 || dp2 < 0 || dp3 < 0 || dp4 < 0 ) {
      HTML("<b>WARNING</b>: There is one (or more) invalid value(s) in your answer.")
    }
    else {
      HTML(paste0("Total: €", cleanToP(dp1+dp2+dp3+dp4)))
    }
  })
  
  
  output$checkPracticeDP <- renderUI({
      totcost <- dpP2Text1()+dpP2Text2()+dpP2Text3()+dpP2Text4()
      if (is.null(input$dpN0) || is.na(cleanToR(input$dpN0))){
        HTML("In order to receive feedback in this exercise/example, please give your answer in the first tab of this page (\"Put yourself to the test\") using a valid value.")
      }
      else if (is.na(totcost) || dpP2Text1() < 0 || dpP2Text2() < 0 || dpP2Text3() < 0 || dpP2Text4() < 0 ) {
        HTML("You used one (or more) invalid value(s). Please use only numbers (e.g., 10) equal to or higher than 0, and use commas for decimal points. ")
      }
      else if (totcost < input$dpN0) {
        HTML("In line with the results usually obtained with similar scenarios, you estimated a lower value than in the first exercise. This occurs because when people make estimates per item and not on the basis of the total cost, they tend to notice that the amount inflates more quickly and thus try to spend less money.")
      }
      else if (totcost == input$dpN0) {
        HTML("Unlike the results usually obtained with similar scenarios, you estimated the same value as in the first exercise. People generally estimate lower values in this second exercise because, when they make estimates per item and not on the basis of the total cost, they tend to notice that the amount inflates more quickly and thus try to spend less money.")
      }
      else{
        HTML("Unlike the results usually obtained with similar scenarios, you estimated a higher value than in the first exercise. People generally estimate lower values in this second exercise because, when they make estimates per item and not on the basis of the total cost, they tend to notice that the amount inflates more quickly and thus try to spend less money.")
      }
  })
  
  
}
