#############################
#
#  TestCalendar Class by
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
require'date'
require_relative 'Calendar'

class TestCalendar < Test::Unit::TestCase

  @date
  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @today = (Time.now.strftime("%Y%m%d")).to_i
    @tomorrow = (Time.now + (60 * 60 * 24 * 1)).strftime("%Y%m%d").to_i
    @one_week = (Time.now + (60 * 60 * 24 * 7)).strftime("%Y%m%d").to_i
    @ten_days = (Time.now + (60 * 60 * 24 * 10)).strftime("%Y%m%d").to_i
    @test_calendar = Calendar.new()
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  # TESTING get_date WHICH WILL RETURN TODAY DATE
  def test_get_date

    expected = @today
    actual = @test_calendar.get_date()

    assert_equal(expected, actual, "Today Date Should Be: #{expected}")
  end

  # TESTING test_advance_oneday WHICH WILL RETURN TODAY DATE  + 1
  def test_advance_oneday

    expected = @tomorrow
    actual = @test_calendar.advance_oneday()

    assert_equal(expected, actual, "Date Should Be by 1 date: #{expected}")
  end

  # TESTING advance WHICH WILL RETURN TODAY DATE  + 7
  def test_advance

    expected = @one_week
    actual = @test_calendar.advance(7)

    assert_equal(expected, actual, "Date Should Be advanced by 7 days: #{expected}")
  end

  # This test_method is testing the difference_between_dates  catching if the "book"  has not been
  # # returned yet after 7 days
  def test_difference_between_dates

    expected_negative = false
    expected_positive =true

    duedate =@ten_days
    today =@today
    tomorrow =@tomorrow

    # Testing False -> Book Not Due Yet as it is 10 days in the future
    actual =@test_calendar.difference_between_dates(duedate,today)

    # Testing False -> Book Not Due Yet as it is 1 day in the future
    actual_negative = @test_calendar.difference_between_dates(tomorrow,today)

    # Testing True -> Book Not Due Yet as it is today
    actual_positive = @test_calendar.difference_between_dates(today,today)

    assert_equal(expected_negative, actual, "Difference Should Be Greater than 6: #{expected_positive}")

    assert_equal(expected_negative, actual_negative, "Difference is one day  1: #{expected_negative}")

    assert_equal(expected_positive, actual_positive, "Book is due today: #{expected_positive}")

  end
end

