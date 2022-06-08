require 'rails_helper'

RSpec.describe 'Products', type: :request do
  
  describe 'GET #index' do
    let(:product_1) { create(:product) }
    let(:product_2) { create(:product) }

    it "is a success" do
      create(:review, rating: 1, product_id: product_1.id)
      create(:review, rating: 4, product_id: product_2.id)
      
      get product_index_path

      expect(JSON.parse(response.body)[0]['id']).to eq(product_2.id)
      expect(JSON.parse(response.body)[1]['id']).to eq(product_1.id)
    end
  end
end




    