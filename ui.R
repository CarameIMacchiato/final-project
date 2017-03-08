library(shiny)
library(ggplot2)
library(dplyr)


# Defining the UI
ui <- fluidPage(theme = "bootstrap.css",
 
  h1("Instagram Project", class = "page-header"),

  sidebarPanel(
    
    # Search for instagram user
    textInput("chosen.search", strong("Search Full Username")),
    p(em("Note: only works for our sandbox users", class = "text-info", class = "small")),
    
    # Display profile
    h4(uiOutput('pic', class = "img-thumbnail"), textOutput("selected.user", inline = TRUE)),
    p(strong("Following: "), textOutput("following", inline = TRUE)), 
    p(strong("Followers: "), textOutput("follows", inline = TRUE)),
    p(strong("Media Count: "), textOutput("media.count", inline = TRUE)),
    p(strong("Name: "), textOutput("name", inline = TRUE)),
    p(strong("Bio: "), textOutput("bio", inline = TRUE))
    
  ),
  mainPanel(
    tabsetPanel(type = "tabs",
      tabPanel("Explanation",
               h2("What is the Self-Worth Evaluator"),
               p("The Self-Worth Evaluator is a application that uses the instagram api to gather information and statistics on individual instagram users. It has many different features that tells a lot about a user, how they use instagram, and much more"),
               h4("Search bar"),
               p("The search bar can be used to look up different instagram users, but is limited to only a few do to instagrams api restrictions on public content. Look up a username and the app finds out all their information"),
               h4("The mini profile page"),
               p("Under the search bar, you can see a users miniature profile page, which includes their profile picture, follower information, and post information"),
               h4("The Photo Map"),
               p("This map displays all the different places pictures were posted, along with the actual pictures and captions"),
               h4("The Image Data"),
               p("This graph shows the amount of likes each photo has and shows in color how many comments it has, and can be clicked to display the image"),
               h4("The filter data"),
               p("This graph shows which filters the user uses the most, which can say a lot about wht kind of photos they take")
               ),
      tabPanel("Map", leafletOutput('maps')),
      tabPanel("Image Data", plotlyOutput("bar_chart"), hr(), 
               uiOutput("click")),
      tabPanel("Statistics",
               h2("Statistics"),
               p("Filters are a big part of Instagram. Here is a graph of the user's filters, and how often they use each of them (if at all).
           You can use this data to see which filters are more popular to use than others, and compare your filter use to other people!"),
               plotlyOutput("filter_plot")),
      tabPanel("Privacy Policy",
               h2("Privacy Policy"),
               p("This privacy policy has been compiled to better serve those who are concerned with how their 'Personally Identifiable Information' (PII) is being used online. PII, as described in US privacy law and information security, is information that can be used on its own or with other information to identify, contact, or locate a single person, or to identify an individual in context. Please read our privacy policy carefully to get a clear understanding of how we collect, use, protect or otherwise handle your Personally Identifiable Information in accordance with our website."),
               strong("What personal information do we collect from the people that visit our blog, website or app?"),
               p("When ordering or registering on our site, as appropriate, you may be asked to enter your Instagram Username or other details to help you with your experience."),
               strong("When do we collect information?"),
               p("We collect information from you when you fill out a form or enter information on our site."),
               strong("How do we use your information?"),
               p("We may use the information we collect from you when you register, make a purchase, sign up for our newsletter, respond to a survey or marketing communication, surf the website, or use certain other site features in the following ways:
                 . To personalize your experience and to allow us to deliver the type of content and product offerings in which you are most interested.
                 . To improve our website in order to better serve you."),
               strong("How do we protect your information?"),
               p("We do not use vulnerability scanning and/or scanning to PCI standards.
                  We only provide articles and information. We never ask for credit card numbers.
                  We do not use Malware Scanning.
                  We do not use an SSL certificate
                  . We only provide articles and information. We never ask for personal or private information like names, email addresses, or credit card numbers."),
               strong("Do we use 'cookies'?"),
               p("We do not use cookies for tracking purposes
                 You can choose to have your computer warn you each time a cookie is being sent, or you can choose to turn off all cookies. You do this through your browser settings. Since browser is a little different, look at your browser's Help Menu to learn the correct way to modify your cookies.
                 If you turn cookies off, Some of the features that make your site experience more efficient may not function properly.that make your site experience more efficient and may not function properly."),
               strong("Third-party disclosure"),
               p("We do not sell, trade, or otherwise transfer to outside parties your Personally Identifiable Information."),
               strong("Third-party links"),
               p("We do not include or offer third-party products or services on our website."),
               strong("Google"),
               p("Google's advertising requirements can be summed up by Google's Advertising Principles. They are put in place to provide a positive experience for users. https://support.google.com/adwordspolicy/answer/1316548?hl=en 
                 We have not enabled Google AdSense on our site but we may do so in the future."),
               strong("California Online Privacy Protection Act"),
               p("CalOPPA is the first state law in the nation to require commercial websites and online services to post a privacy policy. The law's reach stretches well beyond California to require any person or company in the United States (and conceivably the world) that operates websites collecting Personally Identifiable Information from California consumers to post a conspicuous privacy policy on its website stating exactly the information being collected and those individuals or companies with whom it is being shared. - See more at: http://consumercal.org/california-online-privacy-protection-act-caloppa/#sthash.0FdRbT51.dpuf"),
               strong("According to CalOPPA, we agree to the following:"),
               p("Users can visit our site anonymously.
                  Once this privacy policy is created, we will add a link to it on our home page or as a minimum, on the first significant page after entering our website.
                   Our Privacy Policy link includes the word 'Privacy' and can easily be found on the page specified above.
                   You will be notified of any Privacy Policy changes:
                   . On our Privacy Policy Page
                   Can change your personal information:
                   . By logging in to your account"),
               strong("How does our site handle Do Not Track signals?"),
               p("We don't honor Do Not Track signals and Do Not Track, plant cookies, or use advertising when a Do Not Track (DNT) browser mechanism is in place. We don't honor them because: We do not track anything and are not affiliated with third parties."),
               strong("Does our site allow third-party behavioral tracking?"),
               p("It's also important to note that we do not allow third-party behavioral tracking"),
               strong("COPPA (Children Online Privacy Protection Act)"),
               p("When it comes to the collection of personal information from children under the age of 13 years old, the Children's Online Privacy Protection Act (COPPA) puts parents in control. The Federal Trade Commission, United States' consumer protection agency, enforces the COPPA Rule, which spells out what operators of websites and online services must do to protect children's privacy and safety online. We do not specifically market to children under the age of 13 years old."),
               strong("Fair Information Practices"),
               p("The Fair Information Practices Principles form the backbone of privacy law in the United States and the concepts they include have played a significant role in the development of data protection laws around the globe. Understanding the Fair Information Practice Principles and how they should be implemented is critical to comply with the various privacy laws that protect personal information."),
               strong("In order to be in line with Fair Information Practices we will take the following responsive action, should a data breach occur:"),
               p("We will notify the users via in-site notification
                  . Within 1 business day
                  We also agree to the Individual Redress Principle which requires that individuals have the right to legally pursue enforceable rights against data collectors and processors who fail to adhere to the law. This principle requires not only that individuals have enforceable rights against data users, but also that individuals have recourse to courts or government agencies to investigate and/or prosecute non-compliance by data processors."),
               strong("CAN SPAM Act"),
               p("The CAN-SPAM Act is a law that sets the rules for commercial email, establishes requirements for commercial messages, gives recipients the right to have emails stopped from being sent to them, and spells out tough penalties for violations."),
               strong("We collect your email address in order to:"),
               strong("To be in accordance with CANSPAM, we agree to the following:"),
               p("If at any time you would like to unsubscribe from receiving future emails, you can email us at and we will promptly remove you from ALL correspondence."),
               p("Contacting Us"),
               p("If there are any questions regarding this privacy policy, you may contact us using the information below."),
               p("https://github.com/CarameIMacchiato/"),
               p("Mary Gates Hall"),
               p("Seattle, Washington 98195 USA"),
               p("gutierrezc92@yahoo.com"),
               p("Last Edited on 2017-03-01")
      )
    )
  )
   
)

shinyUI(ui)

