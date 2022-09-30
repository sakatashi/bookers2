class UsersController < ApplicationController
   before_action :ensure_current_user,{only:[:edit,:update]}
      before_action :search
 def ensure_current_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
 end
  def search
    # params[:q]のqには検索フォームに入力した値が入る
    @q = User.ransack(params[:q])
  end

  def index
    @users = User.all
    @users = @q.result(distinct: true)
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user!= current_user
        redirect_to user_path(current_user)
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] = "You have updated user successfully."
     redirect_to user_path(@user.id)
    else
     render :edit
    end
  end


     private
 def user_params
  params.require(:user).permit(:name,:introduction,:profile_image)
 end
end
