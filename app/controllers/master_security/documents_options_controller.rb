class MasterSecurity::DocumentsOptionsController < ApplicationController
  before_action :set_documents_option, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }

  # GET /documents_options
  def index
    @documents_options = DocumentsOption.all

    render json: @documents_options
  end

  # GET /documents_options/1
  def show
    render json: @documents_option
  end

  # POST /documents_options
  def create
    @documents_option = DocumentsOption.new(documents_option_params)

    if @documents_option.save
      render json: @documents_option, status: :created, location: @documents_option
    else
      render json: @documents_option.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /documents_options/1
  def update
    if @documents_option.update(documents_option_params)
      render json: @documents_option
    else
      render json: @documents_option.errors, status: :unprocessable_entity
    end
  end

  # DELETE /documents_options/1
  def destroy
    @documents_option.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_documents_option
    @documents_option = DocumentsOption.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def documents_option_params
    params.require(:documents_option).permit(:ID, :Security_Required, :ParentFolderShort)
  end
end
