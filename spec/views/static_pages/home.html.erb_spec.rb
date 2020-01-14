require 'rails_helper'

RSpec.describe "static_pages/home.html.erb", type: :request do
    it '正常にページが表示される' do
        get root_path
        expect(response).to have_http_status 200
    end
end
