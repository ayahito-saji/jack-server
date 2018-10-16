class Event < ApplicationRecord
  has_many :member_events, dependent: :destroy
  has_many :member, through: :member_events
end
