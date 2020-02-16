class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(body: params[:body], user: current_user)

    if comment.save
      flash[:alert] = "저장을 성공했습니다."
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "문제가 생겼습니다."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: root_path)
  end
end
