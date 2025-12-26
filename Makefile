ASM = nasm

SRC_DIR = src
BUILD_DIR = build

$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin
	cp $< $@
	truncate -s 1440k $@

$(BUILD_DIR)/main.bin: $(SRC_DIR)/boot.asm
	mkdir -p $(BUILD_DIR)
	$(ASM) $< -f bin -o $@
