CC := g++
CFLAGS := -Wall -O2
BUILD_DIR := build
SRC_DIR := src

# 添加必要的编译和链接选项
CFLAGS += -DMG_ENABLE_LINES -DMG_ENABLE_OPENSSL=1 -I/usr/include
LDFLAGS += -L/usr/lib/x86_64-linux-gnu -lssl -lcrypto -lpthread

# 主目标
all: $(BUILD_DIR)/pickles

# 创建构建目录
mkdir-build-dir:
	mkdir -p $(BUILD_DIR)

# 编译主程序
$(BUILD_DIR)/pickles: $(BUILD_DIR)/pickles.o $(BUILD_DIR)/mongoose.o $(BUILD_DIR)/RESTserver.o $(BUILD_DIR)/ThreadPool.o
	$(CC) $(CFLAGS) -o $(BUILD_DIR)/pickles $^ $(LDFLAGS)

# 编译 pickles.o
$(BUILD_DIR)/pickles.o: $(SRC_DIR)/pickles.cpp
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $(BUILD_DIR)/pickles.o $(SRC_DIR)/pickles.cpp

# 编译 mongoose.o
$(BUILD_DIR)/mongoose.o: $(SRC_DIR)/RESTserver/mongoose.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $(BUILD_DIR)/mongoose.o $(SRC_DIR)/RESTserver/mongoose.c

# 编译 RESTserver.o
$(BUILD_DIR)/RESTserver.o: $(SRC_DIR)/RESTserver/RESTserver.cpp
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $(BUILD_DIR)/RESTserver.o $(SRC_DIR)/RESTserver/RESTserver.cpp

# 编译 ThreadPool.o
$(BUILD_DIR)/ThreadPool.o: $(SRC_DIR)/ThreadPool/ThreadPool.cpp
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $(BUILD_DIR)/ThreadPool.o $(SRC_DIR)/ThreadPool/ThreadPool.cpp

# 清理
clean:
	rm -f $(BUILD_DIR)/pickles.o $(BUILD_DIR)/mongoose.o $(BUILD_DIR)/RESTserver.o $(BUILD_DIR)/ThreadPool.o $(BUILD_DIR)/pickles
	rmdir $(BUILD_DIR)

# 制定默认目标
.PHONY: all clean mkdir-build-dir
all: mkdir-build-dir
