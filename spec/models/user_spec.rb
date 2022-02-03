require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it 'requires firstname to be set' do
      expect(subject.valid?).to_not be
      expect(subject.errors[:firstname].size).to eq(1)
    end
    it 'requires lastname to be set' do
      expect(subject.valid?).to_not be
      expect(subject.errors[:lastname].size).to eq(1)
    end
  end
end
