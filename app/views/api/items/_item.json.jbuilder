json.partial! 'shared/resource', resource: item

json.call(item, :type, :type_id, :name, :for_sale)
