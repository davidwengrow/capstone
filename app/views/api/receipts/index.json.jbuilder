json.array! @receipts.each do |receipt|
  json.partial! "receipt.json.jbuilder", receipt: receipt
end