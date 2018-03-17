# frozen_string_literal: true
json.orders @orders.each do |order|
  json.(order, :id, :created_at, :updated_at, :user_id)
end
