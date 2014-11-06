json.items @items.each do |item|
  json.partial! 'item', item: item
end
