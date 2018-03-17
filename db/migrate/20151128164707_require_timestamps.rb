# frozen_string_literal: true
class RequireTimestamps < ActiveRecord::Migration[4.2]
  def change
    %w[Item OrderItem Order].map(&:constantize).each do |table|
      table.where(created_at: nil).update_all created_at: Time.now
      table.where(updated_at: nil).update_all updated_at: Time.now
      symbol = table.name.pluralize.underscore.to_sym
      change_column_null symbol, :created_at, false
      change_column_null symbol, :updated_at, false
    end
  end
end
