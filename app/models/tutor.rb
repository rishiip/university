class Tutor < ApplicationRecord
  belongs_to :course

  validates :name, :email, :qualification, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates_format_of :phone, with: /\+?\d[\d -]{8,12}\d/, allow_blank: true
  validates_numericality_of :age, less_than_or_equal_to: 100, greater_than: 18, allow_blank: true
  validates :sex, inclusion: { in: %w(m f) }, allow_blank: true
end
