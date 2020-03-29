CRYSTAL_BIN ?= $(shell which crystal)
SHARD_BIN 	= ../../bin
SOURCE_FILE = ./tasks/generate_svg_sprite.cr
TARGET_FILE = lucky.gen.svg_sprite

generator:
	$(CRYSTAL_BIN) build $(SOURCE_FILE) -o $(SHARD_BIN)/$(TARGET_FILE) --release
