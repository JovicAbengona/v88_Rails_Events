class CommentsController < ApplicationController
  def create
    comment = current_user.comments.new(event: Event.find(params[:id]), content: comment_params[:content])
    if !comment.save
      flash[:add_comment_error] = comment.errors.messages
    end
    redirect_to "/events/#{params[:id]}"
  end

  private
    def comment_params
        params.require(:comment).permit(:content)
    end
end
