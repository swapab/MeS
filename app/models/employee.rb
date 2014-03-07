class Employee < ActiveRecord::Base
  attr_accessible :age, :department, :designation, :email_id, :location, :name
end
