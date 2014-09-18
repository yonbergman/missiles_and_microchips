class Power

  attr_accessor :player, :name, :description, :phase

  PHASES = [
        :start_of_game, #
        :start_of_turn, #
        :choose_cards,  #
        :show_aim_cards,#
        :change,
        :end_of_change, #
        :show_action_cards, #
        :resolve_action, #
        :after_resolve_action, #
        :end_of_turn, #
        :cleanup #
  ]

  def initialize
    @name = 'POWER NAME'
    @description = 'POWER DESCRIPTION'
    @phase = :first
  end

  def run(data)
  end

  def game
    player.game
  end

end