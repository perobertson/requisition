json.errors resource.errors.messages.map(&:first) do |attr|
  json.error do
    json.field attr.to_s
    json.messages resource.errors[attr]
  end
end
json.error_messages resource.errors.full_messages do |message|
  json.message message
end
