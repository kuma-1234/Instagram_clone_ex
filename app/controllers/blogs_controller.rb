class BlogsController < ApplicationController
  before_action :limit_user, only:[:edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
    render :new
    else
      if @blog.save
      ContactMailer.contact_mail(@blog).deliver
        redirect_to blogs_path
      else
        render :new
      end
    end
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
      if @blog.update(blog_params)
        redirect_to blogs_path, notice: "投稿しました！"
      else
        render :edit
      end
  end

  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  private

  def blog_params
    params.require(:blog).permit(:content, :image, :image_cache)
  end

  def limit_user
    @blogs = current_user.blogs
    @blog = @blogs.find_by(id: params[:id])
    unless @blog == @blogs
      redirect_to blogs_path
    end
  end
end



