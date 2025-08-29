class UsersController < ApplicationController
  before_action :unauthorize, only: [ :new, :create ]
  
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Thank you for signing up!"
    else
      flash.now[:error] = "Something went wrong"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :username, :email, :password, :password_confirmation ])
  end
end
