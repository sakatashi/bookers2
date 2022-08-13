class BooksController < ApplicationController
 before_action :ensure_current_user,{only:[:edit,:update]}

def ensure_current_user
  @book = Book.find(params[:id])
   if @book.user.id != current_user.id
   redirect_to books_path
   end
end

 def index
 @books = Book.all
 @book = Book.new
 @user =current_user
 end

 def create
 @book = Book.new(book_params)
 @book.user_id = current_user.id
 @book.save
 redirect_to book_path(@book.id)
 end

def show
 @book = Book.find(params[:id])
 @user =@book.user
 @book_new = Book.new
end

def edit
 if current_user
 @book = Book.find(params[:id])
 end
end

def update
 @book = Book.find(params[:id])
 if @book.update(book_params)
  redirect_to book_path(@book.id)
 else
  render :edit
 end
end

def destroy
 @book = Book.find(params[:id])
 @book.destroy
 redirect_to books_path
end

 private
 def user_params
  params.require(:user).permit(:name,:introduction,:profile_image)
 end
 def book_params
  params.require(:book).permit(:title,:body)
 end
end
