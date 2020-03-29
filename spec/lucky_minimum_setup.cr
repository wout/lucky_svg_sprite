# set up lucky loggor to avoid errors
Lucky.configure do |settings|
  settings.logger = Dexter::Logger.new(nil)
end
