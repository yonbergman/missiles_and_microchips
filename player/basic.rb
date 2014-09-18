module Player
  class Basic < Abstract

    def choose_aim
      aim_card_for(chosen_aim)
    end

    def choose_action
      action_card_for(chosen_action)
    end

    def choose_another_action(excluded_action)
      return action_card_for(:block) if attacked_by_many?

      action_card_for(actions_other_than(excluded_action).sample)
    end

    private

    def chosen_aim
      opponents.sample
    end

    def chosen_action
      ActionCard::TYPES.sample
    end

  end
end
