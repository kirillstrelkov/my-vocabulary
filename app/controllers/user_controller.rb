class UserController < ApplicationController
  def update_score
    # TODO: fix because any user can trigger it manually
    command = params[:command]
    status = :failed
    if loggedin?
      if command
        command = command.to_sym
        user = User.find(session[:user_id])
        if command == :increase
          user.score += 1
        end
        if command == :decrease
          user.score -= 1
        end
        user.save!
        status = command
      end
    end
    render json: {status: status}
  end
end
