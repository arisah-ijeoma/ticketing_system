require 'rails_helper'

describe MessagesController do
  let(:customer) { create(:customer) }
  let(:fishy_user) { create(:customer) }
  let(:support_agent) { create(:support_agent) }
  let(:ticket) { create(:ticket, customer_id: customer.id, support_agent_id: support_agent.id) }
  let(:message) { create(:message, ticket_id: ticket.id) }

  describe 'GET#index' do
    it 'does not authorize for users not logged in' do
      get :index, params: {ticket_id: ticket}
      expect(response.status).to eq(403)
    end

    it 'does not authorize users that do not own the ticket' do
      login fishy_user
      get :index, params: {ticket_id: ticket}
      expect(response.status).to eq(403)
    end
  end

  describe 'can not create tickets if not logged in' do
    it 'does not authorize customer' do
      post :create, params: { ticket_id: ticket, message: {text: 'I need you'} }
      expect(response.status).to eq(403)
    end
  end

  describe 'customers' do
    before do
      login customer
    end

    describe 'GET#index' do
      it 'returns ok status' do
        get :index, params: {ticket_id: ticket}
        expect(response.status).to eq(200)
      end
    end

    describe 'POST#create' do
      it 'can create' do
        post :create, params: { ticket_id: ticket, message: {text: 'Access granted'} }
        expect(response.status).to eq(201)
      end
    end

    describe 'GET#show' do
      it 'has ok status' do
        get :show, params: { ticket_id: ticket, id: message }
        expect(response.status).to eq(200)
      end

      it 'fishy user can not read' do
        login fishy_user

        get :show, params: { ticket_id: ticket, id: message }
        expect(response.status).to eq(403)
      end
    end

    describe 'DELETE#destroy' do
      it 'can not destroy' do
        delete :destroy, params: { id: message, ticket_id: ticket }
        expect(response.status).to eq(403)
      end
    end
  end

  describe 'support agents' do
    before do
      login support_agent
    end

    describe 'GET#index' do
      it 'returns ok status' do
        get :index, params: {ticket_id: ticket}
        expect(response.status).to eq(200)
      end
    end

    describe 'POST#create' do
      it 'returns created status' do
        post :create, params: { ticket_id: ticket, message: {text: 'I need access'} }
        expect(response.status).to eq(201)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(ActionMailer::Base.deliveries.first.to).to eq([customer.email])
      end
    end

    describe 'GET#show' do
      it 'has ok status' do
        get :show, params: { ticket_id: ticket, id: message }
        expect(response.status).to eq(200)
      end
    end

    describe 'DELETE#destroy' do
      it 'returns ok status' do
        delete :destroy, params: { id: message, ticket_id: ticket }
        expect(response.status).to eq(200)
        expect(Message.exists?(message.id)).to be false
      end
    end
  end
end
