#############################
#
#  Member Class by
#  @author Franco Cardinali
#  fcardi01
#  Ruby Version: 2.1.5p273
#  IDE: Eclipse IDE for Java Developers Release 1 (4.4.1)
#  Assignment valid for 25% mark of  Paradigms
#  5th Year Part Time of BCs in Computing
#  12-April-2015
#

#############################

# Library required
require 'csv'

# Printing

class Member

  # Convenient and more elegant  Short-cut to
  # create attribute methods access
  attr_reader :memberid, :name, :library
  def initialize(memberid, name,library)

    # instance variables
    @memberid = memberid
    @name = name
    @library = library
    @members_registred||= []

  end

  def to_s

    "#{@memberid}  #{@name}  #{@library}"
  end

  # add_member use the CSV Api's --> inserting a new member in the system emulating the
  # membership card issuing.
  #
  # @param csv_filename  --> the actual file member.csv
  # @return nothing on screen ... but creates a record in the csv file and SAVES it.
  def add_member (csv_filename,memberid )

    puts "Name: "
    @name = gets.chomp

    puts "Library: "
    @library = gets.chomp

    CSV.open(csv_filename,"a+")   do |row|
      row << [memberid,@name,@library]
    end

  end

end