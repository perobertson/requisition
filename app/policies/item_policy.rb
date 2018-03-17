# frozen_string_literal: true
class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user && @user.can_view_inventory?
        scope
      else
        scope.for_sale
      end
    end
  end

  def show?
    @record.for_sale? || @user && @user.can_view_inventory?
  end

  def create?
    @user && @user.can_add_inventory?
  end

  def update?
    @user && @user.can_change_inventory?
  end
end
