# frozen_string_literal: true

json.partial! 'resource', resource: item

json.call(item, :type_id, :name, :for_sale, :category_id, :rendered)
