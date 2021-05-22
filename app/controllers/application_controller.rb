class ApplicationController < ActionController::Base
  include Calender
  before_action :generate_calender
end
