class MemberEvent < ApplicationRecord
  belongs_to :member
  belongs_to :event

  enum attendance: { attendance: 0, midway_attendance: 1, absence: 2 }
end
