class Clinical::OmniController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :render_duplicate
  before_action { ApplicationController.authenticate(session) }

  def create
    @original_params = params
    params = omni_params

    if omni_params[:Co_Serial].blank? || omni_params[:FacilityName].blank?
      render json: {error: "Co_Serial and FacilityName are required"}, status: :unprocessable_entity
    end

    params["SumofNonCovd$"] = @original_params["SumofNonCovdTotal"].to_f
    params["SumofMCR$"] = @original_params["SumofMCRTotal"].to_f
    params["SumofINS$"] = @original_params["SumofINSTotal"].to_f
    params[:DateStamp] = DateTime.now
    @omni = Omni.new(params)

    if @omni.save
      render json: @omni, status: :created
    else
      render json: {error: @omni.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def render_not_found
    render json: {error: ""}, status: :not_found
  end

  def render_duplicate
    render json: {error: "Record already exists"}, status: :see_other
  end

  def omni_params
    params.require(:omni).permit(:Co_Serial, :FacilityName, :CalPeriod, :MCR_PPD, :INS_PPD, :SumofNonCovdTotal, :SumofMCRTotal, :SumofMCR, :SumofINSTotal, :SumOfINS, :Prescriber_NonCompliance, :Perc_FormularyCompliance, :Perc_AntipsychoticUse_Fac)
  end
end
