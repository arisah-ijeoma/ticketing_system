require 'rails_helper'

describe SessionsController do
  let(:customer) { create(:customer) }
  let(:support_agent) { create(:support_agent) }

  describe 'POST#create' do
    describe 'successful login' do
      it 'returns the customer access token' do

        customer_params = { 'email' => customer.email, 'password' => customer.password }

        post :create, params: customer_params

        expect(response.status).to eq(201)
      end
    end

    describe 'unsuccessful login' do
      it 'returns the error' do

        customer_params = { 'email' => 'user.email', 'password' => 'user.password' }

        post :create, params: customer_params

        expect(response.status).to eq(406)
      end
    end
  end

  context 'destroy' do
    describe 'logged in' do
      before do
        login support_agent
      end

      it 'logs support agent out' do

        delete :destroy

        expect(response.body).to eq('')
        expect(response.status).to eq(204)
      end
    end

    describe 'not logged in' do
      it 'does not work if you are not signed in' do

        delete :destroy

        expect(response.status).to eq(404)
      end
    end
  end
end
