#############################
#
#  Controller Class by
#  @author Franco Cardinali
#  Ruby Version: 2.1.5p273
#  IDE: Eclipse IDE for Java Developers Release 1 (4.4.1)
#  fcardi01
#  Assignment valid for 25% mark of  Paradigms
#  5th Year Part Time of BCs in Computing
#  12-April-2015
#

#############################

#Libraries Required
require 'csv'
require'pp'

#Classes Required
require './LibrarySystem/Book'
require './LibrarySystem/Member'
require './LibrarySystem/Library'
require './LibrarySystem/Calendar'

# Printing
newline = "\n"
prompt =">>.... "

# CSV Tables
book_table = "./LibrarySystem/tables/books.csv"
member_table = "./LibrarySystem/tables/members.csv"

# Instances
newMember = Member.new(@memberid,@name,@library)
newBook   = Book.new(@bookid,@title,@author)
newLibrary = Library.new()
date = Calendar.new()
today = date.get_date()

#Variables
date_due_future = date.advance(7)  # due date is today + 7



#Borrowed Book is held in a Marshal file dumped In Memory

## every time the Controller.rb (this file) is launched
## simply check if the "object" dumping_bookedones exist; if it does
## carry on an it load it up otherwise if it is not in the system
## fir example the library is launched for the first time and there are no
## borrowed book this will be created as new

if File.exist?('./LibrarySystem/tables/borrowed')

  borrowed = Marshal.load(File.binread('./LibrarySystem/tables/borrowed'))

else

  borrowed ={}

end

# This is The interactive  UI Menu

puts 'Welcome To Franco Cardinali Library   '
puts 'RUBY assignment for Paradigms module   '
puts 'fcardi01 - Bsc 2014-2015   '
puts '__________________________________________'
puts ' '
puts 'Today is: '+ Time.now.strftime("%Y-%m-%d")

puts newline

puts '======    MAIN MENU       ============================================================================================='
puts '|1  -->   List Books                   -> Simply list all the Books existing                           |'
puts '|2  -->   List Members                 -> Simply list all the Members registered                                       |'
puts '|3  -->   Issue a Member Card          -> This will create an entry into member.csv file - therefore Member will exist |'
puts '|4  -->   List Books Checked Out       -> This will list a set of book id assigned to a member id and a due date       |'
puts '|5  -->   Check-Out                    -> Librarian will issue a book to a registered member                           |'
puts '|6  -->   Check-In                     -> Librarian will scan back a book which is already out (ONLY)                  |'
puts '|7  -->   Search Book                  -> Librarian will search a book by the title or author                          |'
puts '|8  -->   Books Overdue                -> List All Books Overdue                                                       |'
puts '|9  -->   Books Checked out by Member  -> List All Books Overdue (if any) for a specific memberid                      |'
puts '|10 -->   Exit                                                                                                         |'
puts '======================================================================================================================='
puts newline
puts "Please Select Your Option: Enter a Digit from the above list "
print prompt
puts newline

## Interactive UI
## Simply recall all the Methods in this Project
## Interacting with all the Classes created
## Simply my idea was to create a very good experience of this Ruby project and make the
## user testing/using this small App.
## Have Fun!!!!

while  option = gets.chomp.to_i

  case option

  when 1   #LIST ALL BOOKS

    newLibrary.list_books(book_table)
    puts newline
    countbook = CSV.read(book_table,headers: true)
    puts "Total Books = #{countbook.count}"

    puts newline
    puts "Please Select Your Option  From the Main Menu "
    print prompt

  when 2  # LIST ALL MEMBERS

    newLibrary.list_members(member_table)
    puts newline
    countmembers = CSV.read(member_table,headers: true)
    puts "Total Members Registred = #{countmembers.count}"

    puts newline
    puts "Please Select Your Option  From the Main Menu "
    print prompt

  when 3   # CREATE A MEMEBER - ISSUE MEMBERSHIP
    puts "To Create A Member: id , a name and a specific library"

    puts "Memberid: "

    memberid = gets.chomp.to_i

    if (newLibrary.is_member_real(member_table,memberid) == true && memberid > 0 )

      newMember.add_member(member_table,memberid)
      puts "New Membership n* #{memberid} issued"

    else

      puts 'Id already in use...or id format proposed'

    end

    puts newline
    puts "Please Select Your Option  From the Main Menu "
    print prompt

  when 4   # LIST ALL CHECKED OUT BOOK

    puts "Books Checked Out"

    newLibrary.list_borrowed(borrowed)

    puts newline
    puts "Please Select Your Option  From the Main Menu "
    print prompt

  when 5   # CHECK OUT A BOOK

    puts "Check-Out"

    puts "Enter the Book Id to Check-out for a member"
    bookid_key = gets.chomp.to_i

    if newLibrary.is_book_real(book_table,bookid_key) == false

      puts "Valid id...."
      if newLibrary.is_book_out(borrowed,bookid_key) == true

        puts "Book is Already Out"

      else

        puts "Book is Free.......Please Enter Member id:"

        memberid_value = gets.chomp.to_i

        if newLibrary.is_member_real(member_table,memberid_value) == false

          newLibrary.check_out(borrowed,memberid_value,bookid_key)

        else

          puts "Member not in the System"

        end

      end
    else
      puts "Not Existing Book id ....List all Books with option <1> and check again"

    end
    puts newline
    puts "Please Select Your Option  From the Main Menu "
    print prompt

  when 6  # CHECK IN A BOOK

    puts "Check-in"
    puts "Enter the Book Id to Check-in for a member"
    bookid_key = gets.chomp.to_i

    if newLibrary.is_book_real(book_table,bookid_key) == false

      newLibrary.check_in(borrowed,bookid_key)

    else

      puts "Not A valid Book id "
    end

    puts newline
    puts "Please Select an Option From the Main Menu "
    print prompt

  when 7   # SEARCH BOOKS

    puts "Search Book By Title or Author"
    titleAuthorBook = gets.chomp
    newLibrary.searchTitleAuthor(book_table,titleAuthorBook)

    puts newline
    puts "Please Select an Option  From the Main Menu "
    print prompt

  when 8   # LIST ALL OVERDUE BOOKS

    puts "Books Overdue are:"

    borrowed.each_pair {|k,v| if date.difference_between_dates("#{v[0][1]}",today) == true

        puts "Bookid: #{k}  was due on the #{v[0][1]} ...sending eMail reminder to memberid: #{v[0][0]}"

      end
    }

    puts newline
    puts "Please Select Your Option  From the Main Menu "
    print prompt

  when 9    # SEARCH BY MEMBERID BOOKS CHECKED OUT

    puts "Books Checked-out By Member id are:"

    puts "Memberid:"

    memberid = gets.chomp.to_i
    if newLibrary.is_member_real(member_table,memberid) == false

      newLibrary.search_out_for_member(memberid,borrowed)
    else
      puts "Member Not In The System"

    end
    puts newline
    puts "Please Select Your Option  From the Main Menu "
    print prompt

  when 10  # EXIT

    puts "End of this session Closing The System"
    break

  else

    # if option not between 1 and 10 included - is invalid
    # not integer will be not valid
    puts "Wrong Option...Try Again!!!!)"
    print prompt

  end

end
