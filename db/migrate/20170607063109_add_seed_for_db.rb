# frozen_string_literal: true

class AddSeedForDb < ActiveRecord::Migration
  def up
    execute 'SELECT setseed(0.78);'
  end
end
