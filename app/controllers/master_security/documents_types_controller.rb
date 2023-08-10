class MasterSecurity::DocumentsTypesController < ApplicationController
  before_action :set_documents_type, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }

  # GET /documents_types
  def index
    @documents_types = DocumentsType.all

    render json: @documents_types
  end

  # GET /documents_types/1
  def show
    render json: @documents_type
  end

  # POST /documents_types
  def create
    @documents_type = DocumentsType.new(documents_type_params)

    if @documents_type.save
      render json: @documents_type, status: :created, location: @documents_type
    else
      render json: @documents_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /documents_types/1
  def update
    if @documents_type.update(documents_type_params)
      render json: @documents_type
    else
      render json: @documents_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /documents_types/1
  def destroy
    @documents_type.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_documents_type
    @documents_type = DocumentsType.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def documents_type_params
    params.require(:documents_type).permit(:DocumentType, :Program, :Web_Icon)
  end
end
