# Seed database with course and associated tutors from here

Course.destroy_all if Course.any?

courses = %w(BCOM BBA BCA BA MCOM MBA MCA MA)

courses.each do |title|
  puts "Creating course with tutors - #{title}"
  FactoryBot.create(:course, :with_tutors, title: title)
end
