# == Schema Information
#
# Table name: reviews
#
#  id         :uuid             not null, primary key
#  author     :string           not null
#  body       :text
#  headline   :string           not null
#  rating     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :uuid             not null
#
# Indexes
#
#  index_reviews_on_product_id                            (product_id)
#  index_reviews_on_product_id_and_created_at_and_rating  (product_id,created_at,rating)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :review do
    author { Faker::Artist.name }
    rating { rand(1..5) }
    headline { Faker::Restaurant.review }
    body { Faker::Restaurant.description }
    product
  end
end
