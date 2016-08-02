json.array!(@incidents) do |incident|
  json.extract! incident, :id, :description, :location, :status, :severity, :date, :time, :comments
  json.url incident_url(incident, format: :json)
end
