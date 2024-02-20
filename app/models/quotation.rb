class Quotation < ApplicationRecord
  belongs_to :customer
  validates :attachment, :date, presence: true
  has_one_attached :attachment
end
