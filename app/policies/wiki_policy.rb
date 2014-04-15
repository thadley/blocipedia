class WikiPolicy < ApplicationPolicy

  def premium?
    user.role?(:admin) or user.role?(:premium)
  end

  def destroy?
    user.present? && (record.user == user || user.role?(:admin))
  end

  def show?
    record.is_private == false || user.present?
  end

end
