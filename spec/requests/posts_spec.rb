require 'rails_helper'

RSpec.describe 'Posts', type: 'request' do
  describe 'GET posts#index' do
    before :each do
      get '/users/1/posts'
    end

    it 'is success ' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'renders index template with right text' do
      expect(response.body).to include('List of all post for a specific user')
    end

    it 'does not render a different template' do
      expect(response).to_not render_template(:show)
    end
  end
  describe 'GET posts#show' do
    before :each do
      get '/users/1/posts/1'
    end

    it 'Return success code 200 ' do
      expect(response).to have_http_status(:ok)
    end

    it 'Show the list of template' do
      expect(response).to render_template(:show)
    end

    it 'renders Show template with right text' do
      expect(response.body).to include('Specific post for a specific user')
    end

    it 'does not render a different template' do
      expect(response).to_not render_template(:index)
    end
  end
end
