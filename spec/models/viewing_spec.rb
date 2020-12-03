require 'rails_helper'

describe Viewing, type: :model do
  describe "validations" do
    it {should validate_presence_of(:date)}
    it {should validate_presence_of(:start_time)}
    it {should validate_numericality_of(:duration).is_greater_than(0) }
  end

  describe 'relationships' do
    it {should belong_to(:movie)}
    it {should have_many(:guests)}
    it {should have_many(:users).through(:guests)}
  end
end
