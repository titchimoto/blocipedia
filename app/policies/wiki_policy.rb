class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def create?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.admin? || (@wiki.user == user)
  end
end
