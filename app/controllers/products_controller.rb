class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    render json: @product
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      head :no_content
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    if @product.orders.any?
      render json: "Product is referenced in an order, cannot be deleted", status: :forbidden
    else
      @product.destroy
      head :no_content
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :net_price)
  end
end
