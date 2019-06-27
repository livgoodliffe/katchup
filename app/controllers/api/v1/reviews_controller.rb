class Api::V1::ReviewsController < Api::V1::BaseController

  def index
    @reviews = policy_scope(Review)
  end

  def show
    @spots = Spot.find(params[:id])
    authorise @spot
  end

  # before_action :set_review, only: [:show, :update, :destroy]

  # def index
  #   @reviews = Review.where(user_id: User.find(params[:id]))
  # end

  # def show
  # end

  # def create
  #   @spot = Spot.find(params[:spot_id])
  #   @review = Review.new(review_params)
  #   @review.spot = @spot
  #   @review.user = current_user

  #   if @review.save
  #     render :json => @review.to_json
  #   else
  #     render :json => @review.errors.full_messages.to_json
  #   end
  # end

  # def update
  #   if @review.update(review_params)
  #     render :json => @review.to_json
  #   else
  #     render :json => @review.errors.full_messages.to_json
  #   end
  # end

  # def destroy
  #   if @review.destroy
  #     render :json => @review.to_json
  #   else
  #     render :json => @review.errors.full_messages.to_json
  #   end
  # end

  # private

  # def review_params
  #   params.require(:review).permit(:rating, :notes, :image)
  # end

  # def set_review
  #   @review = Review.find(params[:id])
  # end

end

