class Api::ReceiptsController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user
      @receipts = Receipt.all

      @receipts = @receipts.order(:id => :asc)
      # business_name_search = params["search"]
      # if business_name_search
      #   @receipts = @receipts.where("business_name ILIKE ?", "%#{business_name_search}%")
      # end
  
      render "index.json.jbuilder"
    else
      render json: []
    end
  end
  def show
    @receipt = Receipt.find_by(id: params[:id])
    render "show.json.jbuilder"
  end
  def create
    @receipt = Receipt.new(business_name: params[:business_name],
    address: params[:address],
    phone_number: params[:phone_number],
    fax: params[:fax],
    email: params[:email],
    date: params[:date],
    subtotal: params[:subtotal],
    tax: params[:tax],
    total: params[:total],
    you_save: params[:you_save],
    image: params[:image],
    user_id: current_user.id)
    if @receipt.save
      render "show.json.jbuilder"
    else
      render json: {errors: @receipt.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @receipt = Receipt.find_by(id: params[:id])
    @receipt.business_name = params[:business_name] || @receipt.business_name

    @receipt.address = params[:address] ||  @receipt.address
    @receipt.phone_number = params[:phone_number] || @receipt.phone_number
    @receipt.fax = params[:fax] || @receipt.fax
    @receipt.email = params[:email] || @receipt.email
    @receipt.date = params[:date] ||
    @receipt.subtotal = params[:subtotal] || @receipt.date
    @receipt.tax = params[:tax] || @receipt.tax
    @receipt.total = params[:total] || @receipt.total
    @receipt.you_save = params[:you_save] || @receipt.you_save
    @receipt.image = params[:image] || @receipt.image
    @receipt.user_id = params[:user_id] || @receipt.user_id


    if @product.save
      render "show.json.jbuilder"
    else
      render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @receipt = Receipt.find_by(id: params[:id])
    @receipt.destroy
    render json: {message: "Receipt Destroyed"}
  end
end
