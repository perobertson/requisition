Ability.KINDS.each do |kind|
  Ability.create! kind: kind unless Ability.where(kind: kind).any?
end
