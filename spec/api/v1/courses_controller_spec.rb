require 'rails_helper'

RSpec.describe "API V1 Courses", type: 'request' do
  let(:headers) { { 'HTTP_AUTHORIZATION': ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin') } }

  it 'should give unauthorization error if headers are not passed' do
    get '/api/v1/courses'
    expect(response.status).to eq(401)
  end

  describe "POST /api/v1/courses" do
    let(:course_params) do
      { course: FactoryBot.build(:course).as_json(only: %i[title description published_at fee]) }.with_indifferent_access
    end

    context "with valid parameters" do
      it "creates a new course" do
        expect { post "/api/v1/courses", headers: headers, params: course_params }.to change(Course, :count).by(+1)
        expect(response).to have_http_status :created
        expect(Course.last.title).to eq(course_params['course']['title'])
      end

      it "creates a new course with tutors" do
        tutor_count = rand(1..5)
        tutor_params = (1..tutor_count).collect { |i| FactoryBot.build(:tutor).as_json(except: %i[id created_at updated_at course_id]) }
        course_params[:course].merge!({ tutors_attributes: tutor_params })

        expect { post "/api/v1/courses", headers: headers, params: course_params }.to change(Course, :count).by(+1)
        expect(response).to have_http_status :created
        expect(Course.last.title).to eq(course_params['course']['title'])

        tutors = Course.last.tutors
        expect(tutors.count).to eq(tutor_count)
        expect(tutors.pluck(:name)).to eq(tutor_params.collect{ |t| t['name'] })
      end
    end

    context "with invalid parameters" do
      it "will not create a new course" do
        course_params[:course].delete(:title)
        post "/api/v1/courses", headers: headers, params: course_params
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)).to eq(["Title can't be blank"])
      end

      it "will not create a new course with tutors" do
        invalid_tutor_params = [ FactoryBot.build(:tutor).as_json(except: %i[id created_at updated_at course_id name]) ]
        course_params[:course].merge!({ tutors_attributes: invalid_tutor_params })

        post "/api/v1/courses", headers: headers, params: course_params
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)).to eq(["Tutors name can't be blank"])
      end
    end
  end

  describe "GET /api/v1/courses" do
    context "List all courses" do
      it "List all courses with tutors" do
        course = FactoryBot.create(:course, :with_tutors)
        get "/api/v1/courses", headers: headers
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body).first['title']).to eq(course.title)
      end
    end
  end
end
