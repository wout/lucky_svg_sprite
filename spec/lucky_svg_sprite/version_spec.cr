require "yaml"
require "../spec_helper"

describe LuckySvgSprite::VERSION do
  describe "shard.yml" do
    it "matches the current version" do
      info = YAML.parse(File.read("./shard.yml"))
      version = info["version"]
      LuckySvgSprite::VERSION.should eq("v#{version}")
    end
  end
end
