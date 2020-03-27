require "../../spec_helper"

describe LuckySvgSprite::Mixins::Icon do
  describe "#class_name" do
    it "defines a default svg element class" do
      LuckySvgSpriteTest::Default::Icon.new("testable").class_name
        .should eq("svg-icon svg-default-icon svg-default-testable-icon")
    end

    it "defines an svg element class for a custom set" do
      LuckySvgSpriteTest::MyCustomSet::Icon.new("modified").class_name
        .should eq("svg-icon svg-my-custom-set-icon svg-my-custom-set-modified-icon")
    end
  end
end

module LuckySvgSpriteTest
  abstract class BaseTestIcon
    def initialize(@name : String)
    end
  end

  class Default
    class Icon < LuckySvgSpriteTest::BaseTestIcon
      include LuckySvgSprite::Mixins::Icon
    end
  end

  class MyCustomSet
    class Icon < LuckySvgSpriteTest::BaseTestIcon
      include LuckySvgSprite::Mixins::Icon
    end
  end
end
