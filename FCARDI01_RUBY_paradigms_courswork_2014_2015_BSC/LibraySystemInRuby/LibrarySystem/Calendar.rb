#############################
#
#  Calendar Class by
#  @author Franco Cardinali
#  fcardi01
#  Ruby Version: 2.1.5p273
#  IDE: Eclipse IDE for Java Developers Release 1 (4.4.1)
#  Assignment valid for 25% mark of  Paradigms
#  5th Year Part Time of BCs in Computing
#  12-April-2015
#

#############################
class Calendar
  def initialize()

    @date =nil

  end

    # get_date is like an Oracle SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL;
    #
    # @param n/a
    #
    # @return Today's date a integer YYYYMMDD
  def get_date

    return Time.now.strftime("%Y%m%d").to_i

  end

  # advance Increment dynamically the date (move ahead)
  #
  # @param more_days  --> is an integer representing the due date desired from today
  #
  # @return the date in the future if more_day is then and today is 1 June --> 11 June will be the due date
  def advance (more_days)

    return  (Time.now + (60 * 60 * 24 * more_days)).strftime("%Y%m%d").to_i

  end

  def advance_oneday

    return  (Time.now + (60 * 60 * 24 * 1)).strftime("%Y%m%d").to_i

  end

  # difference_between_dates calculate the difference between two dates
  # and checks if is at least a week since has been checked in.
  # date.parse is expecting a string object therefore to_s for date differences and to_i as
  # boolean check .... absolutely flexible!!!!!
  #
  # @param duedate
  # @param today
  #
  # @return true if due date is today or in the past

  def difference_between_dates (duedate,today)

    if ((Date.parse(duedate.to_s) - Date.parse(today.to_s)).to_i <=0)

      return true
    else
      return false

    end

  end

end

