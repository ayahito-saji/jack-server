class MemberEvent < ApplicationRecord
  belongs_to :member
  belongs_to :event
end