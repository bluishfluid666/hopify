if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => "jutnxoxwwvzf266il65igf3fnjoq",
        :aws_secret_access_key  => "j3g5j3siqyclxefn7nvbgv4vthgfslkht23udjvsknh4imtff3pi2",
        :region                 => 'us-east-1', # Change this for different AWS region. Default is 'us-east-1'
        :endpoint                 => 'https://gateway.storjshare.io' # Change this for different AWS region. Default is 'us-east-1'
    }
    config.fog_directory  = "hopify-bucket"
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.storage = :fog
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
    config.fog_public = true
  end
end
