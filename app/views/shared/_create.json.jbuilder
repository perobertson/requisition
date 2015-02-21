if resource.errors.blank?
  json.call(resource, :id)
else
  json.partial! 'shared/errors', resource: resource
end
