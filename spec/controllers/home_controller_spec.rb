require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    let(:users) { FactoryGirl.create_list :user, 3 }

    context 'when logout' do
      before do
        get :index
      end

      it { expect(response).to have_http_status(:success) } 
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it 'has last posts' do
        100.times {|i| FactoryGirl.create :post, user: users.sample}
        expect(assigns(:last_posts)).to eq(Post.all.order(created_at: :desc).limit(20))
      end

      it 'has suggestions' do
        expect(assigns(:suggestions).count).to be <= 3
        expect(assigns(:suggestions)).to all(be_an(User))
      end
    end

    context 'when login' do
      login_user

      it 'has suggestions' do
        user = subject.current_user
        get :index
        expect(assigns(:suggestions).count).to be <= 3
        expect(assigns(:suggestions)).not_to include(user)
      end
    end
  end
end
