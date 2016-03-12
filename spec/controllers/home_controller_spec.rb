require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET #index' do
    context 'when has no param' do
      subject do
        get :index
      end

      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
    end
  end
end
