class EmployeesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :sanitize_group_by, only: :grouped

  def index
    @title = 'MeSpring - All Employees'
    @employees = Employee.active.order("#{sort_column} #{sort_direction}").search(search_query)
  end

  def destroy
    @employee = Employee.find(params[:id])
    if @employee.destroy
      redirect_to :root, notice: deletion_message
    else
      redirect_to :root, error: 'Failed to delete employee'
    end
  end

  def archived
    @title = 'MeSpring - Archived Employees'
    @employees = Employee.only_deleted
    render :index
  end

  def grouped
    @employees = Employee.active.group_by(@group_by)
  end

  private

    def deletion_message
      if @employee.destroyed?
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

    def search_query
      @search_query ||= params[:employee].fetch(:search, nil) if params[:employee]
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
