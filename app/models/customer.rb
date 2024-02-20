class Customer < ApplicationRecord
    has_many :quotations, dependent: :destroy
    validates :first_name, :phone, :email, presence: true
    validates :phone, length: { minimum: 10, maximum: 14 }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
    accepts_nested_attributes_for :quotations, allow_destroy: true
end
