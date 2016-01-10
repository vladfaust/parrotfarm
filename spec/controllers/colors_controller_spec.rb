require 'rails_helper'

RSpec.describe ColorsController, type: :controller do
  render_views

  let :json do
    JSON.parse(response.body)
  end

  describe 'GET #index' do
    it 'returns colors' do
      create(:color_red)
      create(:color_green)
      create(:color_blue)

      get :index, format: :json

      expect(json.count).to eq 3
    end
  end
end
