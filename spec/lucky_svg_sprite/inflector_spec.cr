require "../spec_helper"

describe LuckySvgSprite::Inflector do
  describe ".dasherize" do
    it "converts a string to lowercase joined by dashes" do
      cases = {
        "Simple example."          => "simple-example",
        "ClassNameExample"         => "class-name-example",
        "__Markdown__ **example**" => "markdown-example",
        "underscored_example"      => "underscored-example",
      }

      cases.each do |from, to|
        LuckySvgSprite::Inflector.dasherize(from).should eq(to)
      end
    end

    it "converts a file path into a dasherized string" do
      cases = {
        "/simple/example_file.svg"         => "example-file",
        "/more/complex/__Ex@mple-File.SVG" => "ex-mple-file",
        "/any/file.type"                   => "file",
      }

      cases.each do |from, to|
        LuckySvgSprite::Inflector.dasherize(from, from_path: true).should eq(to)
      end
    end
  end

  describe ".classify" do
    it "converts a string to a class name" do
      cases = {
        "some_class"         => "SomeClass",
        "__M@r == Complex__" => "MRComplex",
        "123-And the cat"    => "AndTheCat",
      }

      cases.each do |from, to|
        LuckySvgSprite::Inflector.classify(from).should eq(to)
      end
    end

    it "converts a file path into a class name" do
      cases = {
        "/simple/example_file.svg"         => "ExampleFile",
        "/more/complex/__Ex@mple-File.SVG" => "ExMpleFile",
        "/any/file.type"                   => "File",
      }

      cases.each do |from, to|
        LuckySvgSprite::Inflector.classify(from, from_path: true).should eq(to)
      end
    end
  end
end
