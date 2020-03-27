require "../spec_helper"

describe LuckySvgSprite::Converter do
  describe "#convert" do
    it "converts the top level svg to a symbol" do
      input = <<-SVG
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <svg>
          <path d="M13 2L3 14 12 14 11 22 21 10 12 10 13 2z"/>
        </svg>
      SVG
      expected_output = <<-OUTPUT
      tag "symbol" do
        tag "path", d: "M13 2L3 14 12 14 11 22 21 10 12 10 13 2z"
      end
      OUTPUT

      test_output(input, expected_output)
    end

    it "maintains nested svg tags" do
      input = <<-SVG
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <svg>
          <svg>
            <rect width="100" height="99.9" />
          </svg>
        </svg>
      SVG
      expected_output = <<-OUTPUT
      tag "symbol" do
        tag "svg" do
          tag "rect", height: "99.9", width: "100"
        end
      end
      OUTPUT

      test_output(input, expected_output)
    end

    it "strips unwanted top-level attributes" do
      input = <<-SVG
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <svg viewBox="0 0 24 24" width="32" height="32" class="-u-icon" fill="none" stroke="1.5">
          <path d="M13 2L3 14 12 14 11 22 21 10 12 10 13 2z"/>
          <rect width="32" height="32" />
        </svg>
      SVG
      expected_output = <<-OUTPUT
      tag "symbol", fill: "none", stroke: "1.5", viewBox: "0 0 24 24" do
        tag "path", d: "M13 2L3 14 12 14 11 22 21 10 12 10 13 2z"
        tag "rect", height: "32", width: "32"
      end
      OUTPUT

      test_output(input, expected_output)
    end

    it "strips any unwanted attributes" do
      input = <<-SVG
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <svg viewBox="0 0 24 24" class="-u-icon" style="fill:red">
          <circle r="16" />
        </svg>
      SVG
      expected_output = <<-OUTPUT
      tag "symbol", viewBox: "0 0 24 24" do
        tag "circle", r: "16"
      end
      OUTPUT

      test_output(input, expected_output)
    end

    it "strips any unwanted color attributes if required" do
      input = <<-SVG
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
        <svg viewBox="0 0 24 24" fill="none" stroke="aquamarine">
          <circle r="16" fill="cadetblue" stroke="coral" />
        </svg>
      SVG
      expected_output = <<-OUTPUT
      tag "symbol", viewBox: "0 0 24 24" do
        tag "circle", r: "16"
      end
      OUTPUT

      test_output(input, expected_output, true)
    end
  end
end

private def test_output(
  input : String,
  expected_output : String,
  colorless : Bool = false
)
  output = LuckySvgSprite::Converter.new(input, colorless).convert
  output.should eq_html(expected_output)
end

private def eq_html(html)
  eq html.strip + "\n"
end
