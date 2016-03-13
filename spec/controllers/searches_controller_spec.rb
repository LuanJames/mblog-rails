require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  login_user
  
  describe "GET #index" do
    context 'without param' do
      subject do
        get :index
      end
      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
    end

    context 'with param' do
      let(:u1) {FactoryGirl.create :user, name: 'Luan James'}
      let(:u2) {FactoryGirl.create :user, name: 'James', username: 'dart'}
      let(:u3) {FactoryGirl.create :user, name: 'James Luan'}
      let(:u4) {FactoryGirl.create :user, name: 'James Luan', username: 'capjam'}

      context 'with space' do
        before do
          get :index, {q: 'luan james'}
        end

        it { expect(response).to have_http_status(:success) }
        it { is_expected.to render_with_layout :application }
        it { is_expected.to render_template :index }
        it 'has results' do
          expect(assigns(:results)).to match_array([u1, u4, u3])
        end
      end

      context 'by username' do
        before do
          get :index, {q: 'dar'}
        end

        it { expect(response).to have_http_status(:success) }
        it { is_expected.to render_with_layout :application }
        it { is_expected.to render_template :index }
        it 'has results' do
          expect(assigns(:results)).to match_array([u2])
        end
      end
    end
  end

end
