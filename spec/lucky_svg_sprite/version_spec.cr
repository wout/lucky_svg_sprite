require "yaml"
require "../spec_helper"

describe LuckySvgSprite::VERSION do
  it "returns the current version" do
    LuckySvgSprite::VERSION.should eq(`git describe --abbrev=0 --tags`.strip)
  end

  describe "shard.yml" do
    it "matches the current version" do
      info = YAML.parse(File.read("./shard.yml"))
      version = info["version"]
      LuckySvgSprite::VERSION.should eq("v#{version}")
    end
  end
end
