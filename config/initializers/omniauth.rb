Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '265664360191857', '7ba92a352dc7018230dd007c4b843465',
           :scope => 'email,offline_access,publish_stream', :display => 'popup'
end