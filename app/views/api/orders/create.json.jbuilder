if @order.errors.blank?
  json.(@order, :id)
else
  json.errors @order.errors.full_messages do |message|
    json.error do
      json.detail message
    end
  end
end
