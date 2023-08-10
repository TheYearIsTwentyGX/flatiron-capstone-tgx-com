class It::InventoryController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action { ApplicationController.authenticate(session) }

  def facility_items
    render json: InventoryItem.active.where(OwnedBy: params[:id])
  end

  def tg_facility_items
    render json: InventoryItem.active.where(OwnedBy: params[:id]).limit(15), each_serializer: It::TgItemsSerializer
  end

  def create
    item = InventoryItem.create(inventory_params)
    if item.valid?
      render json: item, status: :created
    else
      render json: {error: item.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:ID, :Type, :Brand, :Model, :OwnedBy, :PurchaseDate, :CPUType, :CPUSpeedGHz, :RAMSizeMB, :HardDriveSizeGB, :DateAdded, :Admin_Username, :Admin_Password, :SerialNumber, :OS, :Splashtop_UUID)
  end

  def render_not_found
    render json: {error: ""}, status: :not_found
  end
end
