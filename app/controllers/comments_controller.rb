class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_photo

  def create
    authorize! :create, Comment
    @comment = @photo.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to root_path
    else
      flash[:alert] = "Check the comment form, something went wrong."
      redirect_to root_path
    end
  end

  def destroy
    @comment = @photo.comments.find(params[:id])
    authorize! :destroy, @comment
    if @comment.user_id == current_user.id
      @comment.delete
        redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :rate)
  end

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end
