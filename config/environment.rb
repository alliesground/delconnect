require 'active_record'
require 'require_all'

ActiveRecord::Base.establish_connection(
    :adapter => "postgresql",
    :database => "delconnect_development",
    :host => ENV["POSTGRES_HOST"],
    :user => ENV["POSTGRES_USER"]
)

require_all 'lib'

ActiveRecord::Base.logger = nil
