class WikiPolicy < ApplicationPolicy

  def premium?
    user.role?(:admin) or user.role?(:premium)
  end

end
