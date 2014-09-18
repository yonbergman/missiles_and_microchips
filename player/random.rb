module Player
  class Random < Abstract

    def choose_aim
      aim_cards.sample
    end

    def choose_action
      action_cards.sample
    end

    def choose_another_action(excluded_action)
      action_card_for(actions_other_than(excluded_action).sample)
    end

  end
end
