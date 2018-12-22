class Product < ApplicationRecord
  validates :name,{presence: true, length: {maximum: 30}}
  validates :content,{presence:true, length: {maximum: 3000}}
  has_many :member_products, dependent: :destroy
  has_many :members, through: :member_products
end
