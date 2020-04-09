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
      <svg viewBox="0 0 24 24" class="-u-icon" style="fill:red" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
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

      format = LuckySvgSprite::Format.new(strip: %w[fill stroke])
      test_output(input, expected_output, format)
    end

    it "strips stroke-width if required" do
      input = <<-SVG
      <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
      <svg viewBox="0 0 24 24" fill="none" stroke-width="2">
        <circle r="16" stroke="coral" stroke-width="1" />
      </svg>
      SVG
      expected_output = <<-OUTPUT
      tag "symbol", fill: "none", viewBox: "0 0 24 24" do
        tag "circle", r: "16", stroke: "coral"
      end
      OUTPUT

      format = LuckySvgSprite::Format.new(strip: %w[stroke-width])
      test_output(input, expected_output, format)
    end
  end

  describe ".from_file" do
    it "converts svg from file" do
      expected_output = <<-OUTPUT
      tag "symbol", fill: "none", id: "svg-my-set-github-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24" do
        tag "path", d: "M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"
      end
      OUTPUT

      output = LuckySvgSprite::Converter.from_file(
        "./icons/my_set/github.svg")
      output.should eq_html(expected_output)
    end

    it "can convert without color" do
      expected_output = <<-OUTPUT
      tag "symbol", id: "svg-my-set-github-icon", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24" do
        tag "path", d: "M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"
      end
      OUTPUT

      format = LuckySvgSprite::Format.new(strip: %w[fill stroke])
      output = LuckySvgSprite::Converter.from_file(
        "./icons/my_set/github.svg", format)
      output.should eq_html(expected_output)
    end
  end

  describe ".id_for_icon" do
    it "converts a file path to an id string" do
      id = LuckySvgSprite::Converter.id_for_icon("./icons/my_set/github.svg")
      id.should eq("svg-my-set-github-icon")
      id = LuckySvgSprite::Converter.id_for_icon("./icons/MySet/BloodyMary.svg")
      id.should eq("svg-my-set-bloody-mary-icon")
      id = LuckySvgSprite::Converter.id_for_icon("./icons/_messy-set/123-fab.red.svg")
      id.should eq("svg-messy-set-fab-red-icon")
      id = LuckySvgSprite::Converter.id_for_icon("./icons/WIN_95/TCP_IP.SVG")
      id.should eq("svg-win95-tcp-ip-icon")
    end
  end
end

private def test_output(
  input : String,
  expected_output : String,
  format : LuckySvgSprite::Format = LuckySvgSprite::Format.new
)
  output = LuckySvgSprite::Converter.new(input, format).convert
  output.should eq_html(expected_output)
end

private def eq_html(html)
  eq html.strip + "\n"
end
