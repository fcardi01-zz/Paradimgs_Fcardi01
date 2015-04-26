Library System Assignment
Franco Cardinali
2014-15  BSc Paradigms 
RUBY assignment

In this folder you have 2 option 
		
		1) Try the Eclipse version Opening the LibraySystemInRuby folder 
		2) Try the Ruby Mine version Unzip the  file LibraySystemInRuby Export From RubyMine7_0_4.zip 
		
There in no code difference but it may make your life easier as RubyMine use different absolute paths compared to Eclipse - so I have created both Project to make your life easier;




IN THIS READ ME I FOLLOW THE FOLDER STRUCTURE FOR THE ECLIPSE ONE  

The project export is done by Eclipse as a system folder so it should work with copy and paste in your IDE as well; 
I invite you to follow the FolderStructureEclipse.png folder structure to give you an idea

LibraySystemInRuby\LibrarySystem\ contains five distinct files:

4 Classes: 

	1) Book
	2) Member
	3) Calendar
	4) Library

1 Controller which is acting as Main Menu

	1) Controller.rb

Controller.rb has a 10 options which forms a UI menu; This Interface will guide you through the actions to take as you would simulate the role of the Librarian;

Run Controller.rb firstly and follow the options available:


======    MAIN MENU       =============================================================================================
|1  -->   List Books                   -> Simply list all the Books existing                           |
|2  -->   List Members                 -> Simply list all the Members registered                                       |
|3  -->   Issue a Member Card          -> This will create an entry into member.csv file - therefore Member will exist |
|4  -->   List Books Checked Out       -> This will list a set of book id assigned to a member id and a due date       |
|5  -->   Check-Out                    -> Librarian will issue a book to a registered member                           |
|6  -->   Check-In                     -> Librarian will scan back a book which is already out (ONLY)                  |
|7  -->   Search Book                  -> Librarian will search a book by the title or author                          |
|8  -->   Books Overdue                -> List All Books Overdue                                                       |
|9  -->   Books Checked out by Member  -> List All Books Overdue (if any) for a specific memberid                      |
|10 -->   Exit                                                                                                         |
=======================================================================================================================


Each option (if a valid input is passed) will recall different methods across different classes: Book, Member, Calendar and the Library (the engine of all)

EXAMPLE: 	To create a new Member or Issue a New Membership you need to digit "3"
			Then if a valid integer is passed 
			It will check if the book-id is already out 
			If that is passed it will then generate a new member (record) and issue a new membership.
			
			If on the other hand no good input is passed or the id exist it will throw a friendly exception.
			

There are also just listing option as 1, 2, 4 and 8 the rest of the option will need interactions.

Examples for 4 and 8

Please Select Your Option: Enter a Digit from the above list 
>>.... 
4
Books Checked Out
Bookid: 8 is out for [memberid, duedate]=> [[2, 20150315]]
Bookid: 5 is out for [memberid, duedate]=> [[3, 20150308]]
Bookid: 1 is out for [memberid, duedate]=> [[1, 20150308]]
Bookid: 4 is out for [memberid, duedate]=> [[2, 20150309]]
Bookid: 3 is out for [memberid, duedate]=> [[1, 20150316]]

Please Select Your Option  From the Main Menu 
>>.... 8
Books Overdue are:
Bookid: 8  was due on the 20150315 ...sending eMail reminder to memberid: 2
Bookid: 5  was due on the 20150308 ...sending eMail reminder to memberid: 3
Bookid: 1  was due on the 20150308 ...sending eMail reminder to memberid: 1
Bookid: 4  was due on the 20150309 ...sending eMail reminder to memberid: 2
Bookid: 3  was due on the 20150316 ...sending eMail reminder to memberid: 1



PERSISTENCY RELY ON 2 CSV AND MARSHALLING BYTE STREAM (WITHOUT THOSE 3 FILES AND THIS FOLDER STRUCTURE THIS APPLCIATION WILL NOT WORK)



The Project Folder LibraySystemInRuby\LibrarySystem\tables contains 2 CSV files and the borrowed byte stream

		1) members.csv
		2) book.csv
		3) borrowed (marshal byte stream)
		
		
Those two CSV files are used in the Library system without those the application will not work at all; it will miss the referential id across all the options;


Borrowed binary file details:

	This Marshal "object" stores the transactional data for the library in order to exist in time. 
	Contains the Borrowed books
	Is transformed in hash map while the library runs
	This guarantee me to use the book id as unique Key of the map
	It also stores member id and due-date

	"The marshalling library converts collections of Ruby objects into a byte stream, 
	Allowing them to be stored outside the currently active script. 
	This data may subsequently be read and the original objects reconstituted."
	
	Example 
	
	Books Checked Out
		Bookid: 8 is out for [memberid, duedate]=> [[2, 20150315]]
		Bookid: 5 is out for [memberid, duedate]=> [[3, 20150308]]
		Bookid: 1 is out for [memberid, duedate]=> [[1, 20150308]]
		Bookid: 4 is out for [memberid, duedate]=> [[2, 20150309]]
		Bookid: 3 is out for [memberid, duedate]=> [[1, 20150316]]
		Bookid: 23 is out for [memberid, duedate]=> [[7, 20150323]]

	
	this object is managed by bullet proof methods which will  NEVER ALLOW:
	1) MORE THAN ONE BOOKID
	2) NO MORE THAT 3 MEMBERID FOR 3 DISTINCT BOOKID
	3) NOT EXISTING BOOKID 
	4) NOT EXISTING MEMEBERID
	5) OPTION 4 WILL LIST ALL DUEDATE BOOKS 
	6) WITH Calendar.difference_between_dates() will dynamically calculate if there is/are 1 or more books borrowed for more than 7 days.
	
	

TESTING CLASSES 

	1) TestingCalendar
	2)  TestingLibrary

	
For RUBY MINE 7.0.4 just unzip LibraySystemInRuby Export from RubyMine7_0_4.zip and follow same exact functionalities showed above.

They are using the exact same code.