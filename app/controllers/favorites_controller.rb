class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.create(blog_id: params[:blog_id])
    redirect_to blogs_path
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to blogs_path
  end

  def show
    @favorites = Favorite.where(user_id: current_user.id)
  end

end
