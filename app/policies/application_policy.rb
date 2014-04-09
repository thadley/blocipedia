class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
  #  Rails.logger.debug "in update? user is #{user.inspect} and record is #{record.inspect}"
    user.present? && (record.user == user || user.role?(:admin))
  end

  def edit?
    update?
  end

  # def destroy?
  #   false
  # end

  def scope
    record.class
  end
end

