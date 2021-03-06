require 'spec_helper'

describe TwilioTestToolkit::DSL do
  before(:each) do
    @our_number = "2065551212"
    @their_number = "2065553434"
  end

  describe "ttt_call" do
    describe "basics" do
      before(:each) do
        @call = ttt_call(test_start_twilio_index_path, @our_number, @their_number)
      end

      it "should assign the call" do
        @call.should_not be_nil
      end

      it "should have a sid" do
        @call.sid.should_not be_blank
      end

      it "should default the method to post" do
        @call.http_method.should == :post
      end

      it "should have the right properties" do
        @call.initial_path.should == test_start_twilio_index_path
        @call.from_number.should == @our_number
        @call.to_number.should == @their_number
        @call.is_machine.should be_false
      end
    end

    describe "with a sid, method and machine override" do
      before(:each) do
        @mysid = "1234567"
        @call = ttt_call(test_start_twilio_index_path, @our_number, @their_number, :call_sid => @mysid, :is_machine => true, :method => :get)
      end

      it "should have the right sid" do
        @call.sid.should == @mysid
      end

      it "should be a machine call" do
        @call.is_machine.should be_true
      end

      it "should be a get call" do
        @call.http_method.should == :get
      end
    end

    describe "with a called and direction" do
      before(:each) do
        @direction = 'outbound-api'
        @call = ttt_call(test_start_twilio_index_path, @our_number, @their_number, :direction => @direction, :called => @their_number)
      end

      it "should have the right direction" do
        @call.direction.should == @direction
      end

      it "should have the right called number" do
        @call.called.should == @their_number
      end
    end
  end
end
