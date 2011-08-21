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
    
  describe "when given a date in December" do
    it "must respond with a date in January the following year" do
      date = Date.new(2011, 12, 15) 
      date2 = Date.new(2012, 1, 15) 
      assert_equal(date2, TransferPending::TransferPending::increment(date))
    end
  end
  
  describe "when given a date at the end a 31 day month followed by a 30 day month" do
    it "must respond with a date that is the end of the following month" do
      date = Date.new(2011, 5, 31) 
      date2 = Date.new(2011, 6, 30) 
      assert_equal(date2, TransferPending::TransferPending::increment(date))
    end
  end
  
  
end
