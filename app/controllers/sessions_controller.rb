class SessionsController < ApplicationController
  def login
    if params[:username] == 'admin' && params[:password] == 'admin'
      cookies.permanent[:user] = 'admin'
    elsif params[:username] == 'user' && params[:password] == 'user'
      cookies.permanent[:user] = 'user'
    else
      flash[:error] = 'Incorrect username / password'
    end

    redirect_to :root
  end

  def logout
    cookies.delete(:user)
    redirect_to :root
  end
end
