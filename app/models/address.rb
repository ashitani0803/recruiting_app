class Address < ApplicationRecord
    belongs_to :company

    enum head_status: { head: 0, branch: 1}
end
