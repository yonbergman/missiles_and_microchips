class NuclearPowered < Power

  def initialize
    @name = 'Nuclear Powered'
    @description = 'Charging gains you an extra 1E, but if attacked while charging lose an extra 1E'
    @phase = :resolve_action
  end

  def run(data)
    if player.action == :charge
      if player.aiming_at_me.any?(&:attacking?)
        data.player = -1 #meltdown
      elsif not feedback_loop
        data.player += 1 #nuclear charge
      end
    end
  end

  def feedback_loop
    player.action == :charge and player.target.action == :charge and player.target.target == player
  end

end