class PostsController < ApplicationController
  def index
    @posts = Post.all.decorate
  end
end
