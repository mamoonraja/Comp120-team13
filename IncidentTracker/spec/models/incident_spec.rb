require "rails_helper"
require "spec_helper"

describe Incident do

  it "passed validations when severity is set" do
     incident = Incident.create(:severity => 'my_severity')
     incident.valid?
     expect(incident.errors[:severity].size).to eq(0)
  end

  it "passed validations when location is set" do
     incident = Incident.create(:location => 'my_location')
     incident.valid?
     expect(incident.errors[:location].size).to eq(0)
  end

  it "passed validations when location is blank and generates error" do
     incident = Incident.new
     incident.valid?
     expect(incident.errors[:location].size).to eq(1)
  end

  it "passed validations when severity is blank and generates error" do
     incident = Incident.new
     incident.valid?
     expect(incident.errors[:severity].size).to eq(1)
  end

  it " when status is empty-> set to 1 by the model" do
      incident = Incident.new
      user = User.create(first_name: 'test' , last_name: 'user', email: 'example@example.com', role: 'student', password: 'password-test', password_confirmation: 'password-test')
      incident = Incident.create(user: user, location: 'example_location', severity: '10', description: 'example descripton', time: '9:10 PM', date: '2016-2-24')
      incident.valid?
      incident.save
      expect(incident.status).to eq(1)
  end

end
