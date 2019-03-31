class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.string :business_name
      t.string :address
      t.string :phone_number
      t.string :fax
      t.string :email
      t.string :date
      t.decimal :subtotal, precision: 9, scale: 2
      t.decimal :tax, precision: 9, scale: 2
      t.decimal :total, precision: 9, scale: 2
      t.decimal :you_save, precision: 9, scale: 2
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
