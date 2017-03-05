require 'rails_helper'

describe Ticket do
  let(:customer) { create(:customer) }
  let(:support_agent) { create(:support_agent) }
  let(:admin_agent) { create(:admin_agent) }
  let(:fishy_user) { create(:customer) }
  let(:ticket) { create(:ticket, customer_id: customer.id, support_agent_id: support_agent.id) }
  let(:resolved_ticket) { create(:ticket, status: 'Resolved', support_agent_id: admin_agent.id) }
  let(:ticket_2) { create(:ticket, status: 'Resolved', updated_at: (Date.today - 2.month), support_agent_id: support_agent.id) }

  it 'returns tickets assigned to me' do
    expect(Ticket.assigned_to_me(support_agent)).to include(ticket, ticket_2)
    expect(Ticket.assigned_to_me(support_agent)).not_to include(resolved_ticket)
  end

  it 'returns tickets closed within one month' do
    expect(Ticket.closed_one_month).to include(resolved_ticket)
    expect(Ticket.closed_one_month).not_to include(ticket_2)
  end
end
