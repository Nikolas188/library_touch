# frozen_string_literal: true

class Book
  include Validation

  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
    validate!
  end

  private

  def validate!
    validate_string(@title, 'title')
    validate_class(@author, Author, 'author')
  end
end
