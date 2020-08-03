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
    labs <- c("Outros","Educação","Saúde","Lazer, recreação e cultura",
              "Vestuário e calçado","Restaurantes e hóteis", 
              "Transportes e comunicações", "Habitação, água, luz, gás", 
              "Alimentação, bebidas e tabaco")
    vals <- c((10.6+4.8),1.5,5.3,5.5,
              6.4,12.2,
              15.2,18.3,
              20.1)
    par(mar=c(4,13,0,1))
    barplot(vals, xlab="%", xlim=c(0,25), names = labs, las=1, cex.names=1, col="blue", horiz = T)
  })
  
  
      ########################
      ###### Impulsive #######
      ########################
  
  faP1Radio <- eventReactive(input$faButton, {input$radioFA})
  
  output$feedbackFA <- renderUI({
    if (is.null(faP1Radio())) {HTML("Por favor, responda ao exercício e volte a pressionar o botão \"Confirmar\".")} 
    else if (faP1Radio() < 3) {"Muito bem! A resposta que indicou sugere uma boa autorregulação do comportamento." }
    else {"A resposta que indicou revela falta de autorregulação do comportamento. Carregue no botão \"Continuar\" para aprender mais sobre este enviesamento."}
  })
  
  ### Legenda ###
  
  output$noteFA <- renderUI({
    if (!input$faButton || is.null(faP1Radio()) || faP1Radio() == 3) {HTML('<img src="Sweat.png" width="100%"><br><br>A Maria só tinha 25€ para pagar as suas despesas e ia só fazer uma compra de 4€. Se comprar as meias (4€) e a camisola (75€), usando o cartão de crédito, a Maria continua a ter 25€ em dinheiro para gastar no fim-de-semana, mas já começa o próximo mês com 79€ a menos!')}
    else if (faP1Radio() == 4) {HTML('<img src="Sweat2.png" width="100%"><br><br>A Maria só tinha 25€ para pagar as suas despesas e ia só fazer uma compra de 4€. Se comprar as meias (4€), a camisola (75€) e ainda as calças (30€) e a blusa (20€) a condizer, usando o cartão de crédito, a Maria continua a ter 25€ em dinheiro para gastar no fim-de-semana, mas já começa o próximo mês com 129€ a menos!')}
    else {HTML('<img src="Sweat.png" width="100%"><br><br>A Maria só tinha 25€ para pagar as suas despesas e ia só fazer uma compra de 4€. Se só comprar as meias, cumpre o seu orçamento e fica ainda com 21€ para gastar em comida nos dois dias que restam.')}
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
      dic2 <- c("Ir às compras com fome.", "Ir às compras quando se sente frustrado/a, cansado/a, irritado/a, deprimido/a, etc.",
                "Ir passear/desanuviar em centros comerciais ou lojas.", "Pensar \"uma vez não são vezes\".", "Guardar a informação do cartão de crédito no explorador de internet para facilitar compras futuras.")
      dic1 <- vector(mode="list", length=5)
      names(dic1) <- answerK
      dic1[answerK] <- c("Levar uma lista de compras.", "Saber distinguir quando se aproveita um desconto para poupar de quando se aproveita um desconto para gastar dinheiro.",
                         "Registar as compras não essenciais que vai desejando fazer e adiar a compra para uma próxima vez (por exemplo, quando tiver poupado dinhero para isso).",
                         "Deixar o cartão em casa e levar só a quantia que está disposto/a a gastar.", "Comprometer-se a só comprar algo novo quando o que já tem antigo estiver de facto estragado.")
      dic2 <- vector(mode="list", length=5)
      names(dic2) <- answerF
      dic2[answerF] <- c("Ir às compras com fome.", "Ir às compras quando se sente frustrado/a, cansado/a, irritado/a, deprimido/a, etc.",
                         "Ir passear/desanuviar em centros comerciais ou lojas.", "Pensar \"uma vez não são vezes\".", "Guardar a informação do cartão de crédito no explorador de internet para facilitar compras futuras.")
      clear1 <- intersect(faP2Check(), answerK)
      for (i in clear1) {dic1[i] <- NULL}
      clear2 <- intersect(faP2Check(), answerF)
      
      if(5-length(clear1)>0){
        intro1 <- "Os comportamentos/pensamentos que ajudam a evitar a compra impulsiva, mas que você não selecionou foram:<br><ul><li>"
        mid1 <- paste(dic1, collapse="</li><li>")
        end1 <- "</li></ul>"
        in1 <- paste(intro1, mid1, end1, sep="")
      } else {in1 <- ""}
      
      if(length(clear2)>0) {
        intro2 <- "Os comportamentos/pensamentos que <b>não</b> ajudam a evitar a compra impulsiva, mas que você selecionou foram:<br><ul><li>"
        mid2 <- paste(dic2[clear2], collapse="</li><li>")
        end2 <- "</li></ul>"
        ex1 <- paste(intro2, mid2, end2, sep="")
      } else {ex1 <- ""}
      included <- length(intersect(faP2Check(), answerK))
      excluded <- 5 - length(intersect(faP2Check(), answerF)) 
      if (included+excluded == 10) {ex1 <- "<b>Selecionou todas as respostas correctas e nenhuma das incorrectas, parabéns!</b><br>"}
      HTML(paste("<b>Você escolheu ", included, " das 5 opções correctas e rejeitou correctamente ", 
                  excluded, " das 5 opções incorrectas.</b><br>",
                 in1, ex1, "Utilize o menu lateral para descobrir mais heurísticas e enviesamentos!", sep=""))
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
      HTML("Por favor, responda ao exercício e volte a pressionar o botão \"Confirmar\".")
    }  
    else if (mabP1Radio() == "0"){
      HTML("<b>Parabéns, fez a escolha mais acertada!</b> Ao usar o dinheiro que tinha poupado para as férias para liquidar a dívida do cartão de crédito, evitou o pagamento de juros. Avance para o separador seguinte para saber mais sobre o viés/enviesamento que leva muitas pessoas a escolher as opções b) ou c).")
    }
    else if (mabP1Radio() != "0"){
      HTML("<b>A sua escolha demonstra que a sua contabilidade mental pode estar a prejudicar as suas finanças pessoais.</b> Avance para o separador seguinte para saber mais sobre o viés/enviesamento contabilidade mental.")
    }
    else {HTML("")}
  })
  
  
  output$plotCM <- renderPlot({
      par(mar=c(4,4,4,2))
      barplot(c(600,754.83,1076.61), ylim=c(0,1100), ylab="Custo total em Euros", names=c("Opção a)", "Opção b)", "Opção c)"), col="blue", yaxt ='n')
      axis(2, at=seq(0, 1100, 100), labels=seq(0, 1100, 100))
      
  })

  maP2Radio1 <- eventReactive(input$CMpButton, {input$radioP1CM})
  maP2Radio2 <- eventReactive(input$CMpButton, {input$radioP2CM})
  maP2Radio3 <- eventReactive(input$CMpButton, {input$radioP3CM})


  output$checkPracticeCM <- renderUI({
      if (is.null(maP2Radio1())||is.null(maP2Radio2())||is.null(maP2Radio3())) {
        HTML("Por favor, responda a todas as perguntas do exercício e volte a pressionar o botão \"Confirmar\".")
      }
      else if (maP2Radio1() == maP2Radio2() & maP2Radio2() == maP2Radio3()) {
        HTML("<b>A sua resposta não revelou que faça contabilidade mental, parabéns!</b> Utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.")
      }
      else {
        HTML("<b>A sua resposta revelou que faz contabilidade mental</b>, já que atribuiu pesos diferentes para sapatos que na realidade custam sempre o mesmo (75€). Volte ao separador anterior para reler a explicação de porque tal pode ser um enviesamento ou utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.")
      }
  })

  
  ###############################
  ###### Opportunity costs ######
  ###############################
  
  coP1Radio1 <- eventReactive(input$coButton, {input$radioCO1})
  coP1Radio2 <- eventReactive(input$coButton, {input$radioCO2})
  
  output$feedbackCO <- renderUI({
    if (is.null(coP1Radio1()) || is.null(coP1Radio2())) {
      HTML("Por favor, responda a todas as perguntas do exercício e volte a pressionar o botão \"Confirmar\".")
    }
    else{
      if (coP1Radio1() == "0") {
        felc1 <- "não "
        cost1 <- 0
        }
      else {
        felc1 <- ""
        cost1 <- 14.99}
      if (coP1Radio2() == "0") {
        felc2 <- "3,99€ "
        cost2 <- 3.99}
      else {
        felc2 <- "10€ "
        cost2 <- 10
      }
      HTML(paste("Optou por ", felc1, "gastar 14,99€ no primeiro cenário e por gastar ", felc2, 
            "no segundo cenário. Gastando um total de ", gsub("\\.", ",",(cost1+cost2)) , "€. Lembra-se de ter pensado
            noutras formas de gastar estes ", gsub("\\.", ",",(cost1+cost2)), "€?", sep=""))
    }
  })
  
  output$plotCO1 <- renderPlot({
    par(mar=c(4,4,4,2))
    barplot(c(75,25,55,45), ylim=c(-10,100), ylab="% que escolhe opção", names=c("Comprar \no disco", "Não comprar \no disco", "Comprar \no disco", "Não comprar o disco e \nguardar o dinheiro \npara outras compras"), col="blue", yaxt ='n')
    axis(2, at=seq(0, 100, 10), labels=seq(0, 100, 10))
    lines(c(2.5,2.5), c(0,100))
    abline(h=0)
  })
  
  output$plotCO2 <- renderPlot({
    par(mar=c(4,4,4,2))
    barplot(c(40,60,60,40), ylim=c(-10,100), ylab="% que escolhe opção", names=c("Comprar a \ngarrafa de \n10€", "Comprar a garrafa de \n3,99€ e guardar 6,01€ \npara outras compras", "Comprar a \ngarrafa de \n10€", "Comprar a \ngarrafa de \n3,99€"), col="blue", yaxt ='n')
    axis(2, at=seq(0, 100, 10), labels=seq(0, 100, 10))
    lines(c(2.5,2.5), c(0,100))
    abline(h=0)
  })
  
  output$plotnoteOC1 <- renderUI({
    if (!input$coButton || is.null(coP1Radio1())) {
      HTML("Cerca de 75% dos participantes a quem colocámos a primeira questão do separador anterior
      tendem escolher comprar o disco. No entanto, quando a opção de não 
      comprar o disco é apresentada como “não comprar o disco e guardar os 14,99€ 
      para outras compras”, a percentagem de participantes que escolhe comprar o 
      disco baixa para 55%.<br>")
    } else {
      if (input$radioCO1 == "0") {elif1 <- "não comprar o disco. Cerca de 25% "}
      else {elif1 <- "comprar o disco. Cerca de 75% "}
      HTML(paste("No cenário de compra do disco escolheu ", elif1, "dos participantes a quem colocámos esta questão 
      tendem a dar a mesma resposta neste cenário. No entanto, quando a opção de não 
      comprar o disco é apresentada como “não comprar o disco e guardar os 14,99€ 
      para outras compras”, a percentagem de participantes que escolhe comprar o 
      disco baixa para 55%.<br>", sep=""))
    }
  })
  
  output$plotnoteOC2<- renderUI({
    if (!input$coButton || is.null(coP1Radio2())) {
      HTML("Cerca de 40% dos participantes a quem colocámos a segunda questão do separador anterior 
      tendem a escolher comprar a garrafa de 10€. No entanto,
      quando a opção de comprar a garrafa de 3,99€ é apresentada sem salientar a sobra 
      de 6,01€ para outras compras, a percentagem de participantes que escolhe comprar 
      a garrafa de 10€ sobe para 60%.")
    }
    else {
      if (input$radioCO2 == "0") {elif2 <- "comprar a garrafa de 3,99€ e guardar 6,01€ para outras compras. Cerca de 60% "}
      else {elif2 <- "comprar a garrafa de 10€. Cerca de 40% "}
      HTML(paste("No cenário de compra da garrafa escolheu ", 
                 elif2,"dos participantes a quem colocámos esta questão tendem a dar a mesma resposta neste cenário. No entanto,
      quando a opção de comprar a garrafa de 3,99€ é apresentada sem salientar a sobra 
      de 6,01€ para outras compras, a percentagem de participantes que escolhe comprar 
      a garrafa de 10€ sobe para 60%.", sep=""))
    }
  })
  
  cob2 <- eventReactive(input$copButton, 1)
  
  coP2Radio1 <- eventReactive(input$copButton, {input$radioCOP1})
  coP2Radio2 <- eventReactive(input$copButton, {input$radioCOP2})
  
  output$checkPracticeCO <- renderUI({
    if (is.null(coP2Radio1)||is.null(coP2Radio2())) {
      HTML("Por favor, responda a todas as perguntas do exercício e volte a pressionar o botão \"Confirmar\".")
    }
    else{
      if (coP2Radio1() == coP2Radio2()) {
      HTML("<b>Parabéns! As suas respostas não sugerem que ignore custos de oportunidade.</b><br>
            Utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.
           ")}
      else {
        HTML("<b>As suas respostas sugerem que ignorou custos de oportunidade, já que alterou o seu julgamento após receber informação sobre outros usos para os 1500€ que poupou.</b><br>
            Volte ao separador anterior para reler a explicação sobre custos de oportunidade ou utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.")
      }
    }
  })
    
  
  #|###################|#
  #|###### CASA #######|#
  #|###################|#
  
  output$casaplot <- renderPlot({
    anos <- c(2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017, 2018)
    perc <- c(60.89247599,63.19971239,61.39671518,65.13688402,58.60240964,54.42085618,56.30013369,44.05194333,25.76221542,31.17199391,31.79008106,43.25285622,50.53237912,57.16163853,60.27699473)
    plot(NULL, ylim=c(0, 100), xlim = c(1,15), ylab ="%", xlab="Anos", xaxt = 'n', yaxs = "i")
    abline(h=seq(0, 100, 10))
    lines(perc, col="blue", lwd=3)
    axis(1, at=seq(1, 15, 1), labels=anos)
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
      HTML("Por favor, responda ao exercício e volte a pressionar o botão \"Confirmar\".")
    } else if (sizeBT() >= 30) {
      HTML("Muito bem! Listou um número igual (ou superior) ao número de bancos existentes em Portugal. Confirme abaixo se listou todos correctamente:
           <br>
            <table width=\"100%\">
            <tr>
            <td style=\"padding: 15px;\">
            <li>Banco ActivoBank</li><li>Banco Altântico Europa</li><li>Banco BIC</li><li>Banco BPI</li><li>Banco BNP Paribas</li><li>Banco BAI Europa</li><li>Banco Carregosa</li><li>Banco Comercial Português</li><li>Banco Credibom</li><li>Banco CTT</li><li>Banco de Investimento Global (BIG)</li><li>Banco de Investimento Imobiliário</li><li>Banco Efisa</li><li>Banco Finantia</li><li>Banco Invest</li></td>
            <td style=\"padding: 15px;\"><li>Banco Madesant</li><li>Banco Português de Gestão</li><li>Banco Português de Investimento (BPI)</li><li>Banco Primus</li><li>Banco Santander</li><li>Banco Santander Totta</li><li>BEST - Banco Eletrónico de Serviço Total</li><li>Bison Bank</li><li>BNI - Banco de Negócios Internacional</li><li>Caixa Geral de Depósitos</li><li>Caixa - Investimento</li><li>Haitong Bank</li><li>Montepio</li><li>Novo Banco</li><li>Novo Banco dos Açores</li></td>
            </tr>
            </table>
           <br>
           Veja a lista atualizada <a href=\"https://www.bportugal.pt/entidades-autorizadas/67/all\">no site do Banco de Portugal</a>.")
    } else if (sizeBT() > 0) {
      HTML(paste('Listou ', sizeBT(), 'banco(s)! Porém, existem 30 bancos legais em Portugal:
           <br>
            <table width=\"100%\">
            <tr>
            <td style=\"padding: 15px;\">
            <li>Banco ActivoBank</li><li>Banco Altântico Europa</li><li>Banco BIC</li><li>Banco BPI</li><li>Banco BNP Paribas</li><li>Banco BAI Europa</li><li>Banco Carregosa</li><li>Banco Comercial Português</li><li>Banco Credibom</li><li>Banco CTT</li><li>Banco de Investimento Global (BIG)</li><li>Banco de Investimento Imobiliário</li><li>Banco Efisa</li><li>Banco Finantia</li><li>Banco Invest</li></td>
            <td style=\"padding: 15px;\"><li>Banco Madesant</li><li>Banco Português de Gestão</li><li>Banco Português de Investimento (BPI)</li><li>Banco Primus</li><li>Banco Santander</li><li>Banco Santander Totta</li><li>BEST - Banco Eletrónico de Serviço Total</li><li>Bison Bank</li><li>BNI - Banco de Negócios Internacional</li><li>Caixa Geral de Depósitos</li><li>Caixa - Investimento</li><li>Haitong Bank</li><li>Montepio</li><li>Novo Banco</li><li>Novo Banco dos Açores</li></td>
            </tr>
            </table>
           Veja a lista atualizada <a href=\"https://www.bportugal.pt/entidades-autorizadas/67/all\">no site do banco de Portugal</a>.'))
    }
    })
  
  #### NARROW PLOT ####
  output$narrowplot <- renderPlot({
    # Create the structure of the plot as a 6 by 5 grid
    x <- rep(seq(1,6), 5)
    y <- rep(seq(1,5), 6)
    y <- y[order(y)]
    
    # Create the empty plot area
    plot(NULL, xlim=c(0.90,6.10), ylim=c(0.90,5.10), xaxt = 'n', yaxt = 'n', 
         bty = 'n', pch = '', ylab = '', xlab = '', xaxs="i", yaxs="i")
    
    # Now, populate the graph with the basic structure of the graph
    points(x, y, pch=21, lwd=10)
    
    # Figure out which points to turn red
    if (!input$banksButton || is.null(sizeBT()) || sizeBT() < 1) {uc <- 7}
    else if (sizeBT() > 30) {uc <- 30}
    else {uc <- sizeBT()}
    
    xS <- x[1:(uc)]
    yS <- y[1:(uc)]
    
    # And paint them
    points(xS, yS, pch=21, col="red", lwd=10)
    
  })
  
  ### Narrow plot note ###
  output$narrownote <- renderUI({
    if (!input$banksButton || is.null(sizeBT()) || sizeBT() < 1) {
      HTML("<p style=\"margin-left: 10%;\">Imaginando que conhecia só 7 bancos, o banco com melhores condições poderia ser um dos 23 que não considerou.</p>")
    } else if (sizeBT() >= 30) {
      HTML(paste('Conhecendo todas as opções do atual universo bancário (círculos vermelhos), tem a certeza de poder encontrar aquela com melhores opções.'))
    } else if (sizeBT() == 29){
      HTML(paste('Conhecendo ', sizeBT(), 'bancos (círculos vermelhos), o banco com melhores condições poderia ainda assim ser aquele (círculo preto) que não considerou do atual universo bancário.'))
    } else if (sizeBT() == "1"){
      HTML(paste('Conhecendo apenas um banco (círculo vermelho), o banco com melhores condições poderia ser um dos 29 (círculos pretos) que não considerou do atual universo bancário.'))
    } else {
      HTML(paste('Conhecendo ', sizeBT(), 'bancos (círculos vermelhos), o banco com melhores condições poderia ser um dos ', 30-sizeBT(), ' (círculos pretos) que não considerou do atual universo bancário.'))
    }
    })
  
  ### Feedback Buy ###
  
  sizeBT1 <- eventReactive(input$buyButton, {
    cleanBT1 <- gsub("[[:space:]]", "", input$buyText)
    length(strsplit(cleanBT1, ",")[[1]])
  })
  
  output$feedbackBuy <- renderUI({
    if (sizeBT1() == 0) {
      HTML("Por favor, responda ao exercício e volte a pressionar o botão \"Confirmar\".")
    } else if (sizeBT1() >= 10) {
      HTML("Muito bem! Listou pelo menos tantas opções como nós! Será que ainda assim demonstrou pensamento estreito? Para saber, veja se alguma das 10 opções abaixo poderia complementar a sua resposta:
            <ul>
              <li>Agências imobiliárias</li><li>Bolsas de imóveis de bancos</li>
              <li>Hastas públicas de património</li><li>Jornais ou revistas</li>
              <li>Leilões de imóveis privados</li>
              <li>Leilões de imóveis penhorados pelas Finanças</li>
              <li>Leilões de imóveis penhorados pela Segurança Social</li>
              <li>Perguntar a amigos ou conhecidos por oportunidades</li>
              <li>Ter atenção na rua a anúncios colocados diretamente nos imóveis</li>
              <li>Sites online</li>
            </ul>
           <p>Utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.</p>")
    } else if (sizeBT1() == 1){
      HTML(paste('Listou apenas uma opção! Será que ainda demonstrou pensamento estreito? Para saber, veja se alguma das 10 opções abaixo poderia complementar a sua resposta:
           <ul>
              <li>Agências imobiliárias</li><li>Bolsas de imóveis de bancos</li>
              <li>Hastas públicas de património</li><li>Jornais ou revistas</li>
              <li>Leilões de imóveis privados</li>
              <li>Leilões de imóveis penhorados pelas Finanças</li>
              <li>Leilões de imóveis penhorados pela Segurança Social</li>
              <li>Perguntar a amigos ou conhecidos por oportunidades</li>
              <li>Ter atenção na rua a anúncios colocados diretamente nos imóveis</li>
              <li>Sites online</li>
            </ul>
            <p>Utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.</p>'))
    } else {
      HTML(paste('Listou ', sizeBT1(), 'opções! Será que ainda demonstrou pensamento estreito? Para saber, veja se alguma das 10 opções abaixo poderia complementar a sua resposta:
           <ul>
              <li>Agências imobiliárias</li><li>Bolsas de imóveis de bancos</li>
              <li>Hastas públicas de património</li><li>Jornais ou revistas</li>
              <li>Leilões de imóveis privados</li>
              <li>Leilões de imóveis penhorados pelas Finanças</li>
              <li>Leilões de imóveis penhorados pela Segurança Social</li>
              <li>Perguntar a amigos ou conhecidos por oportunidades</li>
              <li>Ter atenção na rua a anúncios colocados diretamente nos imóveis</li>
              <li>Sites online</li>
            </ul>
            <p>Utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.</p>'))
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
      HTML("Por favor, responda a todas as perguntas e volte a carregar no botão \"Confirmar\".<br><br>")
    }
    else if ((as.numeric(opP1Radio1()) + as.numeric(opP1Radio2()) + 
              as.numeric(opP1Radio3()) + as.numeric(opP1Radio4())) <
             (as.numeric(opP1Radio5()) + as.numeric(opP1Radio6()) + 
              as.numeric(opP1Radio7()) + as.numeric(opP1Radio8()))) {
      HTML("<b>As suas respostas revelaram alguma tendência para otimismo irrealista!</b> Carregue no botão continuar para aprender mais sobre este enviesamento.")
    }
    else {
      HTML("<b>Parabéns, as suas respostas não revelaram tendência para otimismo irrealista!</b> Ainda assim, dado que a maioria das pessoas revela tal enviesamento, carregue no botão continuar para aprender mais sobre este enviesamento.")
    }
  })
  
  
  output$plotOI <- renderPlot({
    if (!input$OIpButton || is.null(opP1Radio1()) || is.null(opP1Radio2()) || is.null(opP1Radio3())
        || is.null(opP1Radio4()) || is.null(opP1Radio5()) || is.null(opP1Radio6())
        || is.null(opP1Radio7()) || is.null(opP1Radio8())){
      par(mar=c(2.5,4,2,4))
      barplot(c(2,9), ylim=c(1,10), xpd=F, names=c("Acontecimentos \nPositivos", "Acontecimentos \nNegativos"), col="blue", yaxt ='n')
      axis(2, at=seq(1, 10), labels=seq(1, 10))
    }
    else {
      posiT <- (as.numeric(opP1Radio1()) + as.numeric(opP1Radio2()) + 
                as.numeric(opP1Radio3()) + as.numeric(opP1Radio4())) / 4
      negaT <- (as.numeric(opP1Radio5()) + as.numeric(opP1Radio6()) + 
                as.numeric(opP1Radio7()) + as.numeric(opP1Radio8())) / 4
      par(mar=c(2.5,4,2,4))
      barplot(c(posiT,negaT), ylim=c(1,10), xpd=F, names=c("Acontecimentos \nPositivos", "Acontecimentos \nNegativos"), col="blue", yaxt ='n')
      axis(2, at=seq(1, 10), labels=seq(1, 10))
    }
    })
  
  output$noteplotOI <- renderUI({
    if (!input$OIpButton || is.null(opP1Radio1()) || is.null(opP1Radio2()) || is.null(opP1Radio3())
        || is.null(opP1Radio4()) || is.null(opP1Radio5()) || is.null(opP1Radio6())
        || is.null(opP1Radio7()) || is.null(opP1Radio8())){
      HTML("Por exemplo, imagine que tinha respondido a todas as perguntas do separador anterior e as suas médias de respostas para os acontecimentos positivos e negativos eram iguais às do gráfico acima. Tal seria um exemplo de otimismo irrealista, já que este viés tende a emergir quando a barra dos acontecimentos positivos é menor que a dos negativos e será tanto maior quanto maior for esta diferença.")
    }
    else {
      HTML("Com base no exercício anterior, apresentamos, no gráfico acima, a sua média de respostas para os acontecimentos positivos e negativos.
          O otimismo irrealista tende a emergir quando a barra dos acontecimentos positivos é menor que a dos negativos e será tanto maior quanto maior for esta diferença.")
    }
    })
  
  
  opP2Slide1 <- eventReactive(input$oiButton, {input$oiN1})
  opP2Slide2 <- eventReactive(input$oiButton, {input$oiN2})
  opP2Slide3 <- eventReactive(input$oiButton, {input$oiN3})
  opP2Slide4 <- eventReactive(input$oiButton, {input$oiN4})
  
  output$feedbackOI <- renderUI({
    if (input$oiButton) {
      if (opP2Slide1() <= 50 & opP2Slide2() >= 10 & opP2Slide3() <= 8 & opP2Slide4() >= 4) {
        pre <- "<b>Não parece sofrer de otimismo irrealista,</b> pois acertou sempre ou deu estimativas mais pessimistas do que as reais.<br>"
      }
      else {
        pre <- "<b>Algumas das suas respostas revelaram alguma tendência para manifestar otimismo irrealista.</b><br><br>"
      }
      a1 <- paste("<a href=\"https://www.pordata.pt/Portugal/Esperan%c3%a7a+de+vida+%c3%a0+nascen%c3%a7a+total+e+por+sexo+(base+tri%c3%a9nio+a+partir+de+2001)-418\">A probabilidade</a> de ultrapassar a esperança média de vida para quem nasceu em 2017 (84 anos para as mulheres ou 78 anos para os homens) é de cerca de 50%, disse: ",opP2Slide1(), "%.<br>", sep="")
      a2 <- paste("<a href=\"https://www.pordata.pt/Portugal/Cr%c3%a9dito+malparado+particulares+devedores+e+montantes+(percentagem)-2952\">A probabilidade</a> de entrar em incumprimento no pagamento dos créditos é de cerca de 10%, disse: ",opP2Slide2(), "%.<br>", sep="")
      a3 <- paste("<a href=\"https://www.e-konomista.pt/probabilidade-de-ganhar-o-euromilhoes/\">A probabilidade</a> de ganhar um prémio no Euromilhões é de cerca de 8%, disse: ", opP2Slide3(), "%.<br>", sep="" )
      a4 <- paste("<a href=\"https://www.pordata.pt/Portugal/Acidentes+de+trabalho+total+e+mortais-72\">A probabilidade</a> de ter um acidente de trabalho é de cerca de 4%, disse: ", opP2Slide4(), "%.<br><br>", sep="")
      HTML(paste(pre, 
                 "Neste exercício usámos, no geral, dados da Pordata como indicador grosseiro da probabilidade de cada uma das situações apresentadas na vida dos portugueses.<br><br>",
                 
                 a1,a2,a3,a4,"<b>Lembre-se que a tendência para manifestar otimismo irrealista tem consequências para a forma como encara as suas decisões financeiras!</b><br><br>Utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação."), sep="")
      }
  })
  
  
  ###########################
  ###### Availability #######
  ###########################
  
  ahP1Radio <- eventReactive(input$ahButton, {input$checkGroupAH})
  
  output$feedbackAH <- renderUI({
    if (is.null(ahP1Radio())) {
      HTML("Por favor, dê primeiro uma resposta à pergunta.")
    }
    else if ("6" == ahP1Radio() | "8" == ahP1Radio()) {
      HTML("Escolheu um dos critérios de comparação mais adequados! Avance para o separador seguinte para saber mais sobre os critérios que melhor permitem a comparação de diferentes propostas de crédito.")
    }
    else {
      HTML("Embora tenha escolhido um critério válido, este não é dos mais adequados para a comparação das diferentes propostas. Avance para o separador seguinte para saber porquê.")
    }
  })
  
  ahP2Select <- eventReactive(input$AHpButton, {input$selectizeAH})
  
  output$checkPracticeAH <- renderUI({
      if (paste(ahP2Select(), collapse=" ") == "") {HTML("Por favor, responda à pergunta ordenando todos os quatro bancos e carregando de novo no botão \"Confirmar\".")}
      else if (paste(ahP2Select(), collapse=" ") ==  "Banco 1 Banco 2 Banco 4 Banco 3") {
        HTML("<b>Resolveu corretamente o exercício, parabéns!</b> <br><br>Utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.")
      }
      else {
        HTML("<b>A ordem não está, ainda, correcta</b>, já que não ordenou todos os bancos em função do montante total a reembolsar ou do TAEG com bonificação. <br><br>Volte ao separador anterior para reler a explicação de porque tal pode ser um erro e corrija a sua resposta, ou utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.")
      }
  })
  
  
  #|######################|#
  #|###### REFORMA #######|#
  #|######################|#
  
  output$reformplot <- renderPlot({
    
      vel <- c(260.83,313.83,333.62,348.48,361.89,377.49,389.11,399.09,408.51,395.28,421.08,427.35,416.89,427.62,436.39)
      pobre <- c(345.75,359.75,365.5,378.67,407.17,414.08,433.92,420.5,416.17,408.83,411.42,421.75,439.08,453.58,467.25)
      labs <- c(seq(2003, 2017, 5), 2017)
      plot(NULL, xlim=c(1,15), ylim=c(260,470), xlab="Ano", ylab="Euros por mês", xaxt="n")
      axis(1, at=c(seq(1, 15, 5), 15), labels=labs)
      
      # Now, populate the graph with the basic structure of the graph
      lines(pobre, col="red", lwd=2)
      lines(vel, col = "blue", lwd = 2)
      
      legend(8, 300, legend=c("Limiar de risco de pobreza", "Pensão de reforma média"),
             col=c("red", "blue"), lty=1)
      
  })
  
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
        HTML("Introduziu um valor inválido. Por favor, insira apenas números iguais ou superiores a zero para responder a esta pergunta e utilize a vírgula para separar casas decimais.")
    }
     else if (inP1Text2() == 0) {
       HTML("Indicou que poupa tanto quando poderia poupar, por isso <b>não parece sofrer 
       de inércia</b> na preparação da reforma! Aprenda mais sobre este viés na página seguinte."
       )}
     else if (inP1Text2() > 0) {
       HTML("Indicou que poderia poupar mais se se esforçasse, por isso <b>parece sofrer 
       de inércia</b> na preparação da reforma! Aprenda mais sobre este viés na página seguinte."
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
    plot(max, type="l", lwd=2, col = "blue", xlab="Anos", ylab="Euros", font.lab=2 )
    # Now, populate the graph with the basic structure of the graph
    lines(pres, col = "red", lwd = 2)
    
  })
  
  ### Narrow plot note ###
  output$inertianote <- renderUI({ 
    if(!input$ineButton || is.na(inP1Text1()) || is.na(inP1Text2()) || inP1Text1() < 0 || inP1Text2() < 0) {
      HTML("Imaginando que tinha respondido, no separador anterior, que poupa 0€ por mês mas 
           poderia poupar mais 10€ por mês se se esforçasse. Se, durante 40 anos, conseguisse 
           poupar os 10€ por mês que poderia poupar, teria <span style=\"color:blue\"> 4800€</span> 
           para utilizar durante a sua reforma. Se, em vez disso, poupasse apenas 0€ por mês, 
           teria <span style=\"color:red\">0€</span> para a reforma, ou seja, a sua inércia 
           estaria a custar-lhe <b>4800€</b>. <br><br><b>Nota</b>: Se, para além de apenas poupar este 
           dinheiro, investisse (por exemplo, num depósito a prazo ou num certificado de aforro), de forma a ganhar juros, 
           o custo da inércia seria maior, dado que poderia ganhar ainda mais dinheiro (veja também a página sobre o pensamento linear).")
      }
    else {
      HTML(paste("Se, durante 40 anos, poupasse os ", cleanToP(inP1Text1()+inP1Text2()), "€ por mês que poderia poupar, 
                 teria <span style=\"color:blue\">", cleanToP((inP1Text1() + inP1Text2())*12*40), "€</span> 
                 para utilizar durante a sua reforma. Se, em vez disso, poupar apenas os ", 
                 cleanToP(inP1Text1()), "€ por mês que poupa, teria <span style=\"color:red\">",  
                 cleanToP(inP1Text1()*12*40), "€</span> para a reforma, ou seja, a sua inércia pode estar a 
                 custar-lhe <b>", cleanToP(((inP1Text1() + inP1Text2())*12*40) - (inP1Text1()*12*40)), "€</b>.
                 <br><br><b>Nota</b>: Se, para além de apenas poupar este dinheiro, investisse (por exemplo, num depósito a prazo ou num certificado de aforro), de forma a ganhar juros, 
                 o custo da inércia seria maior, dado que poderia ganhar ainda mais dinheiro (veja também a página sobre o pensamento linear)." , sep =""))
    }
    })
  
  #### TRAIN 2 - Feedback ####
  
  inP2Radio1 <- eventReactive(input$ine2Button, {input$ineN3})
  inP2Radio2 <- eventReactive(input$ine2Button, {input$ineN4})
  inP2Radio3 <- eventReactive(input$ine2Button, {input$ineN5})
  
  output$feedbackine2 <- renderUI({
      if (is.null(inP2Radio1()) || is.null(inP2Radio2()) || is.null(inP2Radio3())) {
        HTML("Por favor, responda a todas as perguntas e volte a carregar no botão \"Confirmar\".<br><br>")
      }
      else if (inP2Radio1() <= inP2Radio3() | inP2Radio2() <= inP2Radio3()) {
        HTML("<b>Parabéns! Não parece sofrer de inércia no que toca a fazer orçamentos</b>.<br>Utilize o menu lateral para descobrir outras heurísticas e enviesamentos!")
      }        
      else {
        HTML("<b>Parece sofrer de inércia no que toca a fazer orçamentos</b>. Considere as técnicas que mencionámos 
             na página anterior para combater a inércia. A utilização de lembretes pode ser especialmente útil neste caso.")
      }
  })

  
      ############################
      ####### Exponential ########
      ############################
  
  ## Initial feedback ##
  
  egP1Text <- eventReactive(input$ebButton, {cleanToR(input$ebNum)})
  
  output$feedbackeb <- renderUI({
      if (is.na(egP1Text()) || egP1Text() < 0) {
        HTML("Introduziu um valor inválido. Por favor, insira apenas números iguais ou superiores a zero para responder a esta pergunta e utilize a vírgula para separar casas decimais.")
      }
      else if (egP1Text() < 65979) {
        HTML("<b>Respondeu com um valor inferior ao valor real, que é: 65.979,18€</b>. Explore a página sobre pensamento linear para aprender mais sobre 
             porque às vezes é difícil estimar os ganhos de produtos de poupanças.")
      }
      else if (egP1Text() > 65980) {
        HTML("<b>Respondeu com um valor superior ao valor real, que é: 65.979,18€</b>. Ainda que a sua resposta não revele a heurística de pensamento linear, explore a 
              página sobre pensamento linear para aprender mais sobre porque às vezes é difícil estimar os ganhos de produtos de poupanças.")
      }
      else {
        HTML("<b>Acertou no valor, que é: 65.979,18€!</b> Explore a página sobre o pensamento linear para aprender mais sobre 
             porque às vezes é difícil estimar os ganhos de produtos de poupanças.")
      }
  })
  
  ## Plot ##
  
  output$egplot <- renderPlot({
    if(!input$ebButton || is.na(egP1Text()) || egP1Text() < 0){val1 <- 0}
    else if (egP1Text() > 75000) {val1 <- 75000}
    else {val1 <- egP1Text()}
    lin1 <- c(0, 6000, 12000, 18000, 24000, 30000, 36000, 42000, 48000)
    exp1<- c(0, 6342.26, 13070.38, 20322.17, 28138.40, 36562.99, 45643.30, 55430.36, 65979.18)
    plot(NULL, ylim=c(0, 75000), xlim = c(1,9), ylab ="€", xlab="Anos", yaxt ='n', xaxt = 'n', yaxs = "i")
    lines(lin1, col="red", lwd=2)
    lines(exp1, col="blue", lwd=2)
    points(9, val1, pch=16, bg="black")
    axis(1, at=seq(1, 9, 1), labels=c(0, 5, 10, 15, 20, 25, 30, 35, 40))
    axis(2, at=c(0, 32500, 65000), labels=c("0€", "32500€", "65000€"))
    legend(1, 75000, legend=c("Poupança sem juros", "Poupança com juros (1,5% TANB)"),
           col=c("red", "blue"), lty=1, bty="n")
    legend(1.57, 66000, legend="A sua estimativa", col="black", pch=16, bty="n")
  })
  
  
  ## Practice feedback ##
  
  egP2Text <- eventReactive(input$ebpButton, {cleanToR(input$ebpNum)})
  
  output$feedbackebp <- renderUI({
    if (is.na(egP2Text()) || egP2Text() < 0){
      HTML("Introduziu um valor inválido. Por favor, insira apenas números iguais ou superiores a zero para responder a esta pergunta e utilize a vírgula para separar casas decimais.")
    }
    else if (egP2Text() < 133642) {
      HTML("<b>A sua resposta mostra pensamento linear uma vez que indicou um valor inferior ao valor real, que é: 133.642,80€</b>. Não se esqueça que deve utilizar uma aplicação (e.g., calculadora do banco de Portugal) para realizar este tipo de cálculos. <br><br>Utilize o menu lateral para descobrir outras heurísticas e enviesamentos!")
    }
    else if (egP2Text() > 133643) {
      HTML("<b>Respondeu com um valor superior ao valor real, que é: 133.642,80€</b>. Apesar da sua resposta não revelar a utilização do pensamento linear, mostra que teria beneficiado da utilização de uma aplicação para fazer o cálculo. <br><br>Utilize o menu lateral para descobrir outras heurísticas e enviesamentos!")
    }
    else {
      HTML("<b>Muito bem, acertou no valor!</b> Utilize o menu lateral para descobrir outras heurísticas e enviesamentos!")
    }
  })
  
  
      ############################
      ####### Discounting ########
      ############################
  
  hdP1Radio1 <- eventReactive(input$hdButton, {input$radiohd1})
  hdP1Radio2 <- eventReactive(input$hdButton, {input$radiohd2})
  
  
  output$feedbackhd <- renderUI({
    if(is.null(hdP1Radio1()) || is.null(hdP1Radio2())){
      HTML("Por favor, responda a todas as perguntas volte a carregar no botão \"Confirmar\".<br><br>")
    }
    else if (hdP1Radio1() == hdP1Radio2()) {
      HTML("As suas respostas revelaram <b>ausência</b> de enviesamento, já que sugerem que o valor de 
           esperar um dia é constante, quer seja no imediato ou um ano depois. Passe para a página seguinte para compreender melhor os vieses temporais.")
    }
    else if (hdP1Radio1() < hdP1Radio2()) {
      HTML("As suas respostas revelaram um <b>viés do presente</b>, já que sugerem que o valor de esperar um dia é maior no imediato do que um ano depois.
           Passe para a página seguinte para compreender melhor os vieses temporais.")
    }
    else if (hdP1Radio1() > hdP1Radio2()) {
      HTML("As suas respostas revelaram um <b>viés do futuro</b>, já que sugerem que o valor de esperar um dia é maior daqui a um ano do que no imediato.
           Passe para a página seguinte para compreender melhor os vieses temporais.")
    }
  })
  
  ## Plot ##
  
  output$hdplot <- renderPlot({
    par(mar=c(4,4,2,2))
    if(!input$hdButton || is.null(hdP1Radio1()) || is.null(hdP1Radio2())){
      barplot(c(0,1), ylim=c(0,1), names=c("Agora", "Daqui a um ano"), col="blue", yaxt ='n')
      axis(2, at=c(0, 1), labels=c("Não", "Sim"))
    }
    else { 
    barplot(c(as.numeric(hdP1Radio1()),as.numeric(hdP1Radio2())), ylim=c(0,1), names=c("Agora", "Daqui a um ano"), col="blue", yaxt ='n')
    axis(2, at=c(0, 1), labels=c("Não", "Sim"))
    }
  })
  
  
  output$hdnote <- renderUI({
      if(!input$hdButton || is.null(hdP1Radio1()) || is.null(hdP1Radio2())){
        HTML("Imaginando que tinha dado uma resposta ao exemplo anterior e esta se alinhava com o que a maioria das pessoas responde,
              teria indicado que esperar um dia para receber 5€ extra valeria a pena se fosse no futuro, mas não no imediato (viés do presente).")
      }
      else if (hdP1Radio1() == hdP1Radio2()) {
        HTML("Indicou que o valor de esperar um dia é igual, quer seja já ou um ano depois.")
      }
      else if (hdP1Radio1() < hdP1Radio2()) {
        HTML("Indicou que esperar um dia para receber 5€ extra vale a pena se for no futuro, mas não já (viés do presente).")
      }
      else if (hdP1Radio1() > hdP1Radio2()) {
        HTML("Indicou que esperar um dia para receber 5€ extra vale a pena se for já, mas não no futuro (viés do futuro).")
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
       ){HTML("Por favor, dê uma resposta a todas as perguntas primeiro e volte a carregar no botão \"Confirmar\".")}
    else if ((as.numeric(hdP2Radio1()) + as.numeric(hdP2Radio2()) + as.numeric(hdP2Radio3())
              + as.numeric(hdP2Radio4()) + as.numeric(hdP2Radio5())) == 5) {
      HTML("<b>Parabéns! As suas respostas não revelaram o viés temporal!</b>
           <br>Utilize o menu lateral para descobrir os outros enviesamentos disponíveis nesta aplicação.")
    }
    else {
      HTML("<b>As suas respostas revelaram alguma tendência para manifestar o viés temporal.</b>
      <br>Volte ao separador anterior para reler a explicação de porque isto é um enviesamento, 
           ou utilize o menu lateral para descobrir os outros enviesamentos disponíveis nesta aplicação.")
    }
  })
  
  #|####################|#
  #|##### CRÉDITO ######|#
  #|####################|#
  
  
  output$cardplot <- renderPlot({
    vals <-  c(21.8, 8.5, 10.3)
    labs <-  c("Cartões de débito","Cartões de crédito", "População Portuguesa")
    par(mar=c(4,11,4,1))
    barplot(vals, xlim=c(0,25), xlab="Milhões", names = labs, las=1, cex.names=1, col="blue", horiz = T)
  })
  
    
      ########################
      ###### Anchoring #######
      ########################
  
  anP1Text <- eventReactive(input$anchButton, {cleanToR(input$numAN)})
  
  output$feedbackanch <- renderUI({
    if (is.na(anP1Text()) || anP1Text() > 150 || anP1Text() < 0) { 
      HTML("Introduziu um valor inválido. Por favor, insira apenas um número entre zero e o valor que teria disponível (150) para responder a esta pergunta e utilize a vírgula para separar casas decimais.")
    }
    else if (anP1Text() == 150) {HTML("Muito bem! Se alocar todo o dinheiro que tem disponível para abater a dívida, irá pagar o mínimo de juros possível e irá ficar sem dívida o mais rápido possível.")}
    else if (anP1Text() > 58.08) {HTML(paste("Deu uma resposta melhor em ", cleanToP(anP1Text()-58.08), "€ do que a média dos 
                                             participantes de um estudo recente a quem pusemos esta questão. Ainda assim, 
                                             ao pagar uma dívida de crédito, deve tentar pagar o máximo possível (neste caso, 
                                             150€), de forma a pagar o mínimo de juros possível e a ficar sem dívida o mais 
                                             rápido possível.", sep=""))}
    else if (anP1Text() == 58.08) {HTML("Deu uma resposta igual à média dos participantes de um estudo recente a quem pusemos esta questão. Ainda assim, 
                                             ao pagar uma dívida de crédito, deve tentar pagar o máximo possível (neste caso, 
                                             150€), de forma a pagar o mínimo de juros possível e a ficar sem dívida o mais 
                                             rápido possível.")}
    else if (anP1Text() < 58.08) {HTML(paste("Deu uma resposta pior em ", cleanToP(58.08-anP1Text()), "€ do que a média dos 
                                             participantes de um estudo recente a quem pusemos esta questão. Ao pagar uma 
                                             dívida de crédito, deve tentar pagar o máximo possível (neste caso, 
                                             150€), de forma a pagar o mínimo de juros possível e a ficar sem dívida o mais 
                                             rápido possível.", sep=""))}
    })
  
  output$anchplot <- renderPlot({
    labAs <- c("Sua resposta", "Âncora: 36,43€", "Âncora: 60,71€")
    if(!input$anchButton || is.na(anP1Text()) || anP1Text() < 0 || anP1Text() > 150) {Yval <- 0}
    else {Yval <- anP1Text()}
    valAs <- c(Yval, 58.08, 77.01)
    barplot(valAs, ylab="Euros", col="blue", names.arg=labAs, ylim=c(0,150), yaxt='n')
    axis(2, at=seq(0, 150, 25), labels=seq(0, 150, 25))
  })
  
  output$anchnote <- renderUI({ 
    if(!input$anchButton || is.na(anP1Text()) || anP1Text() > 150 || anP1Text() < 0) {HTML("Não deu uma resposta válida no exemplo do separador anterior. Por favor, volte ao separador \"Ponha-se à prova\".")}
    else if (anP1Text() == 150) {
      HTML("Você respondeu que dedicaria todo o dinheiro disponível para pagar o crédito. Muito bem! Dessa forma não seria influenciado pela âncora, demoraria apenas 9 meses a pagar o total e pagaria apenas 38€ de juros.")
      }
    else if (anP1Text() <= 8) {
      HTML(paste("Você respondeu que dedicaria ", cleanToP(anP1Text()), " dos 150€ que teria disponível. Com este valor, nunca poderia pagar o crédito porque o valor que iria abater cada mês seria igual ou inferior ao valor dos juros.", sep = ""))
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
      
      if (floor(N-N2) <= 1) {mes <- "mês"}
      else {mes <- "meses"}
    # Compare
      if (anP1Text() > 77.01) {
        HTML(paste("Deu uma resposta melhor do que a média das pessoas que viram este problema com 
        um pagamento mínimo de 36,43€ e mesmo do que aquelas que viram um pagamento mínimo de 60,71€! Ainda assim, 
        poderia poupar ", cleanToP(Tot-Tot2),"€ e pagar o crédito ", floor(N-N2), " ", mes, " mais cedo, se dedicasse os 150€ a pagar o crédito.", sep=""))
      }
      else if (anP1Text() > 58.081) {
        HTML(paste(fed <- "Deu uma resposta melhor do que a média das pessoas que viram este problema com 
        um pagamento mínimo de 36,43€, mas pior do que a média daquelas que viram um pagamento mínimo de 60,71€. Se tivesse 
        dedicado os 150€ para pagar o crédito, poderia poupar ", cleanToP(Tot-Tot2),"€ e pagar o crédito ", floor(N-N2), " ", mes, " mais cedo.", sep=""))
      }
      else if (anP1Text() == 58.081) {
        HTML(paste("Deu uma resposta igual à média das pessoas que viram este problema com 
        um pagamento mínimo de 36,43€ e pior do que a média daquelas que viram um pagamento mínimo de 60,71€. Se tivesse 
        dedicado os 150€ para pagar o crédito, poderia poupar ", cleanToP(Tot-Tot2),"€ e pagar o crédito ", floor(N-N2), " ", mes, " mais cedo.", sep=""))
      }
      else if (anP1Text() < 58.081) {
        HTML(paste("Deu uma resposta pior do que a média das pessoas que viram este problema com 
        um pagamento mínimo de 36,43€ e do que a média daquelas que viram um pagamento mínimo de 60,71€. Se tivesse 
        dedicado os 150€ para pagar o crédito, poderia poupar ", cleanToP(Tot-Tot2),"€ e pagar o crédito ", floor(N-N2), " ", mes, " mais cedo.", sep=""))
      }
    }
    })
  
  
  anP2Text <- eventReactive(input$anpButton, {
    as.numeric(cleanToR(input$textAN))
  })
  
  output$checkPracticeAN <- renderUI({
    if (is.na(anP2Text())|| anP2Text() < 0) {
      HTML("Introduziu um valor inválido. Por favor, insira apenas números iguais ou superiores a zero para responder a esta pergunta e utilize a vírgula para separar casas decimais.")
    }
    else if (anP2Text() <= 3994) {
      HTML(paste0("<b>A sua resposta, ", cleanToP(anP2Text()), "€, encontra-se num intervalo de valores que sugere ter sido pouco influenciado/a pela proposta da agência de viagens.</b>
            <br><br>O preço médio do pacote de viagem e alojamento apresentado é 3329€. No entanto, os resultados de um estudo prévio mostraram que os participantes foram influenciados pelo valor-âncora que lhes foi apresentado pela agência de viagens quando estimaram o valor que consideravam adequado para o pacote de viagem e alojamento apresentado. Numa demonstração clara do efeito de ancoragem, o valor médio estimado pelos participantes expostos a uma proposta no valor de 5482,95€ foi 4307,78€, enquanto para os participantes expostos a uma proposta no valor de 1165,15€ foi de 1986,55€.<br><br>"))
    }
    else {
      HTML(paste0("<b>A sua resposta, ", cleanToP(anP2Text()), "€, encontra-se num intervalo de valores que sugere ter sido influenciado/a pela proposta da agência de viagens.</b>
            <br><br>O preço médio do pacote de viagem e alojamento apresentado é 3329€. No entanto, os resultados de um estudo prévio mostraram que os participantes foram influenciados pelo valor-âncora que lhes foi apresentado pela agência de viagens quando estimaram o valor que consideravam adequado para o pacote de viagem e alojamento apresentado. Numa demonstração clara do efeito de ancoragem, o valor médio estimado pelos participantes expostos a uma proposta no valor de 5482,95€ foi 4307,78€, enquanto para os participantes expostos a uma proposta no valor de 1165,15€ foi de 1986,55€.<br><br>
                  "))
    }
  })
  
  output$anchPplot <- renderPlot({
      if (!is.na(anP2Text()) && anP2Text() >= 0) {
        labAs <- c("Sua resposta", "Âncora: \n5.482,95€", "Âncora: \n1.165,15€")
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
      HTML("<b>AVISO</b>: Existe um (ou mais) valor(es) inválido(s).")
    }
    else if (da1 > 3040 || da2 > 5108 || da4 > 12793 || da6 > 9694) {
      HTML("<b>AVISO</b>: Um (ou mais) dos valores ultrapassa o valor em dívida do respectivo crédito.")
    }
    else if ((da1+da2+da3+da4+da5+da6) > 15000) {
      HTML("<b>AVISO</b>: Alocou um valor superior ao que tem disponível (15.000€).")
    }
    else{
      paste("Total por alocar: ",cleanToP(15000-(da1+da2+da3+da4+da5+da6)), "€", sep="")
    }
  })
  
  output$feedbackdebta <- renderUI({
    if (is.na(daP1Text1()) || is.na(daP1Text2()) || is.na(daP1Text3()) || is.na(daP1Text4()) || is.na(daP1Text5()) || is.na(daP1Text6()) ||
        daP1Text1() < 0 || daP1Text2() < 0 || daP1Text3() < 0 || daP1Text4() < 0 || daP1Text5() < 0 || daP1Text6() < 0 ||
        daP1Text1() > 3040 || daP1Text2() > 5108 || daP1Text4() > 12793 || daP1Text6() > 9694
        ) {
      HTML("Existe um (ou mais) valor(es) inválido(s). Por favor, insira apenas um número igual ou superior a zero (e.g., 10), mas também não superior ao valor em dívida de cada crédito, em cada caixa e utilize a vírgula se quiser indicar valores decimais.")
    }
    else if (daP1Text1() == 0 & daP1Text2() == 0 & daP1Text3() == 15000 &
        daP1Text4() == 0 & daP1Text5() == 0 & daP1Text6() == 0) {
      HTML("Parabéns! <b>Você alocou o seu dinheiro de forma adequada</b>, minimizando o pagamento de juros. Assim, a sua dívida ficou no valor mínimo possível: 102.244,40€ no próximo mês.")
    } 
    else if (daP1Text1()+daP1Text2()+daP1Text3()+
             daP1Text4()+daP1Text5()+daP1Text6() > 15000){
      HTML(paste("<b>Você atribuiu um total de ", cleanToP(daP1Text1()+daP1Text2()+daP1Text3()+
                  daP1Text4()+daP1Text5()+daP1Text6()), "€ quando só tinha 15.000€ disponíveis.</b>
                 Por favor, distribua apenas 15.000€ pelos créditos e tente outra vez.
                 ", sep=""))}
    else {
      jdiv <- c(1.125, 1.1325, 1.14, 1.135, 1.1375, 1.12)
      actdiv <- c((3040-daP1Text1()), (5108-daP1Text2()), (47003-daP1Text3()), 
                  (12793-daP1Text4()), (27410-daP1Text5()), (9694-daP1Text6()))
      totdiv <- sum(jdiv * actdiv)
      HTML(paste("<b>Você não alocou o seu dinheiro de forma a minimizar o pagamento de juros.</b>
                 Com as suas escolhas, você teria ainda uma dívida de ", sub( '(?<=.{3})', '.', cleanToP(totdiv), perl=TRUE), "€. Se tivesse 
                 maximizado o pagamento de juros, essa dívida seria de apenas 102.244,40€.",sep=""))
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
      barplot(c(102244.40,totdiv), ylim=c(100000,120000), xpd=F, ylab="Valor total da dívida (€)", names=c("Valor mínimo", "O seu valor"), col="blue", yaxt ='n')
      axis(2, at=seq(100000, 120000, 10000), labels=seq(100000, 120000, 10000))
  })
  
  output$debnote <- renderUI({
    if (!input$daButton || is.na(daP1Text1()) || is.na(daP1Text2()) || is.na(daP1Text3()) || is.na(daP1Text4()) || is.na(daP1Text5()) || is.na(daP1Text6()) ||
        daP1Text1() < 0 || daP1Text2() < 0 || daP1Text3() < 0 || daP1Text4() < 0 || daP1Text5() < 0 || daP1Text6() < 0 ||
        daP1Text1() > 3040 || daP1Text2() > 5108 || daP1Text4() > 12793 || daP1Text6() > 9694){
      HTML("Imaginando que tinha respondido ao exercício do separador anterior com a maneira típica (tentando abater o maior número de 
            créditos possível, independentemente das taxas de juro), teria a pagar 102.465,39€, mais 220,99€ do que se tivesse
            utilizado os 15.000€ para abater tanto crédito quanto possível da dívida com juros mais altos.")
    }
    else if (daP1Text1() == 0 & daP1Text2() == 0 & daP1Text3() == 15000 & 
             daP1Text4() == 0 & daP1Text5() == 0 & daP1Text6() == 0) {
      HTML("Com as escolhas que fez no separador anterior, teria reduzido ao máximo 
            as suas dívidas, faltando pagar apenas 102.244,40€.")
      }
    else {
      jdiv <- c(1.125, 1.1325, 1.14, 1.135, 1.1375, 1.12)
      actdiv <- c((3040-daP1Text1()), (5108-daP1Text2()), (47003-daP1Text3()), 
                  (12793-daP1Text4()), (27410-daP1Text5()), (9694-daP1Text6()))
      totdiv <- sum(jdiv * actdiv)
      HTML(paste("Com as escolhas que fez no separador anterior, teria a pagar ",
                 cleanToP(totdiv), "€, mais ", cleanToP((totdiv-102244.40)), "€ do que se tivesse utilizado 
                 os 15.000€ para abater tanto crédito quanto possível da dívida com juros mais altos.", sep=""))
    }
  })
  
  ### 2ND EXERCISE ###
  
  daP2Selectize <- eventReactive(input$dapButton, {input$selectizeDA})
  
  output$checkPracticeDA <- renderUI({
    if (paste(daP2Selectize(), collapse=" ") ==  "Crédito 1 Crédito 2 Crédito 4 Crédito 5 Crédito 3") {
      HTML("<b>Resolveu corretamente o exercício, eliminando os créditos com a taxa de juro mais alta até à mais baixa, parabéns!</b> Utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.")
    }
    else {
      HTML("<b>A ordem não está, ainda, correcta</b>, já que não eliminou os créditos da taxa de juro mais alta para a mais baixa. Volte ao separador anterior para reler a explicação de porque tal pode ser um erro, ou utilize o menu lateral para explorar os outros enviesamentos disponíveis nesta aplicação.")
    }
  })
  
  #############################
  ###### Pain of paying #######
  #############################
  
  dpP1Radio1 <- eventReactive(input$dpButton, {input$dpN1})
  dpP1Radio2 <- eventReactive(input$dpButton, {input$dpN2})
  
  
  output$feedbackpaina <- renderUI({
    if (is.null(dpP1Radio1()) || is.null(dpP1Radio1())) {
     HTML("Por favor, responda a todas as perguntas ao lado e volte a carregar no botão \"Confirmar\".") 
    }
    else if (dpP1Radio1() < dpP1Radio2()) {
      HTML("Tal como os resultados habitualmente obtidos com cenários semelhantes, o seu desconforto psicológico ao pagar com cartão de crédito foi inferior ao desconforto ou custo psicológico que lhe causa ter de pagar em dinheiro. Avance para o separador 
      seguinte para saber mais sobre esta tendência.")
    }
    else if (dpP1Radio1() == dpP1Radio2()) {
      HTML("Ao contrário dos resultados habitualmente obtidos com cenários semelhantes, o seu desconforto psicológico ao pagar com cartão de crédito foi igual ao desconforto ou custo psicológico que lhe causa ter de pagar em dinheiro. Avance para 
           o separador seguinte para saber mais sobre o padrão típico de resposta neste tipo de cenário.")
    }
    else{
      HTML("Ao contrário dos resultados habitualmente obtidos com cenários semelhantes, o seu desconforto psicológico ao pagar com cartão de crédito foi superior ao desconforto ou custo psicológico que lhe causa ter de pagar em dinheiro. Avance para 
           o separador seguinte para saber mais sobre o padrão típico de resposta neste tipo de cenário.")
    }
  })
  
  output$dpplot <- renderPlot({
    par(mar=c(4,4,4,2))
    barplot(c(145.56,175.16), ylim=c(0,200), ylab="Média de estimativa de custo", names=c("Em dinheiro", "Em cartão de crédito"), col="blue", yaxt ='n')
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
      HTML("<b>AVISO</b>: Existe um (ou mais) valor(es) inválido(s).")
    }
    else {
      HTML(paste("Total: ", cleanToP(dp1+dp2+dp3+dp4), "€", sep=""))
    }
  })
  
  
  output$checkPracticeDP <- renderUI({
      totcost <- dpP2Text1()+dpP2Text2()+dpP2Text3()+dpP2Text4()
      if (is.null(input$dpN0) || is.na(cleanToR(input$dpN0))){
        HTML("Para obter feedback neste exercício, por favor responda com um valor válido no primeiro separador (\"Ponha-se à prova\") desta página.")
      }
      else if (is.na(totcost) || dpP2Text1() < 0 || dpP2Text2() < 0 || dpP2Text3() < 0 || dpP2Text4() < 0 ) {
        HTML("Inseriu um (ou mais) valor(es) inválido(s). Preencha, em cada campo, apenas números (e.g., 10) iguais ou superiores a 0 e utilize vírgulas se quiser inserir números com décimas.")
      }
      else if (totcost < input$dpN0) {
        HTML("Em linha com resultados habitualmente obtidos com cenários semelhantes a este, 
             estimou agora um valor total inferior ao primeiro exercício. Isto acontece porque,
             quando fazem estimativas por elemento e não pelo custo total, as pessoas tendem a aperceber-se
             mais rapidamente do crescimento da conta e com isso procuram gastar menos dinheiro.")
      }
      else if (totcost == input$dpN0) {
        HTML("Ao contrário dos resultados habitualmente obtidos com cenários semelhantes a este, 
             estimou o mesmo valor que no primeiro exercício. As pessoas geralmente estimam valores 
             inferiores neste segundo exercício pois, quando fazem estimativas por elemento e não pelo custo total, as pessoas tendem a aperceber-se
             mais rapidamente do crescimento da conta e com isso procuram gastar menos dinheiro.")
      }
      else{
        HTML("Ao contrário dos resultados habitualmente obtidos com cenários semelhantes a este, 
             estimou um valor superior ao que estimou no primeiro exercício. As pessoas geralmente estimam valores 
             inferiores neste segundo exercício pois, quando fazem estimativas por elemento e não pelo custo total, as pessoas tendem a aperceber-se
             mais rapidamente do crescimento da conta e com isso procuram gastar menos dinheiro.")
      }
  })
  
  
}
