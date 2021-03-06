# frozen_string_literal: true

module RedisHelper
  def get(prefix, key)
    key = prepare_key(prefix, key)
    value = Rails.cache.read(key)
    value = JSON.parse(value, symbolize_names: true) if value
    value
  end

  def set(prefix, key, value)
    key = prepare_key(prefix, key)
    Rails.cache.write(key, JSON.dump(value))
  end

  private

  def prepare_key(prefix, key)
    [prefix, key].map(&:to_s).map(&:downcase).map do |e|
      e.gsub(/[\s-]+/, '_')
    end.join(':')
  end
end
