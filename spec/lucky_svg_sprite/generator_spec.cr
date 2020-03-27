require "../spec_helper"

def test_svg_sprite_generator
  LuckySvgSprite::Generator.new("./icons")
end

describe LuckySvgSprite::Generator do
  describe "#icons" do
    it "returns a list of files" do
      icons = test_svg_sprite_generator.icons
      icons.should be_a(Array(String))
      icons.size.should eq(5)
    end
  end

  describe "#generate" do
    it "converts basic svg" do
      # input = "<div><p>Before Link<a>Link</a> After Link</p></div>"
      # expected_output = <<-CODE
      # div do
      #   para do
      #     text "Before Link"
      #     a "Link"
      #     text " After Link"
      #   end
      # end
      # CODE

      # output = HTML2Lucky::Converter.new(input).convert
      # output.should eq_html(expected_output.strip)
    end
  end
end
