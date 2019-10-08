class Api::V1::ReviewsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_review, only: [ :show, :update ]

  def index
    @reviews = policy_scope(Review)
  end

  def show
  end

  def update
    if @review.update(review_params)
      render :show
    else
      render_error
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
    authorize @review  # For Pundit
  end

  def review_params
    params.require(:review).permit(:rating, :notes)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
      status: :unprocessable_entity
  end
end
