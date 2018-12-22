class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
    if !(signed_in?) && @product.progress == "リリース"
      redirect_to("/products/#{params[:id]}/public")
    elsif !(signed_in?)
      flash[:notice] = "このプロダクトは非公開です"
      redirect_to("/products/index")
    end
  end

  def public_show
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
    @members_all = Member.all
  end
  
  def create
    @product = Product.new(name: params[:name], content: params[:content], progress: params[:progress])
    if @product.save
      flash[:notice] = "作成しました"
      redirect_to("/products/index")
    else
      render("products/new")
    end

    Member.all.each do |member|
      if params[:members].include?("#{member.id}")
        MemberProduct.create(member: member, product: @product)
      end
    end
  end

  def edit
    @members_all = Member.all
    @product = Product.find_by(id: params[:id])
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = params[:name]
    @product.content = params[:content]
    @product.progress = params[:progress]
    if @product.save
      flash[:notice] = "編集しました"
      redirect_to("/products/#{params[:id]}")
    else
      render("products/edit")
    end
    Member.all.each do |member|
      @member_product = MemberProduct.find_by(member: member, product: @product)
      if params[:members].include?("#{member.id}") && !(@member_product) #チェックが入っている、かつアソシエーションがない場合
        MemberProduct.create(member: member, product: @product)
      elsif !(params[:members].include?("#{member.id}")) && @member_product #チェックが入っていない、かつアソシエーションがある場合
        @member_product.destroy
      end
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    flash[:notice] = "削除しました"
    redirect_to("/products/index")
  end
end
