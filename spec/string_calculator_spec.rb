require 'spec_helper'

describe StringCalculator do
  describe "#add" do
    it "returns 0 for an empty string" do
      StringCalculator.add("").should == 0
    end
    it "returns 1 when passed '1'" do
      StringCalculator.add("1").should == 1
    end
    it "returns the sum of comma separated numbers" do
      StringCalculator.add("1,2").should == 3
    end
    it "splits on new lines" do
      StringCalculator.add("1\n2").should == 3
    end
    it "allows custom delimiters to be defined using //X/n syntax" do
      StringCalculator.add("//|\n1|2").should == 3
    end
    it "allows custom delimiters to be defined using //X/n syntax" do
      StringCalculator.add("//;1;2").should == 3
    end
    it { expect { StringCalculator.add("-1") }.to raise_error(ArgumentError) }
    it { expect { StringCalculator.add("-1, -2") }.to raise_error(ArgumentError, /(.*)-1, -2(.*)/) }
    it "ignores numbers greater than 1,000" do
      StringCalculator.add("1, 999, 1001").should == 1000
    end
    it "adds using multiple delimiters" do
      StringCalculator.add("//[*][%][~]\n1*2%3~4").should == 10
    end
  end
  describe "#get_delimiter" do
    it "returns '|' for '//|\n1|2" do
      StringCalculator.get_delimiter("//|\n1|2").should include("|")
    end
    it "returns an empty array for '1,2'" do
      StringCalculator.get_delimiter("1,2").should == ["\n", ","]
    end
    it "returns *** for '//[***]\n1,2'" do
      StringCalculator.get_delimiter("//[***]\n1,2").should include("***")
    end
    it "allows for multiple custom delimiters" do
      StringCalculator.get_delimiter("//[*][%]\n1,2").should include("*", "%")
    end
  end
end
