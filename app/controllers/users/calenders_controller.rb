class Users::CalendersController < ApplicationController
  def calender
    @user = User.find_by!(username: params[:user_username])
    if params[:day].present?
      select_day
    elsif params[:month].present?
      select_month
    elsif params[:year].present?
      select_year
    else
      redirect_to memos_path
    end
  end

  def ajax
    @user = User.find_by!(username: params[:user_username])
    generate_calender(change: params[:change].to_i)
  end

  private
  def select_day
    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @memos = @user.memos.where(updated_at: date.in_time_zone.all_day)
  end

  def select_month
    date = Date.new(params[:year].to_i, params[:month].to_i)
    @memos = @user.memos.where(updated_at: date.in_time_zone.all_month)
  end

  def select_year
    date = Date.new(params[:year].to_i)
    @memos = @user.memos.where(updated_at: date.in_time_zone.all_year)
  end
end
