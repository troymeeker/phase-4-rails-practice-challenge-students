class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

   #GET index
   def index
    student = Student.all
    render json: student

   end

   #CREATE create
   def create
    student = Student.create!( student_params)
    render json: student, status: :created
   end
   # must be associated w/ an instructor

   #PATCH update
   def update
    student = Student.find(params[:id])
    if student
        student.update(student_params)
        render json: student
    else
        render json: {error: "Student not found"}, status: :not_found
    end

   end
   #must be associated w/ an instructor

   #DELETE destroy
   def destroy
    student = Student.find(params[:id])
    student.destroy
    head :no_content
   end

   private 

   def student_params
    params.permit(:name, :age, :major, :instructor_id)
   end
   
   def render_not_found_response
    render json: { error: "Student not found"}, status: :not_found
   end

   def render_unprocessable_entity_response(exception)
    render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
   end
end
