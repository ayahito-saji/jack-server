class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @id = params[:id]
    @product = Product.find_by(id: params[:id])
  end

  def new
    
  end
end
