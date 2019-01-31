require "./lib/enumerable"

RSpec.configure do |config|
  config.formatter = :documentation
end

describe Enumerable do
  let(:arr){[23, 12, 73, 66, 82]}
  let(:new_arr){[]}

  describe "#my_each" do
    context "when iterating through each value" do
      it "traverses the block" do
        expect { |block| arr.my_each(&block)}.to yield_successive_args(23, 12, 73, 66, 82)
      end
      it "applies the block being passed in" do
        arr.my_each { |x| new_arr << x * 2}
        expect(new_arr).to eql([46, 24, 146, 132, 164])
      end
    end
    context "when no block is given" do
      it "returns self" do
        expect(arr.my_each).to eql(arr)
      end
    end
  end

  describe "#my_all?" do
    context "when all elements match criteria" do
      it "returns true" do
        temp = arr.my_all? { |x| x > 1}
        expect(temp).to be true
      end
      it "returns false" do
        temp = arr.my_all? { |x| x > 30 }
        expect(temp).to be false
      end
      it "returns false" do
        temp = arr.my_all? { |x| x.between?(20, 100) }
        expect(temp).to be false
      end
    end
  end

  describe "#my_none?" do
    context "when no value matches criteria" do
      it "returns true" do
        temp = arr.my_none? { |x| x > 100 }
        expect(temp).to be true
      end
      it "returns false" do
        temp = arr.my_none? { |x| x < 100 }
        expect(temp).to be false
      end
    end
  end

  describe "#my_count" do
    context "when value is greater than 30" do
      it "returns which values" do
        temp = arr.my_count { |x| x > 30 }
        expect(temp).to eql(3)
      end
    end
    context "when no block is given" do
      it "returns number of elements" do
        expect(arr.my_count).to eql(5)
      end
    end
  end

  describe "#my_inject" do
    context "when passed a block with a binary operator" do
      it "returns sum of elements" do
        temp = arr.my_inject { |sum, n| sum + n }
        expect(temp).to eql(256)
      end
      it "returns product of elements" do
        temp = arr.my_inject { |product, n| product * n }
        expect(temp).to eql(109_040_976)
      end
    end
  end

  describe "#my_map" do
    context "when passed a number comparison" do
      it "returns array of true/false" do
        temp = arr.my_map { |x| x > 30 }
        expect(temp).to eql([false, false, true, true, true])
      end
    end
    context "when passed a conversion method" do
      it "returns array of strings" do
        temp = arr.my_map { |x| x.to_s }
        expect(temp).to eql(["23", "12", "73", "66", "82"])
      end
    end
    context "when no block passed" do
      it "returns enum of itself" do
        temp = arr.my_map
        expect(temp).to be_kind_of(Enumerator)
      end
    end
  end
end
