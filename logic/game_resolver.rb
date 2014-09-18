class GameResolver
  SinglePlayerResult = Struct.new(:modifier)

  def initialize(game)
    @game = game
    @players = game.players.inject({}) { |hash, player| hash[player] = 0; hash }
  end

  def resolve(options = {})
    @game.players.each do |player|
      @game.notify(:player_action, :player => player, :action => player.action, :target => player.target) unless options[:disable_log]
      result = ActionResolver.new(player).resolve
      result = player.phase(:resolve_action, result)
      @players[player] += result.player
      @players[player.target] += result.target
    end
    @players.each do |player, modifier|
      result = player.phase(:after_resolve_action, SinglePlayerResult.new(modifier))
      @players[player] = result.modifier
    end
    @players
  end

end