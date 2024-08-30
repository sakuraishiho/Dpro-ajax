# app/controllers/favorites_controller.rb
class FavoritesController < ApplicationController
  before_action :find_blog

  def create
    @favorite = @blog.favorites.create(user: current_user)
    respond_to do |format|
      format.html { redirect_to @blog }
      format.js   # create.js.erb を呼び出す
    end
  end

  def destroy
    @favorite = @blog.favorites.find_by(user: current_user)
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to @blog }
      format.js   # destroy.js.erb を呼び出す
    end
  end

  private

  def favorit_params
    params.require(:favorite).permit(:description, :blog_id)
  end

  def find_blog
    @blog = Blog.find(params[:blog_id])
  end
end

class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @blog = Blog.find(params[:blog_id])
    @favorite = current_user.favorites.create(blog: @blog)

    respond_to do |format|
      format.js   # app/views/favorites/create.js.erb
      format.html { redirect_to blogs_path, notice: 'Blog was favorited.' }
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @blog = @favorite.blog
    @favorite.destroy

    respond_to do |format|
      format.js   # app/views/favorites/destroy.js.erb
      format.html { redirect_to blogs_path, notice: 'Favorite was removed.' }
    end
  end

  def favorit_params
    params.require(:favorite).permit(:description, :blog_id)
  end

  def find_blog
    @blog = Blog.find(params[:blog_id])
  end
end