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
end
