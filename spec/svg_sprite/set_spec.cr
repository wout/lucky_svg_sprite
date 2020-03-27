require "../spec_helper"

def test_svg_sprite_set
  TestSvgSpriteSet.new
end

describe SvgSprite::Set do
  describe "#style" do
    it "hides the element" do
      test_svg_sprite_set.style.should eq("display:none")
    end
  end

  describe "#id" do
    it "defines a set id" do
      test_svg_sprite_set.id.should eq("svg-default-icon-sprite")
    end
  end
end

class TestSvgSpriteSet
  include SvgSprite::Set

  def initialize(@name : String = "default")
  end
end
