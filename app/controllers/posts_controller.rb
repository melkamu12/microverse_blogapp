class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_current_user, only: %i[new create destroy]

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(params.require(:post).permit(:title, :text))
    @post.author_id = current_user.id

    if @post.save
      flash[:notice] = 'Succesfully Post'
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  def destroy
    @post = @user.posts.find(params[:id])

    if @post
      begin
        @post.comments.destroy_all
        @post.likes.destroy_all
        if @post.destroy
          flash.now[:success] = "Your post titled: '#{@post.title}' was successfully deleted"
        else
          flash.now[:error] = 'Oops! Cannot delete your post.'
        end
      rescue StandardError => e
        flash.now[:error] = "An error occurred: #{e.message}"
      end
    else
      flash.now[:error] = 'Post not found.'
    end

    redirect_to user_posts_path(@user)
  end

  private

  def set_current_user
    @user = current_user
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
