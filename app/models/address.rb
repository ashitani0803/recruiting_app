class Address < ApplicationRecord
    belongs_to :company

    enum head_status: { head: 1, branch: 1}
end
