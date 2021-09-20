class BooksController < ApplicationController

 def index
    # Viewへ渡すためのインスタンス変数に空のモデルオブジェクトを生成する。
    @book = Book.new
    @books = Book.all
 end

 def create
    # １. データを新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
    # ３. show画面へリダイレクト
     redirect_to book_path(@book), notice: 'Book was successfully created.'
    else
     @books = Book.all
     render("books/index")
    end
 end

 def show
   @book = Book.find(params[:id])
 end

 def edit
   @book = Book.find(params[:id])
 end

 def update
    book = Book.find(params[:id])
    if book.update(book_params)
     redirect_to book_path(book.id), notice: 'Book was successfully updated.'
    else
     flash.now[:alert] = "error"
     @book = Book.find(params[:id])
     render :edit
    end
 end

 def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path, notice: 'Book was successfully destroyed.'
    else
     flash.now[:alert] = "error"
    end
 end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end


end
