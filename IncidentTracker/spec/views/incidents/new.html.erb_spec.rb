require "spec_helper"
require "rails_helper"

describe 'incidents/new.html.erb', :type => :view do
  context 'when new incident page renders' do
    it 'render the form partial view 1 time' do
      assign(:incident, Incident.new)
      render
      expect(response).to render_template(partial: '_form', :count => 1)
    end
  end
end

describe 'incidents/show.html.erb', :type => :view do
  context 'when showing an incident' do
    it 'show all incident content' do
      user = User.create(first_name: 'test' , last_name: 'user', email: 'example@example.com', role: 'student', password: 'password-test', password_confirmation: 'password-test')
      assign(:incident, Incident.create(user: user, location: 'example_location', severity: '10', description: 'example descripton', time: '9:10 PM', date: '2016-2-24'))
      render
      expect(rendered).to include('example descripton')
      expect(rendered).to include('test')
      expect(rendered).to include('user')
      expect(rendered).to include('example_location')
      expect(rendered).to include('21:10')
      expect(rendered).to include('2016-02-24')
      expect(rendered).to include('10')
    end
  end
end

describe 'incidents/index.html.erb', :type => :view do
  context 'on incident timeline' do
    it 'display multiple incidents' do
      user = User.create(first_name: 'test' , last_name: 'user', email: 'example@example.com', role: 'student', password: 'password-test', password_confirmation: 'password-test')
      assign(:incidents, [Incident.create(user: user, location: 'example_location', severity: '10', description: 'example descripton', time: '9:10 PM', date: '2016-2-24'), Incident.create(user: user, location: 'example_location2', severity: '9', description: 'example descripton2', time: '9:10 PM', date: '2016-2-24')])
      render
      expect(rendered).to include('example_location')
      expect(rendered).to include('example_location2')
    end
  end
end