class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_post,only: [:edit,:new,:create,:update,:destroy,]

  def index
    @posts = Post.all.order(id: "DESC")
    
  end

  def new
    @post=Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
    redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def correct_post
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
     redirect_to posts_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end
end
