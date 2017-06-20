require 'csv'
require 'json'
require 'sqlite3'


#data =

#CSV.parse(data).to_json


extracted_data   = CSV.table('data/nba-tattoos/nba_tattoos.csv')
transformed_data = extracted_data.map { |row| row.to_hash } #turns extracted data into hash



# puts transformed_data

class CreateTattoo
  attr_accessor :db



  def db
    @db ||= SQLite3::Database.new("data/nba-tattoos/tattoo.db")
  end

  db.execute(sql)

end
