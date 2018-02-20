class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.where('email LIKE ?', "%#{params[:email]}%").first

    if @user
      if @wiki.collaborators.where(user_id: @user.id).any?
        flash[:alert] = "User is already a collaborator."
        redirect_to edit_wiki_path(@wiki)
        return
      else
        @collaborator = Collaborator.new(wiki: @wiki, user: @user)
      end
    else
      flash[:alert] = "User not found. Please try again."
      redirect_to edit_wiki_path(@wiki)
      return
    end


    if @collaborator.save
      flash[:notice] = "Collaborator successfully added."
    else
      flash.now[:alert] = "Error adding Collaborator. Please try again."
    end
    redirect_to edit_wiki_path(@wiki)
  end


  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator successfully removed."
    else
      flash[:alert] = "Error removing collaborator. Please try again."
    end
    redirect_to edit_wiki_path(@wiki)
  end
end
