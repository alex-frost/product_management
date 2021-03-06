class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    render json: @order
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(product_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    if @order.update(product_params)
      head :no_content
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:order).permit(:date, :vat, :status)
  end
end
