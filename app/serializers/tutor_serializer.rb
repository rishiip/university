class TutorSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :email, :qualification, :age, :sex
  belongs_to :course, serializer: TutorCourseSerializer
end
