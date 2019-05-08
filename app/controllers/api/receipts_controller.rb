class Api::ReceiptsController < ApplicationController
  before_action :authenticate_user

  def index
    
    @receipts = Receipt.all

    business_name = params[:business_name]
      if business_name
        @receipts = @receipts.where("business_name ILIKE?", "%#{business_name}%")
      end

    @receipts = @receipts.order(:id => :asc)
      # business_name_search = params["search"]
      # if business_name_search
      #   @receipts = @receipts.where("business_name ILIKE ?", "%#{business_name_search}%")
      # end
  
    render "index.json.jbuilder"
    
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
    # image: cloudinary_url,
    user_id: current_user.id,
    )
    if @receipt.save
      render "show.json.jbuilder"
    else
      render json: { errors: @receipt.errors.full_messages }, status: 422
    end
  end

  def show
    @receipt = Receipt.find_by(id: params[:id])
    render "show.json.jbuilder"
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
    @receipt.save
    render "show.json.jbuilder"

    
  end

  def destroy
    @receipt = Receipt.find_by(id: params[:id])
    @receipt.destroy
    render json: { message: "Receipt Destroyed" }
  end

  def analyze
    # save image to Cloudinary, save url as cloudinary_url
    response = Cloudinary::Uploader.upload(params[:image])
    cloudinary_url = response["secure_url"]

    # Analyze image with RTesseract
    results_rtesseract = RTesseract.new(params[:image].tempfile.path).to_s

    # Analyze image with other API? Original way of using ocr space.
    # resource = OcrSpace::Resource.new(apikey: "6a4d5476f888957")
    # results = resource.clean_convert(url: cloudinary_url, isTable: true).downcase

    ocr_response = HTTP.headers(:apikey => "6a4d5476f888957").post("https://api.ocr.space/parse/image", :form => 
    {
      :language => 'eng',
      :isOverLayRequired => true,
      :url => cloudinary_url, 
      :isTable => true,
      :scale => true

    })

    ocr_response = JSON.parse(ocr_response.body)
# lines = response['ParsedResults'][0]['TextOverlay']['Lines']
# # p lines
    lines = ocr_response['ParsedResults'][0]['ParsedText']



    # 
#     setup authorization
#     CloudmersiveOcrApiClient.configure do |config|
#   # Configure API key authorization: Apikey
#      config.api_key['Apikey'] = 'c9b95806-342b-4b34-9428-12366aa89b2e'
#   # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
#   # config.api_key_prefix['Apikey'] = 'Bearer'
#     end

#     api_instance = CloudmersiveOcrApiClient::ImageOcrApi.new

#     image_file = File.new(params[:image].tempfile.path).to_s # File | Image file to perform OCR on.  Common file formats such as PNG, JPEG are supported.

#     opts = { 
#   language: "ENG" 
# }

#     begin
# #   #Convert a scanned image into words with location
#   line_results = api_instance.image_ocr_image_lines_with_location(image_file, opts)
      
# rescue CloudmersiveOcrApiClient::ApiError => e
#   puts "Exception when calling ImageOcrApi->image_ocr_image_lines_with_location: #{e}"
# end


    # Search results string for certain business names
    if results_rtesseract.downcase.include?("osco") || lines.downcase.include?("osco") 
      business_name = "Jewel Osco"
    end
    if results_rtesseract.downcase.include?("walgreens") || lines.downcase.include?("walgreens") 
      business_name = "Walgreens"
    end
    if results_rtesseract.downcase.include?("target") || lines.downcase.include?("target") 
      business_name = "Target"
    end
    if results_rtesseract.lines.select {|line| line.downcase.include?("broadway")}[0] || lines.lines.select {|line| line.downcase.include?("broadway")}[0]
      address = "5343 N. Broadway Chicago IL. 60640"
    elsif 
       results_rtesseract.lines.select {|line| line.downcase.include?("los")}[0] || lines.lines.select {|line| line.downcase.include?("los")}[0] 
       address = lines.lines.select {|line| line.downcase.include?("los")}[0]
    else
      address = ""
    end
    if phone_line = results_rtesseract.lines.select {|line| line.downcase.include?("phone")}[0] || lines.lines.select {|line| line.downcase.include?("phone")}[0]
    phone_number = phone_line.partition('#').last
  elsif 
      phone_line = results_rtesseract.lines.select {|line| line.downcase.include?("1-")}[0] || lines.lines.select {|line| line.downcase.include?("1-")}[0]
      phone_number = lines.lines.select {|line| line.downcase.include?("1-")}[0]
    else
      phone_number = ""

    end
    

    fax = results_rtesseract.lines.select {|line| line.downcase.include?("fax")}[0] || lines.lines.select {|line| line.downcase.include?("fax")}[0]
    

    email = 
      results_rtesseract.lines.select { |line| 
        line.downcase.include?("@") && line.downcase.include?("com")
      }[0] || 
      lines.lines.select { |line| 
        line.downcase.include?("@") && line.downcase.include?("com")
      }[0]


    date = lines.lines.select {|line| line.downcase.include?("/1")}[0] || lines.lines.select {|line| line.downcase.include?("april")}[0]

    subtotal_line = lines.lines.select {|line| line.downcase.include?("subtotal")}[0] || results_rtesseract.lines.select {|line| line.downcase.include?("subtotal")}[0]
    subtotal = subtotal_line.downcase.partition('subtotal').last.strip

    tax_lines = 
      lines.lines.select {|line|
        line.downcase.include?("tax")
      }[0] || 
      results_rtesseract.lines.select {|line| 
        line.downcase.include?("tax")
      }[0]
    
    if tax_lines.include?("*")
      tax = tax_lines.downcase.partition('*').last.strip 
    elsif tax_lines.include?("%")
      tax = tax_lines.downcase.partition('%').last.strip
    else
      tax = tax_lines.downcase.partition('tax').last.strip
    end
    tax = tax.delete(' ')
    

    total_lines = lines.lines.select {|line| line.downcase.include?("tot")}[1]
    if total_lines
      total = total_lines.downcase.partition('al').last.strip
    else
      total = ""
    end
    total = total.delete(' ')


    total_savings = results_rtesseract.lines.select {|line| line.downcase.include?("total savings")}[0] || lines.lines.select {|line| line.downcase.include?("total savings")}[0]
    if total_savings.include?(":")
      you_save = total_savings.downcase.partition(':').last.strip
    else 
       
      you_save = total_savings.downcase.partition('total savings').last.strip
    # else
    #   you_save = ""
    end






        
      
    

    

    # Search results string for address

    fields = {}
    fields["business_name"] = business_name
    fields["address"] = address
    fields["phone_number"] = phone_number
    fields["fax"] = fax
    fields["email"] = email
    fields["date"] = date
    fields["subtotal"] = subtotal
    fields["tax"] = tax
    fields["total"] = total
    fields["you_save"] = you_save



    # Send result 
    render json: {
      cloudinary_url: cloudinary_url,
      fields: fields,
      lines: lines.lines
    }

  end
end
