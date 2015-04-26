#############################
#
#  TestLibrary Class by
#  @author Franco Cardinali
#  fcardi01
#  Ruby Version: 2.1.5p273
#  IDE: Eclipse IDE for Java Developers Release 1 (4.4.1)
#  Assignment valid for 25% mark of  Paradigms
#  5th Year Part Time of BCs in Computing
#  12-April-2015
#

#############################

require'test/unit'
require 'csv'

require_relative 'Library'

class TestLibrary < Test::Unit::TestCase
  def setup
    @books_in_stock ||= []
    @members_registred||= []
    @test_Library = Library.new()
  end

  def test_is_book_real

    book_table = "./LibrarySystem/tables/books.csv"
    actual = @test_Library.is_book_real(book_table,1)
    # Reverse checking: if false means that the book is existing ->
    # if  matches.any? == false (is the boo kid not existing? ...false IT EXISTS)
    # id 1 does  exist in my book.csv
    expected = false

    actual_2 = @test_Library.is_book_real(book_table,42)
    # Reverse checking: if false means that the book is existing ->
    # if  matches.any? == false (is the book id not existing? ...false IT EXISTS)
    # id 42 does not exist in my book.csv

    expected_2 = true

    assert_equal(expected, actual, "Book-id 1 is the in the list of books: #{expected}")
    assert_equal(expected_2, actual_2, "Book-id 42 is not the in the list of books: #{expected_2}")

  end

  # This Test make sure that passing specifics member id and referring
  # to the actual Live CSV file checks if the member exists or not
  def test_is_member_real

    member_table = "./LibrarySystem/tables/members.csv"

    actual = @test_Library.is_member_real(member_table,1)
    # Reverse checking: if false means that the member is existing ->
    # if  matches.any? == false (is the member id not existing? ...false IT EXISTS)
    # id 1 does  exist in my book.csv
    expected = false

    actual_2 = @test_Library.is_member_real(member_table,1001)
    # Reverse checking: if false means that the member is existing ->
    # if  matches.any? == false (is the member id not existing? ...false IT EXISTS)
    # id 1001 does not exist in my book.csv
    expected_2 = true

    assert_equal(expected, actual, "member-id 1 is the in the list of member: #{expected}")

    assert_equal(expected_2, actual_2, "member-id 1001 is not the in the list of member: #{expected_2}")

  end

  # This Test make sure that passing specifics bookid and referring to the
  # actual Live marshal dumped file (transformed into Hash Map)
  # file checks if the book is borrowed
  def test_is_book_out

    borrowed = {8=>[[2, 20150315]],5=>[[3, 20150308]]}

    expected = true
    actual = @test_Library.is_book_out(borrowed,5)

    expected_2 = false
    actual_2 = @test_Library.is_book_out(borrowed,11)

    borrowed_empty ={}
    expected_3 = false
    actual_3 = @test_Library.is_book_out(borrowed_empty,1)

    assert_equal(expected,actual, " Book id 1 is booked #{expected}")

    assert_equal(expected_2,actual_2, " Book id 11 is not booked #{expected_2}")

    assert_equal(expected_3,actual_3, " Book id 1 is not booked as the hash is empty #{expected_3}")

  end

end

