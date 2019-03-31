class Receipt < ApplicationRecord
  validates :business_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  
  belongs_to :user

  def friendly_updated_at
    updated_at.strftime("%B %e, %Y")
  end
  def tax
    price * 0.09
  end
  def subtotal
    total - tax
  end
  
end
