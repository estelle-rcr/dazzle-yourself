class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :my_comment, only: [:edit, :update, :destroy]


  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(user: current_user, post: @post, comment: params[:comment])

    if @comment.save
     redirect_to myproject_path(anchor: 'chat')
    else
     render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment: params[:comment])

    if @comment.save
      redirect_to myproject_path(anchor: 'chat')
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to myproject_path(anchor: 'chat')
  end

  private

  def my_comment
    @comment = Comment.find(params[:id])
    unless current_user == @comment.user
      flash[:error] ="Vous n'êtes pas autorisé à consulter cette page"
      redirect_to myproject_path(anchor: 'chat')
    end
  end

end



