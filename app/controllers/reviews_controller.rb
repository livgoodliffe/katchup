class ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @spot = Spot.find(params[:spot_id])
    @review = Review.new(review_params)
    @review.spot = @spot
    @review.user = current_user

    if @review.save
      respond_to do |format|
        format.html { redirect_to @spot }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "spots/show" }
        format.js
      end
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:rating, :notes, :image)
  end
end
