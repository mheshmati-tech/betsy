require "test_helper"

describe Product do
 describe "validations" do
  before do
    @collar = products(:collar)
  end

    it "name must be present and unique" do 
      expect(@collar.name).must_equal "collar"

      duplicate_item = @collar.dup
      duplicate_item.save
      expect(duplicate_item.valid?).must_equal false
    end

    it "should give error if name is nil" do 
      @collar.name = nil
      expect(@collar.valid?).must_equal false
      expect(@collar.errors.messages).must_include :name
    end

    it "should give error if name is blank" do 
      @collar.name = "   "
      expect(@collar.valid?).must_equal false
      expect(@collar.errors.messages).must_include :name
    end

    it "is invalid when name not unique" do 
      @leash = products(:leash)
      @leash.name = "collar"
      expect(@leash.valid?).must_equal false
      expect(@leash.errors.messages).must_include :name
    end

    it "is invalid with price not present" do 
      @collar.price = nil
      expect(@collar.valid?).must_equal false
      expect(@collar.errors.messages).must_include :price
    end

    it "is invalid when price is not a number" do 
      product = Product.new(name: 'test', price: 'test')
      expect(product.save).must_equal false
      expect(product.errors.messages).must_include :price
    end

    it "invalid when price is not greater than zero" do 
      product = Product.new(name: "unique name", price: -1)
      expect(product.save).must_equal false
      expect(product.errors.messages).must_include :price
   end
  end
end
