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
    @record && @record.order && @record.order.user == @user
  end

  def create?
    @user && @user.can_place_order?
  end
end
