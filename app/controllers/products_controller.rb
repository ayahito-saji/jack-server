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
  
  def create
    @product = Product.new(name: params[:name])
    @product.save
    redirect_to("/products/index")
  end
  def edit
    @product = Product.find_by(id: params[:id])
  end
end
