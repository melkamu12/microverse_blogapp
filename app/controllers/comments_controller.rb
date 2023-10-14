class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:id])
    @comment = @post.comments.build(comment_params.merge(user_id: @user))
    puts "Comment parameters: #{comment_params.inspect}"
    puts "Comment: #{@comment.inspect}"

    if @comment.save
      redirect_to @post
    else
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
