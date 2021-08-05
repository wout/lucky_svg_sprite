require "yaml"
require "../spec_helper"

describe LuckySvgSprite::VERSION do
  describe "shard.yml" do
    it "matches the current version" do
      info = YAML.parse(File.read("./shard.yml"))

      LuckySvgSprite::VERSION.should eq(info["version"])
    end
  end
end
