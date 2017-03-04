class SupportAgentsController < ApplicationController
  load_and_authorize_resource class: 'SupportAgent'

  def index
    support_agents = SupportAgent.all
    render json: support_agents
  end

  def create
    support_agent = SupportAgent.new(support_agent_params)

    if support_agent.save
      render json: support_agent, status: :created, serializer: SupportAgentSerializer, root: nil
    else
      render json: { error: 'Error' }, status: :unprocessable_entity
    end
  end

  private

  def support_agent_params
    params.require(:support_agent).permit(:email, :first_name, :last_name, :password)
  end
end
