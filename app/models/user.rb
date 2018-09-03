require "bcrypt"

class User < ApplicationRecord
  include BCrypt

  before_save :hash_password

  validates :email, presence: true
  validates :password, presence: true

  def authenticate(password)
    unhashed_password == password
  end

  private

  def hash_password
    self.password = Password.create(password)
  end

  def unhashed_password
    Password.new(password)
  end
end
