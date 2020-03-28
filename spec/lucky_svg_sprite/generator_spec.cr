require "../spec_helper"

def test_svg_sprite_generator
  LuckySvgSprite::Generator.new("./icons/my_set")
end

describe LuckySvgSprite::Generator do
  describe "#icons" do
    it "returns a list of files" do
      icons = test_svg_sprite_generator.icons
      icons.should be_a(Array(String))
      icons.size.should eq(5)
      icons[0].should eq("./icons/my_set/activity.svg")
      icons[1].should eq("./icons/my_set/command.svg")
      icons[2].should eq("./icons/my_set/github.svg")
      icons[3].should eq("./icons/my_set/wind.svg")
      icons[4].should eq("./icons/my_set/zap.svg")
    end
  end

  describe "#concatenate" do
    it "joins a series of converted svg's together" do
      output = LuckySvgSprite::Generator.new("./icons/my_set")
        .concatenate(LuckySvgSprite::Format.new)
      output.scan(/tag "symbol"/).size.should eq(5)
    end
  end

  describe "#namespace" do
    it "generates a namespace from the icon dir" do
      generator = LuckySvgSprite::Generator.new("./icons/my_set")
      generator.namespace.should eq("MySet")
      generator = LuckySvgSprite::Generator.new("./icons/my_sweet_set/")
      generator.namespace.should eq("MySweetSet")
      generator = LuckySvgSprite::Generator.new("./icons/my-other-set")
      generator.namespace.should eq("MyOtherSet")
      generator = LuckySvgSprite::Generator.new("./icons/Yet Another Set")
      generator.namespace.should eq("YetAnotherSet")
      generator = LuckySvgSprite::Generator.new("./icons/123--Flup.svg")
      generator.namespace.should eq("FlupSvg")
    end
  end

  describe "#generate" do
    it "generates a complete sprite class" do
      expected_output = <<-CODE
      class SvgSprite::MySet < BaseSvgSprite
        def render_icons : IO
          tag "symbol", fill: "none", id: "svg-my-set-activity-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
            tag "path", d: "M22 12L18 12 15 21 9 3 6 12 2 12"
          end

          tag "symbol", fill: "none", id: "svg-my-set-command-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
            tag "path", d: "M18 3a3 3 0 0 0-3 3v12a3 3 0 0 0 3 3 3 3 0 0 0 3-3 3 3 0 0 0-3-3H6a3 3 0 0 0-3 3 3 3 0 0 0 3 3 3 3 0 0 0 3-3V6a3 3 0 0 0-3-3 3 3 0 0 0-3 3 3 3 0 0 0 3 3h12a3 3 0 0 0 3-3 3 3 0 0 0-3-3z"
          end

          tag "symbol", fill: "none", id: "svg-my-set-github-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
            tag "path", d: "M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"
          end

          tag "symbol", fill: "none", id: "svg-my-set-wind-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
            tag "path", d: "M9.59 4.59A2 2 0 1 1 11 8H2m10.59 11.41A2 2 0 1 0 14 16H2m15.73-8.27A2.5 2.5 0 1 1 19.5 12H2"
          end

          tag "symbol", fill: "none", id: "svg-my-set-zap-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
            tag "path", d: "M13 2L3 14 12 14 11 22 21 10 12 10 13 2z"
          end
        end

        class Icon < BaseSvgIcon
        end
      end
      CODE

      format = LuckySvgSprite::Format.new
      output = LuckySvgSprite::Generator.new("./icons/my_set").generate(format)
      output.should eq(expected_output)
    end

    it "can generate without color" do
      expected_output = <<-CODE
      class SvgSprite::MySet < BaseSvgSprite
        def render_icons : IO
          tag "symbol", id: "svg-my-set-activity-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
            tag "path", d: "M22 12L18 12 15 21 9 3 6 12 2 12"
          end

          tag "symbol", id: "svg-my-set-command-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
            tag "path", d: "M18 3a3 3 0 0 0-3 3v12a3 3 0 0 0 3 3 3 3 0 0 0 3-3 3 3 0 0 0-3-3H6a3 3 0 0 0-3 3 3 3 0 0 0 3 3 3 3 0 0 0 3-3V6a3 3 0 0 0-3-3 3 3 0 0 0-3 3 3 3 0 0 0 3 3h12a3 3 0 0 0 3-3 3 3 0 0 0-3-3z"
          end

          tag "symbol", id: "svg-my-set-github-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
            tag "path", d: "M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"
          end

          tag "symbol", id: "svg-my-set-wind-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
            tag "path", d: "M9.59 4.59A2 2 0 1 1 11 8H2m10.59 11.41A2 2 0 1 0 14 16H2m15.73-8.27A2.5 2.5 0 1 1 19.5 12H2"
          end

          tag "symbol", id: "svg-my-set-zap-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
            tag "path", d: "M13 2L3 14 12 14 11 22 21 10 12 10 13 2z"
          end
        end

        class Icon < BaseSvgIcon
        end
      end
      CODE

      format = LuckySvgSprite::Format.new(colorless: true)
      output = LuckySvgSprite::Generator.new("./icons/my_set").generate(format)
      output.should eq(expected_output)
    end
  end
end
