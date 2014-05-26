class VatsController < ApplicationController
  before_action :set_vat, only: [:show, :update]

  # GET /vats/1
  # GET /vats/1.json
  def show
    render json: @vat
  end

  # PATCH/PUT /vats/1
  # PATCH/PUT /vats/1.json
  def update
    if @vat.update(vat_params)
      head :no_content
    else
      render json: @vat.errors, status: :unprocessable_entity
    end
  end

  private

  def set_vat
    @vat = Vat.instance
  end

  def vat_params
    params.require(:vat).permit(:amount)
  end
end
