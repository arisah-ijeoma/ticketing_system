require 'rails_helper'

describe UsersController do

  let(:admin) { create(:admin_agent) }
  let(:user) { create(:user) }

  context 'POST#create' do
    describe 'admin' do
      before do
        login admin
      end

      it 'admin can create support agent' do
        post :create, { params: attributes_for(:support_agent) }
        expect(response.status).to eq(201)
      end
    end

    describe 'POST#create' do
      it 'can create customer' do
        post :create, { params: attributes_for(:customer) }
        expect(response.status).to eq(201)
      end
    end
  end
end
