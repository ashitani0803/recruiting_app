class Address < ApplicationRecord
    belongs_to :company

    geocoded_by :address

    after_validation :geocode

    enum head_status: { head: 0, branch: 1}
end
