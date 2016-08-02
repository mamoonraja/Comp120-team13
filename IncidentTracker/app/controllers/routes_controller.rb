class RoutesController < ApplicationController
  def index
    if current_user
      redirect_to '/incidents'
    else
      redirect_to '/users/sign_in'
    end
  end
end
