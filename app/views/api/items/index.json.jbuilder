# frozen_string_literal: true

json.items @items.each do |item|
  json.partial! 'item', item: item
end
