class User < ApplicationRecord
  REQUIRED_PASSWORD_LENGTH = 12
  LENGTH_MESSAGE = "is too short, must be at least #{REQUIRED_PASSWORD_LENGTH} characters long"
  LOWERCASE_MESSAGE = "must include at least 1 lowercase letter"
  UPPERCASE_MESSAGE = "must include at least 1 uppercasecase letter"
  NUMBER_MESSAGE = "must include at least 1 number"
  SYMBOL_MESSAGE = "must include at least 1 symbol"
  IDENTICAL_MESSAGE = "cannot include 3 or more identical characters"
  SEQUENTIAL_MESSAGE = "cannot include 3 or more sequential characters"

  has_secure_password validations: false

  validates :email, presence: true
  validates :password, length: {minimum: REQUIRED_PASSWORD_LENGTH, message: LENGTH_MESSAGE}
  validates :password, format: {with: /[a-z]/, message: LOWERCASE_MESSAGE}
  validates :password, format: {with: /[A-Z]/, message: UPPERCASE_MESSAGE}
  validates :password, format: {with: /[0-9]/, message: NUMBER_MESSAGE}
  validate :validate_password_has_symbols
  validate :validate_password_has_no_identical_characters
  validate :validate_password_has_no_sequential_characters

  private

  def validate_password_has_symbols
    special = "?<>',?[]}{=-)(*&^%$#`~{}"
    regex = /[#{special.gsub(/./) { |char| "\\#{char}" }}]/

    return if password.to_s&.match?(regex)

    errors.add(:password, SYMBOL_MESSAGE)
  end

  def validate_password_has_no_identical_characters
    return unless password.to_s.chars.each_cons(3).map { |a, b, c| a == b && b == c }.any?

    errors.add(:password, IDENTICAL_MESSAGE)
  end

  def validate_password_has_no_sequential_characters
    if password_has_sequential_numbers? || password_has_sequential_letters?
      errors.add(:password, SEQUENTIAL_MESSAGE)
    end
  end

  def password_has_sequential_numbers?
    password.to_s.chars.each_cons(3).map do |a, b, c|
      b.to_i == (a.to_i + 1) && c.to_i == (b.to_i + 1)
    end.any?
  end

  def password_has_sequential_letters?
    letters = ("a".."z").to_a

    password.to_s.chars.each_cons(3).map do |a, b, c|
      letters.index(b).to_i == (letters.index(a).to_i + 1) &&
        letters.index(c).to_i == (letters.index(b).to_i + 1)
    end.any?
  end
end
