class PostsController < ApplicationController
  def index
    @posts = Post.search(params[:search])
  end
end
