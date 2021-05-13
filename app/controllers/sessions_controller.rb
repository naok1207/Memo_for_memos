class SessionsController < ApplicationController
  def new; end

  def create
    if @user = login(params[:login], params[:password], params[:remember])
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    forget_me!
    logout
    redirect_to root_path
  end
end
