class BatteriesIncluded < Power

  def initialize
    @name = 'Batteries Included'
    @description = 'You start the game with and extra 2E'
    @phase = :start_of_game
  end

  def run(data)
    player.energy += 2
  end

end
