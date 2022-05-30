class Tenant < ApplicationRecord
    has_many :leases
    has_many :apartments, through: :leases
    validates :name, presence: true
    validate :must_be_18

    def must_be_18
        if age.to_i < 18
            errors.add(:age, 'Tenant must be at least 18!')
        end
    end
end
