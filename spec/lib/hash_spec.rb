require 'spec_helper'

require './lib/hash'
require './lib/array'

describe Hash do

  describe :roll_by_weights do

    def correct_range_for(tests, max, weight, error)
      percent = weight.to_f / max.to_f
      precise = tests * percent
      min = precise * (1-error)
      max = precise * (1+error)
      (min..max)
    end

    subject { {:a => 10, :b => 25, :c => 65} }
    let(:max) { subject.values.max }
    let(:large_number) { 50000 }
    let(:alpha) { 0.05 }

    let(:correct_a_range) { correct_range_for(large_number, max, subject[:a], alpha) }
    let(:correct_b_range) { correct_range_for(large_number, max, subject[:b], alpha) }
    let(:correct_c_range) { correct_range_for(large_number, max, subject[:b], alpha) }

    it 'should fulfill the law of large numbers' do
      result_array = []
      large_number.times { result_array << subject.roll_by_weights }
      counts = result_array.count_by

      correct_a_range.cover? counts[:a].should be_true
      correct_b_range.cover? counts[:b].should be_true
      correct_c_range.cover? counts[:c].should be_true
    end
  end
end