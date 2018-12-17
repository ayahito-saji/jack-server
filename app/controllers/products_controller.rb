class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @id = params[:id]
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(name: params[:name], content: params[:content], progress: params[:progress])
    if @product.save
      flash[:notice] = "作成しました"
      redirect_to("/products/index")
    else
      render("products/new")
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = params[:name]
    @product.content = params[:content]
    @product.progress = params[:progress]
    if @product.save
      flash[:notice] = "編集しました"
      redirect_to("/products/index")
    else
      render("products/edit")
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    flash[:notice] = "削除しました"
    redirect_to("/products/index")
  end
end
