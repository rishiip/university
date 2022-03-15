module Api
  module V1
    class CoursesController < ApplicationController
      def index
        @courses = Course.includes(:tutors).paginate(page: params.dig(:page) || PAGE, per_page: PER_PAGE) || []
        render json: @courses, status: :ok
      end

      def show
        @course = Course.find(params[:id]) rescue {}
        render json: @course, status: :ok
      end

      def create
        @course = Course.new(course_params)

        if @course.save
          render json: @course, status: :created
        else
          render json: @course.errors.full_messages, status: :unprocessable_entity
        end
      end

      private
      def course_params
        params.require(:course).permit(:title, :description, :published_at, :fee,  tutors_attributes: [:name, :phone, :email, :qualification, :age, :sex])
      end
    end
  end
end
