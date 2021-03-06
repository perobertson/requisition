# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user&.can_view_category?
        scope
      else
        scope.none
      end
    end
  end

  def show?
    @user&.can_view_category?
  end

  def create?
    @user&.can_add_category?
  end

  def update?
    @user&.can_change_category?
  end

  def destroy?
    @user&.can_change_category?
  end
end
