module API
  module V1
    class Incidents < Grape::API
      include API::V1::Defaults

      resource :incidents do
        desc "Return all incidents"
        get "", root: :incidents do
          Incident.all
        end

        desc "Return a single incident"
        params do
          requires :id, type: Integer, desc: "ID of the incident"
        end
        get ":id", root: "incident" do
          Incident.where(id: permitted_params[:id]).first!
        end

        desc "Submits an incident"
        params do
          requires :location, type: String, desc: "Location of the incident"
          requires :severity, type: Integer, default: 1, values: [1,2,3,4,5,6,7,8,9,10], desc: "Severity of the incident (1 least severe, 10 most severe)"
          requires :date, type: Date, desc: 'Date of the incident (YYYY-MM-DD)'
          requires :time, type: String, desc: 'Time of the incident (HH:MM)'
          optional :description, type: String, default: "", desc: 'Description of the incident'
          optional :status, type: Integer, default: 0, values: [0,1,2], desc: 'Status of the incident (0 = open, 1 = processing, 2 = resolved)'
        end
        post do
          Incident.create({
            user_id: 1,
            location: params[:location],
            description: params[:description],
            severity: params[:severity],
            status: params[:status],
            date: params[:date],
            time: params[:time]
          })
        end

        desc 'Update an incident.'
        params do
          requires :id, type: Integer, desc: 'Id of the incident'
          requires :location, type: String, desc: "Location of the incident"
          requires :severity, type: Integer, values: [1,2,3,4,5,6,7,8,9,10], desc: "Severity of the incident (1 least severe, 10 most severe)"
          requires :description, type: String, desc: 'Description of the incident'
          requires :status, type: Integer, values: [0,1,2], desc: 'Status of the incident (0 = open, 1 = processing, 2 = resolved)'
        end
        put do
          Incident.find(params[:id]).update({
                                          location: params[:location],
                                          description: params[:description],
                                          severity: params[:severity],
                                          status: params[:status]
                                      })
        end

        desc 'Delete an incident.'
        params do
          requires :id, type: Integer, desc: 'ID of the incident.'
        end
        route_param :id do
        delete do
          Incident.find(params[:id]).destroy
        end
        end
      end
    end
  end
end
