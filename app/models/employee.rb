class Employee < ApplicationRecord
    validates :email, presence: :true

    paginates_per 5

    has_one_attached :avatar
end
