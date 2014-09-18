class Game
  include Observable

  attr_accessor :players, :aim_cards, :action_cards, :winners, :turn_num

  def initialize(starting_energy, winning_energy)
    @players = []
    @turn_num = 0
    @blind = 0
    @starting_energy = starting_energy
    @winning_energy = winning_energy
    @game_over_flag = false
    @aim_cards = {}
    @action_cards = {}
    @winners = []
  end

  def add_player(player)
    player.game = self
    player.energy = @starting_energy
    @players << player
  end

  def start_game
    @players.each(&:create_hand)
    @blind = @players.sample
    notify(:game_start)
    phase(:start_of_game)
  end

  def phase(phase)
    @players.each { |p| p.phase(phase) }
  end

  def turn
    start_turn
    choose_cards
    show_aim_cards
    change_actions
    resolve_actions
    resolve_end_turn
  end

  def start_turn
    @turn_num += 1
    aim_cards.clear
    action_cards.clear
    notify(:turn_start, :turn => @turn_num, :blind => @blind)
    phase(:start_of_turn)
  end

  def choose_cards
    players.shuffle.each do |player|
      aim_cards[player] = player.choose_aim
      action_cards[player] = player.choose_action
    end
    phase(:choose_cards)
  end

  def show_aim_cards
    aim_cards.values.each(&:face_up!)
    phase(:show_aim_cards)
  end

  def change_actions
    rotated_players = players.dup
    while rotated_players.first == @blind do
      rotated_players = rotated_players.rotate
    end
    rotated_players.each do |player|
      new_action = player.choose_another_action(action_cards[player].type)
      if new_action != :do_nothing
        player.energy -= 1
        action_cards[player] = new_action
      end
    end
    phase(:end_of_change)
  end

  def resolve_actions
    notify(:resolving_actions)
    phase(:show_action_cards)
    result = GameResolver.new(self).resolve
    result.each do |player, energy_delta|
      player.energy += energy_delta
    end
  end

  def resolve_end_turn
    phase(:end_of_turn)
    winners = []
    players_temp = players.dup
    players_temp.each do |player|
      if player.dead?
        player.die
        notify(:player_lost, :player => player)
      end
    end
    players.each do |player|
      winners << player if player.energy >= @winning_energy
    end

    if players.length <= 1
      game_over(players)
    elsif not winners.empty?
      game_over(winners)
    else
      rotate_blind(players_temp)
    end
    phase(:cleanup)
  end

  def game_over(winners)
    @game_over_flag = true
    @winners = winners
    notify(:game_end, :winners => winners)
  end

  def game_ended?
    @game_over_flag
  end

  def rotate_blind(all_players)
    begin
      index = all_players.index(@blind)
      index = if index >= (@players.length - 1) then 0 else (index + 1) end
      player = @players[index]
    end while player.dead?
    @blind = player
  end

  def notify(event, data = nil)
    changed
    notify_observers(event, data)
  end

  def win_type
    return :VP if players.count > 1
    return :LMS if players.count == 1
    :NO
  end

  def duel?
    @players.count <= 2
  end

end