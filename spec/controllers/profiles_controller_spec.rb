require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET #index' do
    context 'when username exists' do
      before do
        @user = (User.all.sample || FactoryGirl.create(:user))
        FactoryGirl.create_list :post, 21, user: @user
        get :index, {username: @user.username}
      end

      
      it { is_expected.to respond_with :ok }
      it { expect(response.content_type).to eq "text/html" }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it 'has the last post of param' do
        expect(assigns(:posts)).to eq(Post.where(user: @user).order(created_at: :desc).limit(20))
      end

      context 'handler case insensitive' do

      end
    end

    context 'when username does not exists' do
      before do
        get :index, {username: '!#@$!'}
      end

      it { is_expected.to render_template :not_find }

    end
  end
end
