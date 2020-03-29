CRYSTAL_BIN ?= $(shell which crystal)
SHARD_BIN 	= ../../bin
TASKS_DIR   = ../../tasks
SOURCE_FILE = generate_svg_sprite.cr
TARGET_FILE = lucky.gen.svg_sprite

generator:
	cp ./tasks/$(SOURCE_FILE) $(TASKS_DIR)/$(SOURCE_FILE)
	$(CRYSTAL_BIN) build $(TASKS_DIR)/$(SOURCE_FILE) -o $(SHARD_BIN)/$(TARGET_FILE) --release
clean:
	rm $(TASKS_DIR)/$(SOURCE_FILE)