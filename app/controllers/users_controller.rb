class UsersController < ApplicationController
  before_action :set_user
  
  before_action :authenticate_user!
  
  def profile
      @book = Book.new
      set_options
      @books = @user.books.where(status: 1)
      @buy_books = @user.books.where(status: 2)
    end
  
  def status0
    @book = Book.find(params[:id])
    respond(nil,0,"#{@book.title} was successfully unbooked.")
  end

  def buy
    @book = Book.find(params[:buy][:id])
    respond(current_user,2,"#{@book.title} was successfully bought.")
  end

  def loose
    @bookExample = Book.new
    @book = Book.find(params[:id])   
    respond(nil,0,"#{@book.title} was successfully returned and your money burned.")
  end

  def user_status
    @book = Book.find(params[:book][:id])
    respond(current_user,1,"#{@book.title} was successfully reserved.")
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  
  def set_book
    @book = Book.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_options 
    @book_options = Book.where(user_id: nil).pluck(:title, :id)   
    @buy_options = Book.where(user_id: current_user).where(status: 1).pluck(:title, :id)  
  end

  def respond(user, status, message)
    respond_to do |format|
      if @book.update(user: user, status: status)
        set_options
        @books = current_user.books.where(status: 1)
        @buy_books = current_user.books.where(status: 2)
        @message = message
        format.js { render nothing: true, notice: message }
        format.html { redirect_to @book, notice: message }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

end

