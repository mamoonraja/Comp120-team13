# config/initializers/carrierwave.rb

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],                        # required
    :aws_secret_access_key  => ENV["AWS_SECRET_KEY"],
    :endpoint               => 'https://s3.amazonaws.com'                     # required
  }
  config.fog_directory  = ENV["AWS_BUCKET"]                     # required
end
