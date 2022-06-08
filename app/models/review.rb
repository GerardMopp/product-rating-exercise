# frozen_string_literal: true

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
class Review < ApplicationRecord
  belongs_to :product
  
  validates_presence_of :author, :headline, :rating

  validates :rating, inclusion: 0..5

  SORT_BY = 'rating', 'created_at'
  ORDER_BY = 'asc', 'desc'

  def self.query(sort_by: 'created_at', order_by: 'desc')
    if SORT_BY.include?(sort_by) && ORDER_BY.include?(order_by)
      order("#{sort_by} #{order_by}")
    else
      order(created_at: :desc)
    end   
  end
end
