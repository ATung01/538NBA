require 'csv'
require 'json'
require 'sqlite3'
require 'pry'

class NbaProjections

  def self.run

    extracted_data = CSV.table("./app/historical_projections.csv")
    transformed_data = extracted_data.map { |row| row.to_hash }

    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS drafts (
    num_id INTEGER PRIMARY KEY,
    player TEXT,
    position TEXT,
    id TEXT,
    draft_year INTEGER,
    projected_spm REAL,
    superstar REAL,
    starter REAL,
    role_player REAL,
    bust REAL)
    SQL

    db = SQLite3::Database.new("./app/nba_database.db")
    db.execute("DROP TABLE IF EXISTS drafts;")
    db.execute(sql)

    transformed_data.each do |data|
      insert_sql = "Insert into drafts (player, position, id, draft_year, projected_spm, superstar, starter, role_player, bust) values (?, ?, ?, ?, ?, ?, ?, ?, ?)"
      db.execute(insert_sql, data[:player], data[:position], data[:id], data[:draft_year], data[:projected_spm], data[:superstar], data[:starter], data[:role_player], data[:bust])
    end


  end

  # p db.execute("Select * from drafts")

end

# draft = Nba/Projections.new
# draft.run
