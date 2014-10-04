package example

class Book {

	String name
	User user
	Date   dateCreated
	Date   lastUpdated

	static constraints = {
		name blank: false, unique: true
		user blank: true, nullable: true
		dateCreated()
		lastUpdated()
	}
}
