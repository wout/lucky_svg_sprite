require "../spec_helper"

def test_svg_sprite_icon
  TestSvgSpriteIcon.new("testable")
end

describe SvgSprite::Icon do
  describe "#href" do
    it "defines a default href" do
      test_svg_sprite_icon.href.should eq("#svg-testable-icon")
    end
  end

  describe "#svg_class" do
    it "defines a default svg element class" do
      test_svg_sprite_icon.svg_class.should eq("svg-icon svg-testable-icon")
    end
  end

  describe "#use_class" do
    it "defines a default use element class" do
      test_svg_sprite_icon.use_class.should be_empty
    end
  end
end

class TestSvgSpriteIcon
  include SvgSprite::Icon

  def initialize(@name : String)
  end
end
