require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:api_key)}
    it { should validate_uniqueness_of(:password)}
    it { should validate_uniqueness_of(:api_key)} 

    it "create user with validations" do
      user = User.create(email: 'joe@test.com', password: 'password123', api_key: '123')
      expect(user).to have_attribute(:email)
      expect(user.email).to eq('joe@test.com')
    end
  end
end