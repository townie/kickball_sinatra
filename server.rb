require 'sinatra'
require 'csv'
require 'open-uri'

@fav_team = nil

def load_players

  @players = {}

  CSV.foreach('lackp_starting_rosters.csv', headers: true, :header_converters => :symbol, :converters => :all) do |row|
    @players[(row[:first_name] + " " +row[:last_name])] = {
        position: row[:position],
        team: row[:team]
    }
  end
  @players
end

def get_teams(players)
 teams =[]
   players.each do |player, pos_team|

      if pos_team[:team] != (teams.include?(pos_team[:team]))
        teams<< pos_team[:team]
      end

  end
  teams.uniq
end


get '/' do
 @teams = get_teams(load_players)
 erb :index
end


team_name = get_teams(load_players)

team_name.each do |name_of_team|
  get "/#{URI::encode(name_of_team)}" do
    @players = load_players
    @current_team = name_of_team
    erb :team
  end
end

get '/players' do
  @players = load_players
  @fav_team = @fav_team
  erb :players
end

# These lines can be removed since they are using the default values. They've
# been included to explicitly show the configuration options.
set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'
