require_relative 'TransferPending'
require 'minitest/autorun'

class TestTransfer < MiniTest::Unit::TestCase
  # def test_one
    # date = Date.new(2011, 3, 19) #This is a Saturday
    # date2 = Date.new(2011, 3, 18) #This is a Friday
    # assert_equal(date2, TransferPending::TransferPending::weekend(date))
  # end
  
  describe "when given a Saturday" do
    it "must respond with the Friday before" do
      date = Date.new(2011, 3, 19) #This is a Saturday
      date2 = Date.new(2011, 3, 18) #This is a Friday
      assert_equal(date2, TransferPending::TransferPending::weekend(date))
    end
  end
  
   describe "when given a Sunday" do
    it "must respond with the Monday after" do
      date = Date.new(2011, 8, 21) #This is a Sunday
      date2 = Date.new(2011, 8, 22) #This is a Monday
      assert_equal(date2, TransferPending::TransferPending::weekend(date))
    end
  end
end
