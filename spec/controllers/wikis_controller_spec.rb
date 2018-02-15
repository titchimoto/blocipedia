require 'rails_helper'
require 'devise'


RSpec.describe WikisController, type: :controller do
  let(:my_wiki) { Wiki.create!(title: "This is my wiki", body: "This is my wiki body", private: false, user: user) }
  let(:user) { User.create!(email: "theo@meowmeowmeowm.com", password: 'meowmeow') }



  context "guest" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: my_wiki.id }
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, params: { id: my_wiki.id }
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, params: { wiki: { title: "this is my title", body: "this is my wiki body!!!" } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, params: { id: my_wiki.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = "This is my new title"
        new_body = "This is my new wiki body!"

        put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, params: { id: my_wiki.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end


  context "logged in user doing CRUD actions on things they don't own" do
    before do
      user = User.create!(email: "user1@example.com", password: "password")
      other_user = User.create!(email: "user2@example.com", password: "password")
      user.confirm
      other_user.confirm
      sign_in other_user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: my_wiki.id }
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, params: { id: my_wiki.id }
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Wiki by 1" do
        expect{ post :create, params: { id: user.id, wiki: { title: "This is my title", body: "This is my wiki body, so please save!!", private: false, user: user } } }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, params: { id: user.id, wiki: { title: "This is my title!", body: "This is my wiki body!!!", user: user } }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, params: { wiki: { title: "This is my title!", body: "This is my wiki body!!!", user: user } }
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: { id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end
    end
  end


  context "logged in user doing CRUD actions on things they own" do
    before do
      user = User.create!(email: "user1@example.org", password: "very-secret")
      user.confirm
      sign_in user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: my_wiki.id }
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, params: { id: my_wiki.id }
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Wiki by 1" do
        expect{ post :create, params: { id: user.id, wiki: { title: "This is my title", body: "This is my wiki body, so please save!!", private: false, user: user } } }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, params: { id: user.id, wiki: { title: "This is my title!", body: "This is my wiki body!!!", user: user } }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, params: { wiki: { title: "This is my title!", body: "This is my wiki body!!!", user: user } }
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: { id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { id: my_wiki.id }
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, params: { id: my_wiki.id }
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq my_wiki.id
        expect(wiki_instance.title).to eq my_wiki.title
        expect(wiki_instance.body).to eq my_wiki.body
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = "This is my new Wiki title"
        new_body = "This is my new Wiki body"

        put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body } }

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = "This is my new Wiki title"
        new_body = "This is my new Wiki body"

        put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, params: { id: my_wiki.id }
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        delete :destroy, params: { id: my_wiki.id }
        expect(response).to redirect_to wikis_path
      end
    end
  end


end
