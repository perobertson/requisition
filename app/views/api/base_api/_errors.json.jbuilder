# frozen_string_literal: true

json.errors resource.errors.messages.map(&:first) do |attr|
  json.field attr.to_s
  json.messages resource.errors[attr]
end
json.error_messages resource.errors.full_messages
