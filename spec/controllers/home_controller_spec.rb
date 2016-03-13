require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET #index' do
    context 'when has no param' do
      before do
        users = FactoryGirl.create_list :user, 5
        100.times {|i| FactoryGirl.create :post, user: User.all.sample}
        
        get :index
      end

        it { expect(response).to have_http_status(:success) }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it 'has last posts' do
        expect(assigns(:last_posts)).to eq(Post.all.order(created_at: :desc).limit(20))
      end
    end
  end
end
