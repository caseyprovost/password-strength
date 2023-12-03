require "rails_helper"

RSpec.describe User, type: :model do
  context "validations" do
    it "requires at least 1 lowercase letter" do
      user = User.new
      user.valid?
      expect(user.errors.messages_for(:password)).to include(User::LOWERCASE_MESSAGE)

      user.password = "a"
      user.valid?
      expect(user.errors.messages_for(:password)).to_not include(User::LOWERCASE_MESSAGE)
    end

    it "requires at least 1 uppercase letter" do
      user = User.new
      user.valid?
      expect(user.errors.messages_for(:password)).to include(User::UPPERCASE_MESSAGE)

      user.password = "A"
      user.valid?
      expect(user.errors.messages_for(:password)).to_not include(User::UPPERCASE_MESSAGE)
    end

    it "requires at least 1 symbol" do
      user = User.new
      user.valid?
      expect(user.errors.messages_for(:password)).to include(User::SYMBOL_MESSAGE)

      user.password = "&"
      user.valid?
      expect(user.errors.messages_for(:password)).to_not include(User::SYMBOL_MESSAGE)
    end

    it "requires at least 1 number" do
      user = User.new
      user.valid?
      expect(user.errors.messages_for(:password)).to include(User::NUMBER_MESSAGE)

      user.password = "1"
      user.valid?
      expect(user.errors.messages_for(:password)).to_not include(User::NUMBER_MESSAGE)
    end

    it "requires at least 12 characters" do
      user = User.new
      user.valid?
      expect(user.errors.messages_for(:password)).to include(User::LENGTH_MESSAGE)

      user.password = "abcdefghigklmnop"
      user.valid?
      expect(user.errors.messages_for(:password)).to_not include(User::LENGTH_MESSAGE)
    end

    it "requires no more than 2 consecutive identical characters" do
      user = User.new(password: "aaa")
      user.valid?
      expect(user.errors.messages_for(:password)).to include(User::IDENTICAL_MESSAGE)

      user.password = "aa"
      user.valid?
      expect(user.errors.messages_for(:password)).to_not include(User::IDENTICAL_MESSAGE)
    end

    it "requires no more than 2 sequential numbers" do
      user = User.new(password: "123")
      user.valid?
      expect(user.errors.messages_for(:password)).to include(User::SEQUENTIAL_MESSAGE)

      user.password = "12"
      user.valid?
      expect(user.errors.messages_for(:password)).to_not include(User::SEQUENTIAL_MESSAGE)
    end

    it "requires no more than 2 sequential letters" do
      user = User.new(password: "abc")
      user.valid?
      expect(user.errors.messages_for(:password)).to include(User::SEQUENTIAL_MESSAGE)

      user.password = "ab"
      user.valid?
      expect(user.errors.messages_for(:password)).to_not include(User::SEQUENTIAL_MESSAGE)
    end
  end
end
