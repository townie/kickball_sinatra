require 'csv'


players = {}

CSV.foreach('lackp_starting_rosters.csv', headers: true, :header_converters => :symbol, :converters => :all) do |row|
  players[(row[:first_name] + " " +row[:last_name])] = {

      position: row[:position],
      team: row[:team]

  }
end

@team =[]

 players.each do |player, pos_team|

    if pos_team[:team] != (@team.include?(pos_team[:team]))
      @team<< pos_team[:team]
    end
    # if pos_team[:team] == "Flinestone Fire" #"Fred Flinestone"=>{:position=>"Catcher", :team=>"Flinestone Fire"}
    #     puts player
    #   end
end

@team.uniq

#puts players["Bart Simpson"][:team]
