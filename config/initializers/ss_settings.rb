config_file = Rails.root.join('config', 'ss_settings.yml')
if File.exist?(config_file)
  config = YAML.load_file(config_file)
  Rails.configuration.ss_settings = config
else
  Rails.logger.warn("SS settings file not found at #{config_file}")
end
