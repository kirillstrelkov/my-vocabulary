# frozen_string_literal: true

class UserController < ApplicationController
  def update_score
    # TODO: fix not safe - because any user can trigger it manually
    word_id = params[:word_id]
    status = :failed
    if user_signed_in? && word_id
      word = current_user.words.find(word_id)
      command = params[:command]
      if command && word
        command = command.to_sym
        case command
        when :increase
          current_user.update_attribute(:score, current_user.score + 1)
          word.update_attribute(:memorized, word.memorized + 1)
        when :decrease
          current_user.update_attribute(:score, current_user.score - 1)
          word.update_attribute(:memorized, word.memorized - 1) if word.memorized.positive?
        end
        status = command
      end
    end
    render json: { status: status }
  end
end
