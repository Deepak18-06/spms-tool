class Customer < ApplicationRecord
    has_many :quotations, dependent: :destroy
    accepts_nested_attributes_for :quotations,
                                allow_destroy: true
end
