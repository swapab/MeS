class EmployeesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :sanitize_group_by, only: :grouped

  def index
    @employees = Employee.order("#{sort_column} #{sort_direction}")
  end

  def destory
    @employee = Employee.find(params[:id])
    if @employee.destory
      redirect_to :root, success: deletion_message
    else
      redirect_to :root, error: 'Failed to delete employee'
    end
  end

  def grouped
    @employees = Employee.group_by(@group_by)
  end

  private

    def deletion_message
      if @employee.deleted?
        'Successfully deleted employee'
      elsif @employee.archived?
        'Successfully archived employee'
      end
    end

    def sanitize_group_by
      @group_by ||= params[:employee].fetch(:group_by, 'location')
      Employee.group_by_columns.include?(@group_by) or
        redirect_to(:root, error: 'In-Valid group-by option selected')
    end

    def sort_column
      Employee.column_names.include?(params[:sort]) ?
       params[:sort] : Employee::DEFAULT_SORT_COLUMN
    end

    def sort_direction
      @sort_direction ||=
        %w[asc desc].include?(params[:direction]) ?
         params[:direction] : Employee::DEFAULT_DIRECTION
    end
end
