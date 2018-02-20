class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  class Scope < Scope
    def resolve
      if user.present? && ( user.admin? || user.premium? )
        scope.all
        # scope.where(???)
      else
        scope.where(private: false)
      end
    end
  end

  def show?
    user.present? && (wiki.user == user || !wiki.private?)
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
