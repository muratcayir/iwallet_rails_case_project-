class BooksController < ApplicationController
  include ActionController::MimeResponds
  before_action :authenticate_request!
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    @books = Book.all
    respond_to do |format|
      format.json { render json: @books }
      format.html # index.html.erb
    end
  end

  # GET /books/:id
  def show
    respond_to do |format|
      format.json { render json: @book }
      format.html # show.html.erb
    end
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.json { render json: @book, status: :created, location: @book }
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
      else
        format.json { render json: @book.errors, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /books/:id
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render json: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      endclass BooksController < ApplicationController
      include ActionController::MimeResponds
      before_action :authenticate_request!
      before_action :set_book, only: [:show, :update, :destroy]
    
      # GET /books
      def index
        @books = Book.all
        respond_to do |format|
          format.json { render json: @books }
          format.html # index.html.erb
        end
      end
    
      # GET /books/:id
      def show
        respond_to do |format|
          format.json { render json: @book }
          format.html # show.html.erb
        end
      end
    
      # POST /books
      def create
        @book = Book.new(book_params)
        respond_to do |format|
          if @book.save
            format.json { render json: @book, status: :created, location: @book }
            format.html { redirect_to @book, notice: 'Book was successfully created.' }
          else
            format.json { render json: @book.errors, status: :unprocessable_entity }
            format.html { render :new }
          end
        end
      end
    
      # PATCH/PUT /books/:id
      def update
        respond_to do |format|
          if @book.update(book_params)
            format.html { redirect_to @book, notice: 'Book was successfully updated.' }
            format.json { render json: @book }
          else
            format.html { render :edit }
            format.json { render json: @book.errors, status: :unprocessable_entity }
          end
        end
      end
    
      # DELETE /books/:id
      def destroy
        @book.destroy
        respond_to do |format|
          format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
          format.json { render json: { message: 'Book was successfully destroyed' }, status: :ok }
        end
      end
    
      private
    
      def set_book
        @book = Book.find(params[:id])
      end
    
      def book_params
        params.require(:book).permit(:title, :author, :publisher, :price)
      end
    end
    
    end
  end

  # DELETE /books/:id
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { render json: { message: 'Book was successfully destroyed' }, status: :ok }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :price)
  end
end
