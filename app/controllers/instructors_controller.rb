class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    #GET index
    def index
     instructor = Instructor.all
     render json: instructor

    end

    #CREATE create
    def create
     instructor = Instructor.create!(instructor_params)
     render json: instructor, status: :created
    end

    #PATCH update
    def update
      instructor = Instructor.find(id: params[:id])
      if instructor
        instructor.update!(instructor_params)
        render json: instructor
      else
        render json: {error: "Instructor not found"}, status: :not_found
      end
    end

    #DELETE destroy
    def destroy
      instructor = Instructor.find(params[:id])
      instructor.destroy
      head :no_content
    end

    private 

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: { error: "instructor not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
end
