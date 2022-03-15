class Course < ApplicationRecord
  has_many :tutors, dependent: :destroy
  accepts_nested_attributes_for :tutors

  validates :title, :fee, presence: true
  validates_numericality_of :fee, greater_than: 0
end
