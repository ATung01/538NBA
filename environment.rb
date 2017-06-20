require 'bundler/setup'
# require 'csv'
# require 'json'

Bundler.require
#CSV.require
require_all 'app'

# @db = SQLite3::Database.new('data/nba-tattoos/tattoo.db')
@db.execute("DROP TABLE IF EXISTS tattos;")
