require 'rails_helper'

describe SessionsController do
  describe 'POST#create' do
    let(:user) { create(:user) }

    describe 'POST#create' do
      describe 'successful login' do
        it 'returns the user access token' do

          user_params = { 'email' => user.email, 'password' => user.password }

          post :create, params: user_params

          expect(response.status).to eq(201)
        end
      end

      describe 'unsuccessful login' do
        it 'returns the error' do

          user_params = { 'email' => 'user.email', 'password' => 'user.password' }

          post :create, params: user_params

          expect(response.status).to eq(406)
        end
      end
    end

    describe 'DELETE#destroy' do
      it 'logs user out' do
        user_params = { 'token' => user.token }

        delete :destroy, params: user_params

        expect(response.body).to eq('')
        expect(response.status).to eq(204)
      end
    end
  end
end
