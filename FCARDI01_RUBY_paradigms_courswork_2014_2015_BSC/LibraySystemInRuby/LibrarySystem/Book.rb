###########################################################
#
#  Book Class by
#  @author Franco Cardinali
#  fcardi01
#  Ruby Version: 2.1.5p273
#  IDE: Eclipse IDE for Java Developers Release 1 (4.4.1)
#  Assignment valid for 25% mark of  Paradigms
#  5th Year Part Time of BCs in Computing
#  12-April-2015
#
###########################################################

# Library
require 'csv'

class Book

  # Convenient and more elegant  Short-cut to
  # create attribute methods access
  attr_reader :bookid, :title, :author
  def initialize(bookid, title,author)

    # instance variables
    @bookid = bookid
    @title = title
    @author = author
    @books_registred||= []

  end

  #Methos To String will be helpful in Printing

  def to_s

    "#{@bookid}   #{@title}   #{@author} "

  end

end