class PostsController < ApplicationController
  def index
    posts = Post.all
    @posts_presenter = PostPresenter.wrap(posts, view_context)
  end
end
