class Bystander < Power

  def initialize
    @name = 'Bystander'
    @description = 'If all the players are attacking this turn, you are immune to damage'
    @phase = :after_resolve_action
  end

  def run(single_player_result)
    if game.players.map(&:action).all? {|action| action == :attack}
      single_player_result.modifier = 0 # untouchable
    end
  end

end