#####PACKAGES##########
library(shiny)
library(ggplot2)
library(shinydashboard)

#### TAB 1 Introduction: #####
ui = dashboardPage(
  dashboardHeader(title = "Biases"),
  dashboardSidebar(  

    
    ####################
    ### SIDEBAR MENU ###
    ####################
    
    
    sidebarMenu(id="tabs", 
                menuItem("Introduction", tabName="intro", icon = icon("map")),
                menuItem("Managing a budget", tabName="orcamento", icon = icon("clipboard"),
                         menuSubItem("Introduction", tabName="introO"),
                         menuSubItem("Self-regulation", tabName="fauto"),
                         menuSubItem("Mental accounting", tabName="contm"),
                         menuSubItem("Opportunity costs", tabName="custop")
                         ),
                menuItem("Buying a house", tabName="casa", icon = icon("home"),
                         menuSubItem("Introduction", tabName="introH"),
                         menuSubItem("Narrow thinking", tabName="narrow"),
                         menuSubItem("Unrealistic optimism", tabName="opir"),
                         menuSubItem("Availability heuristic", tabName="disp")
                         ),
                menuItem("Preparing for retirement", tabName="reforma", icon = icon("coins"),
                         menuSubItem("Introduction", tabName="introR"),
                         menuSubItem("Inertia", tabName="inertia"),
                         menuSubItem("Linear thinking", tabName="exponential"),
                         menuSubItem("Temporal bias", tabName="discounting")
                         ),
                menuItem("Credit cards", tabName="credito", icon = icon("credit-card"),
                         menuSubItem("Introduction", tabName="introC"),
                         menuSubItem("Anchoring", tabName="anchor"),
                         menuSubItem("Debt account aversion", tabName="debtA"),
                         menuSubItem("Pain of paying", tabName="pain")
                         ),
                menuItem("About this app", tabName="sobre", icon = icon("users"))
                )),
  
  dashboardBody(
    fluidRow(

      ##################
      ## LANDING PAGE ##
      ##################

      tabItems(
        tabItem("intro",
          box(width=12,
            h2("Financial decisions", align="center"),
            br(),
            p("Welcome to this app on the impact of heuristics and biases in financial decisions! Here, you can find out more about the simple strategies (i.e. heuristics) that we use in our day-to-day lives to provide answers for the huge number of decisions we face, some of which are simple but others more complex."),
            p("These decision strategies or heuristics are often useful and effective, but given their simplicity they are also a source of bias. This app aims to explain the most common errors and decision biases that result from the use of heuristics as well as to provide ways to avoid or mitigate them."),
            p("Shall we try?", align="center"),
            p("Use the buttons below or the menu on the left to browse the app.", align="center"),
            br()),
            fluidRow(
              box(width=6, p(actionButton(inputId="NextP1A", label=HTML('<h2><i class="fa fa-clipboard"></i> Managing a budget</h2>')), align="center")),
              box(width=6, p(actionButton(inputId="NextP1B", label=HTML('<h2><i class="fa fa-home"></i> Buying a house</h2>')), align="center")),
              box(width=6, p(actionButton(inputId="NextP1C", label=HTML('<h2><i class="fa fa-coins"></i> Preparing for retirement</h2>')), align="center")),
              box(width=6, p(actionButton(inputId="NextP1D", label=HTML('<h2><i class="fa fa-credit-card"></i> Credit cards</h2>')), align="center"))
            ),
        box(width=12, 
            fluidRow(
              column(6, HTML('<img src="fp.png" width="90%">')),
              column(6, HTML('<img src="fct.png" width="100%">'))
            ),
            HTML("<div style=\"text-align:center;\">This app, as part of project PTDC/MHC-PAP/1556/2014, was financed by the Fundação para a Ciência e Tecnologia [Foundation for Science and Technology].</div>")
          )),
        
        #|#############|#
        #|# ORÇAMENTO #|#
        #|#############|#
      
        tabItem("introO",
                box(width=12,
                    h3("MANAGING A BUDGET", align="center")),
                fluidRow(
                box(width=6,
                    h3("Why create and manage a budget?"),
                    p("Creating a monthly budget will help you work out how much money is left after deducting all your  essential expenses (such as rent or mortgage payments, food, etc.), as well as setting savings and expense control goals."),
                    h3("How can you create a budget?"),
                    HTML("<p>There are many ways for you to create a budget, but basically all you need is a pencil and paper:</p>
                        <ol>
                          <li>Start by making a list of your monthly income, such as your wage.</li>
                          <li>Then make a list of your fixed expenses, such as rent or mortgage payments, water, electricity, etc. (see the side illustration for some of the more common categories). If you have fixed expenses that you pay annually (such as a health insurance), divide the yearly total by each month to obtain the amount you should put aside to pay the yearly fee.</li>
                          <li>Subtract these expenses from your monthly income. If you want to save money, also subtract the amount you would like to save.</li>
                          <li>Divide the final sum by the number of weeks in the month. This amount will be your weekly budget to pay for your current, every day costs such as food, clothing, etc.</li>
                        </ol>
                      "),
                    p("It is not easy to create and stick to a monthly budget. Find out below three biases that may have a negative impact on how you plan and implement your family budget.")),
                box(width=6, 
                    HTML("<p>Spending of families, in percentage of available income, accoding to <a href=\"https://www.pordata.pt/Europa/Despesas+de+consumo+final+dos+agregados+dom%C3%A9sticos+por+tipo+de+bens+e+servi%C3%A7os+(percentagem)-1728\">PORDATA</a> data (2016), average of the 28 EU countries:</p>"),
                    plotOutput("orcplot")
                    )),
                box(width=4, p(actionButton(inputId="NextP2A", label=HTML('<h3><i class="fa fa-clipboard"></i> Self-regulation</h3>')), align="center")),
                box(width=4, p(actionButton(inputId="NextP2B", label=HTML('<h3><i class="fa fa-clipboard"></i> Mental accounting</h3>')), align="center")),
                box(width=4, p(actionButton(inputId="NextP2C", label=HTML('<h3><i class="fa fa-clipboard"></i> Opportunity costs</h3>')), align="center"))
                ),
        
            ###################
            ## autocontrolo ##
            ###################
        
        tabItem("fauto", 
                tabsetPanel(id="tabFA",
                            tabPanel("Put yourself to the test!",
                                     box(width=6,
                                         "Maria is a 21 year old student with a part-time job. Two days before receiving her wage, Maria only has €25 to pay for her expenses. In addition to food, Maria has to buy a pair of warm socks for an outdoor party she is going to this week-end. After work, she goes to a shopping centre with her friend Susana to buy the socks. When she passes her favourite shop, Maria sees a lovely jumper in the sale for €75.",
                                         br(),br(),
                                         radioButtons("radioFA", label = "If you were Maria, which of the following options would you take?",
                                                      choices = list("You would just buy the socks." = 1, 
                                                                     "You would want the jumper, but you wouldn’t buy it." = 2, 
                                                                     "You would buy the socks and the jumper with a credit card." = 3,
                                                                     "You would buy the socks, the jumper and a matching shirt and pair of trousers, and pay with the credit card." = 4
                                                                     ), 
                                                      selected = "NULL"),
                                         p(actionButton(inputId="faButton", label="Confirm", icon = icon("check")), align="right")),
                                         box(width=6, HTML("<b>Result:</b>"),
                                                uiOutput("feedbackFA"),
                                                br(),
                                         p(actionButton("Next7", div("Continue", icon("arrow-right"))), align="right"))
                                  ),
                            tabPanel(value="fa1", title="Self-regulation",
                                  box(width=12,
                                      fluidRow(
                                        column(6,
                                           h3("What is it?"),
                                           HTML("Lack of self-control is a problem of self-regulation that can be defined as the lack of mental resources (such as attention) required for an individual to be able to exercise control over his/her actions or thoughts in order to fulfil the goals he/she has for him/herself. Typical examples of self-control failures are: eating high-calorie food when you want to lose weight, impulse buying when you want to save money, or staying at home instead of going to the gym after committing to go three times per week."),
                                           h3("Financial implications"),
                                           HTML("<p>The negative effects of a lack of self control have an impact on many areas of our life. In the financial area:</p>
                                                  <ul>
                                                    <li>In budget management, it causes us to spend more than we had planned.</li>
                                                    <li>In retirement preparation, it causes us to save less than we should.</li>
                                                    <li>In credit cards, it causes us to use our credit card more than we should.</li>
                                                  </ul>
                                                "),
                                           h3("How can this be avoided?"),
                                           HTML("<p>Consider the following ways of attacking self-control failures:</p>
                                                <ul>
                                                  <li>Set clear, specific goals, for example: saving €100/month to buy a car.</li>
                                                  <li>Try to focus on your goal (for example, imagining yourself driving your car) when you are considering doing something that may put the achievement of your goal at stake (such as spending money unnecessarily).</li>
                                                  <li>Be conscious of your emotional state. Negative emotions (such as frustration, depression, etc.) may lead to bad decisions.</li>
                                                  <li>Train your self-control ability. For example, do exercises such as meditation or practice keeping your back straight at all times.</li>
                                                  <li>Try to reduce your exposure to stimuli or contexts that trigger impulsive responses. For example, don’t go shopping when you are hungry to avoid buying tempting but not very healthy products (for example, sweets, cakes, chips, etc.).</li>
                                                  <li>Try to reduce the possibility of acting on impulse. For example, take only enough money to buy the socks and leave the credit card at home.</li>
                                                </ul>
                                                "),
                                           h3("To find out more"),
                                           HTML("<ul>
                                              <li>Canby, N., Cameron, I., Calhoun, A., & Buchanan, G. (2015). A brief mindfulness intervention for healthy college students and its effects on psychological distress, self-control, meta-mood, and subjective vitality. <i>Mindfulness, 6</i>, 1070-1081.</li>
                                              <li>Hagger, M., Wood, C., Stiff, C., & Shatzisarantis, N. (2010). Ego depletion and the strength model of self-control: A meta-analysis. <i>Psychological Bulletin, 136</i>(4), 495-525.</li>
                                              <li>Roberts, J. A., & Manolis, C. (2012). Cooking up a recipe for self-control: The three ingredients of self-control and its impact on impulsive buying. <i>Journal of Marketing Theory and Practice, 20</i>(2), 173-188.</li>
                                              <li>* Rook, D. W., & Fisher, R. J. (1995). Normative influences on impulsive buying behavior. <i>Journal of Consumer Research, 22</i>, 305-313.
                                              <li>Sultan, A. J., Joireman, J., & Sprott, D. E. (2011). Building consumer self-control: The effect of self-control exercises on impulsive buying urges. <i>Marketing Letters, 23</i>, 61-72.</li>
                                             </ul>
                                                <p>* Source of the example from the \"Put yourself to the test!\" tab.</p>")
                                        ),
                                     column(6,
                                            uiOutput("noteFA"),
                                            p(actionButton("Next8", div("Continue", icon("arrow-right"))), align="right")
                                            )))),
                            tabPanel(value="prat4", title="Practice",
                                     box(width=6,checkboxGroupInput("part4cg", label = "Identify the thoughts and behaviours below that help to avoid impulsive buying:", 
                                                        choices = list("Taking a shopping list." = 1,
                                                                       "Going shopping when you are hungry." = 2, 
                                                                       "Going shopping when you are feeling frustrated/tired/irritated/depressed, etc." = 3,
                                                                       "Going around/unwinding in shopping centres or shops." = 4,
                                                                       "Thinking \"once won’t do any harm\"." = 5,
                                                                       "Being able to distinguish between a bargain discount to save money and a discount which leads you to spend more money." = 6,
                                                                       "Keeping note of non-essential items you would like to buy and postponing their purchase to a later date (for instance, when you have saved enough money for them)." = 7,
                                                                       "Leaving your card at home and taking only the amount you are prepared to spend." = 8,
                                                                       "Leaving your credit card details on the Internet browser to facilitate future purchases." = 9,
                                                                       "Committing to only buying something new when the older item you have is actually broken or damaged." = 10
                                                                       ),
                                                        selected = NULL),
                                     p(actionButton(inputId="FApButton", label="Confirm", icon = icon("check")), align="right")),
                                     box(width=6, 
                                        HTML("<b>Result:</b><br>"),br(),
                                        uiOutput("checkPracticeFA")
                                        )
                                     ))),

        
        ###################
        ## Contabilidade ##
        ###################
        
        tabItem("contm", 
                tabsetPanel(id="tabCM",
                            tabPanel("Put yourself to the test!",
                                     box(width=6,
                                         HTML("Imagine you keep €50 a month in a drawer at home to save money for the holidays. You currently have €600 in the drawer and you are already planning your holidays. 
                                          <br>However, due to unforeseen expenses, this month you had to use your credit card to pay €600.
                                          "),
                                         br(),br(),
                                         radioButtons("radio1CM", label = "At the end of the month you will have to choose one of the following alternatives:",
                                                      choices = list("Pay off the total amount owed on your credit card (without the interest) with the money you saved for the holidays." = 0,
                                                                     "Start to pay off the amount owed on your credit card in monthly instalments (with low interest) of €50, suspending your monthly saving of €50 for the holidays, but keeping the €600 you already have for the holidays." = 1,
                                                                     "Start to pay off the amount owed on your credit card in monthly instalments (also with low interest) of €25, reducing your monthly holiday savings from €50 to €25, but continuing to save for your holidays." = 2
                                                      ), selected = "NULL"),
                                         p(actionButton(inputId="cmButton", label="Confirm", icon = icon("check")), align="right")),
                                     box(width=6, HTML("<b>Result:</b>"),
                                         uiOutput("feedbackCM"),
                                         br(),
                                         p(actionButton("Next15", div("Continue", icon("arrow-right"))), align="right"))
                            ),
                            tabPanel(value="cm1", title="Mental accounting",
                                     box(width=12,
                                         fluidRow(
                                           column(6,
                                                  h3("What is it?"),
                                                  HTML("The example you just saw suggests that people tend to treat the same amount of money differently depending on subjective criteria / arbitrary mental categories. This behaviour has been explained on the basis of \"mental accounting\". As with organized business accounting, research suggests that people mentally create expense categories to which they allocate different portions of their budget (for example, entertainment, transport, food). Although money is a fungible asset (i.e. the €50 in the entertainment category is worth exactly the same as the €50 in any other category), people tend to treat mental expense categories in a hermetic manner, spending the money according to the amount allocated to each category.
                                                        <br>An example that illustrates this bias well is the fact that many people resort to loans with high interest rates while at the same time holding deposits in savings accounts that yield very low or even zero interest. This is because people mentally separate their “savings” from the money used to cover their expenses (foreseen or unexpected). This mental categorization makes them feel the need to resort to credit when they have no money in the mental category to which a given expense belongs, even if that money is available in another category.
                                                        <br>Returning to the afore-mentioned example, many people tend to opt to use their credit card to pay off all or part of an unexpected expense, even when they have savings that would allow them to pay that expense without resorting to credit and without incurring interest payments.
                                                        <br>This form of mentally categorizing different expenses and income facilitates the management of a family budget, by keeping people aware of the amounts spent (vs. available) in the different categories. However, treating money differently depending on the mental category assigned often undermines sound management of the family budget. Let us take, for example, the way people tend to spend their income tax refund. Although the reimbursed amount has been deducted monthly from one’s wage, at the time of repayment this amount is seen as a bonus / extra and tends to be spent in a more impulsive / less thought out manner. The same principle applies to premium values or gift cheques / vouchers: when they are perceived as extra revenue, they are more easily spent on expenses that were not included in the family budget (e.g., cars, travel, jewellery).
                                                        "),
                                                  h3("Financial implications"),
                                                  p("This way of organizing personal finances also has an impact on the way people manage their savings and credits. People frequently keep some money in savings accounts with low interest (or even zero interest) rates while paying high interest for credit card use."),
                                                  h3("How can this be avoided?"),
                                                  HTML("One way to avoid the negative effects of mental accounting is to make it \"physical\", keeping track of all your expenses and income. There are currently numerous tools available for this purpose (for example, <a href=\"https://www.saberviver.pt/dinheiro/apps-de-financas-pessoais-facilitam-a-vida/\">here</a>), choose the one you feel is most suitable for you.<br>
                                                    When planning your budget, include one category for possible exceptional earnings and another for exceptional expenses. Consider breaking down the category of exceptional expenses in order to distinguish those that result from unexpected events (for example, medical expenses due to an accident) from those that correspond to “extravagant purchases” you may to want to make. Think twice before using exceptional earnings to incur exceptional expenses / extravagant purchases. There is nothing wrong in doing this, as long as you do it consciously. Set a value that you would consider reasonable for the type of expense / extravagance at stake (for example, a trip) and stick to that value, regardless of the source of the money that will allow you to pay for it. And don't forget: money is a fungible asset - it has the same value regardless of how it was obtained and how it will be spent.
                                                      "),
                                                  h3("To find out more"),
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
                                                  HTML("This figure refers to the problem presented before (in the “put yourself to the test”) and presents a simplified simulation of the total amount of expenses for each one of the 3 response alternatives. Option a) paying the all debt (without interests); option b) paying the debt with monthly installments of €50 with a 3% interest rate (it would take about 1 year and 3 months to pay-off the debt and one would pay close to €155 in interests): option c) paying the debt with monthly installments of €25 with a 3% interest rate (it would take about 3 year and 6 months to pay-off the debt and one would pay close to €476 in interests)."),
                                                  br(),br(),
                                                  p(actionButton("Next16", div("Continue", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat8", title="Practice",
                                     box(width=6, 
                                         HTML("<p>Imagine you are at your favourite shoe shop to buy a pair of shoes. Although you hadn’t planned on spending more than €50, the shoes you like best cost €75.</p><p><b>How likely would it be for you to buy the shoes if...:</b></p>"),
                                         radioButtons("radioP1CM", label = "...you had €75 in your account.",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7), 
                                                      inline=T, selected = "NULL"),
                                         radioButtons("radioP2CM", label = "...you had received a gift cheque for €25.",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7), 
                                                      inline=T, selected = "NULL"),
                                         radioButtons("radioP3CM", label = "...you had found €25 left in the pocket of your jacket.",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7), 
                                                      inline=T, selected = "NULL"),
                                         p(actionButton(inputId="CMpButton", label="Confirm", icon = icon("check")), align="right")),
                                     box(width=6, 
                                         HTML("<b>Result:</b><br>"),br(),
                                         uiOutput("checkPracticeCM")
                                     ))
                            )),
        
        ############################
        ## Custos de oportunidade ##
        ############################
        
        
        tabItem("custop", 
                tabsetPanel(id="tabCO",
                            tabPanel("Put yourself to the test!",
                                     box(width=6,
                                         HTML("Imagine that during the week you managed to save some money to spend on small purchases. When visiting your favourite music store, you notice that one of the featured records is by one of your favourite bands. You had already thought about buying this record on other occasions and now it is at a special price of €14,99. What would you do in this situation?"),
                                         radioButtons("radioCO1", label = "",
                                                      choices = list("I would buy the record." = 1, "I wouldn't buy the record." = 0),
                                                      selected="NULL"
                                         ),
                                         br(),
                                         HTML("Now imagine that you received a gift cheque worth €10. Assuming you wanted to use the gift voucher to buy a reusable water bottle, which of the following options would you choose?"),
                                         radioButtons("radioCO2", label = "",
                                                      choices = list("A metallic bottle with an ergonomic design worth €10." = 1,
                                                                     "A bottle of recycled material worth €3,99, with €6,01 left over for other purchases." = 0),
                                                      selected="NULL"
                                         ),
                                         
                                         p(actionButton(inputId="coButton", label="Confirm", icon = icon("check")), align="right")),
                                     box(width=6, HTML("<b>Result:</b>"),
                                         uiOutput("feedbackCO"),
                                         br(),
                                         p(actionButton("Next19", div("Continue", icon("arrow-right"))), align="right"))
                            ),
                            tabPanel(value="co1", title="Opportunity costs",
                                     box(width=12,
                                         fluidRow(
                                           column(6,
                                                  h3("What is it?"),
                                                  p("Research on consumer behaviour has shown that people tend to ignore alternative ways of spending their resources (time and money) when making their choices. More specifically, if we have to choose between an orange and an apple and choose the orange, the apple (which we eschew) becomes a lost opportunity and the value of the apple (its benefits) is the cost of that opportunity. More generally, when we choose to buy a certain product or make a certain investment, we often ignore other opportunities to use the same money (to buy other products or make other investments). The lost benefits associated with these eschewed opportunities are called opportunity costs."),
                                                  h3("Financial implications"),
                                                  HTML("As illustrated by the example, neglecting opportunity costs often translates into higher consumption than that which occurs when people are explicitly reminded of alternative ways of using the same money. On the other hand, when we do not make the best choice out of a set of possible alternatives, this means that the opportunity costs (the opportunities we overlook when making a given choice) are higher than what we gained from the choice we made. This is an indicator of financial mismanagement."),
                                                  h3("How can this be avoided?"),
                                                  HTML("The best way to avoid neglecting opportunity costs in managing your family budget is by remaining aware of what your financial goals and priorities are. The way you use your money must comply with these goals and priorities.
                                                        <br>When you are tempted to make an unplanned purchase, stop to think about the extent to which that purchase is among your priorities and will help you get closer to your goals.
                                                        <br>Think explicitly about the opportunity costs involved in the purchase:
                                                        <ol type=\"a\"><li>what other things could the same money buy?</li>
                                                            <li>how many hours, days or months do you need to work to pay for that purchase?</li></ol>
                                                "),
                                                  h3("To find out more"),
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
                                                  p(actionButton("Next20", div("Continue", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat10", title="Practice",
                                     box(width=6,
                                         HTML("After a year of work and saving in which you managed to save €1.500 to go on holiday, the time to take that holiday has arrived. To what extent  do you think you should spend your €1.500 on a good holiday?<br><br>
                                         <table width=\"100%\">
                                                <tr><td>Not at all</td><td style=\"text-align:right;\">Absolutely</td></tr>
                                              </table>
                                              <span style=\"text-align:center;\">"),
                                         radioButtons("radioCOP1", label = "", inline=T,
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4,
                                                                     "5" = 5, "6" = 6, "7" = 7), selected = "NULL"),
                                         HTML("</span><br><p>Now, we would like you to consider the following alternatives:</p>
                                              <ul>
                                                <li>Choosing a less expensive holiday (€1.000) by sharing an apartment / hotel room with a friend and investing the rest of the money in a Retirement savings plan.</li>
                                                <li>Choosing to split your holidays using your available funds in two different periods (for example, in the summer and at Christmas).</li>
                                                <li>Looking for the same type of holiday in similar places that are offering discounts.</li>
                                                <li>Using the money for your education (a post-graduation, for example) that will enable you to progress in your career in the company and see your wage increased by 5%.</li>
                                              </ul>
                                              Now consider the same question again. To what extent do you think you should spend your €1,500 on a good holiday?<br><br>
                                              <table width=\"100%\">
                                                <tr><td>Not at all</td><td style=\"text-align:right;\">Absolutely</td></tr>
                                              </table>
                                              <span style=\"text-align:center;\">"),
                                         radioButtons("radioCOP2", label = "", inline=T,
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4,
                                                                     "5" = 5, "6" = 6, "7" = 7), selected = "NULL"),
                                         HTML("</span>"),
                                         p(actionButton(inputId="copButton", label="Confirm", icon = icon("check")), align="right")),
                                     box(width=6, 
                                         HTML("<b>Result:</b><br>"),br(),
                                         uiOutput("checkPracticeCO")
                                     )
                            ))),
        
        
        #|########|#
        #|# CASA #|#
        #|########|#
        
        tabItem("introH",
                box(width=12,
                    h3("BUYING A HOUSE", align="center")),
                fluidRow(
                  box(width=6,
                      h3("Why buy a house?"),
                      p("For many people, the most expensive purchase they make in their life is the purchase of a home and, in most cases, they do so by resorting to credit. As you may see in the chart on the right, housing loans are a significant slice of loans to households and non-financial corporations and its share has increased between 2007 and 2017."),
                      HTML("<p>Buying a house can bring several benefits, for example: 
                        <ul>
                        <li>Not having to pay rent when reaching retirement (or at least having a reduced monthly payment);</li>
                        <li>Being able to have a source of extra income (e.g., by renting a room or garage);</li>
                        <li>Selling it later with capital gains (taking advantage of appreciation periods in the real estate market);</li>
                        <li>or leaving a mortgage-free house for one’s children.</li>
                        </ul>However, it can also have significant costs and risks, such as maintenance expenses, taxes, or surprise expenses (e.g., resulting from environmental disasters). As an investment, the value of buying a home depends on specific purchase conditions, credit and the rental market."),
                      p("In this section, we’ll look at some biases that may have an impact on how we approach home buying."),
                      br()),
                  box(width=6, HTML('<p>Weight of housing loans and consumer credit on lending to Households and Non-Financial Corporations, 2007 and 2017. Source: <a href="https://www.ceps.eu/wp-content/uploads/2018/08/Key%20Findings%20ECRI%20Statistical%20Package%202018_0.pdf">ECRI Statistics</a>.</p>'), plotOutput("casaplot"))
                ),
                  fluidRow(
                    box(width=4, p(actionButton(inputId="NextP3A", label=HTML('<h3><i class="fa fa-home"></i> Narrow view</h3>')), align="center")),
                    box(width=4, p(actionButton(inputId="NextP3B", label=HTML('<h3><i class="fa fa-home"></i> Unrealistic optimism</h3>')), align="center")),
                    box(width=4, p(actionButton(inputId="NextP3C", label=HTML('<h3><i class="fa fa-home"></i> Availability heuristic</h3>')), align="center"))
                )),
        
            ##############
            ## Estreito ##
            ##############
        
        tabItem("narrow",
                tabsetPanel(id="tabPE",
                  tabPanel("Put yourself to the test!",
                    box(width=6,
                        p("Imagine you are looking for a bank to finance your mortgage. You will probably begin by trying to get a list of banks you can turn to. Below, list all the banks in your country that you can remember (regardless of whether you know if they have real estate credit options or not):"),
                        br(),
                        textAreaInput(inputId = "banksText", resize="none", label="Enter  the bank names separated by commas:", placeholder = "Bank 1, Bank 2, Bank 3, etc."),
                        p(actionButton(inputId="banksButton", label="Confirm", icon = icon("check")), align="left")
                    ),
                    box(width=6, 
                        HTML("<b>Result:</b><br>"),
                        uiOutput("feedbackBanks"),
                        br(),
                        p(actionButton("Next1", div("Continue", icon("arrow-right"))), align="right")
                    )),
                tabPanel(value="pe", title="Narrow thinking",
                         box(width=12,
                         fluidRow(
                          column(7,
                            h3("What is it?"),
                            HTML("In the previous tab we saw an example of narrow thinking: typically, people only remember a few banks, not all of them. This bias (narrow thinking) occurs when we only consider a few options. As good as our choice out of this set of options may be, we may be missing out on advantageous opportunities that we haven't even considered.
                              <br>We may, for example, think that if a particular bank was especially good, then we would have heard of it before. However, in reality, there are many reasons why a bank may be good yet not well known (for example: having few customers or branches in your area, not being able to attract many customers as people tend to stick with the same bank unless they have had a bad experience, etc.).
                              <br>In some situations, we may not even have enough time or interest to do a thorough search of the options, but in very important choices, such as buying a house, it is important that we have access to as many options as possible in order to make the best choice."),
                            h3("Financial implications"),
                            HTML("<p>Narrow thinking is when we do not consider all options, for example:</p>
                                    <ul>
                                      <li>When buying a house, when we do not consider all options to discover opportunities.</li>
                                      <li>In budget management, when we do not consider less frequent expenses but it is important to include them in the budget (such as saving in case a broken appliance needs to be replaced);</li>
                                      <li>When preparing for retirement, when we do not consider less common ways to prepare for retirement (such as installing solar panels to reduce electricity costs in retirement).</li>
                                      <li>In credit cards, when we only consider the options of buying with recourse to credit or not buying at all, ignoring other options such as saving to buy later.</li>
                                    </ul>
                                 "),
                            h3("How can this be avoided?"),
                            HTML("<p>Consider the following suggestions:</p>
                                 <ul>
                                  <li>Use bank/estate agents/property advertisement site directories (<a href=\"https://thebanks.eu/banks-by-country\">see example</a>); </li>
                                  <li>Look for property purchase guides or lists (<a href=\"https://www.biggerpockets.com/blog/find-real-estate-deals\">see example</a>);</li>
                                  <li>Make an effort to think about less well known options;</li>
                                  <li>Ask people you know  about less known options.</li>
                                 </ul>
                                 "),
                            h3("To find out more"),
                            HTML("<ul>
                                  <li>Soll, Jack B. and Milkman, Katherine L. and Payne, John W., A User's Guide to Debiasing (June 17, 2014). In G. Keren & G. Wu (Eds.), <i>Wiley-Blackwell Handbook of Judgment and Decision Making</i> (pp. 924-951). Wiley Blackwell.</li>
                                 </ul>")
                            ),
                          column(5,
                           plotOutput("narrowplot"),
                           uiOutput("narrownote"),
                           br(),
                           p(actionButton("Next2", div("Continue", icon("arrow-right"))), align="right")
                           )
                         ))),
                tabPanel(value="prat1",title="Practice",
                         box(width=6,
                          p("Imagine now that you are looking for a house to purchase. Where (e.g. estate agencies) would you look?"),
                          textAreaInput(inputId = "buyText", resize="none", label="", placeholder = "Option 1, Option 2, Option 3, etc."),
                          p(actionButton(inputId="buyButton", label="Confirm", icon = icon("check")), align="left")
                          ),
                          box(width=6,
                              HTML("<b>Result:</b><br>"),br(),
                              uiOutput("feedbackBuy")
                              )
                            ))),
        
        ###############
        ## Otimismo ##
        ###############
        
        tabItem("opir", 
                tabsetPanel(id="tabOI",
                            tabPanel("Put yourself to the test!",
                                     box(width=6,
                                         HTML("For each of the life events listed below, indicate whether you consider it more likely that they will happen to you or to others (i.e., to most other people), using the following 10-point scale:<br><br>
                                              1 = More likely to happen to me than to others.<br>
                                              10 = More likely to happen to others than to me."),
                                         br(),br(),
                                         radioButtons("radioOP1", label = "Buying a house that appreciated after a few years",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9,"10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP2", label = "Having a substantial increase in earnings",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP3", label = "Living in good health until the age of 90",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP4", label = "Being successful/professionally",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP5", label = "Buying a house that depreciated after a few years",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP6", label = "Having a substantial reduction in earnings",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP7", label = "Having a serious illness",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         radioButtons("radioOP8", label = "Having a job that does not fulfil you",
                                                      choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7, "8" = 8, "9" = 9, "10" = 10), 
                                                      selected = "NULL", inline=T),
                                         p(actionButton(inputId="OIpButton", label="Confirm", icon = icon("check")), align="right")),
                                     box(width=6, 
                                         HTML("<b>Result:</b>"),
                                         uiOutput("checkPracticeOI"),
                                         p(actionButton("Next13", div("Continue", icon("arrow-right"))), align="right")
                                     )
                            ),
                            tabPanel(value="oi1", title="Unrealistic optimism",
                                     box(width=12,
                                         fluidRow(
                                           column(6,
                                                  h3("What is it?"),
                                                  p("The example you have just seen illustrates the tendency of most people to assess positive events in their lives as being more likely than in the lives of others, while the opposite is the case for negative events. This trend, referred to as unrealistic optimism, is one of the forms of overconfidence, i.e. a tendency to overestimate one's own abilities and knowledge, as well as one’s degree of control over life events and probabilities of success."),
                                                  h3("Financial implications"),
                                                  HTML("<p>The negative effects of unrealistic optimism have an impact on many areas of our lives. In the financial area, unrealistic optimism is associated with:</p>
                                                  <ul>
                                                    <li>Higher levels of overconfidence which, in turn, are associated with greater financial risk behaviours;</li>
                                                    <li>Overestimation of future earnings / income which translates into a greater propensity for consumption;</li>
                                                    <li>Underestimation of the probability of defaulting on credit instalment payments with an impact on the choice of mortgage (for example, loans for the purchase of a house whose value is higher than what the consumer can pay monthly without getting into financial difficulties);</li>
                                                    <li>Lower propensity to save money for unforeseen financial events;</li>
                                                    <li>Less likelihood of seeking help from an expert.</li>
                                                  </ul>
                                                "),
                                                  h3("How can this be avoided?"),
                                                  HTML("<p>To avoid optimistic unrealism when, for example, you are considering taking out a mortgage, try the following suggestions:</p>
                                                <ul>
                                                  <li>Challenge your beliefs - discuss them with others who can give you other points of view / question your decisions;</li>
                                                  <li>Seek feedback;</li>
                                                  <li>Look for information before making a decision;</li>
                                                  <li>Think actively about what can go wrong;</li>
                                                  <li>Imagine that you are advising a family member or friend;</li>
                                                  <li>Compare yourself to other people you actually know instead of comparing yourself to others in general;</li>
                                                  <li>Avoid impulsive decisions.</li>
                                                </ul>
                                                "),
                                                  h3("To find out more"),
                                                  HTML("<ul>
                                                        <li>Weinstein, N. D. (1980). Unrealistic optimism about future life events. <i>Journal of Personality and Social Psychology, 39</i>(5), 806.</li>
                                                        <li>Shepperd, J. A., Waters, E. A., Weinstein, N. D., & Klein, W. M. P. (2015). A primer on unrealistic optimism. <i>Current Directions in Psychological Science, 24</i>(3), 232–237. https://doi.org/10.1177/0963721414568341 </li>
                                                       </ul>")
                                           ),
                                           column(6,
                                                  HTML("<div style=\"text-align:center\">
                                                  10 = More likely to happen to other people</div>"),
                                                  plotOutput("plotOI"),
                                                  HTML("<div style=\"text-align:center\">1 = More likely to happen to me<br></div>"),
                                                  br(),br(),
                                                  uiOutput("noteplotOI"),
                                                  br(),br(),
                                                  p(actionButton("Next14", div("Continuar", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat7", title="Practice",
                                     box(width=6,
                                         sliderInput("oiN1", label = ("How likely is it (from 0 to 100%) that if you had a child born in 2017, the child will reach the age of 83,5, if female, or 78,3, if male?"), value = 0, min=0, max=100),
                                         sliderInput("oiN2", label = ("How likely is it (from 0 to 100%) that you will default on the payment of your credits?"), value = 0,min=0, max=100),
                                         sliderInput("oiN3", label = ("How likely is it (from 0 to 100%) that you will win a prize of any value in the EuroMillions?"), value = 0, min=0, max=100),
                                         sliderInput("oiN4", label = ("How likely is it (from 0 to 100%) that you will have an accident at work?"), value = 0,min=0, max=100),
                                         br(),br(),
                                         p(actionButton(inputId="oiButton", label="Confirm", icon = icon("check")), align="right")),
                                     box(width=6, HTML("<b>Result:</b>"),
                                         uiOutput("feedbackOI"))
                            ))),
        
        
        #####################
        ## Disponibilidade ##
        #####################
        
        
        tabItem("disp", 
                tabsetPanel(id="tabAH",
                            tabPanel("Put yourself to the test!",
                                     box(width=6,
                                         "Imagine you need to apply for a loan to purchase your home. Of the following information, which do you consider to be the most relevant for comparing the credit proposals that will be presented to you?",
                                         br(),
                                         radioButtons("checkGroupAH", label = "", 
                                                            choices = list("Basic monthly instalment" = 1,
                                                                           "Spread" = 2, 
                                                                           "Life insurance" = 3,
                                                                           "Multi-risk insurance" = 4,
                                                                           "Fees" = 5,
                                                                           "Total payable amount" = 6,
                                                                           "Basic spread (without subscribing to other products)" = 7,
                                                                           "APR (subsidized)" = 8
                                                            ),
                                                            selected = "NULL"),
                                         p(actionButton(inputId="ahButton", label="Confirm", icon = icon("check")), align="right")),
                                     box(width=6, HTML("<b>Result:</b>"),
                                         uiOutput("feedbackAH"),
                                         br(),
                                         p(actionButton("Next23", div("Continue", icon("arrow-right"))), align="right"))
                            ),
                            tabPanel(value="ah1", title="Availability heuristic",
                                     box(width=12,
                                         fluidRow(
                                           column(6,
                                                  h3("What is it?"),
                                                  HTML("The choice of a mortgage involves considering a broad range of facts, often presented in a dispersed manner and not really suited to how people process information. In complex decision environments like this, the difficulty in taking all the information into account leads people to base their decisions on limited information that is usually easier to remember. In other words, this information is more readily accessible or easily retrievable from memory (heuristic availability). Although useful on many occasions, this strategy may lead to wrong decisions when the information that is most easily retrievable from memory is not the most useful information for the decision. Information such as the spread or the monthly instalment when choosing a mortgage is a good example of this. Although they are not the most useful criteria when choosing credit, this information is often referred to in mortgage advertisements, since it is highly available in memory and therefore easily remembered by consumers when making their decision."),
                                                  h3("Financial implications"),
                                                  HTML("Basing one’s choice of a mortgage on information that is most easily retrieved from memory without first considering its soundness, can lead to choices with higher costs for consumers. The table on the side illustrates this. A consumer who bases his choice to take out a loan of €125.000 on the spread, would opt for Bank 1’s proposal and at the end of the loan would have paid a total sum of €167.571,28. In other words, he would have paid €3.499,01 more than he would have paid if he had opted for Bank 3's proposal. If the same consumer based his choice on the basic monthly instalment, and opted for Bank 2's proposal, at the end of the loan he would have paid €444,19 more than if  he had opted for Bank 3's (most advantageous) proposal (note that Bank 2 also has a lower spread than Bank 3). Thus, despite presenting the highest spread and monthly instalment, the most advantageous credit proposal is that of Bank 3, with a total payable amount of €164.072,27. The advantage of this bank is that it charges lower insurance and fees, the type of information that is often overlooked by the consumer."),
                                                  h3("How can this be avoided?"),
                                                  HTML("Making the best decisions in a complex environment such as choosing a mortgage implies firstly recognizing the complexity of the situation and secondly acting on it. In the simulations you will receive from banks, all the information will not be organized and systematized as illustrated in the table on the side. 
                                                        <br>However, there is nothing to prevent you from identifying the relevant information in order to make comparisons between banks and create your own comparison table. Remember that the comparison is only valid if you keep the duration of the contract and the loan amount the same for all simulations. Choose the credit with the lowest APR and the lowest total payable amount.
                                                        <br>Note: your decision may be based on the monthly amount you have available for the loan, opting for credits with lower monthly instalments but longer durations that usually result in higher total repayments. If you have to do this, do it consciously, being aware that your choice is the one that meets your present goals (taking the steps to purchase a house) but it is not the choice that best suits your future financial interests. If your financial situation improves in the meantime, try to pay off your mortgage earlier (thereby reducing the total payable amount).
                                                        <br>Finally, consider consulting an independent mortgage expert - there are currently several companies that can help you find the best solutions for your specific case.
                                                  "),
                                                  h3("To find out more"),
                                                  HTML("<ul>
                                                          <li>Barber, B. M., & Odean, T. (2008). All that glitters: The effect of attention and news on the buying behavior of individual and institutional investors. <i>The Review of Financial Studies, 21</i>(2), 785-818.</li>
                                                          <li>Brenncke, M. (2018). The legal framework for financial advertising: curbing behavioural exploitation. <i>European Business Organization Law Review, 19</i>(4), 853-882.</li>
                                                          <li>Tversky, A., & Kahneman, D. (1974). Judgment under uncertainty: Heuristics and biases. <i>Science, 185</i>, 1124-1131.</li>
                                                        </ul>")
                                                      ),
                                           column(6,
                                                  HTML("Overview simulation table for a loan of €125.000 over 30 years (data provided by DECO, the Portuguese association for the consumer defense):
                                                        <br><br>
                                                        <table class=\"bord\" style=\"width:100%;\">
                                                        <style>.bord {border: 1px solid black;padding: 8px;}</style>
                                                          <tr class=\"bord\">
                                                            <th class=\"bord\"></th>
                                                            <th class=\"bord\">Bank 1</th>
                                                            <th class=\"bord\">Bank 2</th>
                                                            <th class=\"bord\">Bank 3</th>
                                                            <th class=\"bord\">Bank 4</th>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Basic monthly instalment</td>
                                                            <td class=\"bord\">€396,11</td>
                                                            <td class=\"bord\">€400,79</td>
                                                            <td class=\"bord\">€415,27</td>
                                                            <td class=\"bord\">€415,27</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Spread</td>
                                                            <td class=\"bord\">1,20%</td>
                                                            <td class=\"bord\">1,25%</td>
                                                            <td class=\"bord\">1,50%</td>
                                                            <td class=\"bord\">1,50%</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Life insurance</td>
                                                            <td class=\"bord\">€16,93</td>
                                                            <td class=\"bord\">€18,45</td>
                                                            <td class=\"bord\">€15,35</td>
                                                            <td class=\"bord\">€15,39</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Multi-risk insurance</td>
                                                            <td class=\"bord\">€16,14</td>
                                                            <td class=\"bord\">€13,91</td>
                                                            <td class=\"bord\">€9,97</td>
                                                            <td class=\"bord\">€16,61</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Fees</td>
                                                            <td class=\"bord\">€1.284,40</td>
                                                            <td class=\"bord\">€1.033,40</td>
                                                            <td class=\"bord\">€688,15</td>
                                                            <td class=\"bord\">€728,00</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Total payable amount</td>
                                                            <td class=\"bord\">€167.571,28</td>
                                                            <td class=\"bord\">€164.516,46</td>
                                                            <td class=\"bord\">€164.072,27</td>
                                                            <td class=\"bord\">€168.696,45</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Basic spread (without subscribing to other products)</td>
                                                            <td class=\"bord\">1,90%</td>
                                                            <td class=\"bord\">1,75%</td>
                                                            <td class=\"bord\">2,20%</td>
                                                            <td class=\"bord\">1,90%</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">APR (subsidized)</td>
                                                            <td class=\"bord\">1,90%</td>
                                                            <td class=\"bord\">2,00%</td>
                                                            <td class=\"bord\">1,90%</td>
                                                            <td class=\"bord\">2,10%</td>
                                                          </tr>
                                                        </table> "),
                                                  br(),br(),
                                                  p(actionButton("Next24", div("Continue", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat12", title="Practice",
                                     box(width=6,
                                         HTML("Now that you know more about how to choose a mortgage properly, analyze the table below and put the various loans in order, starting with the loan that offers the best conditions to the one that offers the worst conditions:<br><br>
                                                  <table class=\"bord\" style=\"width:100%;\">
                                                          <tr class=\"bord\">
                                                            <th class=\"bord\"></th>
                                                            <th class=\"bord\">Bank 1</th>
                                                            <th class=\"bord\">Bank 2</th>
                                                            <th class=\"bord\">Bank 3</th>
                                                            <th class=\"bord\">Bank 4</th>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Basic monthly instalment</td>
                                                            <td class=\"bord\">€392,25</td>
                                                            <td class=\"bord\">€400,79</td>
                                                            <td class=\"bord\">€415,27</td>
                                                            <td class=\"bord\">€415,27</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Spread</td>
                                                            <td class=\"bord\">1,10%</td>
                                                            <td class=\"bord\">1,25%</td>
                                                            <td class=\"bord\">1,50%</td>
                                                            <td class=\"bord\">1,50%</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Life insurance</td>
                                                            <td class=\"bord\">€11,50</td>
                                                            <td class=\"bord\">€18,45</td>
                                                            <td class=\"bord\">€15,39</td>
                                                            <td class=\"bord\">€15,29</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Multi-risk insurance</td>
                                                            <td class=\"bord\">€15,44</td>
                                                            <td class=\"bord\">€13,91</td>
                                                            <td class=\"bord\">€16,61</td>
                                                            <td class=\"bord\">€8,97</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Fees</td>
                                                            <td class=\"bord\">€979,70</td>
                                                            <td class=\"bord\">€1.033,40</td>
                                                            <td class=\"bord\">€728,00</td>
                                                            <td class=\"bord\">€792,50</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Total payable amount</td>
                                                            <td class=\"bord\">€158.029,72</td>
                                                            <td class=\"bord\">€164.516,46</td>
                                                            <td class=\"bord\">€168.696,45</td>
                                                            <td class=\"bord\">€165.596,82</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">Basic spread (without subscribing to other products)</td>
                                                            <td class=\"bord\">1,70%</td>
                                                            <td class=\"bord\">1,75%</td>
                                                            <td class=\"bord\">1,90%</td>
                                                            <td class=\"bord\">2,00%</td>
                                                          </tr>
                                                          <tr class=\"bord\">
                                                            <td class=\"bord\">APR (subsidized)</td>
                                                            <td class=\"bord\">1,70%</td>
                                                            <td class=\"bord\">2,00%</td>
                                                            <td class=\"bord\">2,10%</td>
                                                            <td class=\"bord\">2,00%</td>
                                                          </tr>
                                                        </table>"),br(),
                                     HTML("Click on the box below and select the order of offers from each bank from best to worst."),
                                     selectizeInput(
                                       'selectizeAH', '', choices = paste(rep("Bank", 4),seq(1,4)), multiple = TRUE
                                     ),
                                     p("Note: If you make a mistake, delete the content and reselect the options to correct."),
                                         p(actionButton(inputId="AHpButton", label="Confirm", icon = icon("check")), align="right")),
                                     box(width=6, 
                                         HTML("<b>Result:</b><br>"),br(),
                                         uiOutput("checkPracticeAH")
                                     )
                            ))),
        
        
        #|###########|#
        #|# REFORMA #|#
        #|###########|#
        
        tabItem("introR",
                box(width=12,
                    h3("PREPARING RETIREMENT", align="center")),
                fluidRow(
                  box(width=6,
                    HTML("<h3>Why should we prepare for retirement?</h3>
                         <p>According to <a href=\"https://ec.europa.eu/eurostat/web/products-eurostat-news/product/-/asset_publisher/VWJkHuaYvLIN/content/DDN-20190115-1/pop_up?_101_INSTANCE_VWJkHuaYvLIN_viewMode=print&_101_INSTANCE_VWJkHuaYvLIN_languageId=en_GB\">Eurostat</a>, in 2017 the proportion of pensioners at risk of poverty in the European Union (EU) was estimated to be 14,2%, slightly above the figure of 13,8% in 2016. The rate has been rising gradually since 2013, when it was 12,6%. In most of the 27 EU Member States for which 2017 data are available, the proportion of pensioners at risk of poverty lies between 10% and 15%. It is therefore important to do more to prepare for retirement. Some ways of preparing for retirement are:
                         </p><p>
                        <ul>
                          <li>Saving money specifically to use in your retirement;</li>
                          <li>Investing the money saved in products such as Retirement Savings Plans;</li>
                          <li>Reducing the costs you will have in your retirement (e.g., by having your own home);</li>
                          <li>Investing in retirement income opportunities (e.g., by buying a home that you can later rent).</li>
                        </ul>
                         Discover below three biases that can have a negative impact on how you prepare your retirement.
                         </p>"),
                    br()),
                box(width=6, HTML('<img src="ppoverty.jpg" width="100%">'))
                ),
                fluidRow(
                  box(width=4, p(actionButton(inputId="NextP4A", label=HTML('<h3><i class="fa fa-coins"></i> Inertia</h3>')), align="center")),
                  box(width=4, p(actionButton(inputId="NextP4B", label=HTML('<h3><i class="fa fa-coins"></i> Linear thinking</h3>')), align="center")),
                  box(width=4, p(actionButton(inputId="NextP4C", label=HTML('<h3><i class="fa fa-coins"></i> Temporal bias</h3>')), align="center"))
                )),
        
            #############
            ## Inércia ##
            #############
        
        tabItem("inertia",
                tabsetPanel(id="tabIN",
                            tabPanel("Put yourself to the test!",
                              box(width=6, 
                                           textInput("ineN1", label = ("How much money do you save per month specifically for your retirement?"), value = 0),
                                           textInput("ineN2", label = ("How much more money do you think you would be able to save if you put more effort into making retirement savings one of your main life goals?"), value = 10),
                                  HTML("<b>Note</b>: Write down just the number (e.g., 10 and not €10) and use commas if you want to use decimals."),
                              p(actionButton("ineButton", label="Confirm", icon = icon("check")), align="right")
                              ),
                              box(width=6,
                                HTML("<b>Result:</b><br>"),
                                uiOutput("feedbackine"),
                                br(),
                                p(actionButton("Next3", div("Continue", icon("arrow-right"))), align="right")
                              )
                              ),
                            tabPanel(title="Inertia", value="ine1",
                             box(width=12,
                              fluidRow(
                                column(7,
                                  h3("What is it?"),
                                  p("Psychological inertia occurs when we avoid the effort and expenditure of mental energy to make decisions to behave instead in an unconscious and largely automatic way. For example, many people prepare for retirement through social security contributions, not because they have done their Math and believe that this contribution will be enough for them to live comfortably when they retire, but rather because these contributions are mandatory and deducted automatically."),
                                  h3("Financial implications"),
                                  HTML("<p>Inertia can be found in all the decisions we make, whenever we decide not to make a decision or to take the usual one. For example:</p>
                                    <ul>
                                      <li>In preparing for retirement, when we do not save money specifically for retirement.</li>
                                      <li>In budget management, when we do not create budgets.</li>
                                      <li>When buying a house, when we go to our bank to ask for a mortgage, without checking if there is a better alternative at another bank.</li>
                                      <li>With credit cards, when, instead of thinking about how much we could pay that particular month, we only make the minimum payment.</li>
                                    </ul>"),
                                  h3("How can this be avoided?"),
                                  p("The mere realization that we often allow ourselves to be carried away by inertia in decision making is a first step towards overcoming it. Ironically, the easiest way to fight inertia is to use inertia to your advantage. For example, you can use automatic deposits to save money for retirement or increase your social security contributions to get an increase in your pension. You can also create a reminder (for example, annually or every 5 years) and set an hour or two aside to evaluate your choices and consider whether you need to make any changes."),
                                h3("To find out more"),
                                HTML("<ul>
                                      <li>Benartzi, S., & Thaler, R. (2007). Heuristics and biases in retirement savings behavior. <i>Journal of Economic perspectives, 21</i>(3), 81-104.</li>
                                      <li>Krijnen, J. M., Zeelenberg, M., & Breugelmans, S. M. (2016). Overcoming inertia in retirement saving. <i>Netspar industry series, 46</i>.</li>
                                     </ul>")),
                                column(5,
                                  plotOutput("inertiaplot"),
                                  uiOutput("inertianote"),
                                  br(),
                                  p(actionButton("Next4", div("Continue", icon("arrow-right"))), align="right")
                                  )))),
                            tabPanel(value="prat2",title="Practice",
                                     box(width=6, 
                                          radioButtons("ineN3", label = ("Do you create a monthly family budget?"),
                                                        choices = list("Yes, always" = 1, "Frequently" = 2,
                                                                       "Sometimes" = 3, "Never" = 4), 
                                                        selected = "NULL"),
                                          radioButtons("ineN4", label = ("Do you meet your family budget?"),
                                                       choices = list("Yes, always" = 1, "Frequently" = 2,
                                                                      "Sometimes" = 3, "Never" = 4), 
                                                       selected = "NULL"),
                                         radioButtons("ineN5", label = ("Do you think it is important to create, and meet, your family budget?"),
                                                      choices = list("Yes, always" = 1, "Frequently" = 2,
                                                                     "Sometimes" = 3, "Never" = 4), 
                                                      selected = "NULL"),
                                                  p(actionButton("ine2Button", label="Confirm", icon = icon("check")), align="right")
                                         ),
                                        box(width=6, HTML("<b>Result:</b><br>"), uiOutput("feedbackine2"))
                                           ))),
        
            ############
            ## linear ##
            ############
        

        tabItem("exponential",
                tabsetPanel(id="tabEB",
                            tabPanel("Put yourself to the test!",
                                     box(width=6, 
                                         HTML("Imagine you have a savings account which earns annual interest with a gross annual nominal rate of 1,5% (the interest is automatically reapplied to your savings account). When you opened the account you made a deposit of €100 and for 40 years you deposited €100 every month in the account.<br><br>"),
                                         textInput("ebNum", label = ("At the end of the 40 years, how much money did you obtain in total (money saved + interest)?"), value = 0),
                                         HTML("<b>Note 1</b>: Write down just the number (e.g., 10 and not €10) and use commas if you want to use decimals.
                                               <br><b>Note 2</b>: This is a simplified example that does not include the deduction of taxes on interest usually charged under Income Tax."),
                                         p(actionButton("ebButton", label="Confirm", icon = icon("check")), align="right")
                                         ),
                                     box(width=6,HTML("<b>Result:</b><br><br>"),
                                         uiOutput("feedbackeb"),
                                         p(actionButton("Next9", div("Continue", icon("arrow-right"))), align="right")
                                         )),
                            tabPanel(title="Linear thinking", value="eb1",
                                     box(width=12,
                                         fluidRow(
                                           column(7,
                                                  h3("What is it?"),
                                                  HTML("Linear thinking refers to people's tendency to make linear growth estimates (if I save €10 per month, after two months I have €20, after 3 months, €30, and so on). This trend leads to an exponential growth bias when used to make estimates about quantities growing exponentially. For example, people tend to underestimate the growth of their savings; and to overestimate the money needed (and the time it takes) to pay an instalment debt. This is because, in these cases, the growth curves are not linear, but exponential.
                                                  <br>In the exercise in question, this bias makes us think that the amount of money we can earn by saving money is less than the real amount (see side image).
                                                  "),
                                                  h3("Financial implications"),
                                                  HTML("<p>Linear thinking leads us to underestimate how much we can earn from saving, but it also leads us to underestimate the cost of interest-bearing debt (for example, when we use a credit card or take out a mortgage).</p>"),
                                                  h3("How can this be avoided?"),
                                                  HTML("<p>You need to understand that cumulative interest on a given amount causes it to grow exponentially and non-linearly, so when you take out credit you will probably pay more than you think and when you save you will also save more than you think.</p>
                                                            If it is not easy for you to think about exponential growth, use a simulator, such as the following simulators:</p>
                                                      <ul>
                                                        <li><a href=\"https://www.savingscalculator.org/\">Savings simulator</a>;</li>
                                                        <li><a href=\"https://www.consumerscu.org/personal/financial-resources/calculators/loan-repayment-calculator\">Consumer credit simulator</a>;</li>
                                                        <li><a href=\"https://www.mortgagecalculator.net/eur\">Mortgage simulator</a>.</li>
                                                      </ul>
                                                    "),
                                                  h3("To find out more"),
                                                  HTML("<ul>
                                                        <li>Stango, V., & Zinman, J. (2009). Exponential growth bias and household finance. <i>The Journal of Finance, 64</i>(6), 2807-2849.</li>
                                                       </ul>")
                                           ),
                                           column(5,
                                                  plotOutput("egplot"),
                                                  HTML("As you can see in the graph, the distance between interest-bearing and interest-free savings increases as time passes. In our example, 1,5% interest represents a total gain of €17.879,18 over 40 years."),
                                                  br(),br(),
                                                  p(actionButton("Next10", div("Continue", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat5",title="Practice",
                                     box(width=6,                                          
                                         HTML("Imagine you applied for a mortgage with an annual nominal rate of 1,5%. You borrowed €100.000 and decided to repay it in 40 years.<br><br>"),
                                         textInput("ebpNum", label = ("At the end of 40 years, how much money would you have paid in total (loan + interest)?"), value = 0),
                                         HTML("<b>Note 1</b>: Write down just the number (e.g., 10 and not €10) and use commas if you want to use decimals.<br>
                                              <b>Note 2</b>: You can use a <a href=\"https://www.mortgagecalculator.net/eur\">mortgage calculator</a>."),
                                         p(actionButton("ebpButton", label="Confirmar", icon = icon("check")), align="right")
                                         ),
                                     box(width=6,
                                         HTML("<b>Result:</b><br><br>"),
                                         uiOutput("feedbackebp")
                                     )))),
        
        ##############
        ## temporal ##
        ##############
        
        tabItem("discounting",
                tabsetPanel(id="tabHD",
                            tabPanel("Put yourself to the test!",
                                     box(width=6, 
                                         HTML("<p>Imagine that you participated in a contest and were presented with a choice between receiving €500 today or €505 tomorrow.</p>"),
                                         radioButtons("radiohd1", label = ("What would you choose?"),
                                                      choices = list("Receive €500 today" = 0, 
                                                                     "Receive €505 tomorrow" = 1
                                                                     ), selected=character(0)),
                                         HTML("<p>Now imagine that the options were: receiving €500 in a year or €505 in a year and a day.</p>"),
                                         radioButtons("radiohd2", label = ("What would you choose?"),
                                                      choices = list("Receive €500 a year from now " = 0, 
                                                                     "Receive €505 in a year and a day" = 1
                                                                     ), selected=character(0)),
                                         p(actionButton("hdButton", label="Confirm", icon = icon("check")), align="right")
                                     ),
                                     box(width=6,HTML("<b>Result:</b><br><br>"),
                                         uiOutput("feedbackhd"),
                                         p(actionButton("Next11", div("Continue", icon("arrow-right"))), align="right")
                                     )),
                            tabPanel(title="Temporal bias", value="hd1",
                                     box(width=12,
                                         fluidRow(
                                           column(7,
                                                  h3("What is it?"),
                                                  HTML("A temporal bias occurs when we do not assign a constant value to time. For example, if you agree to wait a day to receive €500, if you are given an extra €5, it shouldn't matter whether you have to wait for that day now or in a year’s time.
                                                  <br>Temporal bias has two variants, namely the present bias (when we need to be paid more to postpone receiving money in the present) and the  future bias (when we need to be paid more to postpone receiving money in the future)."),
                                                  h3("Financial implications"),
                                                  HTML("Both the future and present bias can have negative financial implications, as the moment when we make a choice or when it is applicable becomes important.
                                                  <br>For example, if we suffer from present bias, we can decide not to save and make purchases using credit because from this perspective having money is worth more now than in the future. In the case of future bias, we can make too many sacrifices in the present in order to have money in the future, not using a coupon now because we are waiting for a future purchase where it will be more beneficial to use it, or eternally postponing a pleasure (like a bottle of special wine or a holiday somewhere we would love to go)."),
                                                  h3("How can this be avoided?"),
                                                  HTML("<p>Some ways of avoiding these biases are as follows:</p>
                                                       <ul>
                                                         <li>For both biases, commit to following a certain logic before the choice appears: for example, you will save all the money you receive over €1.000 or you will open the special bottle of wine when you get a raise. If the desirable outcome (saving or opening the bottle) never happens, review your commitment to make it more possible.</li>
                                                         <li>To avoid the present bias, remember that we often postpone things because we mistakenly assume that our future Self will have exactly the same skills, energy, motivation and health as our present Self. However, this perfectionist view of our Self in the future is illusory. To avoid being a victim of this illusion try to imagine the needs that you may have (increased health expenses, unexpected expenses with the car or home, loss of financial capacity after retirement, etc.). Another effective strategy is to imagine that you are advising a friend to prepare for the future (instead of making decisions about yourself).</li>
                                                         <li>To avoid future bias, try to use your past experience to know when the time is right to postpone. For example, if you have a 10% discount on a coupon with a one month validity and the most expensive purchase you usually make per month is €50, use it when you make that purchase, without waiting for a more expensive purchase. Take another example, if you are always waiting for the right time to visit a museum in your city but it hasn't happened yet, then you should try going there as soon as possible and not waiting for a better moment.</li>
                                                       </ul>
                                                       "),
                                                  h3("To find out more"),
                                                  HTML(
                                                  "<ul>
                                                    <li>Princeton University & FINRA Investor Education Foundation. <i>Overcoming biases to promote wise investing.</i></li>
                                                    <li>Shu, S. (2005). Choosing to consume later: Determinants of future-biased choice. <i>ACR North American Advances, 32</i>, 67-68.</li>
                                                    <li>† Stanovich, K. E., West, R. F., & Toplak, M. E. (2016). <i>The rationality quotient</i>. MIT Press.</li>
                                                    <li>Takeuchi, K. (2011). Non-parametric test of time consistency: Present bias and future bias. <i>Games and Economic Behavior, 71</i>(2), 456-478.</li>
                                                    <li>* Thaler, R. H. (1991). Some Empirical Evidence on Dynamic Inconsistency. In R. H. Thaler (Ed.), <i>Quasi rational economics</i>, 127-136. The Russell Sage Foundation.
                                                  </ul>
                                                  
                                                  <p>* Source of the example from the \"Put yourself to the test!\" tab, † source of the example from the \"Practice\" tab.</p>")
                                                  
                                           ),
                                           column(5,
                                                  HTML("<div style=\"text-align:center;\">Would you accept €5 extra to wait one day to receive €500?</div>"),
                                                  plotOutput("hdplot"),
                                                  uiOutput("hdnote"),
                                                  br(),
                                                  p(actionButton("Next12", div("Continue", icon("arrow-right"))), align="right")
                                           )))),
                            tabPanel(value="prat6",title="Practice",
                                     box(width=6,                                          
                                         HTML("<p>Imagine that you can choose to receive a given amount of money now or wait 3 months to receive €100. Indicate your preferences for each of the following possibilities:</p>"),
                                         radioButtons("radiophd1", label = ("€60 now or €100 within 3 months?"),
                                                      choices = list("€60 now" = 0, 
                                                                     "€100 within 3 months" = 1
                                                      ), inline=T, selected=character(0)),
                                         radioButtons("radiophd2", label = ("€70 now or €100 within 3 months?"),
                                                      choices = list("€70 now" = 0, 
                                                                     "€100 within 3 months" = 1
                                                      ), inline=T, selected=character(0)),
                                         radioButtons("radiophd3", label = ("€80 now or €100 within 3 months?"),
                                                      choices = list("€80 now" = 0, 
                                                                     "€100 within 3 months" = 1
                                                      ), inline=T, selected=character(0)),
                                         radioButtons("radiophd4", label = ("€85 now or €100 within 3 months?"),
                                                      choices = list("€85 now" = 0, 
                                                                     "€100 within 3 months" = 1
                                                      ), inline=T, selected=character(0)),
                                         radioButtons("radiophd5", label = ("€90 now or €100 within 3 months?"),
                                                      choices = list("€90 now" = 0, 
                                                                     "€100 within 3 months" = 1
                                                      ), inline=T, selected=character(0)),
                                         radioButtons("radiophd6", label = ("€99 now or €100 within 3 months?"),
                                                      choices = list("€99 now" = 0, 
                                                                     "€100 within 3 months" = 1
                                                      ), inline=T, selected=character(0)),
                                         p(actionButton("hdpButton", label="Confirm", icon = icon("check")), align="right")),
                                     box(width=6,
                                         HTML("<b>Result:</b><br><br>"),
                                         uiOutput("feedbackphd")
                                     )))),
        
        #|###########|#
        #|# CRÉDITO #|#
        #|###########|#
        
        tabItem("introC",
                box(width=12,
                    h3("CREDIT CARDS", align="center")),
                fluidRow(box(width=6,
                    HTML("<h3>Why use credit cards?</h3>
                    <p>The number of payments people make by card has increased. Between 2013 and 2017, the average number of payments per card in Europe has gone from 54,4 to 75,2. Credit cards represent a significant amount (31,4%) of the total of payment cards people use, so it is important people use them to their advantage.</p>
                    <p>Credit cards can bring several benefits, such as:</p>
                    <ul>
                      <li>Cashbacks (that is, a percentage of the purchase price is returned);</li>
                      <li>Special discounts;</li>
                      <li>Access to special conditions when subscribing to other bank products (for example, insurance with a lower annual fee);</li>
                      <li>Being able to make purchases for which there is no current liquidity (available money), but there will be in the near future.</li>
                     </ul>However, they can also be a source of problems, especially if you are led to buy more things than you should or to incur debt.</p>"),
                    p("Discover three biases below that can have a negative impact on the way you use credit cards.")),
                    box(width=6,HTML("Average number of payments made by card (red) per year and credit cards as a percentage of total credit and debit cards. Source: <a href=\"https://www.paymentscardsandmobile.com/payment-card-yearbooks-european-payments-continue-to-rise-rapidly/\">Payment Card Yearbooks</a>."),
                        plotOutput("cardplot"))
                    ),
                fluidRow(
                  box(width=4, p(actionButton(inputId="NextP5A", label=HTML('<h3><i class="fa fa-credit-card"></i> Anchoring</h3>')), align="center")),
                  box(width=4, p(actionButton(inputId="NextP5B", label=HTML('<h3><i class="fa fa-credit-card"></i> Debt account aversion</h3>')), align="center")),
                  box(width=4, p(actionButton(inputId="NextP5C", label=HTML('<h3><i class="fa fa-credit-card"></i> Pain of paying</h3>')), align="center"))
                )),
        
            ###############
            ## Ancoragem ##
            ###############
        
        tabItem("anchor",
                tabsetPanel(id="tabAN",
                            tabPanel("Put yourself to the test",
                                     box(width=6,
                                             HTML("Imagine that your credit card currently has a negative balance (i.e. a debt) of €1.214,18. According to the bank statement, the minimum instalment to be paid for this amount is 
                                             <b>€36,43</b>.
                                             <br><br>Assuming that after paying all your monthly expenses you have €150 available, what amount would you be willing to pay to bring down your credit?"),
                                             textInput("numAN", label = "", value = "", width="100%"),
                                             HTML("<b>Note</b>: Write down just the number (e.g., 10 and not €10) and use commas if you want to use decimals."),
                                             p(actionButton("anchButton", label="Confirm", icon = icon("check")), align="right")
                                          ),
                                          box(width=6, 
                                              HTML("<b>Result:</b>"),
                                              uiOutput("feedbackanch"),
                                              br(),
                                              p(actionButton("Next5", div("Continue", icon("arrow-right"))), align="right")
                                            )
                                         ),
                            tabPanel(title="Anchoring", value="anc1",
                                     box(width=12,
                                         fluidRow(
                                           column(7,
                                                  h3("What is it?"),
                                                  p("The anchoring effect occurs when a value that is suggested in the context in which we make a decision influences the estimates we make (that is, it functions as an anchor). In the previous example, the minimum instalment (€36,43) acts as an anchor, making people indicate lower monthly instalments (average = €58,08) when compared to people who responded to the same problem, but where the minimum instalment presented was higher: €60,71 (average response = €77,01)."),
                                                  HTML("<p>The anchoring effect can lead to negative consequences in the payment of credit, namely:</p>
                                                       <ul>
                                                        <li>Taking longer to pay the credit;</li>
                                                        <li>Having to pay more interest.</li>
                                                       </ul>
                                                       <p>For example, considering an interest rate of 8%, those who were presented with a minimum instalment of €36,43 would pay on average €70 more and would take approximately 16 months longer to pay off their debt than those to whom a minimum instalment of €60,71 was presented.
                                                       <br>The anchoring effect has several explanations. According to the anchoring and adjustment heuristic (a simple decision strategy), this bias occurs because people tend to use the values presented in the decision contexts as a useful clue for their response. They use that value as a starting point and adjust it (upwards or downwards) until they find a value they think is appropriate. The fact that this adjustment is often insufficient (due to a lack of time, motivation or simply because people do not do it thoroughly), results in numerical estimates that are closer to the suggested values than to the average estimates given in the same type of situation when no value is suggested in the decision context. Other factors, for example, the tendency to accept payment amounts that are charged to us by default also contribute to many consumers ending up paying the minimum monthly amount of their credit card statements.</p>"),
                                                  h3("Financial implications"),
                                                  HTML("<p>The anchoring effect is often used in consumption and business contexts:</p>
                                                       <ul>
                                                        <li>Amounts suggested by one of the parties in the purchase and sale of goods and products (e.g. cars, houses) anchor the final values of the transaction (even when they are rejected by the other party);</li>
                                                        <li>In many negotiating circumstances, the first offer acts as an anchor that ends up influencing the value agreed upon at the end of the negotiation. That is, the higher the first offer, the higher the final value agreed after the negotiation and vice versa (the lower the first offer the lower the final negotiated value).</li>
                                                       </ul>
                                                       "),
                                                  h3("How can this be avoided?"),
                                                  HTML("The anchoring effect is an extremely difficult bias to avoid.
                                                    <br>The most effective way of doing this is by questioning the amounts suggested to you in different contexts, thinking of reasons why they may not be valid or thinking about other possible amounts.
                                                    <br>In the example of the credit card provision, you could think of reasons for not paying only the minimum amount indicated:
                                                    <ul>
                                                       <li>Why is this amount indicated as the minimum amount?</li>
                                                       <li>How long will it take to pay off the credit if I always opt for the minimum instalment?</li>
                                                       <li>What would be the maximum amount I could pay?</li>
                                                    </ul>"),
                                                  h3("To find out more"),
                                                  HTML("<ul>
                                                        <li>Keys, B. J., Wang, J., & Bureau, C. F. P. (2014). <i>Perverse nudges: Minimum payments and debt paydown in consumer credit cards.</i> University of Chicago Working Paper.</li>
                                                        <li>Navarro-Martinez, D., Salisbury, L. C., Lemon, K. N., Stewart, N., Matthews, W. J., & Harris, A. J. (2011). Minimum required payment and supplemental information disclosure effects on consumer debt repayment decisions. <i>Journal of Marketing Research, 48</i>(SPL), S60-S77.</li>
                                                        <li>Sôro, J. , Ferreira, M., Garcia-Marques, L., Almeida F. & Reis, J. (submitted). <i>Anchoring effects in credit card payments</i>.</li>
                                                        <li>Tversky, A., & Kahneman, D. (1974). Judgment under uncertainty: Heuristics and biases. <i>Science, 185</i>, 1124-1131</li>
                                                       </ul>")
                                         ),
                                         column(5,
                                                plotOutput("anchplot"),
                                                uiOutput("anchnote"),
                                                br(),
                                                p(actionButton("Next6", div("Continue", icon("arrow-right"))), align="right")
                                                )
                                         ))),
                            tabPanel(title="Practice", value="prat3",
                                     box(width=6,
                                         HTML("Imagine you are planning your next holiday. You plan to book an 8 to 10-day trip for two to the Hawaii region, in peak season.
                                               <br>You have consulted a travel agency that has presented you with a travel and accommodation package proposal for two people, in a 3-star hotel with breakfast included for  €1.165,15, offering the possibility to pay by credit card.
                                               <br>Is this amount above, below or equal to the amount you consider acceptable (i.e. the market value) for the travel and accommodation package?
                                              <div style=\"text-align:center;\">"),
                                         radioButtons("radioAN", label = "",
                                                      choices = list("Above" = 1, "Equal" = 2, "Below" = 3), 
                                                      selected = NULL, inline=T),
                                          HTML("</div>What amount do you consider to be acceptable (i.e. the market value) for the above-mentioned travel and accommodation package?
                                              <br>Before presenting the estimate value, remember the strategies you learned to avoid the anchoring effect!"),
                                         textInput("textAN", "", value=0),
                                         HTML("<b>Note</b>: Write down just the number (e.g., 10 and not €10) and use commas if you want to use decimals."),
                                         p(actionButton("anpButton", label="Confirm", icon = icon("check")), align="right")
                                     ),
                                     box(width=6,
                                         HTML("<b>Result:</b><br><br>"),
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
                        tabPanel("Put yourself to the test!",
                                 box(width=6,
                                     HTML("Imagine you owe the following amounts:
                                     <br><br>
                                           <table style=\"width:100%\">
                                            <tr><th>Credits</th><th>Outstanding debt</th><th>Interest rate</th></tr>
                                            <tr><td>Credit 1</td><td>€3.040</td><td>12,50%</td></tr>
                                            <tr><td>Credit 2</td><td>€5.108</td><td>13,25%</td></tr>
                                            <tr><td>Credit 3</td><td>€47.003</td><td>14,00%</td></tr>
                                            <tr><td>Credit 4</td><td>€12.793</td><td>13,50%</td></tr>
                                            <tr><td>Credit 5</td><td>€27.410</td><td>13,75%</td></tr>
                                            <tr><td>Credit 6</td><td>€9.694</td><td>12,00%</td></tr>
                                            <tr><td><b>Total: </b></td><td>€105.048</td><td></td></tr>
                                          </table> 
                                          <br>
                                          Assuming you received a €15.000 prize, how would you allocate your money? Fill in only the space(s) corresponding to the credit(s) where you wish to allocate some of this money, but empty spaces should be filled with zeros.
                                          "),
                                      HTML("<table cellspacing=0>
                                            <tr><td>Credit 1:&nbsp;€&nbsp;</td><td>"),
                                     textInput("textDA1", "", value=0),
                                      HTML("</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                           <td>Credit 2:&nbsp;€&nbsp;</td><td>"),
                                     textInput("textDA2", "", value=0),
                                     HTML("</td><td></td></tr>
                                           <tr><td>Credit 3:&nbsp;€&nbsp;</td><td>"),
                                     textInput("textDA3", "", value=0),
                                     HTML("</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                           <td>Credit 4:&nbsp;€&nbsp;</td><td>"),
                                     textInput("textDA4", "", value=0),
                                     HTML("</td></tr>
                                           <tr><td>Credit 5:&nbsp;€&nbsp;</td><td>"),
                                     textInput("textDA5", "", value=0),
                                     HTML("</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                           <td>Credit 6:&nbsp;€&nbsp;</td><td>"),
                                     textInput("textDA6", "", value=0),
                                      HTML("</td></tr>
                                           </table>"),
                                     div(uiOutput("debSum"), align="center"),
                                     HTML("<br><b>Note</b>: Write down just a number (e.g., 10 and not €10) above or equal to zero and use commas if you want to use decimals."),
                                     p(actionButton("daButton", label="Confirm", icon = icon("check")), align="right")
                                       ),
                                 box(width=6,
                                              HTML("<b>Result:</b>"),
                                              uiOutput("feedbackdebta"),
                                     br(),
                                     p(actionButton("Next17", div("Continue", icon("arrow-right"))), align="right"))
                                 ),
                        tabPanel(title="Debt account aversion", value="da1",
                                 box(width=12,
                                     fluidRow(
                                       column(7,
                                              h3("What is it?"),
                                              p("In the previous tab we showed you an example of debt account aversion. In situations where people keep multiple credits open, debt account aversion is manifested by a preference for paying smaller debts first (in order to eliminate them) rather than first paying or amortizing debts that have higher interest rates."),
                                              h3("Financial implications"),
                                              p("Eliminating some debts can be tempting as it creates a feeling in the consumer of fulfilling a small objective, thus motivating him to fulfil the larger objective, which is to eliminate all his debts. However, when this strategy leads the consumer to start out by eliminating the debts with lower interest rates (and continuing to pay the debts with higher interest rates  for longer), he ends up with a global debt that is higher than what would need to be paid if payments had first been allocated to the debts with the highest interest rates."),
                                              h3("How can this be avoided?"),
                                              HTML("The most effective way to counter the tendency to prefer to eliminate small debts first is to choose to write off debts with higher interest rates with the money available (regardless of the value of the debt).<br>
                                              So, to reduce the temptation to eliminate small debts in the first place, calculate the interest amounts that result from failure to pay each of your debts.<br>
                                              Another way of reducing the impact of “debt account aversion” on your personal finances is by opting to consolidate all your debts into a single debt. While this option may have upfront costs, it typically reduces debt service (i.e. monthly instalments), ultimately allowing you to settle the debt more effectively."),
                                              HTML("<p>Should you opt for debt consolidation, it is advisable to use the support of independent experts such as the <a href=\"https://ecdn.eu/\">European Consumer Debt Network</a>.</p>"),
                                              h3("To find out more"),
                                              HTML("<ul>
                                                   <li>* Amar, M., Ariely, D., Ayal, S., Cryder, C. E., & Rick, S. I. (2011). Winning the battle but losing the war: The psychology of debt management. <i>Journal of Marketing Research, 48</i>(SPL), S38-S50.</li>
                                                   </ul>
                                                   <p>* Source of the example from the \"Put yourself to the test!\" tab.</p>")
                                       ),
                                       column(5,
                                              plotOutput("debplot"),
                                              uiOutput("debnote"),
                                              br(),
                                              p(actionButton("Next18", div("Continue", icon("arrow-right"))), align="right")
                                       )
                                    ))),
                        tabPanel(title="Practice", value="prat9",
                                 box(width=6,
                                     HTML("Imagine you have a friend who owes the following amounts:
                                     <br><br>
                                           <table style=\"width:100%\">
                                            <tr><th>Credits</th><th>Outstanding debt</th><th>Interest rate</th></tr>
                                            <tr><td>Credit 1</td><td>€1.500</td><td>18,50%</td></tr>
                                            <tr><td>Credit 2</td><td>€25.375</td><td>14,75%</td></tr>
                                            <tr><td>Credit 3</td><td>€8.760</td><td>10,50%</td></tr>
                                            <tr><td>Credit 4</td><td>€27.410</td><td>13,75%</td></tr>
                                            <tr><td>Credit 5</td><td>€3.200</td><td>12,00%</td></tr>
                                            <tr><td><b>Total: </b></td><td>€66.245</td><td></td></tr>
                                          </table> 
                                          <br>
                                          Click on the box below and select the order (from first to last) in which you would advise him to pay his credits."),
                                     selectizeInput(
                                       'selectizeDA', '', choices = paste(rep("Credit", 5),seq(1,5)), multiple = TRUE
                                     ),
                                     HTML("<b>Note</b>: If you make a mistake, delete the content and reselect the options to correct.<br>"),
                                     br(),
                                     p(actionButton("dapButton", label="Confirm", icon = icon("check")), align="right")
                                 ),
                                 box(width=6,
                                     HTML("<b>Result:</b><br><br>"),
                                     uiOutput("checkPracticeDA")
                                     )
                                 )
                        )),
    
    ##################
    ## Dor de pagar ##
    ##################
    
    tabItem("pain",
            tabsetPanel(id="tabDP",
                        tabPanel("Put yourself to the test!",
                                 box(width=6,
                                     HTML("Imagine you are planning to have a dinner at your house with 6 friends. Before going to the supermarket, you make a short list of what you need to buy: for entrées some bread / crackers and some cheese, for the main dish the ingredients for a meat lasagne and some side vegetables (salad or roasted vegetables), a pie for dessert and a few bottles of wine."),
                                     br(),br(),
                                     textInput("dpN0", label = ("Estimate the cost of the shopping for your dinner:"), value = 0),
                                     HTML("From a psychological point of view, how difficult would it be for you to pay this supermarket bill if you did so by...<br><br>
                                          <b>Using your credit card - the expense will be paid as of next month in smooth instalments:</b><br>
                                          <table width=\"100%\">
                                            <tr><td>Not at all (no psychological discomfort)</td><td style=\"text-align:right;\">Very much (high psychological discomfort)</td></tr>
                                          </table><span style=\"text-align:center;\">"),
                                     radioButtons("dpN1", label = "",
                                                  choices = list("1" = 1, "2" = 2, "3" = 3, 
                                                                 "4" = 4, "5" = 5, "6" = 6, "7" = 7), 
                                                  selected = "NULL", inline=T),
                                     HTML("</span><b>Withdrawing money from the ATM - supermarket bills are paid for in cash at the time of purchase:</b><br>
                                          <table width=\"100%\">
                                            <tr><td>Not at all (no psychological discomfort)</td><td style=\"text-align:right;\">Very much (high psychological discomfort)</td></tr>
                                          </table><span style=\"text-align:center;\">"),
                                     radioButtons("dpN2", label = "",
                                                  choices = list("1" = 1, "2" = 2, "3" = 3, 
                                                                 "4" = 4, "5" = 5, "6" = 6, "7" = 7), 
                                                  selected = "NULL", inline=T),
                                     HTML("</span>"),
                                     p(actionButton("dpButton", label="Confirm", icon = icon("check")), align="right")
                                 ),
                                 box(width=6,
                                     HTML("<b>Result:</b>"),
                                     uiOutput("feedbackpaina"),
                                     br(),
                                     p(actionButton("Next21", div("Continue", icon("arrow-right"))), align="right"))
                        ),
                        tabPanel(title="Pain of paying", value="dp1",
                                 box(width=12,
                                     fluidRow(
                                       column(7,
                                              h3("What is it?"),
                                              HTML("Research on consumer behaviour has shown that people spend more money when they pay for their purchases with credit cards (or even debit cards) than when they use cash.
                                              <br>The payment for goods and services generates an experience of discomfort in the consumer called “pain of paying”. This discomfort results from the balance between the expected benefits at the time of the purchase of the goods and services and the costs associated with them, and will be all the greater the more evident the relationship between the goods and services purchased and the costs incurred with the purchase is. 
                                              <br>Thus, payment methods that make it difficult to establish a relationship between the goods and services purchased and their costs, such as  the credit card, are associated with less “pain of paying” and, consequently, with a higher propensity to consume."),
                                              h3("Financial implications"),
                                              HTML("Payment by credit card is one of the methods where the characteristics make it difficult to correctly assess the cost-benefit ratio in the purchase of goods and services.
                                              <br>On the one hand, there is a time gap between the moment of purchase and enjoyment of the goods or service and the moment when they are actually paid for. The fact that goods and services paid for by credit card do not translate into immediate costs, unlike when they are paid for with cash, lessens the “pain of paying” and increases consumption.
                                              <br>On the other hand, the payment of expenses charged to a credit card is done in an aggregate manner, hiding the relationship between the different goods and services and their costs and thereby boosting higher levels of consumption."),
                                              h3("How can this be avoided?"),
                                              HTML("Considering the factors that can make you spend more money when you pay by credit card, when using this payment method try to think about the following points:
                                                   <ul>
                                                    <li>Assuming that you had the money available for the purchase, how willing would you be to make the same purchase if the payment had to be made with cash? Note: if your motivation for using a credit card is because you do not have the money available for the purchase, think hard about whether you really need to incur this expense and how likely it will be for you to be able to pay it off within 3 months at most. But don't forget that your assessment may be skewed by some unrealistic optimism.</li>
                                                    <li>Keep a record of the purchases you make over the month with your credit card and the total amount resulting from them - don't forget that our mental accounting is often fallible!</li>
                                                    <li>Be aware of other payment methods that make it difficult to establish an immediate relationship between the goods and services purchased and their costs - automatic payments with a mobile phone or debit card and direct debits are good examples.</li>
                                                   </ul>
                                                   "),
                                              h3("To find out more"),
                                              HTML("<ul>
                                                     <li>Prelec, D., & Loewenstein, G. (1998). The red and the black: Mental accounting of savings and debt. <i>Marketing Science, 17</i>(1), 4-28.</li>
                                                     <li>Prelec, D., & Simester, D. (2001). Always leave home without it: A further investigation of the credit-card effect on willingness to pay. <i>Marketing Letters, 12</i>(1), 5-12.</li>
                                                     <li>* Raghubir, P., & Srivastava, J. (2008). Monopoly money: The effect of payment coupling and form on spending behavior. <i>Journal of Experimental Psychology: Applied, 14</i>(3), 213.</li>
                                                   </ul>
                                                   <p>* Source of the example from the \"Put yourself to the test!\" tab.</p>")
                                       ),
                                       column(5,
                                              plotOutput("dpplot"),
                                              HTML("In a study with American participants (<a href=\"https://psycnet.apa.org/buy/2008-12802-002\" target=\"_blank\">Raghubir & Srivastava, 2008</a>), people who estimated the cost of dinner thinking they would pay by credit card estimated a cost of $175,16, almost $30 more than those who estimated they would pay in cash (where the average was $145,56)."),
                                              br(),br(),
                                              p(actionButton("Next22", div("Continue", icon("arrow-right"))), align="right")
                                       )
                                     ))),
                        tabPanel(title="Practice", value="prat11",
                                 box(width=6,
                                     HTML("Do you still remember the example of the dinner with friends at your house? Now re-estimate the total value of the dinner, considering the values for the different items separately:"),
                                     br(),br(),
                                     textInput("dppN1", label = ("Entrées:"), value = 0),
                                     textInput("dppN2", label = ("Main dish:"), value = 0),
                                     textInput("dppN3", label = ("Dessert:"), value = 0),
                                     textInput("dppN4", label = ("Drinks:"), value = 0),
                                     br(),
                                     div(uiOutput("dpSum"), align="center"),
                                     br(),
                                     p(actionButton("dppButton", label="Confirm", icon = icon("check")), align="right")
                                 ),
                                 box(width=6,
                                     HTML("<b>Result:</b><br><br>"),
                                     uiOutput("checkPracticeDP")
                                 )
                        )
            )),
    
    
    
    ###########
    ## Sobre ##
    ###########
    
    tabItem("sobre",
            box(width=12,
                h2("About this app", align="center"),
                br(),
                HTML('<p>This app was developed by Mário Boto Ferreira, Joana Reis, and Cristina Mendonça by the Cognition in Context (CO2) research group of the
                  <a href="https://www.psicologia.ulisboa.pt/cicpsi/">Centro de Investigação em Ciência Psicológica</a> (CICPSI), of the Faculdade de Psicologia da Universidade de Lisboa,
                     and financed under project PTDC/MHC-PAP/1556/2014 by the Fundação para a Ciência e Tecnologia.</p>'),
                HTML("<p style=\"text-align:center;\">This app is available at <a href=\"https://github.com/CristinaMendonca/FinantialDecisionsApp_pt-PT\">GitHub</a>, follow the link to leave comments, see the code, or download it!</p>"),
                br(),
                fluidRow(
                  column(6, HTML('<img src="fp.png" width="90%">')),
                  column(6, HTML('<img src="fct.png" width="100%">'))
                ))
            )
                            
                            
        ))))

