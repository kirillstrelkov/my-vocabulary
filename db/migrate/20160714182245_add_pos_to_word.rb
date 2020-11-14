# frozen_string_literal: true

class AddPosToWord < ActiveRecord::Migration
  def change
    add_column :words, :pos, :string
  end
end
