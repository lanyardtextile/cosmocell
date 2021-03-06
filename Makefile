SOURCES_ceres=ceres/main.cpp
SOURCES_client=account.cpp network/constant.cpp network/object.cpp app/client/layer_root.cpp app/client/layer_auth.cpp app/client/main.cpp
SOURCES_server=account.cpp network/constant.cpp network/object.cpp app/server/layer_root.cpp app/server/layer_auth.cpp app/server/main.cpp
SOURCES_test=app/test/layer/root.cpp app/test/layer/buffer.cpp app/test/layer/graphic.cpp app/test/layer/network_accuracy.cpp app/test/layer/network_speed.cpp app/test/main.cpp
SRCPATH=src/
INCPATHS=include/ include/app/
LIBPATHS=lib/ ../cosmodon/lib/
OBJPATH=obj/
BINPATH=bin/
LDFLAGS=-lcosmodon -lGL -lGLU -lGLEW -lglfw3 -lX11 -lXxf86vm -pthread -lXi -lXrandr
CFLAGS=-Wall -std=c++11

# Compilers
BG_WHITE=$$(tput setab 7)

# Foreground colors
FG_RED=$$(tput setaf 1)
FG_GREEN=$$(tput setaf 2)
FG_YELLOW=$$(tput setaf 3)
FG_BLUE=$$(tput setaf 4)
FG_MAGENTA=$$(tput setaf 5)
FG_CYAN=$$(tput setaf 6)

# Other colors
COLOR_RESET=$$(tput sgr 0)
 
# Goal-Based variables
GOAL = $(MAKECMDGOALS)
APPPATH=$(GOAL)/
SOURCES=$(SOURCES_$(GOAL))
OBJECTS=$(SOURCES:%.cpp=%.o)
SOURCE_FILES=$(SOURCES:%=$(SRCPATH)%)
OBJECT_FILES=$(OBJECTS:%=$(OBJPATH)%)

# Compilers
PLATFORM=linux64
CC_linux64=g++
CC_win32=/opt/mingw32/cross_win32/bin/i686-w64-mingw32-g++
CC = $(CC_linux64)

INCFLAGS=$(foreach TMP,$(INCPATHS),-I$(TMP))
LIBFLAGS=$(foreach TMP,$(LIBPATHS),-L$(TMP:%=%$(PLATFORM)/))
BINARY=$(GOAL)_$(PLATFORM)

# Initial Target
$(GOAL): $(SOURCE_FILES) $(BINARY)
	@echo "$(BG_WHITE)$(FG_MAGENTA) Executing $(COLOR_RESET)"
	(cd bin && ./$(BINARY))
	@echo ""

# Link into a library
$(GOAL)_linux64: $(OBJECTS)
	@echo "$(BG_WHITE)$(FG_GREEN) Creating $@.a $(COLOR_RESET)"
	$(CC) $(OBJECT_FILES) $(LIBFLAGS) $(LDFLAGS) -o $(BINPATH)$@
	@echo ""

# Compile source into objects
%.o:
	@echo "$(BG_WHITE)$(FG_BLUE) Compiling $(@:%.o=%.cpp) $(COLOR_RESET)"
	$(CC) $(INCFLAGS) -c $(SRCPATH)$(@:%.o=%.cpp) $(LIBFLAGS) $(LDFLAGS) $(CFLAGS) -o $(OBJPATH)$@
	@echo ""
