require 'rails_helper'

describe Item do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_numericality_of(:unit_price).is_greater_than(0) }
   end
  
   describe 'relationships' do
    it { should belong_to :merchant }
   end
end
