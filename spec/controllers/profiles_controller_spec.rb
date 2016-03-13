require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET #index' do
    context 'when username exists' do
      before do
        @user = (User.all.sample || FactoryGirl.create(:user))
        FactoryGirl.create_list :post, 21, user: @user
        get :index, {username: @user.username}
      end

      
      it { expect(response).to have_http_status(:success) }
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

  describe 'POST #create_post' do
    context 'when login' do
      login_user

      it 'with void content' do
        post :create_post, {content: ''}

        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)['success']).to eq false
      end

      it 'with valid content' do
        post :create_post, {content: Faker::Lorem.paragraph}
        user = User.last
        expect(Post.where(user: user).count).to eq 1
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)['success']).to eq(true)
      end
    end

    context 'when logout' do
      before do
        post :create_post, {content: Faker::Lorem.paragraph}
      end

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(JSON.parse(response.body)['success']).to eq(false) }
    end
  end


  describe 'POST #toggle_follow_user' do
    context 'when login' do
      login_user

      it 'with invalid param' do
        post :toggle_follow_user, {user_id: -1}

        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)['success']).to eq false
      end

      context 'with valid param' do
        it 'follow' do
          user = User.last
          post :toggle_follow_user, {user_id: FactoryGirl.create(:user).id}

          expect(user.following.count).to eq 1
          expect(response).to have_http_status(201)
          expect(JSON.parse(response.body)['success']).to eq true
          expect(JSON.parse(response.body)['body']).to eq 'Unfollow'
        end

        it 'unfollow' do
          user = User.last
          new_user = FactoryGirl.create(:user)
          user.following << new_user

          post :toggle_follow_user, {user_id: new_user.id}

          expect(user.following.count).to eq 0
          expect(response).to have_http_status(201)
          expect(JSON.parse(response.body)['success']).to eq true
          expect(JSON.parse(response.body)['body']).to eq 'Follow'
        end
      end
    end

    context 'when logout' do
      before do
        post :toggle_follow_user, {user_id: FactoryGirl.create(:user).id}
      end
      
      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(JSON.parse(response.body)['success']).to eq(false) }
    end
  end
end
