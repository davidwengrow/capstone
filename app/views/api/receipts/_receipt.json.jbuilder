    json.id receipt.id
    json.business_name receipt.business_name
    json.address receipt.address
    json.phone_number receipt.phone_number
    json.fax receipt.fax
    json.email receipt.email
    json.date receipt.date
    json.subtotal receipt.subtotal
    json.tax receipt.tax
    json.total receipt.total
    json.you_save receipt.you_save
    json.image receipt.image
    json.user receipt.user

    json.formatted_tax number_to_currency(receipt.tax)
    json.formatted_total number_to_currency(receipt.total)
    json.formatted_subtotal number_to_currency(receipt.subtotal)
    json.formatted_you_save number_to_currency(receipt.you_save)
