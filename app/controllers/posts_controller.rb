class PostsController < ApplicationController
  before_action :block_if_authorized, except: [ :index ]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(session[:user_id])
    @post = @user.posts.new(post_params)

    if @post.save
      redirect_to root_path, notice: "Post created successfully."
    else
      flash[:error] = "Something went wrong."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.expect(post: [ :title, :body ])
  end
end
