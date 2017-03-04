require 'rails_helper'

describe SupportAgentsController do

  let!(:admin) { create(:admin_agent) }

  context 'POST#create' do
    describe 'admin' do
      before do
        login admin
      end

      it 'admin can create support agent' do
        post :create, { params: { support_agent: attributes_for(:support_agent) } }
        expect(response.status).to eq(201)
      end
    end
  end
end
