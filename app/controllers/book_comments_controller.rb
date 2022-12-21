class BookCommentsController < ApplicationController
      before_action :is_matching_login_user, only: [:destroy]

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:book_comment).permit(:comment)
  end

  def is_matching_login_user
    @user = BookComment.find(params[:id])
    user_id = @user.user_id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to request.referer
    end
  end
end
