module SessionHelper
  def update_session(key, value)
    Rails.logger.debug("#{self}##{__method__} params: #{key} #{value}")
    session[key] = value
  end
end
