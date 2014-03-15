class Employee < ActiveRecord::Base
  DEFAULT_SORT_COLUMN = 'name'
  DEFAULT_DIRECTION = 'asc'

  attr_accessible :age, :department, :designation, :email_id, :location, :name

  def self.active
    where('deleted_at IS NULL')
  end

  def self.group_by(column)
    all.group_by{ |e| e.try(column) }
  end

  def self.group_by_columns
    Employee.attribute_names & Employee.accessible_attributes.to_a
  end

  def self.only_deleted
    unscoped.where("deleted_at IS NOT NULL")
  end

  def self.search(query=nil)
    where("age LIKE :query OR
           department LIKE :query OR
           designation LIKE :query OR
           email_id LIKE :query OR
           location LIKE :query OR
           name LIKE :query", query: "%#{query}%")
  end

  def archived?
    !deleted_at.blank?
  end

  def destroy
    !archived? ? soft_delete : destroy!
  end

  private

    def soft_delete
      self.deleted_at = Time.now
      self.save
    end
end
