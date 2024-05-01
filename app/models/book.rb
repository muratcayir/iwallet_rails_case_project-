class Book < ApplicationRecord
    validates :title, presence: true
    validates :author, presence: true
    validates :publisher, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    has_many :cart_items
  end
  