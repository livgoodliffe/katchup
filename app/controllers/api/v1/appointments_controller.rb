class Api::V1::AppointmentsController < Api::V1::BaseController

  before_action :set_appointment, only: [:show, :update, :destroy]
  def index
    @appointments = current_user.appointments
  end

  def show
  end

  def create
    @appointment = Appointment.new(appointments_params.merge(user_id: current_user.id))
    if @appointment.save
      render :json => @appointment.to_json
    else
      render :json => @appointment.errors.full_messages.to_json
    end
  end

  def update
    if @appointment.update(appointments_params)
      render :json => @appointment.to_json
    else
      render :json => @appointment.errors.full_messages.to_json
    end
  end

  def destroy
    if @appointment.destroy
      render :json => @appointment.to_json
    else
      render :json => @appointment.errors.full_messages.to_json
    end
  end

  private

  def appointments_params
    params.require(:appointment).permit(:title, :body)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
