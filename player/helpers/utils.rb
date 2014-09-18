module Player
  module Helpers
    module Utils
      def target
        game.aim_cards[self].target
      end

      def action
        game.action_cards[self].type
      end

      def aiming_at_me
        game.aim_cards.select {
            |_, aim_card| aim_card.target == self
        }.map {
          |_, aim_card| aim_card.owner
        }
      end

      def attacking?
        action == :attack
      end
    end
  end
end