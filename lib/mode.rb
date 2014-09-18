class Array

  def mode_array
    uniq.sort_by {|i| grep(i).length }
  end

  def mode
    mode_array.last
  end

  def percent_of(i)
    grep(i).length * 100.0 / self.length
  end
end