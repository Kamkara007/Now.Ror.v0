class HomeController < ApplicationController
  def index
    @posts = Post.ordered_by_most_recent #feed for creator
  end
end
