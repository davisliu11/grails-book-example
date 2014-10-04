grails-book-example
===================

demo project for grails quick study
    

Tutorial:

# Download GGTS (Groovy/Grails Tool Suite) and install it
  http://spring.io/tools/ggts
  
# Create a project.

  GGTS -> File -> Grails Project
  

# Add the proxy into BuildConfig.groovy
 
   System.setProperty("socket.proxyHost", "192.168.1.4");

   System.setProperty("socket.proxyPort", "5678");

   Note: Change your proxy address accordingly

# New a Book domain

 class Book {

    String name
    Date    dateCreated
    Date    lastUpdated
    
        static constraints = {
        name blank: false, unique: true
        dateCreated()
        lastUpdated()
    }
 }

# New a Book Controller with scaffold

 class BookController {
    static scaffold = true
 }

# messages.properties 
  
 book.name.label = 书名

 book.dateCreated.label = 入库时间

 book.lastUpdated.label = 更新时间
 
 
# Demo Create, Update book and notice the 入库时间 & 更新时间
 
# Change DataSource.groovy for DB config as you like

# Add plugins in BuildConfig.groovy

        // Spring security to auth users
        compile ":spring-security-core:2.0-RC3"
        
        // Bootstrap kickstart plugin
        compile ":kickstart-with-bootstrap:1.1.0"
        
        // Jetty embedded server
        runtime ':war-exec:1.0.1'
        
 
  Note: You can find more plugins at https://grails.org/plugins/
           Remember to refresh your project through: Right click on project name -> Grails Tools -> Refresh Dependencies
 
# Run commands below in grails command as the console log tells
 
 s2-quickstart store User Role
 kickstart

# Add static rules in Config.groovy per your case
 
      '/**':                              ['ROLE_ADMIN']
 
# Add default user & group in the Bootstrap.groovy
 
    def init = { servletContext ->
        if (User.count() != 0) {
            return
        }
        user()
    }
 
    def user() {
        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        def admin = new User(username: 'admin', password: 'admin').save(flush: true)
        def user = new User(username: 'user', password: 'user').save(flush: true)

        UserRole.create(admin, adminRole, true)
        UserRole.create(user, userRole, true)
    }
    
# Add a scaffolded UserController class

# Remove page header in kickstart.gsp and remove main menu in _content.gsp

# Change the home controller to book in UrlMapping.groovy
        "/"    {
            controller    = 'book'
            action    = { 'index' }
                        view        = { 'index' }
        }

# Add <sec:ifLoggedIn> tag, add logout and remove controller browser, user, language 

       <sec:ifLoggedIn>
        <ul class="nav navbar-nav navbar-right">
            <li><g:link controller="user" action="index">
                    <g:message code="user.label" default="User" />
                </g:link></li>    
            <li><g:link controller="book" action="index">
                    <g:message code="book.label" default="Book" />
                </g:link></li>    
                
            <g:render template="/_menu/admin"/>                                                        
            <g:render template="/_menu/info"/>                    
    
            <li><g:link controller="logout" action="index">
                    <g:message code="security.signoff.label" default="Logout" />
                </g:link></li>                                                    
        </ul>    
        </sec:ifLoggedIn>
        
# Add below into Config.groovy to enable logout through http get

 grails.plugin.springsecurity.logout.postOnly = false
 
# Add user into the Book domain

 class Book {
 
     String name
     User   user
     Date    dateCreated
     Date    lastUpdated
     
     static constraints = {
         name blank: false, unique: true
         user blank: true, nullable: true
         dateCreated()
         lastUpdated()
     }
 }

# Add toString into User domain so that we can have a user-friendly user name in the book CRUD

    @Override    // Override toString for a nicer / more descriptive UI
    public String toString() {
        return username;
    } 
