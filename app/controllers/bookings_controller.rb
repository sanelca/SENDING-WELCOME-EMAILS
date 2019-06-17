class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @flight = Flight.find(params[:flight_id])
    @num_passengers = params[:num_passengers].to_i
    if @num_passengers < 1 || @num_passengers > 4
      @num_passengers = 1
    end
    @num_passengers.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      flash[:success] = "Booking created!"
      @booking.passengers.each do |passenger|
        PassengerMailer.with(passenger: passenger, booking: @booking).thank_you_email.deliver_now!
      end
      redirect_to @booking
    else
      @flight = Flight.find(booking_params[:flight_id].to_i)
      if match = /\d/.match(params[:num_passengers])
        @num_passengers = match.captures.first.to_i
      end
      render 'new'
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:id, :name, :email, :booking_id])
  end

end
