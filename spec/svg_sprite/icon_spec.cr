require "../spec_helper"

describe SvgSprite::Icon do
  describe "#class_name" do
    it "defines a default svg element class" do
      SvgSpriteTest::Default::Icon.new("testable").class_name
        .should eq("svg-icon svg-default-icon svg-default-testable-icon")
    end

    it "defines an svg element class for a custom set" do
      SvgSpriteTest::MyCustomSet::Icon.new("modified").class_name
        .should eq("svg-icon svg-my-custom-set-icon svg-my-custom-set-modified-icon")
    end
  end
end

module SvgSpriteTest
  abstract class BaseTestIcon
    def initialize(@name : String)
    end
  end

  class Default
    class Icon < SvgSpriteTest::BaseTestIcon
      include SvgSprite::Icon
    end
  end

  class MyCustomSet
    class Icon < SvgSpriteTest::BaseTestIcon
      include SvgSprite::Icon
    end
  end
end
