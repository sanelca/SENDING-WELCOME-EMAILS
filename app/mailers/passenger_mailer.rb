class PassengerMailer < ApplicationMailer
  def thank_you_email
    @passenger = params[:passenger]
    @booking = params[:booking]
    @url = booking_url(@booking)
    mail(to: @passenger.email, subject: 'Thanks for booking with Flight-Booker!')
  end
end
