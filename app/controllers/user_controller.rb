class UserController < ApplicationController
  def update_score
    # TODO: fix because any user can trigger it manually
    command = params[:command]
    status = :failed
    if user_signed_in?
      if command
        command = command.to_sym
        if command == :increase
          current_user.score += 1
        elsif command == :decrease
          current_user.score -= 1
        end
        current_user.save!
        status = command
      end
    end
    render json: { status: status }
  end
end
