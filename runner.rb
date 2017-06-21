require_relative 'environment.rb'
# require_relative 'app/tattoo_class.rb'
# require_relative 'app/nba_projections_class.rb'



class Runner
  def run
    # person = LoginSignup.run
    # game = GameStarter.run(person)
    # game = PlayGame.run(game)
    # binding.pry
    tattoo = CreateTattoo.run
    draft = NbaProjections.run
    db = SQLite3::Database.open("./app/nba_database.db")
    db.execute("SELECT name from sqlite_master where type='table';").flatten.each do |table_name|
      puts "Created a table for #{table_name} \n"
    end
  questions = Queries.top_ten_busts
  end
end

blah = Runner.new
blah.run
