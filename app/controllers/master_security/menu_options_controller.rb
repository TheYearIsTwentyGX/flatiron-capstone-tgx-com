class MasterSecurity::MenuOptionsController < ApplicationController
  before_action { ApplicationController.authenticate(session) }

  def show
    @user = User.find_by! User_ID: params[:id]
    if @user
      connection = ActiveRecord::Base.establish_connection :MasterSecurity
      results = connection.connection.execute_procedure("_CustomSP_MenuOptions", @user.User_ID)
      render json: results
    else
      render json: {error: "User not found"}, status: :not_found
    end
  end
end
