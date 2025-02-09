# build: Builds binary
# run: Runs binary
# test: Runs tests
# clean: Removes object files
# reset: Removes object files and binary
# lint: Runs static analysis

TARGET = build/sb.exe

CC = g++

SOURCES = $(wildcard src/*.c)
OBJECTS = $(patsubst src/%,build/objs/%,$(SOURCES:%.c=%.o))

TEST_SOURCES = $(filter-out src/main.c,$(SOURCES)) $(wildcard test/*.test.c)
TEST_OBJECTS = $(addprefix build/objs/, $(notdir $(TEST_SOURCES:%.c=%.o)))

CPPCHECK = cppcheck
CPPCHECK_TARGET = ./src/*

# Commands

build: $(TARGET)

.PHONY: run
run: $(TARGET)
	./$(TARGET) $(VAR)

.PHONY: test
test: build/test.exe
	./build/test.exe

.PHONY: clean
clean:
	rm -f build/objs/*.o

.PHONY: reset
reset: clean
	rm -f build/*.exe

.PHONY: lint
lint:
	@$(CPPCHECK) --enable=all --std=c99 --suppress=missingIncludeSystem $(CPPCHECK_TARGET)

# Build Rules

$(TARGET): $(OBJECTS)
	$(CC) -o $@ $^

build/objs/%.test.o: test/%.test.c test/*.h src/*.h
	$(CC) -I./src -I./test -c -o $@ $<

build/objs/%.o: src/%.c src/*.h
	$(CC) -I./src -I./test -c -o $@ $<

build/test.exe: $(TEST_OBJECTS)
	$(CC) -o $@ $^
