CRYSTAL_BIN ?= $(shell which crystal)
SHARDS_BIN ?= $(shell which shards)
SHARD_BIN 	= ../../bin
TARGET_FILE = lucky.gen.svg_sprite
SOURCE_FILE = ./tasks/generate_svg_sprite.cr

generator:
	$(SHARDS_BIN) build
	$(CRYSTAL_BIN) build $(SOURCE_FILE) -o $(SHARD_BIN)/$(TARGET_FILE) --release