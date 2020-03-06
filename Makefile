TARGET = enmon
CC = gcc

CFLAGS += -std=gnu11
CFLAGS += -Wall
CFLAGS += -pedantic
CFLAGS += -O2

LDFLAGS += -framework CoreFoundation
LDFLAGS += -framework IOKit

INC_DIR +=
SRC_DIR += src
OBJ_DIR ?= obj
OUT_DIR ?= out

SRC = $(foreach dir,$(SRC_DIR),$(wildcard $(dir)/*.c))
OBJ = $(SRC:%.c=$(OBJ_DIR)/%.o)
DEP = $(OBJ:%.o=%.d)
BIN = $(OUT_DIR)/$(TARGET)

.PHONY: all clean

all: $(BIN)

clean:
	@-rm -rf $(OBJ_DIR) $(OUT_DIR)

$(BIN): $(OBJ)
	@echo "Linking..."
	@mkdir -p $(@D)
	@$(CC) $(LDFLAGS) $(OBJ) -o $@

$(OBJ_DIR)/%.o: %.c Makefile
	@echo "Compiling: $<"
	@mkdir -p $(@D)
	@$(CC) $(CFLAGS) -MMD -c $(foreach d,$(INC_DIR),-I$d) -o $@ $<

-include $(DEP)
