# frozen_string_literal: true

if @resource.errors.blank?
  json.call(@resource, :id)
else
  json.partial! 'errors', resource: @resource
end
