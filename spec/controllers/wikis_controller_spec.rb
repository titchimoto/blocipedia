require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_wiki) { Wiki.create!(title: "This is my wiki", body: "This is my wiki body", private: false, user: user) }
  let(:user) { User.create!(email: "theo@meowmeowmeowm.com", password: 'meowmeow') }

  context "guest" do
  end

  context "logged in user" do
    before do
      sign_in(:user)
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
        expect{ post :create, params: { wiki: { title: "This is my title", body: "This is my wiki body, so please save!!", private: false, user: user } } }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, params: { wiki: { title: "This is my title!", body: "This is my wiki body!!!" } }
        expect(assigns(:wiki)).to eq Wiki.last
      end
    end




    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: { id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end
    end
  end


end
