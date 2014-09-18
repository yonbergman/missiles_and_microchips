module Player
  module Helpers
    module Heuristics

      def map_opponents_by_energy
        opponents.inject({}) do |hash, player|
          hash[player] = player.energy
          hash
        end
      end

      def strongest_players
        map_opponents_by_energy.keys_with_maximum_value
      end

      def weakest_players
        map_opponents_by_energy.keys_with_maximum_value
      end

      def targeted_count
        game.aim_cards.values.count { |player| player == self }
      end

      def attacked_by_many?
        targeted_count >= (game.players.length / 2).ceil
      end

      def action_weights_hash
        {
            :attack => 0,
            :block  => 0,
            :charge => 0,
            :do_nothing => 0
        }
      end



    end
  end
end