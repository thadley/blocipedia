class WikiPolicy < ApplicationPolicy

  def private?
    user.role?(:admin) or user.role?(:premium)
  end

end
