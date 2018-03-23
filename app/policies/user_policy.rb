# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user && @user.can_view_users?
        scope
      else
        scope.none
      end
    end
  end

  def show?
    @user && @user.can_view_users?
  end

  def update?
    @user == @record
  end
end
