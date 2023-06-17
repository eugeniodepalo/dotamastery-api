class UserPolicy < ApplicationPolicy
  def show?
    record == user
  end
end
