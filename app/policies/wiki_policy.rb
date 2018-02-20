class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  class Scope < Scope
    def resolve
      wikis = []
      all = scope.all

      if user.present?
        if user.admin?
          wikis = scope.all
        elsif user.role == "premium"
          all.each do |wiki|
            if wiki.private == false || wiki.user == user
              wikis << wiki
            else
              wiki.collaborators.each do |c|
                if c.user_id == user.id
                  wikis << wiki
                end
              end
            end
          end
        else
          all.each do |wiki|
            if wiki.private == false
              wikis << wiki
            end

            wiki.collaborators.each do |c|
              if c.user_id == user.id
                wikis << wiki
              end
            end
          end
        end
      else
        wikis = scope.where(private: false)
      end
      wikis
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
