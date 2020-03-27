require "../spec_helper"

def test_svg_sprite_icon
  TestSvgSpriteIcon.new("testable")
end

def test_svg_sprite_icon_with_set
  TestSvgSpriteIcon.new("testable", set: "colored")
end

describe SvgSprite::Icon do
  describe "#href" do
    it "defines a default href" do
      test_svg_sprite_icon.href
        .should eq("#svg-default-testable-icon")
    end

    it "defines a href for a custom set" do
      test_svg_sprite_icon_with_set.href
        .should eq("#svg-colored-testable-icon")
    end
  end

  describe "#svg_class" do
    it "defines a default svg element class" do
      test_svg_sprite_icon.svg_class
        .should eq("svg-default-icon svg-default-testable-icon")
    end

    it "defines an svg element class for a custom set" do
      test_svg_sprite_icon_with_set.svg_class
        .should eq("svg-colored-icon svg-colored-testable-icon")
    end
  end
end

class TestSvgSpriteIcon
  include SvgSprite::Icon

  def initialize(
    @name : String,
    @set : String = "default"
  )
  end
end
