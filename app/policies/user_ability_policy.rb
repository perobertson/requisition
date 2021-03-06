# frozen_string_literal: true

class UserAbilityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user&.can_view_users?
        scope
      else
        scope.none
      end
    end
  end

  def show?
    @user&.can_view_users?
  end

  def create?
    @user&.can_change_user?
  end

  def destroy?
    @user&.can_change_user?
  end
end
