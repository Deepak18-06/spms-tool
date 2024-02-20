class Customer < ApplicationRecord
    has_many :quotations, dependent: :destroy
end
