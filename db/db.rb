require 'sqlite3'

module DB
  def self.connection
    @@db ||= create_db
  end
  
  def self.find_by opts
    selected = opts.keys.first.to_s
    from = (selected == "short") ? "long" : "short" 
    value = opts.values.first
    query = connection.execute <<-SQL
      SELECT "#{from}" FROM links WHERE "#{selected}" = "#{value}" LIMIT 1;
    SQL

    query&.first&.first
  end

  def self.create(long, short)
    query = connection.execute <<-SQL
      INSERT INTO links(long, short) VALUES ("#{long}", "#{short}") RETURNING short;
    SQL
    
    query&.first&.first
  end

  def self.migrate db
    db.execute <<-SQL 
    CREATE TABLE IF NOT EXISTS links (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      long CHAR(30) UNIQUE NOT NULL,
      short CHAR(30) UNIQUE NOT NULL 
    );

    CREATE INDEX source_index ON links(long);

    CREATE INDEX source_index ON links(short)
    SQL
  end

  def self.create_db
    db = SQLite3::Database.new 'db/test.db'
    migrate db

    db
  end
end



