require_relative './helpers/heuristics'
require_relative './helpers/utils'

module Player
  class Player::Abstract

    include Player::Helpers::Heuristics
    include Player::Helpers::Utils
    attr_accessor :energy, :powers, :game, :aim_cards, :action_cards, :name

    def initialize(name, powers = [])
      @name = name
      @powers = powers
      @powers.each do |power|
        power.player = self
      end
      @action_cards = []
    end

    def opponents
      game.players.reject { |player| player == self }
    end

    def aim_cards
      aim_cards = []
      game.players.each do |other|
        if other != self
          aim_cards << AimCard.new(self, other)
        end
      end
      aim_cards
    end

    def aim_card_for(player)
      aim_cards.find { |card| card.target == player }
    end

    def action_card_for(action)
      return action if action == :do_nothing
      action_cards.find { |card| card.type == action }
    end

    def create_hand
      ActionCard::TYPES.each do |type|
        action_cards << ActionCard.new(self, type)
      end
    end

    def choose_aim
      raise '`choose_aim` to be implemented by subclass'
    end

    def choose_action
      raise '`choose_action` to be implemented by subclass'
    end

    def choose_another_action(excluded_action)
      raise '`choose_another_action` to be implemented by subclass'
    end

    def phase(phase, data = nil)
      return data if game.duel?
      self.powers.select { |power|
        power.phase == phase }.each{ |power|
        power.run(data)
      }
      data
    end

    def dead?
      @energy <= 0
    end

    def die
      game.players.delete(self)
    end

    def name
      "#{self.class.name} #{@name} <#{powers.map(&:name).join(',')}>"
    end

    def to_s
      "#{name} (#@energy)"
    end

    def actions_other_than(an_action)
      if @energy <= 2
        return [:do_nothing]
      end
      actions = ActionCard::TYPES.dup.reject { |action| action == an_action }
      (actions.count * 5).times do
        actions << :do_nothing
      end
      actions
    end

  end
end