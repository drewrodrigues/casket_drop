# == Schema Info
#
# Table name: users
#
# address                    string
# admin                      boolean             not null
# bottom_fit                 string
# city                       string
# current_period_end         date
# email                      string              not null
# favorite_bottoms           [string]
# favorite_colors            [string]
# favorite_tops              [string]
# id                         integer             not null, primary key
# password                   string              not null
# state                      string
# stripe_id                  string
# subscribed                 boolean
# top_size                   string
# waist_size                 integer

class User < ApplicationRecord
  include Passwordable
  include Stripeable

  after_initialize :set_defaults
  before_save :hash_password

  validates :admin, inclusion: { in: [true, false] }
  validates :bottom_fit, presence: { message: "must be selected" }
  validates :email, email: { strict: true }, presence: true,
                    uniqueness: { case_sensitive: false }
  validate :favorites_selected
  validates :password, length: { minimum: 8 }, presence: true
  validates :top_size, presence: { message: "must be selected" }
  validates :waist_size, inclusion: { in: 28..36, message: "must be selected" }

  private

  def set_defaults
    self.admin ||= false
  end

  def favorites_selected
    %i(favorite_bottoms favorite_colors favorite_tops).each { |c| selection?(c) }
  end

  def selection?(column)
    errors.add(column, "must be selected") unless send(column).uniq.length > 1
  end
end
