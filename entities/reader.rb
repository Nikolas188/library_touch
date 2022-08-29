# frozen_string_literal: true

class Reader
  include Validation

  attr_reader :name, :email, :city, :street, :house

  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @street = street
    @city = city
    @house = house
    validate!
  end

  private

  def validate!
    validate_string(@name, 'name')
    validate_string(@email, 'email')
    validate_string(@street, 'street')
    validate_number(@house, 'house')
    validate_positive(@house, 'house')
    validate_string(@city, 'city')
  end
end
