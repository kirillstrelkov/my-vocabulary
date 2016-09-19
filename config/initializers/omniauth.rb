Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :google, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
  # provider :vkontakte, ENV['VKONTAKTE_KEY'], ENV['VKONTAKTE_SECRET']
  provider :vkontakte, '5603331', 'BVAxVsvFKnzMF6QRiaIW'
end
