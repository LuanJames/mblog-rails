require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET #index' do
    context 'when has no param' do
      before do
        get :index
      end
      # it 'return home page' do
      #   expect(response).to have_http_status(:success)
      # end


      it { is_expected.to respond_with :ok }
      it { expect(response.content_type).to eq "text/html" }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
    end
  end

  describe 'GET #profile' do
    context 'when username exists' do
      before do
        @user = (User.all.sample || FactoryGirl.create(:user))
        FactoryGirl.create_list :post, 21, user: @user
        get :profile, {username: @user.username}
      end

      
      it { is_expected.to respond_with :ok }
      it { expect(response.content_type).to eq "text/html" }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :profile }
      it 'has the last post of param' do
        expect(assigns(:posts)).to eq(Post.where(user: @user).order(created_at: :desc).limit(20))
      end

      context 'handler case insensitive' do

      end
    end

    context 'when username does not exists' do
      before do
        get :profile, {username: '!#@$!'}
      end

      it { is_expected.to render_template :profile_not_find }

    end
  end
end
