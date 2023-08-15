class AccessProfilesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

	def index
		render json: AccessProfile.all
	end
  

  private

  def render_not_found
    render json: {error: ""}, status: :not_found
  end
end
