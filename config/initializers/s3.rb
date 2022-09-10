if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'jvtumg3loiuzldavi7q66icnpuxq',
      :aws_secret_access_key  => 'j2ip6uybjo6o265ilnukc46u42x22vijx6xofdha6kzvjwr7panmo',
      :region                 => 'us-east-1', # Change this for different AWS region. Default is 'us-east-1'
      :endpoint                 => 'https://gateway.storjshare.io', # Change this for different AWS region. Default is 'us-east-1'
    }
    # config.fog_credentials = {
      #     :provider               => 'AWS',
      #     :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
      #     :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
      #     :region                 => ENV['AWS_REGION'], # Change this for different AWS region. Default is 'us-east-1'
      #     :bucket                 => ENV['AWS_BUCKET'],
      #     :endpoint                 => 'https://gateway.storjshare.io', # Change this for different AWS region. Default is 'us-east-1'
      # }
      config.fog_directory  = "hopify-bucket"
      # config.cache_dir = "#{Rails.root}/tmp/uploads"
      config.storage = :fog
      config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}", "Content-Length": 9999, "Content-Type": "mime/type" }
      config.fog_public = true
    end
end
    