require_relative './power'
require_relative './solar'
require_relative './nuclear'
require_relative './bystander'
require_relative './satellite'
require_relative './batteries_included'

class Power

  def self.all_powers
    [SolarPowered, NuclearPowered, Bystander, Satellite, BatteriesIncluded]
  end

end