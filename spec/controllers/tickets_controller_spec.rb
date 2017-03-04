require 'rails_helper'

describe TicketsController do
  let(:customer) { create(:customer) }
  let(:support_agent) { create(:support_agent) }
  let(:fishy_user) { create(:customer) }
  let(:ticket) { create(:ticket, customer_id: customer.id) }
  let(:ticket_params) { {
          'title' => ticket.title,
          'description' => ticket.description
  } }

  describe 'GET#index' do
    it 'returns ok status' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'can not create tickets if not logged in' do
    it 'does not authorize customer' do
      post :create, params: ticket_params
      expect(response.status).to eq(403)
    end
  end

  describe 'customers' do
    before do
      login customer
    end

    describe 'POST#create' do
      it 'returns ok status' do
        post :create, params: ticket_params
        expect(response.status).to eq(201)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(ActionMailer::Base.deliveries.first.to).to eq([customer.email])
      end
    end

    describe 'GET#show' do
      it 'has ok status' do
        get :show, params: { id: ticket }
        expect(response.status).to eq(200)
      end

      it 'fishy user can not read' do
        login fishy_user

        get :show, params: { id: ticket }
        expect(response.status).to eq(403)
      end
    end

    describe 'DELETE#destroy' do
      it 'does not authorize' do
        delete :destroy, params: { id: ticket }
        expect(response.status).to eq(403)
      end
    end
  end

  describe 'support agents' do
    before do
      login support_agent
    end

    describe 'POST#create' do
      it 'does not authorize' do
        post :create, params: ticket_params
        expect(response.status).to eq(403)
      end
    end

    describe 'GET#show' do
      it 'has ok status' do
        get :show, params: { id: ticket }
        expect(response.status).to eq(200)
      end
    end

    describe 'DELETE#destroy' do
      it 'returns ok status' do
        delete :destroy, params: { id: ticket }
        expect(response.status).to eq(200)
        expect(Ticket.exists?(ticket.id)).to be false
      end
    end
  end
end
