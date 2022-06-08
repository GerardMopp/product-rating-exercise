# frozen_string_literal: true

class ReviewsController < ApplicationController
  def index
    @reviews = Review.query(sort_by: index_params[:sort_by], order_by: index_params[:order_by])

    render json: @reviews, status: :ok
  end

  def create
    @review = Review.new(review_params)
      
    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end
  
  def product
    @reviews = Review.where(product_id: index_params[:product_id]).query(sort_by: index_params[:sort_by], order_by: index_params[:order_by])

    render json: @reviews, status: :ok
  end

  private

  def review_params
    params.require(:review).permit(:author, :rating, :headline, :body, :product_id)
  end

  def index_params
    params.permit(:product_id, :sort_by, :order_by)
  end
end
