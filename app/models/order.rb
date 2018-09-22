# == Schema Info
#
# Table name: orders
#
# details                    text
# status                     string
# user_id                    integer                       foreign_key

class Order < ApplicationRecord
  belongs_to :user

  after_initialize :set_defaults

  validates :status, presence: true,
                     inclusion: { in: ["new", "attention", "complete"] }

  private

  def set_defaults
    self.status ||= "new"
  end
end
