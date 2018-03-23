# frozen_string_literal: true

json.orders @orders.each do |order|
  json.id order.id
  json.created_at order.created_at
  json.updated_at order.updated_at
  json.user_id order.user_id
end
