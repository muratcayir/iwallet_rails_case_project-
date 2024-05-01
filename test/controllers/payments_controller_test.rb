require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get process_payment" do
    get payments_process_payment_url
    assert_response :success
  end
end
