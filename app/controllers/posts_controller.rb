class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @project = current_user.ongoing_project[0]
    @posts = Post.all.order("created_at DESC")
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @project = current_user.ongoing_project[0]
    @post = Post.new(user: current_user, project: @project, title: params[:title], content: params[:content])

    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end

  end

  def edit
  end

  def update
    @post.update(title: params[:title], content: params[:content])
    if @post.save
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path

  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

end
