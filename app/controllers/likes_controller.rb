class LikesController < ApplicationController
  def create
    @micropost=Micropost.find(params[:micropost_id])
    unless @micropost.like?(current_user)
      @micropost.like(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @micropost=Like.find(params[:id]).micropost
    if @micropost.like?(current_user)
      @micropost.unlike(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
