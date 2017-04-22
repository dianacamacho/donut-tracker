class Vendor < ApplicationRecord
  has_many :user_vendors, dependent: :destroy
  has_many :users, through: :user_vendors
end
