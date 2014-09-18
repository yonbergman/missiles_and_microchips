class GameLogger

  def initialize(game)
    game.add_observer(self)
  end

  def update(event, data)
    case event
      when :game_start
        puts "=============== NEW GAME ==============="

      when :turn_start
        puts "---------------- TURN #{data[:turn]} ----------------"
        puts "Blind at: #{data[:blind]}"

      when :resolving_actions
        puts "Actions:"

      when :player_action
        case data[:action]
          when :attack
            puts "  #{data[:player]}\t\tattacks\t\t@{#{data[:target]}}"
          when :block
            puts "  #{data[:player]}\t\tdefends\t\t@{#{data[:target]}}"
          when :charge
            puts "  #{data[:player]}\t\tcharges\t\t@{#{data[:target]}}"
        end

      when :player_lost
        puts "#{data[:player]} dies"

      when :game_end
        puts "-- GAME END --"
        if data[:winners].empty?
          puts "Nobody won"
        else
          puts "Victory for: #{data[:winners].map(&:name).join(',')}"
        end
        puts "\n"
    end
  end
end