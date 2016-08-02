module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        desc "Return all Users"
        get "", root: :users do
          User.all
        end

        desc "Return a single user"
        params do
          requires :id, type: Integer, desc: "ID of the user"
        end
        get ":id", root: "user" do
          User.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
