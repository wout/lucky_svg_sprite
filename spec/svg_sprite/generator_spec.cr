require "../spec_helper"

def test_svg_sprite_generator
  SvgSprite::Generator.new("./icons")
end

describe SvgSprite::Generator do
  describe "#icons" do
    it "returns a list of files" do
      icons = test_svg_sprite_generator.icons
      icons.should be_a(Array(String))
      icons.size.should eq(5)
    end
  end
end
