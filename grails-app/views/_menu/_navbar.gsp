<nav id="Navbar" class="navbar navbar-fixed-top navbar-inverse" role="navigation">
	<div class="container">
	
	    <div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
        		<span class="sr-only">Toggle navigation</span>
        		<span class="icon-bar"></span>
	           	<span class="icon-bar"></span>
	           	<span class="icon-bar"></span>
			</button>
	
			<a class="navbar-brand" href="${createLink(uri: '/')}">
				<img class="logo" src="${resource(plugin: 'kickstart', dir:'images', file:'brand_logo.png')}" alt="${meta(name:'app.name')}" width="16px" height="16px"/> 
				${meta(name:'app.name')}
				<small> v${meta(name:'app.version')}</small>
			</a>
		</div>

		<div class="collapse navbar-collapse navbar-ex1-collapse" role="navigation">

			<sec:ifLoggedIn>
				<ul class="nav navbar-nav navbar-right">
					<li><g:link controller="user" action="index">
							<g:message code="user.label" default="User" />
						</g:link></li>
					<li><g:link controller="book" action="index">
							<g:message code="book.label" default="Book" />
						</g:link></li>

					<g:render template="/_menu/admin" />
					<g:render template="/_menu/info" />

					<li><g:link controller="logout" action="index">
							<g:message code="security.signoff.label" default="Logout" />
						</g:link></li>
				</ul>
			</sec:ifLoggedIn>

		</div>
	</div>
</nav>
