class MasterSecurity::DocumentsController < ApplicationController
  before_action :set_document, only: %i[show update destroy]
  before_action { ApplicationController.authenticate(session) }

  # GET /documents
  def index
    render json: Document.all
  end

  def active
    render json: Document.active
  end

  # GET /documents/1
  def show
    render json: @document
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document).permit(:ID, :Document_DisplayName, :DocumentUpdated, :AlertUpdated, :DocumentType, :Message, :MainFolder, :SubFolder, :SubSubFolder, :DocType, :ParentFolder, :Active_Starting, :Active_Until, :ChildFolder1, :ChildFolder2, :ChildFolder3, :ChildFolder4, :ChildFolder5, :Keyword)
  end
end
