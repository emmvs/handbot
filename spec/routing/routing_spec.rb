# frozen_string_literal: true

RSpec.describe 'Routing', type: :routing do
  describe 'Webhooks routing' do
    it 'routes /receive to webhooks#receive' do
      expect(post: '/receive').to route_to(controller: 'webhooks', action: 'receive')
    end
  end

  describe 'Pages routing' do
    it 'routes root to pages#home' do
      expect(get: '/').to route_to(controller: 'pages', action: 'home')
    end
  end
end
