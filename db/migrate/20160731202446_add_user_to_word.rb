# frozen_string_literal: true

class AddUserToWord < ActiveRecord::Migration
  def change
    add_reference :words, :user, index: true
  end
end
