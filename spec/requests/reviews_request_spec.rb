require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  
  describe 'GET #index' do
    let(:product) { create(:product) }
    let!(:review_1) { create(:review, product: product, created_at: DateTime.now, rating: 2) }
    let!(:review_2) { create(:review, product: product, created_at: DateTime.now + 1.day, rating: 1) }

    it "is a success" do
      get reviews_path

      expect(response).to have_http_status(:ok)
    end

    context 'default ordering' do
      it 'orders reviews by date descending' do       
        get reviews_path
        
        expect(JSON.parse(response.body)[0]).to eq(review_2.as_json)
        expect(JSON.parse(response.body)[1]).to eq(review_1.as_json)
      end
    end

    context 'when sorting' do
      context 'by star rating ascending' do
        it 'returns reviews sorted by rating ascending' do
          get reviews_path(sort_by: 'rating', order_by: 'asc')
      
          expect(JSON.parse(response.body)[0]).to eq(review_2.as_json)
          expect(JSON.parse(response.body)[1]).to eq(review_1.as_json)
        end
      end

      context 'by star rating descending' do
        it 'returns reviews sorted by rating descending' do
          get reviews_path(sort_by: 'rating', order_by: 'desc')
      
          expect(JSON.parse(response.body)[0]).to eq(review_1.as_json)
          expect(JSON.parse(response.body)[1]).to eq(review_2.as_json)
        end
      end

      context 'by date ascending' do
        it 'returns reviews sorted by date ascending' do
          get reviews_path(sort_by: 'created_at', order_by: 'asc')
      
          expect(JSON.parse(response.body)[0]).to eq(review_1.as_json)
          expect(JSON.parse(response.body)[1]).to eq(review_2.as_json)
        end
      end

      context 'by date descending' do
        it 'returns reviews sorted by date descending' do
          get reviews_path(sort_by: 'created_at', order_by: 'desc')
      
          expect(JSON.parse(response.body)[0]).to eq(review_2.as_json)
          expect(JSON.parse(response.body)[1]).to eq(review_1.as_json)
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'returns vaild review' do
        product = create(:product)        
        
        post '/reviews', params:
                          { review: {
                            author: 'author name',
                            rating: 3,
                            headline: 'news headline',
                            body: 'body content',
                            product_id: product.id
                          } }

        expect(JSON.parse(response.body)['author']).to eq('author name')
        expect(JSON.parse(response.body)['rating']).to eq(3)
        expect(JSON.parse(response.body)['headline']).to eq('news headline')
        expect(JSON.parse(response.body)['body']).to eq('body content')
      end
    end

    context 'with invalid parameters' do
      it 'returns a unprocessable entity status' do
        post '/reviews', params:
        { review: {
          author: '',
          rating: '',
          headline: '',
          body: '',
          product_id: ''
        } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #product' do
    let(:product) { create(:product) }
    let!(:review_1) { create(:review, product: product, created_at: DateTime.now, rating: 2) }
    let!(:review_2) { create(:review, product: product, created_at: DateTime.now + 1.day, rating: 1) }

    it "is a success" do
      get product_reviews_path(product_id: product.id)

      expect(response).to have_http_status(:ok)
    end

    context 'default ordering' do
      it 'orders reviews by date descending' do       
        get product_reviews_path(product_id: product.id)
        
        expect(JSON.parse(response.body)[0]).to eq(review_2.as_json)
        expect(JSON.parse(response.body)[1]).to eq(review_1.as_json)
      end
    end

    context 'when sorting' do
      context 'by star rating ascending' do
        it 'returns reviews sorted by rating ascending' do
          get product_reviews_path(product_id: product.id, sort_by: 'rating', order_by: 'asc')
      
          expect(JSON.parse(response.body)[0]).to eq(review_2.as_json)
          expect(JSON.parse(response.body)[1]).to eq(review_1.as_json)
        end
      end

      context 'by star rating descending' do
        it 'returns reviews sorted by rating descending' do
          get product_reviews_path(product_id: product.id, sort_by: 'rating', order_by: 'desc')
      
          expect(JSON.parse(response.body)[0]).to eq(review_1.as_json)
          expect(JSON.parse(response.body)[1]).to eq(review_2.as_json)
        end
      end

      context 'by date ascending' do
        it 'returns reviews sorted by date ascending' do
          get product_reviews_path(product_id: product.id, sort_by: 'created_at', order_by: 'asc')
      
          expect(JSON.parse(response.body)[0]).to eq(review_1.as_json)
          expect(JSON.parse(response.body)[1]).to eq(review_2.as_json)
        end
      end

      context 'by date descending' do
        it 'returns reviews sorted by date descending' do
          get product_reviews_path(product_id: product.id, sort_by: 'created_at', order_by: 'desc')
      
          expect(JSON.parse(response.body)[0]).to eq(review_2.as_json)
          expect(JSON.parse(response.body)[1]).to eq(review_1.as_json)
        end
      end
    end
  end
end




    