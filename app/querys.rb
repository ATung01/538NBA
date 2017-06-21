
class Queries
  @db = SQLite3::Database.open("./app/nba_database.db")


  def self.top_ten_busts
    has_tattoo = 0
    @db.execute("Select drafts.player, drafts.bust, tattoos.tattoo From drafts Inner Join tattoos On drafts.player = tattoos.player_name Order By drafts.bust Desc Limit 10").each do |player|
      if player[2] == "yes"
        player[2] = "does"
        has_tattoo += 1
      else
        player[2] = "does NOT"
      end
      puts "The player #{player[0]} has a bust likelihood of #{(player[1] * 100).round(2)}% and #{player[2]} have a tattoo."
    end
    puts "\n#{has_tattoo} out of the top 10 players most likely to bust have tattoos."




  end

end
