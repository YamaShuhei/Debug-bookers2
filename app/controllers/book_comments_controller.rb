class BookCommentsController < ApplicationController
      before_action :is_matching_login_user, only: [:destroy]

  def create
    book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(comment_params)
    @book_comment.book_id = book.id
    unless @book_comment.save
      render 'error'
    end
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    @book_comment = BookComment.new

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
