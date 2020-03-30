require "../../spec_helper"

describe LuckySvgSprite::Mixins::Icon do
  describe "#class_name" do
    it "defines a default svg element class" do
      LuckySvgSpriteTest::Default::Testable.new.class_name
        .should eq("svg-icon svg-default-icon svg-default-testable-icon")
    end

    it "defines an svg element class for a custom set" do
      LuckySvgSpriteTest::MyCustomSet::MaStaBa.new.class_name
        .should eq("svg-icon svg-my-custom-set-icon svg-my-custom-set-ma-sta-ba-icon")
    end
  end
end

describe "Finding an icon my name" do
  describe "#initialize" do
    it "allows to be initialized without a name" do
      icon = LuckySvgSpriteTest::Default::Icon.new
      icon.name.should eq("icon")
    end

    it "allows to be initialized zith a name" do
      icon = LuckySvgSpriteTest::Default::Icon.new("custom-name")
      icon.name.should eq("custom-name")
    end
  end
end

module LuckySvgSpriteTest
  abstract class BaseTestIcon; end

  class Default
    class Testable < LuckySvgSpriteTest::BaseTestIcon
      include LuckySvgSprite::Mixins::Icon
    end

    class Icon
      include LuckySvgSprite::Mixins::Icon

      def initialize(@name : String? = nil)
      end

      def name
        @name || super
      end
    end
  end

  class MyCustomSet
    class MaStaBa < LuckySvgSpriteTest::BaseTestIcon
      include LuckySvgSprite::Mixins::Icon
    end
  end
end
