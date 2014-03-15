module EmployeesHelper
  def flash_message
    flash[:notice] || flash[:alert] || flash[:error]
  end

  def is_checked?(column)
    @group_by == column ? 'checked' : ''
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column and sort_direction == 'asc') ? 'desc' : 'asc'
    link_to(title, {sort: column, direction: direction}, class: css_class)
  end
end
