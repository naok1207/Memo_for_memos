module Calender
  extend ActiveSupport::Concern

  def generate_calender(change: 0)
    @date = Date.today.next_month(change)
    @changed = change
    from_date = Date.new(@date.year, @date.month, @date.beginning_of_month.day).beginning_of_week(:sunday)
    to_day = Date.new(@date.year, @date.month, @date.end_of_month.day).end_of_week(:sunday)
    @calendar_data = from_date.upto(to_day)
  end
end