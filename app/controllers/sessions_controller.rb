class SessionsController < ApplicationController
  before_action :unblock_if_authorized, only: [ :new, :create ]
  before_action :get_email_and_password, only: [ :create ]

  def new
  end

  def create
    @user = User.find_by_email(@email)

    if @user && @user.authenticate(@password)
      session[:user_id] = @user.id
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

  private

  def get_email_and_password
    @email = params[:email]
    @password = params[:password]

    if @email.blank? || @password.blank?
      flash.now[:error] = "Email and password cannot be empty."
      render :new, status: :unprocessable_entity
    end
  end
end
