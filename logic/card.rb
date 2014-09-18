class Card
  attr_accessor :face_up, :owner

  def initialize(owner)
    @face_up = false
    @owner = owner
  end

  def face_up!
    @face_up = true
  end

  def face_up?
    !!@face_up
  end
end

class AimCard < Card
  attr_accessor :target

  def initialize(owner, target)
    super(owner)
    @target = target
  end
end

class ActionCard < Card
  attr_accessor :type
  TYPES = [:attack, :block, :charge]

  def initialize(owner, type)
    super(owner)
    @type = type
  end

  def attack?
    @type == :attack
  end

  def defense?
    @type == :defense
  end

  def charge?
    @type == :charge
  end
end