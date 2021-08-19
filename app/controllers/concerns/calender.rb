module Calender
  extend ActiveSupport::Concern

  def generate_calender(change: 0)
    @date = Time.zone.today.next_month(change)
    @changed = change
    @calendar_data = from_date.upto(to_date)
    user_memo_update_ats
  rescue StandardError
    redirect_to root_path
  end

  private

  def from_date
    Date.new(@date.year, @date.month, @date.beginning_of_month.day).beginning_of_week(:sunday)
  end

  def to_date
    Date.new(@date.year, @date.month, @date.end_of_month.day).end_of_week(:sunday)
  end

  def user_memo_update_ats
    @user = params[:username].present? ? User.find_by!(username: params[:username]) : current_user
    @memo_updated_ats = @user.memos.select('date(updated_at) as date').group('date(updated_at)').complete
  end
end
