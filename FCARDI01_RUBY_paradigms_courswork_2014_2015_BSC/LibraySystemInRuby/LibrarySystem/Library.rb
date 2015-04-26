#############################
#
#  Library Class by
#  @author Franco Cardinali
#  Ruby Version: 2.1.5p273
#  IDE: Eclipse IDE for Java Developers Release 1 (4.4.1)
#  fcardi01
#  Assignment valid for 25% mark of  Paradigms
#  5th Year Part Time of BCs in Computing
#  12-April-2015
#

#############################

require 'csv'
require './LibrarySystem/Member'
require './LibrarySystem/Book'

class Library
  # Needed to declare 2 arrays to store the results
  def initialize
    @books_in_stock ||= []
    @members_registred||= []
  end

  # list_books will output on screen all the records from book.csv
  # as an array in temporary memory.
  #
  # @param csv_filename  --> the actual file book.csv
  # @return lines or better an Array;
  def list_books (csv_filename)

    # This make sure when printing the list from controller.rb it will
    # not print 2 -3 -4 times the same elements
    @books_in_stock.clear

    CSV.foreach(csv_filename, headers: true) do |row|

      @books_in_stock << Book.new(row["bookid"], row["title"],row["author"])

    end

    @books_in_stock.each  { |book| puts book.to_s }

  end

  # list_members will output on screen all the records from members.csv
  # as an array in temporary memory.
  #
  # @param csv_filename  --> the actual file member.csv
  # @return lines or better an Array;
  def list_members(csv_filename)

    # This make sure when printing the list from controller.rb it will
    # not print 2 -3 -4 times the same elements
    @members_registred.clear

    puts "Members:"
    puts "MEMBERID  ||  MEMBERNAME  ||  LIBRARY \n"

    CSV.foreach(csv_filename, headers: true) do |row|

      @members_registred << Member.new(row["memberid"], row["name"],row["library"])

    end

    @members_registred.each  { |member| puts member.to_s }

  end

  # list_borrowed simply list all the records contained in the ruby dump object
  # those entries represent the all checked out books.
  # @note: the elegance of the output
  #
  # @param marshal_hash  --> Marshal Dump object read in binary code - emulating a DB Table
  #
  # @return the all records for the marshal Object - checked out books
  def list_borrowed(marshal_hash)

    marshal_hash.each {|key , value | puts "Bookid: #{key} is out for [memberid, duedate]=> #{value}"}

  end

  # check_in will first check if the Hash created will contain the key (book id)
  # if it finds it delete all the record associated to it.
  # book id is perfect as key as the library will only issue one book to one member.
  #
  # @param marshal_hash  --> Marshal Dump object read in binary code - emulating a DB Table
  # @param bookid_key    --> an Integer which represent the book id
  #
  # @return a message if the record exist (after it has deleted it)
  def check_in (marshal_hash,bookid_key)

    if  marshal_hash.has_key?(bookid_key)== false

      puts "Book is not been borrowed.... therefore not possible to check in"

    else

      marshal_hash.delete(bookid_key)

      puts "Book Returned Successfully"

      File.open('./LibrarySystem/tables/borrowed','wb') do |f|

        f.write Marshal.dump(marshal_hash)

      end

    end

  end

  # is_book_out will only check if a book id is in the object booked. this means if it there
  # is simply checked out - not possible to be borrowed.
  #
  # @param borrowed      --> Marshal Dump object read in binary code - emulating a DB Table
  # @param bookid_key    --> an Integer which represent the book id
  #
  # @return true if found false if not found
  def is_book_out (borrowed,bookid_key)

    if  borrowed.has_key?(bookid_key)== true

      return true

    else

      return false

    end

  end

  # searchTitleAuthor use the CSV Api's --> Treat any index record
  # of the Array as single string
  #
  #
  # @param csv_filename  --> the actual file book.csv
  # @param titleAuthor   --> a string that match perfectly the title or the author of the book
  # @return the all record/s if a match/s is/are found as print on the screen
  def searchTitleAuthor (csv_filename,titleAuthor)

    # This make sure when printing the list from controller.rb it will
    # not print 2 -3 -4 times the same elements
    @books_in_stock.clear
    #keeps count of hits found
    count = 0
    puts "Search Result:"

    CSV.foreach(csv_filename, headers: true) do |row|

      @books_in_stock << Book.new(row["bookid"], row["title"],row["author"])

    end

    # in the loop that insert the record into array from the CSV file
    # each record is scanned for inclusion of text with down-case option
    # to avoid user mistakes and upper cases letters;
    # it is possible to find Authors or Book title or even id's if you like
    @books_in_stock.each_index{|i|

      if @books_in_stock[i].to_s.downcase().include?(titleAuthor.downcase())
        count = count +1
        puts "#{@books_in_stock[i]}"

      end

    }

    puts ""
    puts "Book/s Found: #{count}"
  end

  # search_out_for_member will list all the records associated to a member id in the borrowed Hash
  #
  #
  # @param borrowed      --> Marshal Dump object read in binary code - emulating a DB Table
  # @param memberid       --> an Integer which represent the member id requested from prompt in the Controller.rb Class
  #
  # @return all the record intersected with that member id
  def search_out_for_member(memberid,borrowed)

    borrowed.each_pair {|k,v| if "#{v[0][0]}".to_i == memberid

        puts "Book id: #{k}  is out for member: #{v[0][0]} due on  #{v[0][1]} "

      end
    }

  end

  # is_book_real use the CSV Api very well, fetch through the file and cross check with the book id
  # if found the hit ... book is real and is good to borrow...or check in.
  #
  # @param table  --> the actual file book.csv
  # @return true if not real (if the book does not exist) and false if it exists
  def is_book_real (table,bookid_value)

    search_criteria =  { 'bookid' => bookid_value}

    options = { :headers    => :first_row, :converters => [ :numeric ] }

    matches = nil
    headers = nil

    CSV.open( table, "r", options ) do |csv|

      matches = csv.find_all do |row|
        match = true
        search_criteria.keys.each do |key|
          match = match && ( row[key] == search_criteria[key] )
        end
        match
      end
      headers = csv.headers
    end

    #Checking if a Book exists - Negation of truth
    # just used a different way
    if  matches.any? == false
      return true
    else
      return false
    end

  end

  # is_member_real use the CSV Api very well, fetch through the file and cross check with the member id
  # if found the hit ... member can borrow or check in books.
  #
  # @param table  --> the actual file member.csv
  # @return true if not real (if the member does not exist) and false if it exists
  def is_member_real (table,memberid_value)

    search_criteria =  { 'memberid' => memberid_value}

    options = { :headers    => :first_row, :converters => [ :numeric ] }

    matches = nil
    headers = nil

    CSV.open( table, "r", options ) do |csv|

      matches = csv.find_all do |row|
        match = true
        search_criteria.keys.each do |key|
          match = match && ( row[key] == search_criteria[key] )
        end
        match
      end
      headers = csv.headers
    end

    #Checking if a Member exists
    if  matches.any? == false
      return true
    else
      return false
    end

  end

  # check_out will:
  #            1-  check if the member has already 3 books checked out - method each_pair and a counter will do
  #            2-  If member is good to borrow a book then the book id will be a new key for the Object Borrowed(Hash/Marshal)
  #            3-  Member id also will be recorded and the due date is automatically
  #                  calculated (today (60 seconds * 60 minutes * 24 hours * 7 days)) as an integer with to_i
  #            4-   then a stream of binary conversion is open with the Object in Memory borrowed and the entry is written and saved.
  #
  # @param borrowed         --> Marshal object is cloned into an Hash Map
  # @param bookid_key       --> an Integer which represent the book id
  # @param memberid_value   --> an Integer which represent the member id
  #
  # @return a message Book Successfully Assigned to member if all the steps above are succesfull
  def check_out (borrowed,memberid_value,bookid_key)

    count = 0

    borrowed.each_pair {|k,v|  if "#{v[0][0]}".to_i == memberid_value

        count = count +1

      end

    }

    if count >= 3

      puts "This Member has already 3 books out."
    else
      #If Yes Create an entry in the Marshal Object in Memory
      borrowed[bookid_key] = []

      borrowed[bookid_key] << [memberid_value,(Time.now + (60 * 60 * 24 * 7)).strftime("%Y%m%d").to_i]

      File.open('./LibrarySystem/tables/borrowed','wb') do |f|

        f.write Marshal.dump(borrowed)

      end

      puts "Book Successfully Assigned to member"

    end

  end

  #End Class
end

