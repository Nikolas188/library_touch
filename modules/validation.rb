# frozen_string_literal: true

module Validation
  def validate_string(value, name)
    validate_class(value, String, name)
  end

  def validate_number(value, name)
    validate_class(value, Integer, name)
  end

  def validate_class(object, class_name, argument_name)
    raise ArgumentError, "#{argument_name} is not an object of class #{class_name}" unless object.is_a?(class_name)
  end

  def validate_positive(value, name)
    raise ArgumentError, "#{name} must be positive" if value <= 0
  end
end
