require 'csv'
require 'json'
require 'sqlite3'
require 'pry'

class CreateTattoo

  def self.run

    extracted_data   = CSV.table("./app/nba_tattoos.csv")
    transformed_data = extracted_data.map { |row| row.to_hash }

    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS tattoos (
    id INTEGER PRIMARY KEY,
    player_name TEXT,
    tattoo Boolean)
    SQL

    db = SQLite3::Database.new("./app/nba_database.db")
    db.execute("DROP TABLE IF EXISTS tattoos;")
    db.execute(sql)

    transformed_data.each do |data|
      insert_sql = "Insert into tattoos (player_name, tattoo) values (?, ?)"
      db.execute(insert_sql, data[:player_name], data[:tattoos_yesno])
    end

    # p db.execute("Select * from tattoos")

  end

  # def self.name
    # db.execute("Select ")

end

# new_tattoo = CreateTattoo.new
# new_tattoo.run
