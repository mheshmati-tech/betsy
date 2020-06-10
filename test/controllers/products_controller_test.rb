require "test_helper"

describe ProductsController do
  before do
    @leash = products(:leash)
  end
 
 describe "index" do
  it "responds to success for all products" do

    get products_path

    must_respond_with :success
  end
 end

 describe "show" do
  it "will get show for valid product id" do

    valid_product_id = @leash.id

    get product_path(valid_product_id)

    must_respond_with :success
  end
 end

 it "will redirect for invalid product id" do
  
  get product_path(-1)

  must_respond_with :redirect

  # must_redirect_to root_path
 end

 describe "new" do
  it "can get the new product path" do

    get new_product_path

    must_respond_with :success
  end
 end

 describe "create" do
  let (:new_puppy_toy) {
    {
      product: {
        name: "chewy toy",
        price: 4.99,
        description: "a fun toy for your dog",
        stock: 2,
        photo_url: "https://dogtime.com/assets/uploads/2011/03/puppy-development-1280x720.jpg"
      }
    }
  }
  it "can create a new product with valid information and redirect" do
  
  expect{post products_path, params: new_puppy_toy}.must_change "Product.count", 1

  end
 end


end
 