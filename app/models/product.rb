class Product < ApplicationRecord
  validates :name,{presence: true, length: {maximum: 30}}
  validates :content,{presence:true, length: {maximum: 3000}}
end
