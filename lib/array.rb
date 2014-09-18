class Array

  def count_by
    inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
  end

end