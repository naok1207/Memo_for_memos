class MemosController < ApplicationController
  def index
    @memos = current_user.memos.title_asc
  end

  def calender
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

  def select_day
    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @memos = current_user.memos.where(updated_at: date.in_time_zone.all_day)
  end

  def select_month
    date = Date.new(params[:year].to_i, params[:month].to_i)
    @memos = current_user.memos.where(updated_at: date.in_time_zone.all_month)
  end

  def select_year
    date = Date.new(params[:year].to_i)
    @memos = current_user.memos.where(updated_at: date.in_time_zone.all_year)
  end
end
