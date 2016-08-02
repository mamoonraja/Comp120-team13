class IncidentSerializer < ActiveModel::Serializer

  attributes :id, :description, :location, :status,
       :severity, :date, :time, :comments, :media,
       :user_id, :created_at, :updated_at
end
