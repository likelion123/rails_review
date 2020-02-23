class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.publish
  end

  def new
  end

  def create
    post = Post.new(title: params[:title], content: params[:content], user: current_user)

    if post.save
      flash[:alert] = "성공적으로 저장했습니다."
      redirect_to post_path(post)
    else
      flash[:error] = "저장을 실패했습니다."
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])

    if post.update(title: params[:title], content: params[:content])
      flash[:alert] = "수정을 성공했습니다."
      redirect_to post_path(post)
    else
      flash[:error] = "수정을 실패했습니다."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy

    redirect_to posts_path
  end
end
