import example.Role
import example.User
import example.UserRole

class BootStrap {
	
	
	def init = { servletContext ->
		if (User.count() != 0) {
			return
		}
		user()
	}
	
    def destroy = {
    }
	
	def user() {
		def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
		def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
	
		def admin = new User(username: 'admin', password: 'admin').save(flush: true)
		def user = new User(username: 'user', password: 'user').save(flush: true)
	
		UserRole.create(admin, adminRole, true)
		UserRole.create(user, userRole, true)
	}
}
