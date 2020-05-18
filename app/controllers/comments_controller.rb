class CommentsController < ApplicationController
    before_action :set_micropost, only: %i[create destroy]

    def create
        @comment = @micropost.comments.build(comment_params)
        @comment.user_id = current_user.id
        @comment.save
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
    end


    private

    def set_micropost
        @micropost = Micropost.find(params[:micropost_id])
    end

    def comment_params
        params.require(:comment).permit(:content, :micropost_id, :user_id)
    end
end
