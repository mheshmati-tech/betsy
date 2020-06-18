require "test_helper"

describe OrdersController do
  before do
    @product = products(:leash)
  end

  describe "show" do
    it "will get show for valid ids" do
      original_order_count = Order.count
      order = create_order(@product,1)
      expect(Order.count).must_equal original_order_count + 1

      session[:order_id].must_equal order.id

      get order_path(order.id)

      must_respond_with :success
    end

    it "will respond with not_found if no current order set" do
      assert_raises( "NoMethodError") { get order_path(-1) }
    end
  end

  describe "update" do
    before do
      @order = create_order(@product,1)
    end

    let (:new_order_hash) {
      {
        order: {
          email_address: "louie@hotmail.com",
          mailing_address: "52 Center St.",
          name_on_credit_card: "Louie",
          credit_card_number: "4321432143214321",
          credit_card_expiration: "03/22",
          credit_card_CVV: "321",
          billing_zip_code: "12321"
        },
      }
    }
    it "will update a model with a valid post request" do
      expect {
        patch order_path(@order.id), params: new_order_hash
      }.wont_change "Order.count"
  
      must_redirect_to finalize_order_path
  
      order = Order.find_by(id: @order.id)
      expect(order.email_address).must_equal new_order_hash[:order][:email_address]
      expect(order.mailing_address).must_equal new_order_hash[:order][:mailing_address]
      expect(order.name_on_credit_card).must_equal new_order_hash[:order][:name_on_credit_card]
      expect(order.credit_card_number).must_equal new_order_hash[:order][:credit_card_number]
      expect(order.credit_card_expiration).must_equal new_order_hash[:order][:credit_card_expiration]
      expect(order.credit_card_CVV).must_equal new_order_hash[:order][:credit_card_CVV]
      expect(order.billing_zip_code).must_equal new_order_hash[:order][:billing_zip_code]

    end
  
    # it "will respond with not_found for invalid ids" do
    #   id = -1
  
    #   expect {
    #     patch book_path(id), params: new_book_hash
    #   }.wont_change "Book.count"
  
    #   must_respond_with :not_found
    # end
  
    # it "will not update if the params are invalid" do
    #   # This test will be examined when we cover validations next week
    # end
  end

end
