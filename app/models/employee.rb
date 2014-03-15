class Employee < ActiveRecord::Base
  DEFAULT_SORT_COLUMN = 'name'
  DEFAULT_DIRECTION = 'asc'

  default_scope where('deleted_at <> NULL')

  attr_accessible :age, :department, :designation, :email_id, :location, :name, :deleted_at

  def self.group_by(column)
    all.group_by{ |e| e.try(column) }
  end

  def self.group_by_columns
    Employee.attribute_names & Employee.accessible_attributes.to_a
  end

  def archived?
    !deleted_at.blank?
  end

  def destroy
    !archived? ? soft_delete : destroy!
  end

  def soft_delete
    self.deleted_at = Time.now
    self.save
  end
end
