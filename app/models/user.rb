require "bcrypt"

# address          string
# admin            boolean             null(false)
# bottom_fit       string
# city             string
# email            string              null(false)
# password         string              null(false)
# shoe_size        float
# state            string
# style            string
# top_size         string
# waist_size       integer

class User < ApplicationRecord
  include BCrypt

  after_initialize :set_defaults
  before_save :hash_password

  validates :admin, inclusion: { in: [true, false] }
  validates :bottom_fit, inclusion: %w(Skinny Straight Relaxed)
  validates :email, email: { strict: true }, presence: true,
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, presence: true
  validates :shoe_size, inclusion: [7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5]
  validates :style, inclusion: %w(Athletic Casual Formal Hipster Street)
  validates :top_size, inclusion: %w(SM MD LG XL)
  validates :waist_size, inclusion: { in: 28..40 }

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
