require "../spec_helper"

describe LuckySvgSprite::Format do
  describe "#initialize" do
    it "has a default value for indent" do
      test_format.indent.should eq(0)
    end

    it "has a default value for colorless" do
      test_format.colorless.should eq(false)
    end

    it "has a nilable value for id_param" do
      test_format.id_param.should be_nil
    end
  end
end

private def test_format
  LuckySvgSprite::Format.new
end
