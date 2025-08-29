class SessionsController < ApplicationController
  before_action :unauthorize, only: [ :new, :create ]

  def new
  end

  def create
    email = params[:email]
    password = params[:password]

    if email.blank? || password.blank?
      flash.now[:alert] = "Email and password cannot be empty."
      render :new, status: :unprocessable_entity
      return
    end

    user = User.find_by_email(email)

    if user && user.authenticate(password)
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in!"
    else
      flash.now[:error] = "Email or password is invalid."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
