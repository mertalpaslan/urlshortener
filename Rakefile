require 'sqlite3'

desc "Create db and tables"

namespace :db do
  task :setup do
    db = SQLite3::Database.new  'db/test.db'

    db.execute <<-SQL 
      CREATE TABLE links (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        long CHAR(30) UNIQUE NOT NULL,
        short CHAR(30) UNIQUE NOT NULL 
      );

      CREATE INDEX source_index ON links(long);

      CREATE INDEX source_index ON links(short)
      SQL
  end
end