Rails.application.configure do
  config.action_cable.disable_request_forgery_protection = false
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = false
  config.assets.compile = false
  config.action_controller.asset_host = ENV.fetch("ASSET_HOST", ENV.fetch("APPLICATION_HOST"))
  config.action_controller.default_asset_host_protocol = "https"
  config.active_storage.service = :local
  config.log_level = :debug
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end
  config.active_record.dump_schema_after_migration = false
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=31557600",
  }
  config.action_mailer.default_url_options = {
    host: ENV.fetch("APPLICATION_HOST"),
    protocol: "https",
  }
  config.action_mailer.asset_host = ENV.fetch("ASSET_HOST", ENV.fetch("APPLICATION_HOST"))
  config.credentials.key_path = "/var/rails/cntrl.mike-burns.com/production.key"
end
