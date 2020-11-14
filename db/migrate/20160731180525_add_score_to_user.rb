# frozen_string_literal: true

class AddScoreToUser < ActiveRecord::Migration
  def change
    add_column :users, :score, :integer, default: 0
  end
end
