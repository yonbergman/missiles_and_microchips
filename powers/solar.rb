class SolarPowered < Power

  def initialize
    @name = 'Solar Powered'
    @description = 'If no one charges during this turn - gain 1E'
    @phase = :end_of_turn
  end

  def run(data)
    if game.players.map(&:action).count(:charge) == 0
      player.energy += 1
    end
  end

end