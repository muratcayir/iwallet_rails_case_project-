class BooksController < ApplicationController
    before_action :set_book, only: [:show, :update, :destroy]
  
    # Tüm kitapların listelenmesi
    def index
      @books = Book.all
      render json: @books
    end
  
    # Belirli bir kitabın detaylarının gösterilmesi
    def show
      render json: @book
    end
  
    # Yeni bir kitabın eklenmesi
    def create
      @book = Book.new(book_params)
  
      if @book.save
        render json: @book, status: :created
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end
  
    # Mevcut bir kitabın güncellenmesi
    def update
      if @book.update(book_params)
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end
  
    # Mevcut bir kitabın silinmesi
    def destroy
      @book.destroy
    end
  
    private
  
    # İlgili kitabı bulmak için kullanılan yardımcı metod
    def set_book
      @book = Book.find(params[:id])
    end
  
    # Kitap oluşturma/güncelleme işlemleri için izin verilen parametreler
    def book_params
      params.require(:book).permit(:title, :description, :price, :stock)
    end
  end
  
