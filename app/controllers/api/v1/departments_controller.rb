module Api
  module V1
    class DepartmentsController < BaseController
      before_action :set_department, only: [:show, :update, :destroy]

      def index
        departments = Department.all
        render_success(data: departments)
      end

      def show
        render_success(data: @department)
      end

      def create
        department = Department.new(department_params)
        if department.save
          LoggerService.info(component: "DepartmentsAPI", event: "CREATE", message: "Created department #{department.name}")
          render_success(data: department, status: :created)
        else
          render_error(errors: department.errors.full_messages)
        end
      end

      def update
        if @department.update(department_params)
          LoggerService.info(component: "DepartmentsAPI", event: "UPDATE", message: "Updated department #{@department.name}")
          render_success(data: @department)
        else
          render_error(errors: @department.errors.full_messages)
        end
      end

      def destroy
        @department.destroy
        LoggerService.info(component: "DepartmentsAPI", event: "DESTROY", message: "Deleted department #{@department.name}")
        render_success(message: "Department deleted successfully")
      end

      private

      def set_department
        @department = Department.find(params[:id])
      end

      def department_params
        params.require(:department).permit(:name, :code, :description, :active)
      end
    end
  end
end
