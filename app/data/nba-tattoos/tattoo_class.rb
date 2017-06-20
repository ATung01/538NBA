require 'csv'
require 'json'
require 'sqlite3'
require 'pry'

#data =

#CSV.parse(data).to_json





# puts transformed_data
# binding.pry
class CreateTattoo

  extracted_data   = CSV.table("./nba_tattoos.csv")
  transformed_data = extracted_data.map { |row| row.to_hash } #turns extracted data into hash

  sql = <<-SQL
  CREATE TABLE IF NOT EXISTS tattoos (
  id INTEGER PRIMARY KEY,
  player_name TEXT,
  tattoo Boolean)
  SQL

  db = SQLite3::Database.new("./tattoos.db")
  db.execute("DROP TABLE IF EXISTS tattoos;")
  db.execute(sql)

  transformed_data.each do |data|
    insert_sql = "Insert into tattoos (player_name, tattoo) values (?, ?)"
    db.execute(insert_sql, data[:player_name], data[:tattoos_yesno])
  end
  #
  db.execute("Select * from tattoos")
  # db.execute(sql)

end
