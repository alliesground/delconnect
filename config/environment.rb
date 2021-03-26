ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/journals.db"
)

require_all 'lib'

ActiveRecord::Base.logger = nil
