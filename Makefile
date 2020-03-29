CRYSTAL_BIN ?= $(shell which crystal)
SHARDS_BIN ?= $(shell which shards)
TARGET_BIN 	= ../../bin
TARGET_FILE = lucky.gen.svg_sprite
SOURCE_FILE = ./tasks/generate_svg_sprite.cr

generator:
	$(SHARDS_BIN) build
	$(CRYSTAL_BIN) build $(SOURCE_FILE) -o $(TARGET_BIN)/$(TARGET_FILE) --release