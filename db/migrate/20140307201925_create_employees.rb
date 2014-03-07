class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string  :name
      t.integer :age
      t.string  :email_id
      t.text    :location
      t.string  :department
      t.string  :designation

      t.timestamps
    end
  end
end
