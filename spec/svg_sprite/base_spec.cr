require "../spec_helper"

def test_svg_sprite_base
  TestSvgSpriteBase.new
end

describe SvgSprite::Base do
  describe "#style" do
    it "hides the element" do
      test_svg_sprite_base.style.should eq("display:none")
    end
  end

  describe "#id" do
    it "defines a default id" do
      test_svg_sprite_base.id.should eq("svg-icon-sprite")
    end
  end
end

class TestSvgSpriteBase
  include SvgSprite::Base
end
