class SessionsController < ApplicationController
  def create
    user = User.find_by(User_Name: params[:Username])
		puts "user: #{user}"
    if user&.authenticate(params[:Password])
			puts "authenticated"
        session[:user_id] = user.id
        cookies.signed[:user_id] ||= user.id
        render json: user, status: :ok
    else
      render json: {error: "Invalid username or password"}, status: :unauthorized
    end
  end

  def test
    puts "sending"
    TestMailer.welcome_email.deliver_now
    puts "sent"
  end
end
