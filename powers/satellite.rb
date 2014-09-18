class Satellite < Power

  def initialize
    @name = 'Satellite'
    @description = 'You may use the change phase to change your aim card instead of the action card for 1E'
    @phase = :change
  end

  def run(data)

  end

end
