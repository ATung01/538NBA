
class Queries
  @db = SQLite3::Database.open("./app/nba_database.db")


  def self.top_ten_busts
    has_tattoo = 0
    puts "| Player\t\t| Bust likelihood | Tattoo present|"
    @db.execute("Select drafts.player, drafts.bust, tattoos.tattoo From drafts Inner Join tattoos On drafts.player =
    tattoos.player_name Order By drafts.bust Desc Limit 10").each do |player|
      if player[2] == "yes"
        player[2] = "does"
        has_tattoo += 1
      else
        player[2] = "does NOT"
      end
      # puts "The player #{player[0]} has a bust likelihood of #{(player[1] * 100).round(2)}% and #{player[2]} have a tattoo."
      puts "|#{player[0]}\t\t| #{(player[1] * 100).round(1)}%\t\t| #{player[2]}\t|"
    end
    puts "\n#{has_tattoo} out of the top 10 players most likely to bust have tattoos."
  end

  def self.superstars

  end

  def self.most_likely
    starter_counter = 0.0
    role_counter = 0.0
    bust_counter = 0.0
    starter_no_tat = 0.0
    role_no_tat = 0.0
    bust_no_tat = 0.0
    @db.execute("Select drafts.player, drafts.starter, drafts.role_player, drafts.bust, tattoos.tattoo From drafts Inner Join tattoos On drafts.player = tattoos.player_name Order By tattoos.tattoo").each do |player|
      best_stat_number = player.select{|x| x.class == Float }.max
      # binding.pry
      x = ['starter', 'role player', 'bust']

      best_stat = player.slice(1, 3).index(best_stat_number)
      case x[best_stat]
      when x[0]
        player.last == "yes" ? starter_counter += 1 : starter_no_tat += 1
      when x[1]
        player.last == "yes" ? role_counter += 1 : role_no_tat += 1
      when x[2]
        player.last == "yes" ? bust_counter += 1 : bust_no_tat += 1

      end

        # binding.pry
      # end

      # puts "The player #{player[0]} has a #{x[best_stat]} likelihood of #{(best_stat_number * 100).round(2)}%."
    end
    puts "There were #{starter_counter.to_i} starters, #{role_counter.to_i} role players, and #{bust_counter.to_i} bust players that had tattoos."
    puts "There were #{starter_no_tat.to_i} starters, #{role_no_tat.to_i} role players, and #{bust_no_tat.to_i} bust players that didn't have tattoos."

    total_tats = starter_counter + role_counter + bust_counter
    total_without_tats = starter_no_tat + role_no_tat + bust_no_tat
    # binding.pry


    puts "Of the #{total_tats} players with tattoos, #{((starter_counter/total_tats)*100).round(1)}% were projected to be starters, #{((role_counter/total_tats)*100).round(1)}% role players, and #{((bust_counter/total_tats)*100).round(1)}% busts."

    puts "Of the #{total_without_tats} players without tattoos, #{((starter_no_tat/total_without_tats)*100).round(1)}% were projected to be starters, #{((role_no_tat/total_without_tats)*100).round(1)}% role players, and #{((bust_no_tat/total_without_tats)*100).round(1)}% busts."

  end

end
