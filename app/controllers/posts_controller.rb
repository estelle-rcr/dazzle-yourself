class PostsController < ApplicationController


  def index
    @project = current_user.ongoing_project[0]
    @posts = Post.all.order("created_at DESC")
  end

  def show
@post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @project = current_user.ongoing_project[0]
    @post = Post.new(user: current_user, project: @project, title: params[:title], content: params[:content])

    if @post.save
      redirect_to myproject_path(anchor: 'chat')
    else
      render 'new'
    end

  end

  def edit
@post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(title: params[:title], content: params[:content])
    if @post.save
      redirect_to myproject_path(anchor: 'chat')
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to myproject_path(anchor: 'chat')

  end



end
