class Discount < ApplicationRecord
  belongs_to :merchant

  validates :percentage, :quantity, presence: true
end