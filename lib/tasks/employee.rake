namespace :employee do
  # rake employee:load max=100 
  desc "Populate Test Data"
  task :load => :environment do
    init_count = Employee.count
    num_of_emp = ENV['max'] || 50
    FactoryGirl.create_list(:employee, num_of_emp)
    puts "Employees Added : #{Employee.count - init_count}"
  end
end
