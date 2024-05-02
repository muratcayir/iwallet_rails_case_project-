require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is valid with all attributes' do
    book = Book.new(title: 'Sample Book', author: 'Author Name', publisher: 'Publisher Name', price: 25.99)
    expect(book).to be_valid
  end

  it 'is invalid without a title' do
    book = Book.new(author: 'Author Name', publisher: 'Publisher Name', price: 25.99)
    expect(book).to_not be_valid
  end

  it 'is invalid without an author' do
    book = Book.new(title: 'Sample Book', publisher: 'Publisher Name', price: 25.99)
    expect(book).to_not be_valid
  end

  it 'is invalid without a publisher' do
    book = Book.new(title: 'Sample Book', author: 'Author Name', price: 25.99)
    expect(book).to_not be_valid
  end

  it 'is invalid without a price' do
    book = Book.new(title: 'Sample Book', author: 'Author Name', publisher: 'Publisher Name')
    expect(book).to_not be_valid
  end

  it 'is invalid with a negative price' do
    book = Book.new(title: 'Sample Book', author: 'Author Name', publisher: 'Publisher Name', price: -1)
    expect(book).to_not be_valid
  end

  it 'is valid with a price of zero' do
    book = Book.new(title: 'Sample Book', author: 'Author Name', publisher: 'Publisher Name', price: 0)
    expect(book).to be_valid
  end
end
