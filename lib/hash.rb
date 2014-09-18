class Hash

  def keys_with_maximum_value
    select{|_, v| v == max_value}.keys
  end

  def weights
    last_weight = 0
    self.inject({}) do |hash, (k,v)|
      hash[k] = (last_weight...(last_weight+v))
      last_weight = hash[k].last
      hash
    end
  end

  def roll_by_weights
    weights = self.weights
    max_value = weights.values.map(&:last).max
    roll = rand(0...max_value)
    weights.find { |_, v| v.cover? roll }.first
  end

end