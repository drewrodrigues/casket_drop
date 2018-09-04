require "bcrypt"

class User < ApplicationRecord
  include BCrypt

  after_initialize :set_defaults
  before_save :hash_password

  validates :admin, inclusion: { in: [true, false] }
  validates :email, email: { strict: true }, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, presence: true

  def authenticate(password)
    unhashed_password == password
  end

  private

  def hash_password
    self.password = Password.create(password) unless password_already_hashed?
  end

  def unhashed_password
    Password.new(password)
  end

  def password_already_hashed?
    Password.valid_hash?(password)
  end

  def set_defaults
    self.admin ||= false
  end
end
