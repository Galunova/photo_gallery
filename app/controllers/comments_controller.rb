class CommentsController < ApplicationController
  before_action :set_photo

  def index
    @comments = @photo.comments.order("created_at ASC")

    respond_to do |format|
      format.html { render 'comments/index' }
    end
  end

  def create
    @comment = @photo.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to root_path
    else
      flash[:alert] = "Check the comment form, something went wrong."
      render root_path
    end
  end

  def destroy
    @comment = @photo.comments.find(params[:id])

    if @comment.user_id == current_user.id
      @comment.delete
			redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end

