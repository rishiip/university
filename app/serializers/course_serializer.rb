class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :published_at, :fee
  has_many :tutors, serializer: TutorCourseSerializer
end
