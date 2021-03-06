# frozen_string_literal: true

class OrderItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user
        scope.where order: @user.orders
      else
        scope.none
      end
    end
  end

  def show?
    @record&.order && @record.order.user == @user
  end

  def create?
    @user&.can_place_order?
  end
end
