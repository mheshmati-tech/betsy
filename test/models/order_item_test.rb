require "test_helper"

describe OrderItem do
  before do
    @collar = order_items(:collar_order_item)
    @leash = order_items(:leash_order_item)
  end
  describe "validations" do
    it "is valid when quantity is present" do
      expect(@collar.valid?).must_equal true
      expect(@leash.valid?).must_equal true
    end
    it "is invalid when quantity is not present, is not a number, or is a negative number" do
      @collar.quantity = "not an integer"
      @leash.quantity = -1

      expect(@collar.valid?).must_equal false
      expect(@collar.errors.messages).must_include :quantity
      expect(@leash.valid?).must_equal false
      expect(@leash.errors.messages).must_include :quantity
    end
  end
  describe "relations" do
  end
  describe "custom methods" do
  end
end
