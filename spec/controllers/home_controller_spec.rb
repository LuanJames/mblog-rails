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
end
