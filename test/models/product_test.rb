require "test_helper"

describe Product do
 describe "validations" do
  before do
    @collar = products(:collar)
  end

  it "name must be present and unique" do 
    expect(@collar.valid?).must_equal true
  end

  
  it "should give error if name not present" do 
    @collar.name = nil
    expect(@collar.valid?).must_equal false
    expect(@collar.errors.messages).must_include :name
  end

  it "is invalid when not unique" do 
    @leash = products(:leash)
    @leash.name = "collar"
    expect(@leash.valid?).must_equal false
    expect(@leash.errors.messages).must_include :name


  end

  it "price must be present, a number and greater than zero" do
    expect(@collar.valid?).must_equal true

  end

  it "is invalid with price not present" do 
    @collar.price = nil
    expect(@collar.valid?).must_equal false
    expect(@collar.errors.messages).must_include :price
  end

  it "is invalid when price is not a number" do 
    @collar.price = 0
    # check on line 41 for number not a number
    expect(@collar.valid?).must_equal false
    expect(@collar.errors.messages).must_include :price

  end

  it "invalid when price is not greater than zero" do 
    @collar.price = 0
    expect(@collar.valid?).must_equal false
    expect(@collar.errors.messages).must_include :price
  end

 end
end
