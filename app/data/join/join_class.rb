require 'csv'
require 'json'
require 'sqlite3'
require 'pry'

class Joins

  sql = <<-SQL
    SELECT *
    from drafts
    INNER JOIN tattoos
    ON drafts.player = tattoos.player_name
    GROUP BY tattoos.tattoo
    ORDER BY drafts.bust DESC;
  SQL

  db = SQLite3::Database.new(":memory:")
  db.execute(sql)

end
