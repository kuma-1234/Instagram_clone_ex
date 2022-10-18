class BlogsController < ApplicationController

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
    unless @blog.user_id == current_user.id
      redirect_to blogs_path
    end
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.user_id != current_user.id
      redirect_to blogs_path
    else
      if @blog.update(blog_params)
        redirect_to blogs_path, notice: "投稿しました！"
      else
        render :edit
      end
    end
  end

  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def destroy
    @blog = Blog.find(params[:id])
    if @blog.user_id != current_user.idq
      redirect_to blogs_path
    else
      @blog.destroy
      redirect_to blogs_path, notice: "ブログを削除しました！"
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:content, :image, :image_cache)
  end
end