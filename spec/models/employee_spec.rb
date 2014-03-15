require 'spec_helper'

describe Employee do
  describe 'validate #attributes' do
    subject { FactoryGirl.build(:employee) }

    its(:name){ should_not be_blank }
  end

  describe '#factory' do
    it 'should be a valid object' do
      employee = build(:employee)
      employee.should be_valid
      employee.errors.should be_blank
    end
  end

  describe 'Mass Assignment Protection' do
    before do
      @employee = build(:employee)
      @parameters = {name: 'Swapnil Abnave', age: 24, email_id: 'swap.it@hotmail.com',
                      location: 'Mumbai', department: 'Web Solutions', designation: 'Sr. Developer'}
    end

    it 'should update whitelisted attributes' do
      expect {@employee.update_attributes(@parameters)}.to_not raise_error
    end

    it 'should not update attributes not whitelisted' do
      expect {@employee.update_attributes(sneek: 'hacker')}.to raise_error
    end
  end

  describe 'Full Text Search' do
    before do
      @employee =
        create(:employee, age: 10, department: 'R&D',
                          designation: 'Sci-fi Hacker', email_id: 'info@bang.com',
                          location: 'Earth', name: 'Swap Ab')
    end

    it 'return all records for a blank search' do
      Employee.search('').should eq(Employee.all)
      Employee.search.should eq(Employee.all)
    end

    context "search all attributes" do
      it '#age' do
        bad_result = create(:employee, age: 11)
        @results = Employee.search('10')
        @results.count.should eq(1)
        @results.should include(@employee)
        @results.should_not include(bad_result)
      end

      it '#department' do
        bad_result = create(:employee, department: 'RnD')
        @results = Employee.search('R&D')
        @results.count.should eq(1)
        @results.should include(@employee)
        @results.should_not include(bad_result)
      end

      it '#designation' do
        bad_result = create(:employee, designation: 'Science')
        @results = Employee.search('sci-fi')
        @results.count.should eq(1)
        @results.should include(@employee)
        @results.should_not include(bad_result)
      end

      it '#email_id' do
        bad_result = create(:employee, email_id: 'inf@dod.com')
        @results = Employee.search('info')
        @results.count.should eq(1)
        @results.should include(@employee)
        @results.should_not include(bad_result)
      end

      it '#location' do
        bad_result = create(:employee, location: 'Mumbai')
        @results = Employee.search('ear')
        @results.count.should eq(1)
        @results.should include(@employee)
        @results.should_not include(bad_result)
      end

      it '#name' do
        associated_result = create(:employee, email_id: 'swap.it@hotmail.com')
        @results = Employee.search('Swap')
        @results.count.should eq(2)
        @results.should include(@employee)
        @results.should include(associated_result)
      end
    end
  end
end
