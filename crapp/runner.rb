require_relative '../environment.rb'
require_relative './tattoo_class.rb'
require_relative './nba_projections_class.rb'

class Runner
  def self.run
    # person = LoginSignup.run
    # game = GameStarter.run(person)
    # game = PlayGame.run(game)
    draft = NbaProjections.new
    tattoo = CreateTattoo.new
    draft.run
    tattoo.run
  end
end

runner = Runner.new
runner.run
