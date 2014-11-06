if resource.errors.blank?
  json.(resource, :id)
else
  json.partial! 'shared/errors', resource: resource
end
