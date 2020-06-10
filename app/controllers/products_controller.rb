class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to root_path #TODO - what is the best thing to do when prodcut is not found
      return
    end
  end
end
