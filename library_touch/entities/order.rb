# frozen_string_literal: true

class Order
  include Validation

  attr_reader :book, :reader, :date

  def initialize(book, reader, date)
    @book = book
    @reader = reader
    @date = Date.parse(date)
    validate!
  end

  private

  def validate!
    validate_class(@book, Book, 'book')
    validate_class(@reader, Reader, 'reader')
  end
end
