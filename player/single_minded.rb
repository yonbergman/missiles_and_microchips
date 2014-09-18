module Player
  class SingleMinded < Abstract

    def initialize(name, action = nil)
      super(name)
      @single_minded_action = action
    end

    def choose_aim
      aim_card_for(chosen_aim)
    end

    def choose_action
      action_card_for(chosen_action)
    end

    def choose_another_action(excluded_action)
      return :do_nothing
    end

    private

    def chosen_aim
      opponents.sample
    end

    def chosen_action
      @single_minded_action
    end

  end
end
