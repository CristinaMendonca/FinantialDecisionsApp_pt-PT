########## Visualising savings and credits ##########

#####PACKAGES##########
library(shiny)
library(ggplot2)
library(shinydashboard)

#### TAB 1 Introduction: #####
ui = dashboardPage(
  dashboardHeader(title = "Enviesamentos"),
  dashboardSidebar(  

    
    ####################
    ### SIDEBAR MENU ###
    ####################
    
    
    sidebarMenu(id="tabs", 
                menuItem("Introdução", tabName="intro", icon = icon("map")),
                menuItem("Gerir o orçamento", tabName="orcamento", icon = icon("clipboard"),
                         menuSubItem("Introdução", tabName="introO"),
                         menuSubItem("Autorregulação ", tabName="fauto"),
                         menuSubItem("Contabilidade mental", tabName="contm"),
                         menuSubItem("Custos de oportunidade", tabName="custop")
                         ),
                menuItem("Comprar casa", tabName="casa", icon = icon("home"),
                         menuSubItem("Introdução", tabName="introH"),
                         menuSubItem("Pensamento estreito", tabName="narrow"),
                         menuSubItem("Otimismo irrealista", tabName="opir"),
                         menuSubItem("Heurística da disponibilidade", tabName="disp")
                         ),
                menuItem("Preparar a reforma", tabName="reforma", icon = icon("coins"),
                         menuSubItem("Introdução", tabName="introR"),
                         menuSubItem("Inércia", tabName="inertia"),
                         menuSubItem("Pensamento linear", tabName="exponential"),
                         menuSubItem("Viés temporal", tabName="discounting")
                         ),
                menuItem("Cartões de crédito", tabName="credito", icon = icon("credit-card"),
                         menuSubItem("Introdução", tabName="introC"),
                         menuSubItem("Ancoragem", tabName="anchor"),
                         menuSubItem("Aversão a contas em dívida", tabName="debtA"),
                         menuSubItem("Dor de pagar", tabName="pain")
                         ),
                menuItem("Sobre esta aplicação", tabName="sobre", icon = icon("users"))
                )),
  
  dashboardBody(
    fluidRow(

      ##################
      ## LANDING PAGE ##
      ##################

      tabItems(
        tabItem("intro",
          box(width=12,
            h2("Decisões financeiras", align="center"),
            br(),
            p("Seja bem-vindo/a a esta aplicação sobre o impacto de heurísticas e enviesamentos em decisões financeiras! Aqui pode aprender mais sobre as estratégias simples (isto é, heurísticas) que utilizamos no dia-a-dia para dar respostas à quantidade enorme de decisões, algumas mais simples mas outras mais complexas, com que nos deparamos."),
            p("Estas estratégias ou heurísticas de decisão são muitas vezes úteis e eficazes, mas dada a sua simplicidade são também fonte de enviesamentos. Esta aplicação tem como objetivo explicitar os erros e enviesamentos de decisão mais comuns que decorrem do uso das heurísticas assim com fornecer formas de os evitar ou atenuar."),
            p("Vamos experimentar?", align="center"),
            p("Utilize os botões abaixo ou o menu à esquerda para navegar na aplicação.", align="center"),
            br()),
            fluidRow(
              box(width=6, p(actionButton(inputId="NextP1A", label=HTML('<h2><i class="fa fa-clipboard"></i> Gerir o orçamento</h2>')), align="center")),
              box(width=6, p(actionButton(inputId="NextP1B", label=HTML('<h2><i class="fa fa-home"></i> Comprar casa</h2>')), align="center")),
              box(width=6, p(actionButton(inputId="NextP1C", label=HTML('<h2><i class="fa fa-coins"></i> Preparar a reforma</h2>')), align="center")),
              box(width=6, p(actionButton(inputId="NextP1D", label=HTML('<h2><i class="fa fa-credit-card"></i> Cartões de crédito</h2>')), align="center"))
            ),
        box(width=12, 
            fluidRow(
              column(6, HTML('<img src="fp.png" width="90%">')),
              column(6, HTML('<img src="fct.png" width="100%">'))
            ),
            HTML("<div style=\"text-align:center;\">Esta aplicação foi financiada pela Fundação para a 
                 Ciência e Tecnologia através do projeto PTDC/MHC-PAP/1556/2014.</div>")
          )),
        
        #|#############|#
        #|# ORÇAMENTO #|#
        #|#############|#
      
        tabItem("introO",
                box(width=12,
                    h3("GERIR O ORÇAMENTO", align="center")),
                fluidRow(
                box(width=6,
                    h3("Porquê criar e gerir um orçamento?"),
                    p("Criar um orçamento mensal ajuda a compreender quanto dinheiro sobra depois 
                    de todas as despesas essenciais (como renda, alimentação, etc.), assim como a 
                    estabelecer objetivos de poupança e de controlo de despesa."),
                    h3("Como criar um orçamento?"),
                    HTML("<p>Existem muitas formas de criar o seu orçamento, mas no essencial só precisa de papel e lápis:</p>
                        <ol>
                          <li>Comece por listar os seus rendimentos mensais, como o seu salário.</li>
                          <li>Depois, liste as suas despesas fixas, como renda, água, luz, etc. (ver figura ao lado para algumas categorias mais comuns). Se tem despesas fixas que paga anualmente (como um seguro de saúde), divida o total anual por cada mês para obter o valor que deve meter de parte para poder pagar a anuidade.</li>
                          <li>Subtraia estas despesas aos rendimentos mensais. Se quiser poupar dinheiro, subtraia também o valor que gostaria de poupar.</li>
                          <li>Divida o valor final pelo número de semanas do mês. Esse será o valor que tem, por semana, para pagar a despesas correntes como comida, vestuário, etc.</li>
                        </ol>
                      "),
                    p("Criar, e cumprir, um orçamento mensal não é tarefa fácil. Descubra, abaixo, três enviesamentos que podem ter um impacto negativo na forma como planeia e executa o seu orçamento familiar.")),
                box(width=6, 
                    HTML("<p>Despesas das famílias em percentagem do rendimento disponível, segundo dados da <a href=\"https://www.pordata.pt/Portugal/Despesas+de+consumo+final+no+total+do+rendimento+dispon%c3%advel+das+fam%c3%adlias+total+e+por+tipo+de+bens+e+servi%c3%a7os+(percentagem)-767\">PORDATA</a>, referentes a 2016:</p>"),
                    plotOutput("orcplot")
                    )),
                box(width=4, p(actionButton(inputId="NextP2A", label=HTML('<h3><i class="fa fa-clipboard"></i> Autorregulação </h3>')), align="center")),
                box(width=4, p(actionButton(inputId="NextP2B", label=HTML('<h3><i class="fa fa-clipboard"></i> Contabilidade mental</h3>')), align="center")),
                box(width=4, p(actionButton(inputId="NextP2C", label=HTML('<h3><i class="fa fa-clipboard"></i> Custos de oportunidade</h3>')), align="center"))
                ),
        
            ###################
            ## autocontrolo ##
            ###################
        
        tabItem("fauto", 
                tabsetPanel(id="tabFA",
                            tabPanel("Ponha-se à prova!",
                                     box(width=6,
                                         "A Maria é uma estudante de 21 anos que tem um part-time. 
                                         Dois dias antes de receber o seu salário, a Maria só tem 25€ para pagar as suas 
                                         despesas. Para além de comida, a Maria tem de comprar um par de meias quentes para 
                                         uma festa que tem ao ar livre este fim-de-semana. Depois do trabalho ela vai com 
                                         a sua amiga Susana para o centro comercial comprar as meias. Quando passam à frente 
                                         da sua loja favorita, a Maria vê uma camisola muito gira em saldo que custa 75€.",
                                         br(),br(),
                                         radioButtons("radioFA", label = "Se fosse a Maria, o que faria de entre as seguintes opções:",
                                                      choices = list("Iria comprar só as meias." = 1, 
                                                                     "Iria querer a camisola, mas não a iria comprar." = 2, 
                                                                     "Iria comprar as meias e a camisola com um cartão de crédito." = 3,
                                                                     "Iria comprar as meias, a camisola e ainda umas calças e blusa a condizer e pagaria tudo com o cartão de crédito." = 4
                                                                     ), 
                                                      selected = "NULL"),
                                         p(actionButton(inputId="faButton", label="Confirmar", icon = icon("check")), align="right")),
                                         box(width=6, HTML("<b>Resultado:</b>"),
                                                uiOutput("feedbackFA"),
                                                br(),
                                         p(actionButton("Next7", div("Continuar", icon("arrow-right"))), align="right"))
                                  ),
                            tabPanel(value="fa1", title="Autorregulação ",
                                  box(width=12,
                                      fluidRow(
                                        column(6,
                                           h3("O que é?"),
                                           HTML("A falta de autocontrolo é um problema de autorregulação que pode ser definido como a ausência de recursos mentais (tais como atenção) necessários para que a pessoa 
                                             possa exercer controlo sobre as suas ações ou pensamentos de forma a cumprir os objetivos que tem para si mesma. 
                                             Exemplos típicos de falhas de autocontrolo são: comer comida alta em calorias quando se quer perder peso, a compra por impulso quando se quer poupar dinheiro ou
                                             ficar em casa a descansar em vez de se ir ao ginásio depois de se ter comprometido a ir três vezes por semana."),
                                           h3("Implicações financeiras"),
                                           HTML("<p>Os efeitos negativos da falta de autocontrolo têm impacto em muitas áreas da nossa vida. Na área financeira:</p>
                                                  <ul>
                                                    <li>Na gestão de orçamento, leva-nos a gastar mais do que planeado.</li>
                                                    <li>Na preparação da reforma, leva-nos a que façamos menos poupanças do que devíamos.</li>
                                                    <li>Nos cartões de crédito, leva-nos a utilizar mais o cartão de crédito do devíamos.</li>
                                                  </ul>
                                                "),
                                           h3("Como evitar?"),
                                           HTML("<p>Considere as seguintes frentes de ataque às falhas de autocontrolo:</p>
                                                <ul>
                                                  <li>Tenha objetivos claros e concretos, por exemplo: poupar 100€/mês para comprar um carro.</li>
                                                  <li>Tente focar-se no seu objetivo (por exemplo, imaginando conduzir o seu carro) quando está a considerar fazer algo que põe em causa atingir o seu objetivo (como gastar dinheiro desnecessariamente).</li>
                                                  <li>Tenha em atenção o seu estado emocional. Emoções negativas (como frustração, depressão, etc.) podem levar a más decisões.</li>
                                                  <li>Treine a sua capacidade de autocontrolo. Por exemplo, fazendo exercícios como meditação ou treinar manter sempre as costas direitas.</li>
                                                  <li>Tente diminuir a exposição aos estímulos ou contextos que desencadeiam respostas impulsivas da sua parte. Por exemplo, não indo às compras quando tem fome para evitar comprar produtos apetecíveis, mas pouco saudáveis (por exemplo doces, bolos, batatas fritas, etc.).</li>
                                                  <li>Tente diminuir a possibilidade de agir sobre o seu impulso. Por exemplo, levando só o dinheiro para comprar as meias e deixando o cartão de crédito em casa.</li>
                                                  
                                                </ul>
                                                "),
                                           h3("Para saber mais"),
                                           HTML("<ul>
                                              <li>Canby, N., Cameron, I., Calhoun, A., & Buchanan, G. (2015). A brief mindfulness intervention for healthy college students and its effects on psychological distress, self-control, meta-mood, and subjective vitality. <i>Mindfulness, 6</i>, 1070-1081.</li>
                                              <li>Hagger, M., Wood, C., Stiff, C., & Shatzisarantis, N. (2010). Ego depletion and the strength model of self-control: A meta-analysis. <i>Psychological Bulletin, 136</i>(4), 495-525.</li>
                                              <li>Roberts, J. A., & Manolis, C. (2012). Cooking up a recipe for self-control: The three ingredients of self-control and its impact on impulsive buying. <i>Journal of Marketing Theory and Practice, 20</i>(2), 173-188.</li>
                                              <li>* Rook, D. W., & Fisher, R. J. (1995). Normative influences on impulsive buying behavior. <i>Journal of Consumer Research, 22</i>, 305-313.
                                              <li>Sultan, A. J., Joireman, J., & Sprott, D. E. (2011). Building consumer self-control: The effect of self-control exercises on impulsive buying urges. <i>Marketing Letters, 23</i>, 61-72.</li>
                                             </ul>
                                                <p>* Fonte do exemplo do separador \"Ponha-se à prova\".</p>")
                                        ),
                                     column(6,
                                            uiOutput("noteFA"),
                                            p(actionButton("Next8", div("Continuar", icon("arrow-right"))), align="right")
                                            )))),
                            tabPanel(value="prat4", title="Pratique",
                                     box(width=6,checkboxGroupInput("part4cg", label = "Identifique abaixo pensamentos e comportamentos que ajudam a evitar a compra impulsiva:", 
                                                        choices = list("Levar uma lista de compras." = 1,
                                                                       "Ir às compras com fome." = 2, 
                                                                       "Ir às compras quando se sente frustrado/a, cansado/a, irritado/a, deprimido/a, etc." = 3,
                                                                       "Ir passear/desanuviar em centros comerciais ou lojas." = 4,
                                                                       "Pensar \"uma vez não são vezes\"." = 5,
                                                                       "Saber distinguir quando se aproveita um desconto para poupar de quando se aproveita um desconto para gastar dinheiro." = 6,
                                                                       "Registar as compras não essenciais que vai desejando fazer e adiar a compra para uma próxima vez (por exemplo, quando tiver poupado dinheiro para isso)." = 7,
                                                                       "Deixar o cartão em casa e levar só a quantia que está disposto/a a gastar." = 8,
                                                                       "Guardar a informação do cartão de crédito no explorador de internet para facilitar compras futuras." = 9,
                                                                       "Comprometer-se a só comprar algo novo quando o que já tem antigo estiver de facto estragado." = 10
                                                                       ),
                                                        selected = NULL),
                                     p(actionButton(inputId="FApButton", label="Confirmar", icon = icon("check")), align="right")),
                                     box(width=6, 
                                        HTML("<b>Resultado:</b><br>"),br(),
                                        uiOutput("checkPracticeFA")
                                        )
                                     ))),

        
        ###################
        ## Contabilidade ##
        ###################
        
        tabItem("contm", 
                tabsetPanel(id="tabCM",
                            tabPanel("Ponha-se à prova!",
                                     box(width=6,
                                         HTML("Imagine que guarda 50€ por mês numa gaveta em sua casa para poupar dinheiro para as férias. Neste momento já tem 600€ na gaveta e já está a planear as férias. 
                                          <br>Entretanto, devido a despesas imprevistas, este mês teve que usar o seu cartão de crédito para pagar 600€.
                                          "),
                                         br(),br(),
                                         radioButtons("radio1CM", label = "No final do mês terá que optar por uma das seguintes alternativas:",
                                                      choices = list("Pagar o total da dívida do cartão de crédito (sem juros) com o dinheiro que andou a poupar para as férias." = 0,
                                                                     "Começar a pagar a dívida do cartão de crédito em prestações mensais (com juros suaves) de 50€, suspendendo a sua poupança 50€/mês para as férias, mas guardando os 600€ que já tem para férias." = 1,
                                                                     "Começar a pagar a dívida do cartão de crédito em prestações de 25€/mês (com juros igualmente suaves), diminuindo a sua poupança mensal para as férias de 50 para 25€ /mês, mas continuando a fazer alguma poupança para as férias." = 2
                                                      ), selected = "NULL"),
                                         p(actionButton(inputId="cmButton", label="Confirmar", icon = icon("check")), align="right")),
                                     box(width=6, HTML("<b>Resultado:</b>"),
                                         uiOutput("feedbackCM"),
                                         br(),
                                         p(actionButton("Next15", div("Continuar", icon("arrow-right"))), align="right"))
                            ),
                            tabPanel(value="cm1", title="Contabilidade mental",
                                     box(width=12,
                                         fluidRow(
                                           column(6,
                                                  h3("O que é?"),
                                                  HTML("O exemplo que acabou de ver sugere que as pessoas têm tendência para tratar a mesma quantidade de dinheiro de forma diferente em função de critérios subjetivos/categorias mentais arbitrárias. Este comportamento tem sido explicado com base na existência de uma “contabilidade mental” (mental accounting). À semelhança do que acontece com a contabilidade organizada das empresas, a investigação sugere que as pessoas criam mentalmente categorias de despesas às quais alocam diferentes parcelas do seu orçamento (por exemplo, entretenimento, transportes, alimentação). Apesar do dinheiro ser um bem fungível (i.e., os 50€ da categoria entretenimento valem exatamente o mesmo que os 50€ de outra qualquer categoria), as pessoas tendem a tratar as categorias mentais de despesas de forma estanque, gastando o dinheiro em função dos valores alocados a cada categoria.
                                                        <br>Um exemplo que ilustra bem este viés é o facto de muitas pessoas recorrerem a créditos com elevadas taxas de juro associadas e simultaneamente manterem depósitos em contas poupança que rendem juros muito baixos ou mesmo nulos. Isto acontece porque as pessoas separam mentalmente as suas “poupanças” do dinheiro para fazer face às despesas (previstas ou inesperadas). Esta categorização mental faz com que sintam necessidade de recorrer a crédito quando não têm dinheiro na categoria mental em que se enquadra uma dada despesa, mesmo que esse dinheiro esteja disponível noutra categoria.   
                                                        <br>Voltando ao exemplo apresentado, muitas pessoas tendem a optar por usar o cartão de crédito para pagar a totalidade ou uma parte de uma despesa inesperada, mesmo quando têm uma poupança que permitiria pagar essa despesa sem recorrer crédito e sem incorrer no pagamento de juros.   
                                                        <br>Este modo de categorização mental das diferentes despesas e receitas facilita a gestão do orçamento familiar ao manter as pessoas atentas aos valores gastos (vs. disponíveis) das diferentes categorias. No entanto, tratar o dinheiro de forma diferente em função da categoria mental que é atribuída prejudica muitas vezes a boa gestão do orçamento familiar. A título de exemplo refira-se o modo como as pessoas tendem a gastar o reembolso do seu IRS/imposto sobre o rendimento. Apesar do valor reembolsado ter sido abatido mensalmente ao valor do vencimento, no momento do reembolso este valor é visto como um bónus/extra e tende a ser gasto de forma mais impulsiva/menos pensada. O mesmo princípio se aplica aos valores de prémios ou aos cheques-oferta/vouchers: ao serem percebidos como receitas extra acabam por ser gastos com mais facilidade em despesas que não estavam contempladas no orçamento familiar (e.g., carros, viagens, joias).
                                                        "),
                                                  h3("Implicações financeiras"),
                                                  p("Este modo de organização das finanças pessoais tem impacto também no modo como as pessoas fazem a gestão das suas poupanças e dos seus créditos. Com frequência as pessoas mantêm algum dinheiro em contas poupança com juros baixos (ou mesmo sem juros) ao mesmo tempo que pagam juros elevados pelo uso de cartão de crédito."),
                                                  h3("Como evitar?"),
                                                  HTML("
                                                    Uma forma de evitar os efeitos negativos da contabilidade mental é torná-la “física”, mantendo o registo de todas as suas despesas e receitas. Atualmente existem inúmeras ferramentas disponíveis para o efeito (por exemplo, <a href=\"https://www.saberviver.pt/dinheiro/apps-de-financas-pessoais-facilitam-a-vida/\">esta</a>), escolha a que lhe parecer mais conveniente.<br>
                                                    No planeamento do seu orçamento inclua uma categoria para eventuais recebimentos excecionais e outra para despesas excecionais. Considere repartir a categoria de despesas excecionais de forma a distinguir aquelas que resultam de acontecimentos inesperados (por exemplo, despesas médicas decorrentes de um acidente) das que correspondem a “extravagâncias” que poderá querer fazer. <br>
                                                    Pense duas vezes antes de usar recebimentos excecionais para incorrer em despesas excecionais/extravagâncias. Não há nada de errado em fazê-lo, desde que o faça de forma consciente. Estipule um valor que consideraria razoável para o tipo de despesa/extravagância em causa (por exemplo, uma viagem) e mantenha-se fiel a esse valor, independentemente da origem do dinheiro que lhe vai permitir pagá-lo.<br>
                                                    E não se esqueça: o dinheiro é um bem fungível - tem o mesmo valor independentemente do modo como foi obtido e do modo como será gasto.
                                                  "),
                                                  h3("Para saber mais"),
                                                  HTML("
                                                       <ul>
                                                        <li>Ariely, D., & Kreisler, J. (2017). <i>Dollars and sense: How we misthink money and how to spend smarter.</i> HarperCollins.</li>
                                                        <li>Belsky, G., & Gilovich, T. (2010). <i>Why smart people make big money mistakes and how to correct them: Lessons from the life-changing science of behavioral economics.</i> Simon and Schuster.</li>
                                                        <li>Thaler, R. H. (1999). Mental accounting matters. <i>Journal of Behavioral Decision Making, 12</i>(3), 183-206.</li>
                                                       </ul>
                                                       ")
                                           ),
                                           column(6,
                                                  plotOutput("plotCM"),
                                                  HTML("Este gráfico refere-se ao problema apresentado anteriormente no “ponha-se à prova” e apresenta uma simulação simplificada da despesa para cada uma das três alternativas de resposta. Na opção a) pagamento total e imediato da divida; opção b) pagamento em prestações de 50€ com juros suaves de 3% (esta dívida demoraria cerca de 1 ano e 3 meses a ser saldada pagando-se cerca de 155€ em juros); opção c) pagamento em prestações de 25€ com juros suaves de 3% (esta dívida demoraria cerca de 3 anos e 6 meses a ser saldada pagando-se cerca de 476€ em juros)."),
                                                  br(),br(),
                                                  p(actionButton("Next16", div("Continuar", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat8", title="Pratique",
                                     box(width=6, 
                                         HTML("<p>Imagine que está na sua sapataria preferida para comprar uns sapatos. Embora não pensasse gastar mais do 50€, os sapatos de que gostou mais custam 75€.</p><p><b>Quão provável seria comprar os sapatos se...:</b></p>"),
                                         radioButtons("radioP1CM", label = "...tivesse os 75€ na sua conta.",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7), 
                                                      inline=T, selected = "NULL"),
                                         radioButtons("radioP2CM", label = "...tivesse recebido um cheque-oferta no valor de 25€",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7), 
                                                      inline=T, selected = "NULL"),
                                         radioButtons("radioP3CM", label = "...tivesse encontrado 25€ esquecidos no bolso do seu casaco.",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7), 
                                                      inline=T, selected = "NULL"),
                                         p(actionButton(inputId="CMpButton", label="Confirmar", icon = icon("check")), align="right")),
                                     box(width=6, 
                                         HTML("<b>Resultado:</b><br>"),br(),
                                         uiOutput("checkPracticeCM")
                                     ))
                            )),
        
        ############################
        ## Custos de oportunidade ##
        ############################
        
        
        tabItem("custop", 
                tabsetPanel(id="tabCO",
                            tabPanel("Ponha-se à prova!",
                                     box(width=6,
                                         HTML("Imagine que durante a semana conseguiu juntar algum dinheiro para gastar em pequenas compras. Ao visitar a sua loja de música preferida repara que um dos discos que está em destaque é de uma das suas bandas preferidas. Já tinha pensado comprar este disco noutras ocasiões e agora está com o preço especial de 14,99€. O que faria nesta situação?"),
                                         radioButtons("radioCO1", label = "",
                                                      choices = list("Compraria o disco." = 1, "Não compraria o disco." = 0),
                                                      selected="NULL"
                                         ),
                                         br(),
                                         HTML("Imagine agora que recebia um cheque-oferta no valor de 10€. Imaginando que queria utilizar o cheque-oferta para comprar uma garrafa de água reutilizável, qual das seguintes opções escolheria?"),
                                         radioButtons("radioCO2", label = "",
                                                      choices = list("Uma garrafa metálica com desenho ergonómico no valor de 10€." = 1,
                                                                     "Uma garrafa de material reciclado no valor de 3,99€, sobrando 6,01€ para outras compras." = 0),
                                                      selected="NULL"
                                         ),
                                         
                                         p(actionButton(inputId="coButton", label="Confirmar", icon = icon("check")), align="right")),
                                     box(width=6, HTML("<b>Resultado:</b>"),
                                         uiOutput("feedbackCO"),
                                         br(),
                                         p(actionButton("Next19", div("Continuar", icon("arrow-right"))), align="right"))
                            ),
                            tabPanel(value="co1", title="Custos de oportunidade",
                                     box(width=12,
                                         fluidRow(
                                           column(6,
                                                  h3("O que é?"),
                                                  p("A investigação acerca do comportamento do consumidor tem demonstrado que as pessoas têm tendência para ignorar formas alternativas de gastar os seus recursos (tempo e dinheiro) quando fazem as suas escolhas. De um modo mais específico, se tivermos que escolher entre uma laranja e uma maçã e escolhermos a laranja, a maçã (que preterimos) passa a ser uma oportunidade perdida e o valor da maçã (os seus benefícios) é o custo dessa oportunidade. De forma mais geral, quando optamos por comprar um determinado produto ou fazer um determinado investimento, ignoramos muitas vezes outras oportunidades de usar o mesmo dinheiro (para comprar outros produtos ou fazer outros investimentos). Os benefícios que se perdem associados a estas oportunidades preteridas chamam-se os custos de oportunidade (opportunity costs)."),
                                                  h3("Implicações financeiras"),
                                                  HTML("Conforme o exemplo apresentado ilustra, a negligência dos custos de oportunidade traduz-se frequentemente num consumo superior àquele que ocorre quando as pessoas são explicitamente recordadas de formas alternativas de usar o mesmo dinheiro. Por outro lado, quando não fazemos a melhor escolha de um conjunto de alternativas possíveis isso quer dizer que os custos de oportunidade (as oportunidades que preterimos ao fazer uma dada escolha) são superiores ao que ganhámos com a escolha que fizemos. Isto é um indicador de má gestão financeira."),
                                                  h3("Como evitar?"),
                                                  HTML("A melhor forma de evitar a negligência de custos de oportunidade na gestão do seu orçamento familiar é manter-se consciente de quais são os seus objetivos e prioridades no domínio financeiro. O modo como usa o seu dinheiro deve obedecer a estes objetivos e prioridades. 
                                                        <br>Quando se sentir tentado/a a fazer uma compra não planeada pare para pensar em que medida essa compra faz parte das suas prioridades e o/a ajudará a aproximar-se dos seus objetivos.
                                                        <br>Pense explicitamente nos custos de oportunidade envolvidos na compra a realizar:
                                                        <ol type=\"a\"><li>que outras coisas poderia comprar o mesmo dinheiro?</li>
                                                            <li>quantas horas, dias ou meses precisa de trabalhar para pagar essa compra?</li></ol>
                                                "),
                                                  h3("Para saber mais"),
                                                  HTML("<ul>
                                                        <li>Ariely, D., & Kreisler, J. (2017). <i>Dollars and sense: How we misthink money and how to spend smarter.</i> HarperCollins.</li>
                                                        <li>Frederick, S., Novemsky, N., Wang, J., Dhar, R., & Nowlis, S. (2009). <i>Opportunity cost neglect. Journal of Consumer Research, 36</i>(4), 553-561.</li>
                                                       </ul>")
                                           ),
                                           column(6,
                                                  plotOutput("plotCO1"),
                                                  uiOutput("plotnoteOC1"),
                                                  plotOutput("plotCO2"),
                                                  uiOutput("plotnoteOC2"),
                                                  br(),br(),
                                                  p(actionButton("Next20", div("Continuar", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat10", title="Pratique",
                                     box(width=6,
                                         HTML("Após um ano de trabalho e poupanças em que juntou 1500€ para ir de férias, chegou a altura de tirar as férias. Até que ponto acha que deve gastar os 1500€ numas boas férias? <br><br>
                                         <table width=\"100%\">
                                                <tr><td>Certamente que não</td><td style=\"text-align:right;\">Certamente que sim</td></tr>
                                              </table>
                                              <span style=\"text-align:center;\">"),
                                         radioButtons("radioCOP1", label = "", inline=T,
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4,
                                                                     "5" = 5, "6" = 6, "7" = 7), selected = "NULL"),
                                         HTML("</span><br><p>Agora, pedimos-lhe que considere as seguintes alternativas:</p>
                                              <ul>
                                                <li>Optar por umas férias menos dispendiosas (1000€) dividindo um apartamento/quarto de hotel com um amigo e investir o resto do dinheiro num PPR (plano poupança reforma).</li>
                                                <li>Optar por férias repartidas usando o dinheiro disponível em dois períodos diferentes (por exemplo no verão e no Natal).</li>
                                                <li>Procurar férias do mesmo género em locais semelhantes que estejam a fazer promoções.</li>
                                                <li>Usar o dinheiro na sua formação (exemplo, pós-graduação) o que lhe permitirá subir na carreira na sua empresa com um aumento de ordenado de 5%.</li>
                                              </ul>
                                              Agora considere novamente a mesma questão até que ponto acha que deve gastar os 1500€ numas boas férias?<br><br>
                                              <table width=\"100%\">
                                                <tr><td>Certamente que não</td><td style=\"text-align:right;\">Certamente que sim</td></tr>
                                              </table>
                                              <span style=\"text-align:center;\">"),
                                         radioButtons("radioCOP2", label = "", inline=T,
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4,
                                                                     "5" = 5, "6" = 6, "7" = 7), selected = "NULL"),
                                         HTML("</span>"),
                                         p(actionButton(inputId="copButton", label="Confirmar", icon = icon("check")), align="right")),
                                     box(width=6, 
                                         HTML("<b>Resultado:</b><br>"),br(),
                                         uiOutput("checkPracticeCO")
                                     )
                            ))),
        
        
        #|########|#
        #|# CASA #|#
        #|########|#
        
        tabItem("introH",
                box(width=12,
                    h3("COMPRAR CASA", align="center")),
                fluidRow(
                  box(width=6,
                      h3("Porquê comprar casa?"),
                      p("Para muitas pessoas, a compra de valor mais elevado que fazem na sua vida é a compra de uma casa e, 
                      na maioria dos casos, fazem-no recorrendo a crédito. Como pode ver no gráfico à direita, 
                      nos últimos 15 anos, a maior fatia do crédito que as pessoas contraem é relativo à habitação (sendo 2011 e 2015 uma excepção)."),
                      HTML("<p>Comprar uma casa pode trazer vários benefícios como, por exemplo: 
                        <ul>
                        <li>Não ter de pagar renda quando entrar na reforma (ou pelo menos ter um pagamento mensal reduzido);</li>
                        <li>Poder vir a ter uma fonte de rendimento extra (e.g., arrendando um quarto ou uma garagem);</li>
                        <li>Vendê-la mais tarde com mais-valias (aproveitando períodos de valorização do mercado imobiliário);</li>
                        <li>ou deixar uma casa paga aos filhos.</li>
                        </ul>Contudo, também pode ter grandes custos e riscos, como despesas de manutenção, impostos, ou despesas surpresa (e.g., por causa de desastres ambientais). Enquanto investimento, o valor de comprar uma casa 
                        depende das condições específicas de compra, do crédito e do mercado de arrendamento."),
                      p("Nesta secção, vamos ver alguns enviesamentos que podem ter um impacto na forma como
                        abordamos a compra de casa."),
                      br()),
                  box(width=6, HTML('<p>Peso do crédito à habitação (em %) no total do crédito a particulares, segundo dados da <a href="https://www.pordata.pt/Portugal/Montantes+de+empr%c3%a9stimos+concedidos+no+ano+a+particulares+total+e+por+tipo+de+finalidade-2844-244811">PORDATA</a>:</p>'), plotOutput("casaplot"))
                ),
                    fluidRow(
                      box(width=4, p(actionButton(inputId="NextP3A", label=HTML('<h3><i class="fa fa-home"></i> Pensamento estreito</h3>')), align="center")),
                      box(width=4, p(actionButton(inputId="NextP3B", label=HTML('<h3><i class="fa fa-home"></i> Otimismo irrealista</h3>')), align="center")),
                      box(width=4, p(actionButton(inputId="NextP3C", label=HTML('<h3><i class="fa fa-home"></i> Heurística da disponibilidade</h3>')), align="center"))
                )),
        
            ##############
            ## Estreito ##
            ##############
        
        tabItem("narrow",
                tabsetPanel(id="tabPE",
                  tabPanel("Ponha-se à prova!",
                    box(width=6,
                        p("Imagine que está à procura de um banco para financiar o seu crédito à habitação. Provavelmente irá começar por tentar obter uma lista dos bancos a que pode vir a recorrer. Abaixo, liste todos os bancos, em Portugal, que se lembra de existir (quer saiba terem ou não opções de crédito para imóveis):"),
                        br(),
                        textAreaInput(inputId = "banksText", resize="none", label="Insira os nomes dos bancos separados por vírgulas:", placeholder = "Banco 1, Banco 2, Banco 3, etc."),
                        p(actionButton(inputId="banksButton", label="Confirmar", icon = icon("check")), align="left")
                    ),
                    box(width=6, 
                        HTML("<b>Resultado:</b><br>"),
                        uiOutput("feedbackBanks"),
                        br(),
                        p(actionButton("Next1", div("Continuar", icon("arrow-right"))), align="right")
                    )),
                tabPanel(value="pe", title="Pensamento estreito",
                         box(width=12,
                         fluidRow(
                          column(7,
                            h3("O que é?"),
                            HTML("No separador anterior vimos um exemplo de pensamento estreito: tipicamente, as pessoas só se lembram de alguns bancos, não de todos. Este enviesamento (pensamento estreito),
                              acontece quando consideramos apenas algumas opções. Por melhor que seja a nossa escolha desse conjunto de opções, podemos estar a perder oportunidades vantajosas que nem chegamos a considerar.
                              <br>Podemos, por exemplo, achar que se um determinado banco fosse especialmente bom, então já teríamos ouvido falar dele antes. Mas na realidade, existem muitas razões pelas quais um banco 
                              pode ser bom mas pouco conhecido (por exemplo: ter, para já, poucos clientes ou balcões na sua área, não conseguir atrair muitos clientes porque as pessoas ficam sempre no mesmo banco 
                              a não ser que tenham uma má experiência, etc.).
                              <br>Em algumas situações, até podemos não ter tempo ou interesse suficiente para fazer uma pesquisa exaustiva das opções, mas em escolhas muito importantes, como comprar uma casa, é 
                              importante que tenhamos acesso a tantas opções quantas possíveis de forma a tomarmos a melhor opção."),
                            h3("Implicações financeiras"),
                            HTML("<p>O pensamento estreito verifica-se sempre que não consideramos todas as opções, por exemplo:</p>
                                    <ul>
                                      <li>Na compra da casa, quando não consideramos todas as opções para descobrir oportunidades.</li>
                                      <li>Na gestão do orçamento, quando não consideramos despesas menos frequentes mas que é importante serem incluídas no orçamento (como poupar para se for preciso substituir um eletrodoméstico que se estrague);</li>
                                      <li>Na preparação da reforma, quando não consideramos maneiras de preparar a reforma menos comuns (como instalar painéis solares para diminuir a conta da luz na reforma).</li>
                                      <li>Nos cartões de crédito, quando consideramos apenas as opções de comprar recorrendo a crédito ou não comprar, ignorando outras opções como poupar para comprar mais tarde.</li>
                                    </ul>
                                 "),
                            h3("Como evitar?"),
                            HTML("<p>Considere as seguintes sugestões:</p>
                                 <ul>
                                  <li>Utilize diretórios de bancos/imobiliárias/sites de anúncios de imóveis (<a href=\"https://www.bportugal.pt/entidades-autorizadas/67/all\">ver exemplo</a>); </li>
                                  <li>Procure guias ou listas de compras de imóveis (<a href=\"http://saldopositivo.cgd.pt/assets/2017/03/Guia-como-comprar-casa_final-1.pdf\">ver exemplo</a>);</li>
                                  <li>Faça o esforço de pensar em opções menos conhecidas;</li>
                                  <li>Pergunte a conhecidos por opções menos conhecidas.</li>
                                 </ul>
                                 "),
                            h3("Para saber mais"),
                            HTML("<ul>
                                  <li>Soll, Jack B. and Milkman, Katherine L. and Payne, John W., A User's Guide to Debiasing (June 17, 2014). In G. Keren & G. Wu (Eds.), <i>Wiley-Blackwell Handbook of Judgment and Decision Making</i> (pp.924-951). Wiley Blackwell.</li>
                                 </ul>")
                            ),
                          column(5,
                           plotOutput("narrowplot"),
                           uiOutput("narrownote"),
                           br(),
                           p(actionButton("Next2", div("Continuar", icon("arrow-right"))), align="right")
                           )
                         ))),
                tabPanel(value="prat1",title="Pratique",
                         box(width=6,
                          p("Imagine agora que está à procura de uma casa para comprar. Em que sítios (e.g., agências imobiliárias) iria procurar?"),
                          textAreaInput(inputId = "buyText", resize="none", label="", placeholder = "Opção 1, Opção 2, Opção 3, etc."),
                          p(actionButton(inputId="buyButton", label="Confirmar", icon = icon("check")), align="left")
                          ),
                          box(width=6,
                              HTML("<b>Resultado:</b><br>"),br(),
                              uiOutput("feedbackBuy")
                              )
                            ))),
        
        ###############
        ## Otimismo ##
        ###############
        
        tabItem("opir", 
                tabsetPanel(id="tabOI",
                            tabPanel("Ponha-se à prova!",
                                     box(width=6,
                                         HTML("Para cada um dos acontecimentos de vida listados abaixo, indique se considera mais provável que lhe aconteçam a si ou aos outros (i.e., à generalidade dos portugueses), usando a seguinte escala de 10 pontos onde:<br><br>
                                              1 = Mais provável que aconteça a mim do que aos outros.<br>
                                              10 = Mais provável que aconteça aos outros do que a mim."),
                                         br(),br(),
                                         radioButtons("radioOP1", label = "Comprar uma casa que valorizou ao fim de alguns anos",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9,"10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP2", label = "Ter um aumento substancial de rendimentos",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP3", label = "Viver saudavelmente até aos 90 anos",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP4", label = "Ser bem sucedido/a profissionalmente",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP5", label = "Comprar uma casa que desvalorizou ao fim de alguns anos",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP6", label = "Ter uma redução substancial de rendimentos",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP7", label = "Ter uma doença grave",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP8", label = "Ter um trabalho que não o/a realiza",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         p(actionButton(inputId="OIpButton", label="Confirmar", icon = icon("check")), align="right")),
                                     box(width=6, 
                                         HTML("<b>Resultado:</b>"),
                                         uiOutput("checkPracticeOI"),
                                         p(actionButton("Next13", div("Continuar", icon("arrow-right"))), align="right")
                                     )
                            ),
                            tabPanel(value="oi1", title="Otimismo irrealista",
                                     box(width=12,
                                         fluidRow(
                                           column(6,
                                                  h3("O que é?"),
                                                  p("O exemplo que acabou de ver ilustra a tendência que a maioria das pessoas tem para avaliar como mais prováveis os acontecimentos positivos nas suas vidas do que nas vidas dos outros, sendo o inverso válido para os acontecimentos negativos. Esta tendência, apelidada de otimismo irrealista, é uma das formas de manifestação de sobreconfiança, i.e., tendência para sobrestimar as capacidades e conhecimentos do próprio, assim como o seu grau de controlo sobre os acontecimentos de vida e as suas probabilidades de sucesso."),
                                                  h3("Implicações financeiras"),
                                                  HTML("<p>Os efeitos negativos do otimismo irrealista têm impacto em muitas áreas da nossa vida. Na área financeira o otimismo irrealista está associado a:</p>
                                                  <ul>
                                                    <li>Níveis mais elevados de sobreconfiança que, por sua vez, estão associados a comportamentos de maior risco financeiro;</li>
                                                    <li>Sobrestimação de ganhos/rendimentos futuros traduz-se numa maior propensão para consumo;</li>
                                                    <li>Subestimação da probabilidade de incumprimento no pagamento de prestações de crédito com impacto na escolha de créditos a habitação (por exemplo, empréstimos para compra de casa de valor superior ao que o consumidor pode pagar mensalmente sem entrar em dificuldades financeiras);</li>
                                                    <li>Menor propensão para poupar dinheiro para eventuais imprevistos financeiros;</li>
                                                    <li>Menor propensão para procurar ajuda de um especialista.</li>
                                                  </ul>
                                                "),
                                                  h3("Como evitar?"),
                                                  HTML("<p>Para evitar o irrealismo otimista quando estiver, por exemplo, a pensar fazer um empréstimo para compra de habitação, experimente as seguintes sugestões:</p>
                                                <ul>
                                                  <li>Desafie as suas crenças – discuta-as com outras pessoas que possam dar-lhe outros pontos de vista / questione as suas decisões;</li>
                                                  <li>Procure feedback;</li>
                                                  <li>Procure informação para tomar decisões;</li>
                                                  <li>Pense ativamente no que pode correr mal;</li>
                                                  <li>Imagine que está a aconselhar um familiar ou amigo/a;</li>
                                                  <li>Compare-se com outras pessoas que de facto conheça em vez de se comparar com os outros em geral;</li>
                                                  <li>Evite decisões impulsivas.</li>
                                                </ul>
                                                "),
                                                  h3("Para saber mais"),
                                                  HTML("<ul>
                                                        <li>Weinstein, N. D. (1980). Unrealistic optimism about future life events. <i>Journal of Personality and Social Psychology, 39</i>(5), 806.</li>
                                                        <li>Shepperd, J. A., Waters, E. A., Weinstein, N. D., & Klein, W. M. P. (2015). A primer on unrealistic optimism. <i>Current Directions in Psychological Science, 24</i>(3), 232–237. https://doi.org/10.1177/0963721414568341 </li>
                                                       </ul>")
                                           ),
                                           column(6,
                                                  HTML("<div style=\"text-align:center\">
                                                  10 = Mais provável na vida da generalidade dos portugueses do que na minha</div>"),
                                                  plotOutput("plotOI"),
                                                  HTML("<div style=\"text-align:center\">1 = Mais provável na minha vida do que na da generalidade dos portugueses<br></div>"),
                                                  br(),br(),
                                                  uiOutput("noteplotOI"),
                                                  br(),br(),
                                                  p(actionButton("Next14", div("Continuar", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat7", title="Pratique",
                                     
                                     box(width=6,
                                         sliderInput("oiN1", label = ("Imagine que tem um filho ou uma filha que nasceu em 2017. Qual acha ser a sua probabilidade (de 0 a 100%) de chegar a fazer 84 anos, caso seja menina, ou 78 anos, caso seja menino?"), value = 0, min=0, max=100),
                                         sliderInput("oiN2", label = ("Qual acha ser a sua probabilidade (de 0 a 100%) de entrar em incumprimento no pagamento dos seus créditos?"), value = 0,min=0, max=100),
                                         sliderInput("oiN3", label = ("Qual acha ser a sua probabilidade (de 0 a 100%) de ganhar um prémio de qualquer valor no Euromilhões?"), value = 0, min=0, max=100),
                                         sliderInput("oiN4", label = ("Qual acha ser a sua probabilidade (de 0 a 100%) de ter um acidente no trabalho?"), value = 0,min=0, max=100),
                                         br(),br(),
                                         p(actionButton(inputId="oiButton", label="Confirmar", icon = icon("check")), align="right")),
                                     box(width=6, HTML("<b>Resultado:</b>"),
                                         uiOutput("feedbackOI"))
                            ))),
        
        
        #####################
        ## Disponibilidade ##
        #####################
        
        
        tabItem("disp", 
                tabsetPanel(id="tabAH",
                            tabPanel("Ponha-se à prova!",
                                     box(width=6,
                                         "Imagine que precisa de pedir um empréstimo para a compra da sua casa. Qual das seguintes informações considera a mais relevante para comparar as propostas de crédito que lhe serão apresentadas?",
                                         br(),
                                         radioButtons("checkGroupAH", label = "", 
                                                            choices = list("Prestação mensal base" = 1,
                                                                           "Spread contratado" = 2, 
                                                                           "Seguro de vida" = 3,
                                                                           "Seguro Multirriscos" = 4,
                                                                           "Comissões" = 5,
                                                                           "Montante total a reembolsar" = 6,
                                                                           "Spread base (sem contratação de outros produtos)" = 7,
                                                                           "TAEG com bonificação" = 8
                                                            ),
                                                            selected = "NULL"),
                                         p(actionButton(inputId="ahButton", label="Confirmar", icon = icon("check")), align="right")),
                                     box(width=6, HTML("<b>Resultado:</b>"),
                                         uiOutput("feedbackAH"),
                                         br(),
                                         p(actionButton("Next23", div("Continuar", icon("arrow-right"))), align="right"))
                            ),
                            tabPanel(value="ah1", title="Heurística da disponibilidade",
                                     box(width=12,
                                         fluidRow(
                                           column(6,
                                                  h3("O que é?"),
                                                  HTML("A escolha de um crédito habitação envolve a consideração de um vasto conjunto de informações, muitas vezes apresentado de forma dispersa e pouco adequada ao modo como as pessoas processam informação. Em ambientes de decisão complexos como este, a dificuldade de levar em consideração toda a informação apresentada, leva as pessoas a basear as suas decisões num conjunto limitado de informação que habitualmente é mais fácil de recordar. Isto é, que está mais acessível ou disponível na sua memória (heurística da disponibilidade). Embora útil em muitas ocasiões, esta estratégia pode conduzir a decisões erradas quando a informação que está mais disponível em memória não é a informação mais útil para a decisão. Informações como o spread ou a prestação mensal na escolha de um crédito habitação são um bom exemplo disso. Embora não sejam os critérios mais úteis na escolha do crédito, estas informações são frequentemente referidas na publicidade ao crédito habitação, estando muito disponíveis em memória e sendo por isso facilmente lembrados pelos consumidores no momento da sua decisão."),
                                                  h3("Implicações financeiras"),
                                                  HTML("Basear a escolha de crédito habitação na informação mais acessível em memória, sem antes considerar a validade desta informação, pode conduzir a escolhas com custos mais elevados para os consumidores. A tabela ao lado ilustra isso mesmo. Um consumidor que baseasse a sua escolha para contrair um empréstimo de 125 mil Euros no spread, optaria pela proposta do Banco 1 e no final do empréstimo teria pagado um montante total de 167.571,28€. Ou seja, teria pagado 3.499,01€ a mais do que pagaria se optasse pela proposta do Banco 3. Se o mesmo consumidor baseasse a sua escolha no valor da prestação mensal base, e optasse pela proposta do Banco 2, no final do empréstimo teria pago mais 444,19€ do que se optasse pela proposta (mais vantajosa) do Banco 3 (note que o Banco 2 tem igualmente um spread inferior ao do Banco 3). Assim, apesar de apresentar o spread e a prestação mensal mais elevados, a proposta de crédito mais vantajosa é a do Banco 3, com um montante total a reembolsar no valor de 164.072,27€. A vantagem deste banco está na cobrança de valores mais baixos de seguros e comissões, informações que são frequentemente negligenciadas pelo consumidor."),
                                                  h3("Como evitar?"),
                                                  HTML("Tomar as melhores decisões num ambiente complexo como o da escolha de crédito habitação implica em primeiro lugar reconhecer a complexidade da situação e em segundo lugar agir sobre ela. Nas simulações que vai receber dos bancos não terá a informação toda organizada e sistematizada como lhe ilustramos com a tabela ao lado. 
                                                        <br>Contudo nada o impede de identificar a informação relevante para fazer comparações entre bancos e criar a sua própria tabela de comparação. Lembre-se que a comparação só é válida se mantiver a duração do contrato e o montante do empréstimo iguais para todas as simulações. 
                                                        <br>Escolha o crédito com menor TAEG e um menor montante total a reembolsar. 
                                                        <br>Nota: é possível que a sua decisão se baseie no montante mensal que tem disponível para o empréstimo, optando por créditos com menores prestações mensais e durações mais longas que normalmente resulta em montantes totais a reembolsar mais elevados. Se tiver que o fazer, faça-o de forma consciente, sabendo que a sua escolha é a que satisfaz os seus objetivos presentes (avançar para a compra da casa) mas não é a escolha que melhor serve os seus interesses financeiros futuros. Se a sua situação financeira entretanto melhorar, procure amortizar mais rapidamente o seu crédito habitação (reduzindo assim o montante total a reembolsar).
                                                        <br>Por fim, pondere consultar um especialista em crédito imobiliário independente – existem atualmente várias empresas que o/a podem ajudar a encontrar as melhores soluções para o seu caso concreto.
                                                  "),
                                                  h3("Para saber mais"),
                                                  HTML("<ul>
                                                          <li>Barber, B. M., & Odean, T. (2008). All that glitters: The effect of attention and news on the buying behavior of individual and institutional investors. <i>The Review of Financial Studies, 21</i>(2), 785-818.</li>
                                                          <li>Brenncke, M. (2018). The legal framework for financial advertising: curbing behavioural exploitation. <i>European Business Organization Law Review, 19</i>(4), 853-882.</li>
                                                          <li>Tversky, A., & Kahneman, D. (1974). Judgment under uncertainty: Heuristics and biases. <i>Science, 185</i>, 1124-1131.</li>
                                                        </ul>")
                                                      ),
                                           column(6,
                                                  HTML("Tabela síntese de simulação para um empréstimo de 125.000€ com duração de 30 anos (dados fornecidos pela DECO):
                                                        <br><br>
                                                        <table class=\"bord\" style=\"width:100%;\">
                                                        <style>.bord {border: 1px solid black;padding: 8px;}</style>
                                                          <tr class=\"bord\">
                                                            <th class=\"bord\"></th>
                                                            <th class=\"bord\">Banco 1</th>
                                                            <th class=\"bord\">Banco 2</th>
                                                            <th class=\"bord\">Banco 3</th>
                                                            <th class=\"bord\">Banco 4</th>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Prestação mensal base</td>
                                                            <td class=\"bord\">396,11€</td>
                                                            <td class=\"bord\">400,79€</td>
                                                            <td class=\"bord\">415,27€</td>
                                                            <td class=\"bord\">415,27€</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Spread contratado</td>
                                                            <td class=\"bord\">1,20%</td>
                                                            <td class=\"bord\">1,25%</td>
                                                            <td class=\"bord\">1,50%</td>
                                                            <td class=\"bord\">1,50%</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Seguro de vida</td>
                                                            <td class=\"bord\">16,93€</td>
                                                            <td class=\"bord\">18,45€</td>
                                                            <td class=\"bord\">15,35€</td>
                                                            <td class=\"bord\">15,39€</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Seguro multirriscos</td>
                                                            <td class=\"bord\">16,14€</td>
                                                            <td class=\"bord\">13,91€</td>
                                                            <td class=\"bord\">9,97€</td>
                                                            <td class=\"bord\">16,61€</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Comissões</td>
                                                            <td class=\"bord\">1.284,40€</td>
                                                            <td class=\"bord\">1.033,40€</td>
                                                            <td class=\"bord\">688,15€</td>
                                                            <td class=\"bord\">728,00€</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Montante total a reembolsar</td>
                                                            <td class=\"bord\">167.571,28€</td>
                                                            <td class=\"bord\">164.516,46€</td>
                                                            <td class=\"bord\">164.072,27€</td>
                                                            <td class=\"bord\">168.696,45€</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Spread base (sem contratação de outros produtos)</td>
                                                            <td class=\"bord\">1,90%</td>
                                                            <td class=\"bord\">1,75%</td>
                                                            <td class=\"bord\">2,20%</td>
                                                            <td class=\"bord\">1,90%</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">TAEG com bonificação</td>
                                                            <td class=\"bord\">1,90%</td>
                                                            <td class=\"bord\">2,00%</td>
                                                            <td class=\"bord\">1,90%</td>
                                                            <td class=\"bord\">2,10%</td>
                                                          </tr>
                                                        </table> "),
                                                  br(),br(),
                                                  p(actionButton("Next24", div("Continuar", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat12", title="Pratique",
                                     box(width=6,
                                         HTML("Agora que já sabe mais sobre o modo como escolher adequadamente um crédito habitação, analise a tabela abaixo e ordene os vários créditos apresentados começando pelo crédito que oferece melhores condições até ao que oferece piores condições:<br><br>
                                                  <table class=\"bord\" style=\"width:100%;\">
                                                          <tr class=\"bord\">
                                                            <th class=\"bord\"></th>
                                                            <th class=\"bord\">Banco 1</th>
                                                            <th class=\"bord\">Banco 2</th>
                                                            <th class=\"bord\">Banco 3</th>
                                                            <th class=\"bord\">Banco 4</th>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Prestação mensal base</td>
                                                            <td class=\"bord\">392,25€</td>
                                                            <td class=\"bord\">400,79€</td>
                                                            <td class=\"bord\">415,27€</td>
                                                            <td class=\"bord\">415,27€</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Spread contratado</td>
                                                            <td class=\"bord\">1,10%</td>
                                                            <td class=\"bord\">1,25%</td>
                                                            <td class=\"bord\">1,50%</td>
                                                            <td class=\"bord\">1,50%</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Seguro de vida</td>
                                                            <td class=\"bord\">11,50€</td>
                                                            <td class=\"bord\">18,45€</td>
                                                            <td class=\"bord\">15,39€</td>
                                                            <td class=\"bord\">15,29€</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Seguro multirriscos</td>
                                                            <td class=\"bord\">15,44€</td>
                                                            <td class=\"bord\">13,91€</td>
                                                            <td class=\"bord\">16,61€</td>
                                                            <td class=\"bord\">8,97€</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Comissões</td>
                                                            <td class=\"bord\">979,70€</td>
                                                            <td class=\"bord\">1.033,40€</td>
                                                            <td class=\"bord\">728,00€</td>
                                                            <td class=\"bord\">792,50€</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Montante total a reembolsar</td>
                                                            <td class=\"bord\">158.029,72€</td>
                                                            <td class=\"bord\">164.516,46€</td>
                                                            <td class=\"bord\">168.696,45€</td>
                                                            <td class=\"bord\">165.596,82€</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Spread base (sem contratação de outros produtos)</td>
                                                            <td class=\"bord\">1,70%</td>
                                                            <td class=\"bord\">1,75%</td>
                                                            <td class=\"bord\">1,90%</td>
                                                            <td class=\"bord\">2,00%</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">TAEG com bonificação</td>
                                                            <td class=\"bord\">1,70%</td>
                                                            <td class=\"bord\">2,00%</td>
                                                            <td class=\"bord\">2,10%</td>
                                                            <td class=\"bord\">2,00%</td>
                                                          </tr>
                                                        </table>"),br(),
                                     HTML("Clique na caixa abaixo e selecione a ordem das ofertas de cada banco da melhor à pior."),
                                     selectizeInput(
                                       'selectizeAH', '', choices = paste(rep("Banco", 4),seq(1,4)), multiple = TRUE
                                     ),
                                     p("Nota: Caso se engane, apague o conteúdo e volte a selecionar as opções para corrigir."),
                                         p(actionButton(inputId="AHpButton", label="Confirmar", icon = icon("check")), align="right")),
                                     box(width=6, 
                                         HTML("<b>Resultado:</b><br>"),br(),
                                         uiOutput("checkPracticeAH")
                                     )
                            ))),
        
        
        #|###########|#
        #|# REFORMA #|#
        #|###########|#
        
        tabItem("introR",
                box(width=12, h3("PREPARAR A REFORMA", align="center")),
                fluidRow(box(width=6,
                    HTML("<h3>Porquê preparar a reforma?</h3>
                         <p>Segundo dados da <a href=\"https://www.pordata.pt/Portugal/Pens%C3%A3o+m%C3%A9dia+anual+da+Seguran%C3%A7a+Social+total++de+sobreviv%C3%AAncia++de+invalidez+e+de+velhice-706\">PORDATA</a>, 
                         em 2017 o valor da pensão média em Portugal foi de cerca de 436,39€ por mês. Este valor é inferior ao limiar de risco de pobreza, que em 2017 foi de 467,25€. Nos últimos 15 anos (ver gráfico à direita), o valor 
                         médio da reforma encontrou-se sempre (menos em 2013 e 2014) abaixo do limiar de risco de pobreza. É, por isso, importante fazer mais para preparar a reforma. Algumas formas de preparar a reforma são:</p><p>
                        <ul>
                          <li>Poupar dinheiro especificamente para usar na reforma;</li>
                          <li>Investir o dinheiro poupado em produtos como Planos Poupança Reforma (PPR);</li>
                          <li>Diminuir os custos que terá na reforma (e.g., tendo casa própria);</li>
                          <li>Investindo em oportunidades de rendimento para reforma (e.g., comprando uma casa que mais tarde possa alugar).</li>
                        </ul>
                         Descubra, abaixo, três enviesamentos que podem ter um impacto negativa na forma como prepara a reforma.
                         </p>"),
                    br()),
                box(width=6, plotOutput("reformplot"))),
                    fluidRow(
                      box(width=4, p(actionButton(inputId="NextP4A", label=HTML('<h3><i class="fa fa-coins"></i> Inércia</h3>')), align="center")),
                      box(width=4, p(actionButton(inputId="NextP4B", label=HTML('<h3><i class="fa fa-coins"></i> Pensamento linear</h3>')), align="center")),
                      box(width=4, p(actionButton(inputId="NextP4C", label=HTML('<h3><i class="fa fa-coins"></i> Viés temporal</h3>')), align="center"))
                    )
                ),
        
            #############
            ## Inércia ##
            #############
        
        tabItem("inertia",
                tabsetPanel(id="tabIN",
                            tabPanel("Ponha-se à prova!",
                              box(width=6, 
                                           textInput("ineN1", label = ("Quanto dinheiro poupa por mês especificamente para a reforma?"), value = 0),
                                           textInput("ineN2", label = ("Quanto dinheiro mais acha que seria capaz de poupar se se esforçasse mais tornando a poupança para a reforma um dos seus grandes objetivos de vida?"), value = 10),
                                  HTML("<b>Nota</b>: Insira apenas o número (e.g., 10) e utilize a vírgula se quiser indicar valores decimais."),
                              p(actionButton("ineButton", label="Confirmar", icon = icon("check")), align="right")
                              ),
                              box(width=6,
                                HTML("<b>Resultado:</b><br>"),
                                uiOutput("feedbackine"),
                                br(),
                                p(actionButton("Next3", div("Continuar", icon("arrow-right"))), align="right")
                              )
                              ),
                            tabPanel(title="Inércia", value="ine1",
                             box(width=12,
                              fluidRow(
                                column(7,
                                  h3("O que é?"),
                                  p("A inércia psicológica acontece quando evitamos o esforço e o gasto de energia mental para tomar decisões e, em vez disso, comportamo-nos de forma pouco consciente e largamente automática. Por exemplo, muita gente prepara a reforma através de descontos para a segurança social, não porque fez as contas e acha que o que desconta será o suficiente para viver bem na reforma, mas porque os descontos acontecem de forma obrigatória e automática."),
                                  h3("Implicações financeiras"),
                                  HTML("<p>A inércia pode verificar-se em todas as decisões que fazemos, sempre que decidimos não tomar uma decisão ou tomar aquela que é habitual. Por exemplo:</p>
                                    <ul>
                                      <li>Na preparação da reforma, quando não poupamos dinheiro especificamente para a reforma.</li>
                                      <li>Na gestão do orçamento, quando não fazemos orçamentos.</li>
                                      <li>Na compra de uma casa, quando vamos ao nosso banco pedir um crédito habitação, sem verificar se haveria uma alternativa melhor noutro banco.</li>
                                      <li>Nos cartões de crédito, quando, em vez de pensarmos quanto poderíamos pagar naquele mês, fazemos apenas o pagamento mínimo.</li>
                                    </ul>"),
                                  h3("Como evitar?"),
                                  p("A mera tomada de consciência de que muitas vezes nos deixamos levar pela inércia na tomada de decisão é um primeiro passo para a combater. Ironicamente, a maneira mais fácil de lutar contra a inércia é utilizar a inércia em seu benefício. Por exemplo, pode utilizar depósitos automáticos para poupar dinheiro para a reforma ou aumentar as contribuições que faz à segurança social para ter um acréscimo na pensão. Pode também criar um lembrete (por exemplo, anual ou a cada 5 anos) e dedicar uma ou duas horas a avaliar as suas escolhas e considerar se precisa fazer algumas alterações."),
                                h3("Para saber mais"),
                                HTML("<ul>
                                      <li>Benartzi, S., & Thaler, R. (2007). Heuristics and biases in retirement savings behavior. <i>Journal of Economic perspectives, 21</i>(3), 81-104.</li>
                                      <li>Krijnen, J. M., Zeelenberg, M., & Breugelmans, S. M. (2016). Overcoming inertia in retirement saving. <i>Netspar industry series, 46</i>.</li>
                                     </ul>")),
                                column(5,
                                  plotOutput("inertiaplot"),
                                  uiOutput("inertianote"),
                                  br(),
                                  p(actionButton("Next4", div("Continuar", icon("arrow-right"))), align="right")
                                  )))),
                            tabPanel(value="prat2",title="Pratique",
                                     box(width=6, 
                                          radioButtons("ineN3", label = ("Faz o orçamento familiar mensal?"),
                                                        choices = list("Sim, sempre" = 1, "Muitas vezes" = 2,
                                                                       "Por vezes" = 3, "Nunca" = 4), 
                                                        selected = "NULL"),
                                          radioButtons("ineN4", label = ("Cumpre o seu orçamento familiar?"),
                                                       choices = list("Sim, sempre" = 1, "Muitas vezes" = 2,
                                                                      "Por vezes" = 3, "Nunca" = 4), 
                                                       selected = "NULL"),
                                         radioButtons("ineN5", label = ("Acha que é importante fazer, e cumprir o seu orçamento familiar?"),
                                                      choices = list("Sim, sempre" = 1, "Muitas vezes" = 2,
                                                                     "Por vezes" = 3, "Nunca" = 4), 
                                                      selected = "NULL"),
                                                  p(actionButton("ine2Button", label="Confirmar", icon = icon("check")), align="right")
                                         ),
                                        box(width=6, HTML("<b>Resultado:</b><br>"), uiOutput("feedbackine2"))
                                           ))),
        
            ############
            ## linear ##
            ############
        

        tabItem("exponential",
                tabsetPanel(id="tabEB",
                            tabPanel("Ponha-se à prova!",
                                     box(width=6, 
                                         HTML("Imagine que tem uma conta poupança que lhe rende juros anualmente com uma taxa anual nominal bruta (TANB) de 1,5% (os juros são reaplicados automaticamente na conta poupança). Quando abriu a conta fez logo um depósito de 100€ e, durante 40 anos, depositou todos os meses 100€ por mês na conta.<br><br>"),
                                         textInput("ebNum", label = ("Ao fim dos 40 anos, quanto dinheiro obteve no total (poupado + juros)?"), value = 0),
                                         HTML("<b>Nota 1</b>: Insira apenas o número (e.g., 10) e utilize a vírgula se quiser indicar valores decimais.
                                               <br><b>Nota 2</b>: Este é um exemplo simplificado que não contempla a dedução dos impostos sobre juros habitualmente cobrados em sede de IRS."),
                                         p(actionButton("ebButton", label="Confirmar", icon = icon("check")), align="right")
                                         ),
                                     box(width=6,HTML("<b>Resultado:</b><br><br>"),
                                         uiOutput("feedbackeb"),
                                         p(actionButton("Next9", div("Continuar", icon("arrow-right"))), align="right")
                                         )),
                            tabPanel(title="Pensamento linear", value="eb1",
                                     box(width=12,
                                         fluidRow(
                                           column(7,
                                                  h3("O que é?"),
                                                  HTML("O pensamento linear refere-se à tendência que as pessoas têm para fazer estimativas lineares do crescimento (se poupar 10€ por mês, ao fim de dois meses tenho 20€, ao fim de 3 meses, 30€, e assim sucessivamente). Esta tendência leva ao enviesamento de crescimento exponencial quando é usada para fazer estimativas sobre quantidades crescem de forma exponencial. Por exemplo, as pessoas tendem a subestimar o crescimento das suas poupanças; e a sobrestimar o dinheiro necessário (e o tempo que demora a pagar) uma dívida a prestações. Isto acontece porque, nestes casos, as curvas de crescimento não são lineares, mas sim exponenciais. 
                                                  <br>No exercício em questão, este viés faz com que achemos que a quantidade de dinheiro que podemos ganhar a poupar dinheiro é inferior à real (ver imagem ao lado).
                                                  "),
                                                  h3("Implicações financeiras"),
                                                  HTML("<p>O pensamento linear leva-nos a subestimar quanto podemos ganhar a fazer poupanças, mas também nos leva a subestimar o custo de dívidas com juros (por exemplo, quando usamos cartão de crédito ou subscrevemos um crédito habitação)."),
                                                  h3("Como evitar?"),
                                                  HTML("<p>Compreenda que os juros cumulativos sobre um dado valor fazem com que este cresça de maneira exponencial e não linear, pelo que quando contrair crédito vai provavelmente pagar mais do que pensa e quando fizer poupanças vai poupar mais do que pensa.</p>Se não tiver facilidade em pensar em crescimentos exponenciais, recorra a um simulador, como os seguintes simuladores do <a href=\"https://www.bportugal.pt/\">Banco de Portugal</a> e do <a href=\"https://www.todoscontam.pt/\">plano nacional de literacia financeira</a>:</p>
                                                      <ul>
                                                        <li><a href=\"https://www.todoscontam.pt/simulador-da-poupanca\">Simulador de poupança</a>;</li>
                                                        <li><a href=\"https://clientebancario.bportugal.pt/creditos-consumidores\">Simulador de crédito ao consumo</a>;</li>
                                                        <li><a href=\"https://clientebancario.bportugal.pt/credito-habitacao\">Simulador de crédito à habitação</a>.</li>
                                                      </ul>
                                                    "),
                                                  h3("Para saber mais"),
                                                  HTML("<ul>
                                                        <li>Stango, V., & Zinman, J. (2009). Exponential growth bias and household finance. <i>The Journal of Finance, 64</i>(6), 2807-2849.</li>
                                                       </ul>")
                                           ),
                                           column(5,
                                                  plotOutput("egplot"),
                                                  HTML("Como pode ver no gráfico, a distância entre uma poupança com e sem juros vai aumentando à medida que o tempo passa.
                                                       No nosso exemplo, os juros de 1,5% representam um ganho total de 17.879,18€ ao longo dos 40 anos."),
                                                  br(),
                                                  p(actionButton("Next10", div("Continuar", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat5",title="Pratique",
                                     box(width=6,                                          
                                         HTML("Imagine que pediu um crédito habitação com uma taxa anual nominal (TAN) de 1,5%. Pediu 100.000€ de empréstimo e decidiu pagá-los em 40 anos.<br><br>"),
                                         textInput("ebpNum", label = ("Ao fim dos 40 anos, quanto dinheiro pagou no total (empréstimo + juros)?"), value = 0),
                                         HTML("<b>Nota 1</b>: Insira apenas o número (e.g., 10) e utilize a vírgula se quiser indicar valores decimais.<br>
                                              <b>Nota 2</b>: Pode usar a <a href=\"https://www.todoscontam.pt/pt-pt/simuladorcreditohabitacao\">calculadora do Banco de Portugal</a>."),
                                         p(actionButton("ebpButton", label="Confirmar", icon = icon("check")), align="right")
                                         ),
                                     box(width=6,
                                         HTML("<b>Resultado:</b><br><br>"),
                                         uiOutput("feedbackebp")
                                     )))),
        
        ##############
        ## temporal ##
        ##############
        
        tabItem("discounting",
                tabsetPanel(id="tabHD",
                            tabPanel("Ponha-se à prova!",
                                     box(width=6, 
                                         HTML("<p>Imagine que participava num concurso e lhe apresentavam uma escolha entre receber 500€ hoje ou 505€ amanhã.</p>"),
                                         radioButtons("radiohd1", label = ("O que escolheria?"),
                                                      choices = list("Receber 500€ hoje" = 0, 
                                                                     "Receber 505€ amanhã" = 1
                                                                     ), selected=character(0)),
                                         HTML("<p>Agora imagine que as opções eram: receber 500€ daqui a um ano ou 505€ daqui a um ano e um dia.</p>"),
                                         radioButtons("radiohd2", label = ("O que escolheria?"),
                                                      choices = list("Receber 500€ daqui a um ano" = 0, 
                                                                     "Receber 505€ daqui a um ano e um dia" = 1
                                                                     ), selected=character(0)),
                                         p(actionButton("hdButton", label="Confirmar", icon = icon("check")), align="right")
                                     ),
                                     box(width=6,HTML("<b>Resultado:</b><br><br>"),
                                         uiOutput("feedbackhd"),
                                         p(actionButton("Next11", div("Continuar", icon("arrow-right"))), align="right")
                                     )),
                            tabPanel(title="Viés temporal", value="hd1",
                                     box(width=12,
                                         fluidRow(
                                           column(7,
                                                  h3("O que é?"),
                                                  HTML("O viés temporal acontece quando não atribuímos um valor constante ao tempo.
                                                  Por exemplo, se aceita esperar um dia para receber 500€ se lhe derem 5€ extra,
                                                  não deveria importar, à partida, se tem de esperar esse dia agora ou daqui a um ano.
                                                  <br>O viés temporal tem duas variantes, o viés do presente (quando precisamos que nos paguem mais para adiarmos receber dinheiro no imediato)
                                                  e o viés do futuro (quando precisamos que nos paguem mais para adiarmos receber dinheiro no futuro)."),
                                                  h3("Implicações financeiras"),
                                                  HTML("Tanto o viés do futuro como o viés do presente podem ter implicações financeiras negativas, já que a altura em que tomamos uma escolha ou em que ela se aplica passa a ter impacto.
                                                  <br>
                                                  Por exemplo, se sofrermos de viés de presente, podemos decidir não poupar ou então fazer compras utilizando crédito porque ter dinheiro agora vale mais do que no futuro.
                                                  No caso do viés do futuro, podemos fazer demasiados sacrifícios no presente para podermos ter dinheiro no futuro, não utilizar um cupão porque estamos à espera de uma compra futura onde vá ser mais benéfico usá-lo ou adiar o prazer (como uma garrafa de vinho especial ou umas férias num local que gostaríamos muito de experimentar) para o futuro."),
                                                  h3("Como evitar?"),
                                                  HTML("<p>Algumas maneiras de evitar estes vieses são:</p>
                                                       <ul>
                                                         <li>Para ambos os vieses, comprometa-se a seguir uma determinada lógica antes de aparecer a escolha: por exemplo, poupará todo dinheiro que obtiver acima de 1000€ ou abrirá a garrafa de vinho especial quando receber um aumento. Se o desejável (poupar ou abrir a garrafa) nunca vier a acontecer, reveja o seu compromisso de forma a torná-lo mais possível de acontecer.</li>
                                                         <li>Para evitar o viés do presente, lembre-se que muitas vezes adiamos as coisas porque assumimos erradamente o nosso Eu futuro exatamente com as mesmas capacidades, energia, motivação e saúde do nosso Eu presente. Contudo, esta visão perfecionista do nosso Eu no futuro é ilusória. Para evitar ser vítima desta ilusão tente imaginar as necessidades que poderá vir a ter (aumento das despesas de saúde, despesas surpresa com o carro ou a casa, perda de capacidade financeira após a reforma, etc.). Outra estratégia eficaz é imaginar que está a aconselhar um amigo a preparar-se para o futuro (em vez de tomar decisões sobre si mesmo).</li>
                                                         <li>Para evitar o viés do futuro, tente utilizar a experiência passada para saber quando será uma altura certa para adiar ou não. Por exemplo, se tiver um cupão de validade mensal de 10% de desconto e a compra de valor superior que costuma fazer por mês é 50€, utilize-o quando fizer essa compra, sem esperar por poder vir a fazer uma compra com valor superior. Noutro exemplo, se está sempre à espera de uma boa altura para visitar um museu na sua cidade mas ainda não aconteceu, então deve tentar fazê-lo assim que possível e não esperar por uma melhor altura.</li>
                                                       </ul>
                                                       "),
                                                  h3("Para saber mais"),
                                                  HTML(
                                                  "<ul>
                                                    <li>Princeton University & FINRA Investor Education Foundation. <i>Overcoming biases to promote wise investing.</i></li>
                                                    <li>Shu, S. (2005). Choosing to consume later: Determinants of future-biased choice. <i>ACR North American Advances, 32</i>, 67-68.</li>
                                                    <li>† Stanovich, K. E., West, R. F., & Toplak, M. E. (2016). <i>The rationality quotient</i>. MIT Press.</li>
                                                    <li>Takeuchi, K. (2011). Non-parametric test of time consistency: Present bias and future bias. <i>Games and Economic Behavior, 71</i>(2), 456-478.</li>
                                                    <li>* Thaler, R. H. (1991). Some Empirical Evidence on Dynamic Inconsistency. In R. H. Thaler (Ed.), <i>Quasi rational economics</i>, 127-136. The Russell Sage Foundation.
                                                  </ul>
                                                  
                                                  <p>* Fonte do exemplo do separador \"Ponha-se à prova\", † Fonte do exemplo do separador \"Pratique\".</p>"
                                                  )
                                           ),
                                           column(5,
                                                  HTML("<div style=\"text-align:center;\">Aceitaria 5€ extra para esperar um dia para receber 500€?</div>"),
                                                  plotOutput("hdplot"),
                                                  uiOutput("hdnote"),
                                                  br(),
                                                  p(actionButton("Next12", div("Continuar", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat6",title="Pratique",
                                     box(width=6,                                          
                                         HTML("<p>Imagine que pode escolher entre receber uma dada quantidade de dinheiro agora ou esperar 3 meses para receber 100€. Indique as suas preferências para cada uma das seguintes possibilidades:</p>"),
                                         radioButtons("radiophd1", label = ("60€ agora ou 100€ dentro de 3 meses?"),
                                                      choices = list("60€ agora" = 0, 
                                                                     "100€ dentro de 3 meses" = 1
                                                      ), inline=T, selected=character(0)),
                                         radioButtons("radiophd2", label = ("70€ agora ou 100€ dentro de 3 meses?"),
                                                      choices = list("70€ agora" = 0, 
                                                                     "100€ dentro de 3 meses" = 1
                                                      ), inline=T, selected=character(0)),
                                         radioButtons("radiophd3", label = ("80€ agora ou 100€ dentro de 3 meses?"),
                                                      choices = list("80€ agora" = 0, 
                                                                     "100€ dentro de 3 meses" = 1
                                                      ), inline=T, selected=character(0)),
                                         radioButtons("radiophd4", label = ("85€ agora ou 100€ dentro de 3 meses?"),
                                                      choices = list("85€ agora" = 0, 
                                                                     "100€ dentro de 3 meses" = 1
                                                      ), inline=T, selected=character(0)),
                                         radioButtons("radiophd5", label = ("90€ agora ou 100€ dentro de 3 meses?"),
                                                      choices = list("90€ agora" = 0, 
                                                                     "100€ dentro de 3 meses" = 1
                                                      ), inline=T, selected=character(0)),
                                         radioButtons("radiophd6", label = ("99€ agora ou 100€ dentro de 3 meses?"),
                                                      choices = list("99€ agora" = 0, 
                                                                     "100€ dentro de 3 meses" = 1
                                                      ), inline=T, selected=character(0)),
                                         p(actionButton("hdpButton", label="Confirmar", icon = icon("check")), align="right")),
                                     box(width=6,
                                         HTML("<b>Resultado:</b><br><br>"),
                                         uiOutput("feedbackphd")
                                     )))),
        
        #|###########|#
        #|# CRÉDITO #|#
        #|###########|#
        
        tabItem("introC",
                box(width=12,
                    h3("CARTÕES DE CRÉDITO", align="center")),
                fluidRow(box(width=6,
                    HTML("<h3>Porquê utilizar cartões de crédito?</h3>
                    <p>Em 2018, Portugal ficou no <a href=\"https://www.jornaldenegocios.pt/mercados/detalhe/portugal-e-o-quarto-pais-europeu-com-mais-cartoes-bancarios-por-habitante\">quarto lugar</a> 
                    dos países da União Europeia com mais cartões bancários por habitante, com 2 cartões bancários por pessoa 
                    (média da União Europeia = 1,6), sendo que um terço desses cartões bancários (36,44%) são cartões de crédito.</p>
                    <p>Os cartões de crédito podem trazer vários benefícios, tais como:</p>
                    <ul>
                      <li>Cashbacks (isto é, uma percentagem do valor da compra é devolvido);</li>
                      <li>Descontos especiais;</li>
                      <li>Acesso a condições especiais na subscrição de outros produtos do banco (por exemplo, seguros com uma anuidade mais baixa);</li>
                      <li>Permitir antecipar compras para as quais não se tem liquidez (dinheiro disponível) no momento, mas que se vai ter num futuro próximo.</li>
                     </ul>Podem também, porém, ser fonte de problemas, especialmente se o/a levar a comprar mais coisas do que devia ou a contrair  dívida.</p>"),
                    p("Descubra, abaixo, três enviesamentos que podem ter um impacto negativo na forma como utiliza cartões de crédito.")),
                    box(width=6,plotOutput("cardplot"),HTML("<br><p>Fontes: <a href=\"https://www.bportugal.pt/sites/default/files/anexos/pdf-boletim/rsp2018_0.pdf\">Banco de Portugal</a> e da <a href=\"https://www.pordata.pt/Portugal/Popula%c3%a7%c3%a3o+residente++estimativas+a+31+de+Dezembro+total+e+por+grupo+et%c3%a1rio-7\">PORDATA</a>, dados relativos a 2018.</p>"))
                    ),
                fluidRow(
                  box(width=4, p(actionButton(inputId="NextP5A", label=HTML('<h3><i class="fa fa-credit-card"></i> Ancoragem</h3>')), align="center")),
                  box(width=4, p(actionButton(inputId="NextP5B", label=HTML('<h3><i class="fa fa-credit-card"></i> Aversão a contas em dívida</h3>')), align="center")),
                  box(width=4, p(actionButton(inputId="NextP5C", label=HTML('<h3><i class="fa fa-credit-card"></i> Dor de pagar</h3>')), align="center"))
                )),
        
            ###############
            ## Ancoragem ##
            ###############
        
        tabItem("anchor",
                tabsetPanel(id="tabAN",
                            tabPanel("Ponha-se à prova!",
                                     box(width=6,
                                             HTML("Imagine que o seu cartão de crédito apresenta neste momento um 
                                             saldo negativo (ou seja, uma dívida) de 1.214,18€. De acordo com o extrato bancário, a prestação 
                                             mínima a pagar para este valor é de <b>36,43€</b>. <br><br>Assumindo que depois de 
                                             pagar todas as suas despesas mensais tem disponíveis 150€, qual o valor 
                                             que estaria disposto/a pagar para abater o seu crédito?"),
                                             textInput("numAN", label = "", value = "", width="100%"),
                                             HTML("<b>Nota</b>: Insira apenas o número (e.g., 10) e utilize a vírgula se quiser indicar valores decimais."),
                                             p(actionButton("anchButton", label="Confirmar", icon = icon("check")), align="right")
                                          ),
                                          box(width=6, 
                                              HTML("<b>Resultado:</b>"),
                                              uiOutput("feedbackanch"),
                                              br(),
                                              p(actionButton("Next5", div("Continuar", icon("arrow-right"))), align="right")
                                            )
                                         ),
                            tabPanel(title="Ancoragem", value="anc1",
                                     box(width=12,
                                         fluidRow(
                                           column(7,
                                                  h3("O que é?"),
                                                  p("O efeito de ancoragem verifica-se quando um valor que é sugerido no contexto em que tomamos uma decisão influencia as estimativas que fazemos (ou seja, funciona como uma âncora). No exemplo anterior, a prestação mínima (36,43€) funciona como âncora, fazendo com que as pessoas indiquem prestações mensais mais baixas (média = 58,08€) quando comparadas com as pessoas que responderam ao mesmo problema, mas onde a prestação mínima apresentada foi mais elevada:  60,71€ (média de resposta = 77,01€)."),
                                                  HTML("<p>O efeito de ancoragem pode levar a consequências negativas no pagamento do crédito, designadamente:</p>
                                                       <ul>
                                                        <li>Demorar mais tempo a pagar o crédito;</li>
                                                        <li>Ter de pagar mais juros.</li>
                                                       </ul>
                                                       <p>Por exemplo, considerando uma taxa de juro de 8%, as pessoas a quem foi apresentada uma prestação mínima de 36,43€, pagariam em média mais 70€ e demorariam aproximadamente mais 16 meses a saldar a sua dívida do que as pessoas a quem foi apresentada uma prestação mínima de 60,71€.<br>
                                                       O efeito de ancoragem tem várias explicações. Segundo a heurística da ancoragem e ajustamento (uma estratégia simples de decisão), este enviesamento ocorre porque as pessoas tendem a usar os valores apresentados nos contextos de decisão como uma pista útil para a sua resposta, partindo desse valor  e ajustando-o (para cima ou para baixo) até encontrarem um valor que considerem adequado. O facto deste ajustamento ser muitas vezes insuficiente (por falta de tempo, motivação ou simplesmente porque as pessoas não o fazem de uma forma exaustiva), resulta em estimativas numéricas que estão mais próximas dos valores sugeridos do que das estimativas médias dadas no mesmo tipo de situação quando nenhum valor é sugerido no contexto de decisão.
                                                       Outros fatores como, por exemplo, a tendência para aceitar valores de pagamento que nos são cobrados por defeito contribuem também para que muitos consumidores acabem por pagar o valor mínimo mensal dos seu extratos de cartão de crédito.</p>"),
                                                  h3("Implicações financeiras"),
                                                  HTML("<p>O efeito e ancoragem é muitas vezes aproveitado em contextos de consumo e de negociação:</p>
                                                       <ul>
                                                        <li>Valores sugeridos por uma das partes na compra e venda de bens e produtos (ex. carros, casas) ancoram os valores finais da transação (mesmo quando são rejeitados pela outra parte);</li>
                                                        <li>Em muitas circunstâncias de negociação a primeira oferta funciona como uma âncora que acaba por influenciar o valor acordado no final da negociação. Ou seja, quanto maior a primeira oferta, maior o valor final acordado após a negociação e vice-versa (quanto menor a primeira oferta menor o valor final negociado).</li>
                                                       </ul>
                                                       "),
                                                  h3("Como evitar?"),
                                                  HTML("O efeito de ancoragem é um enviesamento extremamente difícil de evitar.
                                                    <br>A forma mais eficaz de o fazer é questionar os valores que lhe são sugeridos nos diferentes contextos, pensando em razões para que não sejam válidos ou pensando noutros valores possíveis. 
                                                    <br>No exemplo da prestação do cartão de crédito, poderia pensar em razões para não pagar apenas o valor mínimo indicado:
                                                    <ul>
                                                       <li>Por que razão é este o valor indicado como valor mínimo?</li>
                                                       <li>Quanto tempo demorará a pagar o crédito se optar sempre pela prestação mínima indicada?</li>
                                                       <li>Qual seria o valor máximo que poderia pagar?</li>
                                                    </ul>"),
                                                  h3("Para saber mais"),
                                                  HTML("<ul>
                                                        <li>Keys, B. J., Wang, J., & Bureau, C. F. P. (2014). <i>Perverse nudges: Minimum payments and debt paydown in consumer credit cards.</i> University of Chicago Working Paper.</li>
                                                        <li>Navarro-Martinez, D., Salisbury, L. C., Lemon, K. N., Stewart, N., Matthews, W. J., & Harris, A. J. (2011). Minimum required payment and supplemental information disclosure effects on consumer debt repayment decisions. <i>Journal of Marketing Research, 48</i>(SPL), S60-S77.</li>
                                                        <li>Sôro, J. , Ferreira, M., Garcia-Marques, L., Almeida F. & Reis, J. (in prep.). <i>Anchoring effects in credit card payments</i>.</li>
                                                        <li>Tversky, A., & Kahneman, D. (1974). Judgment under uncertainty: Heuristics and biases. <i>Science, 185</i>, 1124-1131</li>
                                                       </ul>")
                                         ),
                                         column(5,
                                                plotOutput("anchplot"),
                                                uiOutput("anchnote"),
                                                br(),
                                                p(actionButton("Next6", div("Continuar", icon("arrow-right"))), align="right")
                                                )
                                         ))),
                            tabPanel(title="Pratique", value="prat3",
                                     box(width=6,
                                         HTML("Imagine que está a planear as suas próximas férias. Planeia fazer uma viagem a dois pela região do Havai, com a duração de 8 a 10 dias em época alta.
                                               <br>Consultou uma agência de viagens que lhe apresentou uma proposta de um pacote de viagem e alojamento para duas pessoas, em hotel de 3 estrelas com pequeno almoço incluído, no valor de 5482,95€, oferecendo a possibilidade de pagar com o cartão de crédito.
                                               <br>Este valor está acima, abaixo ou é igual ao valor que considera adequado (i.e., o valor de mercado) para o pacote de viagem e alojamento?
                                              <div style=\"text-align:center;\">"),
                                         radioButtons("radioAN", label = "",
                                                      choices = list("Acima" = 1, "Igual" = 2, "Abaixo" = 3), 
                                                      selected = NULL, inline=T),
                                          HTML("</div>Qual o valor que considera adequado pagar (i.e., o valor de mercado) pelo pacote de viagem acima referido?
                                              <br>Antes de apresentar o valor estimado lembre-se das estratégias que aprendeu para evitar o efeito de ancoragem!"),
                                         textInput("textAN", "", value=0),
                                         HTML("<b>Nota</b>: Insira apenas o número (e.g., 10) e utilize a vírgula se quiser indicar valores decimais."),
                                         p(actionButton("anpButton", label="Confirmar", icon = icon("check")), align="right")
                                     ),
                                     box(width=6,
                                         HTML("<b>Resultado:</b><br><br>"),
                                         uiOutput("checkPracticeAN"),
                                         plotOutput("anchPplot")
                                     )
                            )
                )),
                            
      
    ######################
    ## Aversão a contas ##
    ######################
    
    
    tabItem("debtA",
            tabsetPanel(id="tabDA",
                        tabPanel("Ponha-se à prova!",
                                 box(width=6,
                                     HTML("Imagine que tem em dívida os seguintes valores:
                                     <br><br>
                                           <table style=\"width:100%\">
                                            <tr><th>Créditos</th><th>Valor em dívida</th><th>Taxa de juro</th></tr>
                                            <tr><td>Crédito 1</td><td>3.040€</td><td>12,50%</td></tr>
                                            <tr><td>Crédito 2</td><td>5.108€</td><td>13,25%</td></tr>
                                            <tr><td>Crédito 3</td><td>47.003€</td><td>14,00%</td></tr>
                                            <tr><td>Crédito 4</td><td>12.793€</td><td>13,50%</td></tr>
                                            <tr><td>Crédito 5</td><td>27.410€</td><td>13,75%</td></tr>
                                            <tr><td>Crédito 6</td><td>9.694€</td><td>12,00%</td></tr>
                                            <tr><td><b>Total: </b></td><td>105.048€</td><td></td></tr>
                                          </table> 
                                          <br>
                                          Admitindo que recebia um prémio no valor de €15.000, de que forma iria alocar o seu dinheiro? Preencha apenas o(s) espaço(s) correspondente(s) ao(s) crédito(s) onde pretende alocar algum dinheiro.
                                          "),
                                      HTML("<table cellspacing=0>
                                            <tr><td>Crédito 1:&nbsp;</td><td>"),
                                     textInput("textDA1", "", value=0),
                                      HTML("</td><td>€</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                           <td>Crédito 2:&nbsp;</td><td>"),
                                     textInput("textDA2", "", value=0),
                                     HTML("</td><td>€</td><td></td></tr>
                                           <tr><td>Crédito 3:&nbsp;</td><td>"),
                                     textInput("textDA3", "", value=0),
                                     HTML("</td><td>€</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                           <td>Crédito 4:&nbsp;</td><td>"),
                                     textInput("textDA4", "", value=0),
                                     HTML("</td><td>€</td></tr>
                                           <tr><td>Crédito 5:&nbsp;</td><td>"),
                                     textInput("textDA5", "", value=0),
                                     HTML("</td><td>€</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                           <td>Crédito 6:&nbsp;</td><td>"),
                                     textInput("textDA6", "", value=0),
                                      HTML("</td><td>€</td></tr>
                                           </table>"),
                                     div(uiOutput("debSum"), align="center"),
                                     HTML("<br><b>Nota</b>: Insira apenas um número igual ou superior a zero (e.g., 10) em cada caixa e utilize a vírgula se quiser indicar valores decimais."),
                                     p(actionButton("daButton", label="Confirmar", icon = icon("check")), align="right")
                                       ),
                                 box(width=6,
                                              HTML("<b>Resultado:</b>"),
                                              uiOutput("feedbackdebta"),
                                     br(),
                                     p(actionButton("Next17", div("Continuar", icon("arrow-right"))), align="right"))
                                 ),
                        tabPanel(title="Aversão a contas em dívida", value="da1",
                                 box(width=12,
                                     fluidRow(
                                       column(7,
                                              h3("O que é?"),
                                              p("No separador anterior mostrámos-lhe um exemplo da aversão a contas em dívida. Em situações em que as pessoas mantêm em aberto vários créditos, a aversão a contas em dívida manifesta-se pela preferência por pagar em primeiro lugar as dívidas menores (de forma a eliminá-las) em vez de pagar ou amortizar em primeiro lugar as dívidas que têm associadas maiores taxas de juro."),
                                              h3("Implicações financeiras"),
                                              p("Eliminar o número de dívidas pode ser tentador por criar no consumidor a sensação de cumprimento de um pequeno objetivo, motivando-o assim para o cumprimento do objetivo maior que é eliminar todas as dívidas. No entanto, quando esta estratégia leva a que se comece por eliminar as dívidas com menores taxas de juro (continuando a pagar durante mais tempo as dívidas com maiores taxas de juros), acabamos por ter que pagar  uma dívida global superior àquela que pagaríamos caso os pagamentos fossem alocados em primeiro lugar às dívidas com as maiores taxas de juro."),
                                              h3("Como evitar?"),
                                              p("A forma mais eficaz de contrariar a tendência para preferir eliminar pequenas dívidas em primeiro lugar é optar por amortizar com o dinheiro disponível as dívidas com maiores taxas de juro (independentemente do valor da dívida)."),
                                              p("Assim, para reduzir a tentação de eliminar as pequenas dívidas em primeiro lugar, calcule os valores de juros que resultam do não pagamento de cada uma das suas dívidas."),
                                              p("Uma outra forma de diminuir o impacto da “aversão a contas em dívida” nas suas finanças pessoais é optar pela consolidação de todas as dívidas numa dívida única. Embora esta opção possa ter custos iniciais, tipicamente reduz o serviço da dívida (i.e., as prestações mensais), acabando por permitir liquidar a dívida mais eficazmente."),
                                              HTML("<p>No caso de optar pela consolidação da dívida aconselha-se que recorra ao apoio de especialistas independentes como o <a href=\"https://www.deco.proteste.pt/institucionalemedia/quem-somos/servicos/gas\">Gabinete de Apoio ao Sobre-endividado da DECO</a>.</p>"),
                                              h3("Para saber mais"),
                                              HTML("<ul>
                                                   <li>* Amar, M., Ariely, D., Ayal, S., Cryder, C. E., & Rick, S. I. (2011). Winning the battle but losing the war: The psychology of debt management. <i>Journal of Marketing Research, 48</i>(SPL), S38-S50.</li>
                                                   </ul>
                                                   <p>* Fonte do exemplo do separador \"Ponha-se à prova\".</p>")
                                       ),
                                       column(5,
                                              plotOutput("debplot"),
                                              uiOutput("debnote"),
                                              br(),
                                              p(actionButton("Next18", div("Continuar", icon("arrow-right"))), align="right")
                                       )
                                    ))),
                        tabPanel(title="Pratique", value="prat9",
                                 box(width=6,
                                     HTML("Imagine que um amigo seu tem em dívida os seguintes valores:
                                     <br><br>
                                           <table style=\"width:100%\">
                                            <tr><th>Créditos</th><th>Valor em dívida</th><th>Taxa de juro</th></tr>
                                            <tr><td>Crédito 1</td><td>1.500€</td><td>18,50%</td></tr>
                                            <tr><td>Crédito 2</td><td>25.375€</td><td>14,75%</td></tr>
                                            <tr><td>Crédito 3</td><td>8.760€</td><td>10,50%</td></tr>
                                            <tr><td>Crédito 4</td><td>27.410€</td><td>13,75%</td></tr>
                                            <tr><td>Crédito 5</td><td>3.200€</td><td>12,00%</td></tr>
                                            <tr><td><b>Total: </b></td><td>66.245€</td><td></td></tr>
                                          </table> 
                                          <br>
                                          Clique na caixa abaixo e selecione a ordem (do primeiro ao último) pela qual o aconselharia a pagar os seus créditos."),
                                     selectizeInput(
                                       'selectizeDA', '', choices = paste(rep("Crédito", 5),seq(1,5)), multiple = TRUE
                                     ),
                                     HTML("<b>Nota</b>: Caso se engane, apague o conteúdo e volte a selecionar as opções para corrigir.<br>"),
                                     br(),
                                     p(actionButton("dapButton", label="Confirmar", icon = icon("check")), align="right")
                                 ),
                                 box(width=6,
                                     HTML("<b>Resultado:</b><br><br>"),
                                     uiOutput("checkPracticeDA")
                                     )
                                 )
                        )),
    
    ##################
    ## Dor de pagar ##
    ##################
    
    tabItem("pain",
            tabsetPanel(id="tabDP",
                        tabPanel("Ponha-se à prova!",
                                 box(width=6,
                                     HTML("Imagine que está a planear fazer um jantar em sua casa com 6 amigos. Antes de ir ao supermercado faz uma pequena lista do que precisa de comprar: para entradas algum pão/tostas e alguns queijos, para o prato principal os ingredientes para uma lasanha de carne e alguns vegetais para acompanhamento (salada ou legumes assados), uma tarte para sobremesa e algumas garrafas de vinho."),
                                     br(),br(),
                                     textInput("dpN0", label = ("Estime o custo das compras para o seu jantar:"), value = 0),
                                     HTML("De um ponto de vista psicológico, quanto acha que lhe custaria pagar este valor do supermercado se o fizesse...<br><br>
                                          <b>Usando o seu cartão de crédito - o valor da despesa será pago a partir do próximo mês em prestações suaves:</b><br>
                                          <table width=\"100%\">
                                            <tr><td>Nada (sem desconforto psicológico)</td><td style=\"text-align:right;\">Muito (elevado desconforto psicológico)</td></tr>
                                          </table><span style=\"text-align:center;\">"),
                                     radioButtons("dpN1", label = "",
                                                  choices = list("1" = 1, "2" = 2, "3" = 3, 
                                                                 "4" = 4, "5" = 5, "6" = 6, "7" = 7), 
                                                  selected = "NULL", inline=T),
                                     HTML("</span><b>Levantando dinheiro no multibanco - a despesa de supermercado é paga em dinheiro no momento da compra:</b><br>
                                          <table width=\"100%\">
                                            <tr><td>Nada (sem desconforto psicológico)</td><td style=\"text-align:right;\">Muito (elevado desconforto psicológico)</td></tr>
                                          </table><span style=\"text-align:center;\">"),
                                     radioButtons("dpN2", label = "",
                                                  choices = list("1" = 1, "2" = 2, "3" = 3, 
                                                                 "4" = 4, "5" = 5, "6" = 6, "7" = 7), 
                                                  selected = "NULL", inline=T),
                                     HTML("</span>"),
                                     p(actionButton("dpButton", label="Confirmar", icon = icon("check")), align="right")
                                 ),
                                 box(width=6,
                                     HTML("<b>Resultado:</b>"),
                                     uiOutput("feedbackpaina"),
                                     br(),
                                     p(actionButton("Next21", div("Continuar", icon("arrow-right"))), align="right"))
                        ),
                        tabPanel(title="Dor de pagar", value="dp1",
                                 box(width=12,
                                     fluidRow(
                                       column(7,
                                              h3("O que é?"),
                                              HTML("A investigação acerca do comportamento do consumidor tem demonstrado que as pessoas gastam mais dinheiro quando pagam as suas compras com cartões de crédito (ou mesmo com cartões de débito) do que quando estas são pagas com dinheiro.
                                              <br>O pagamento de bens e serviços gera no consumidor uma experiência de desconforto apelidada de “dor de pagar” (pain of paying). Este desconforto resulta do balanço entre os benefícios esperados no momento da aquisição dos bens e serviços e os custos a eles associados e será tanto maior quanto mais evidente for a relação entre os bens e serviços adquiridos e os custos incorridos com a aquisição. 
                                              <br>Por essa razão, os métodos de pagamento que, como o cartão de crédito, dificultam o estabelecimento da relação entre os bens e serviços adquiridos e os seus custos estão associados a uma menor “dor de pagar” e, consequentemente, a uma maior propensão para o consumo."),
                                              h3("Implicações financeiras"),
                                              HTML("O pagamento com cartão de crédito é um dos métodos cujas características dificultam uma correta avaliação da relação custo-benefício na aquisição de bens e serviços.
                                              <br>Por um lado, existe uma distância temporal entre o momento da aquisição e fruição do bem ou serviço e o momento em que este é efetivamente pago. O facto dos bens e serviços pagos com cartão de crédito não se traduzirem em custos imediatos, como acontece quando estes são pagos com dinheiro, diminui a “dor de pagar” e potencia o consumo. 
                                              <br>Por outro lado, o pagamento das despesas debitadas no cartão de crédito é feito de forma agregada, ocultando a relação entre os diferentes bens e serviços e os seus custos e potenciando com isso maiores níveis de consumo."),
                                              h3("Como evitar?"),
                                              HTML("Tendo em conta os aspetos que o/a podem fazer gastar mais dinheiro quando paga com cartão de crédito, quando usar este método de pagamento procure pensar nos seguintes pontos:
                                                   <ul>
                                                    <li>Admitindo que tinha o dinheiro disponível para a compra, quão disposto/a estaria a realizar a mesma compra se o pagamento tivesse de ser feito com dinheiro? Nota: caso a sua motivação para o uso de cartão de crédito seja não ter o dinheiro disponível para a compra, avalie bem se precisa mesmo de incorrer nessa despesa e quão provável será conseguir pagá-la num prazo não superior a 3 meses. Mas não se esqueça que esta sua avaliação pode estar a enviesada por algum otimismo irrealista.</li>
                                                    <li>Mantenha um registo das compras que vai fazendo ao longo do mês com o cartão de crédito e do valor total que delas resulta - não se esqueça que a nossa contabilidade mental é muitas vezes falível!</li>
                                                    <li>Fique atento/a a outros métodos de pagamentos que dificultam o estabelecimento da relação imediata entre os bens e serviços adquiridos e os seus custos - os pagamentos automáticos com telemóvel ou cartão de débito e os débitos diretos são bons exemplos.</li>
                                                   </ul>
                                                   "),
                                              h3("Para saber mais"),
                                              HTML("<ul>
                                                     <li>Prelec, D., & Loewenstein, G. (1998). The red and the black: Mental accounting of savings and debt. <i>Marketing Science, 17</i>(1), 4-28.</li>
                                                     <li>Prelec, D., & Simester, D. (2001). Always leave home without it: A further investigation of the credit-card effect on willingness to pay. <i>Marketing Letters, 12</i>(1), 5-12.</li>
                                                     <li>* Raghubir, P., & Srivastava, J. (2008). Monopoly money: The effect of payment coupling and form on spending behavior. <i>Journal of Experimental Psychology: Applied, 14</i>(3), 213.</li>
                                                   </ul>
                                                   <p>* Fonte do exemplo do separador \"Ponha-se à prova\".</p>")
                                       ),
                                       column(5,
                                              plotOutput("dpplot"),
                                              HTML("Num estudo com participantes Americanos (<a href=\"https://psycnet.apa.org/buy/2008-12802-002\" target=\"_blank\">Raghubir & Srivastava, 2008</a>), as pessoas que fizeram a estimativa 
                                                   do custo do jantar pensando que iriam pagar com cartão de crédito estimaram um custo 
                                                   de 175,16$, quase 30$ mais do que os que estimaram imaginando que pagariam em dinheiro
                                                   (onde a média foi 145,56$)"),
                                              br(),
                                              p(actionButton("Next22", div("Continuar", icon("arrow-right"))), align="right")
                                       )
                                     ))),
                        tabPanel(title="Pratique", value="prat11",
                                 box(width=6,
                                     HTML("Ainda se lembra do exemplo do jantar com amigos em sua casa? Volte agora a estimar o valor total do jantar, considerando separadamente os valores associados aos diferentes itens:"),
                                     br(),br(),
                                     textInput("dppN1", label = ("Entradas:"), value = 0),
                                     textInput("dppN2", label = ("Prato principal:"), value = 0),
                                     textInput("dppN3", label = ("Sobremesa:"), value = 0),
                                     textInput("dppN4", label = ("Bebidas:"), value = 0),
                                     br(),
                                     div(uiOutput("dpSum"), align="center"),
                                     br(),
                                     p(actionButton("dppButton", label="Confirmar", icon = icon("check")), align="right")
                                 ),
                                 box(width=6,
                                     HTML("<b>Resultado:</b><br><br>"),
                                     uiOutput("checkPracticeDP")
                                 )
                        )
            )),
    
    
    
    ###########
    ## Sobre ##
    ###########
    
    tabItem("sobre",
            box(width=12,
                h2("Sobre esta aplicação", align="center"),
                br(),
                HTML('Esta aplicação foi desenvolvida pelo grupo de investigação Cognição em Contexto (CO2) do
                  <a href="https://www.psicologia.ulisboa.pt/cicpsi/">Centro de Investigação em Ciência Psicológica</a> (CICPSI), da Faculdade de Psicologia da Universidade de Lisboa,
                     tendo sido financiada pela Fundação para a Ciência e Tecnologia através do projeto PTDC/MHC-PAP/1556/2014.'),
                br(),
                fluidRow(
                  column(6, HTML('<img src="fp.png" width="90%">')),
                  column(6, HTML('<img src="fct.png" width="100%">'))
                ))
            )
                            
                            
        ))))

