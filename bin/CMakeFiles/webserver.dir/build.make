# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/muyi/webserver

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/muyi/webserver/bin

# Include any dependencies generated for this target.
include CMakeFiles/webserver.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/webserver.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/webserver.dir/flags.make

CMakeFiles/webserver.dir/http_conn.o: CMakeFiles/webserver.dir/flags.make
CMakeFiles/webserver.dir/http_conn.o: ../src/http_conn.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muyi/webserver/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/webserver.dir/http_conn.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/webserver.dir/http_conn.o -c /home/muyi/webserver/src/http_conn.cpp

CMakeFiles/webserver.dir/http_conn.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/webserver.dir/http_conn.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muyi/webserver/src/http_conn.cpp > CMakeFiles/webserver.dir/http_conn.i

CMakeFiles/webserver.dir/http_conn.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/webserver.dir/http_conn.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muyi/webserver/src/http_conn.cpp -o CMakeFiles/webserver.dir/http_conn.s

CMakeFiles/webserver.dir/http_conn.o.requires:

.PHONY : CMakeFiles/webserver.dir/http_conn.o.requires

CMakeFiles/webserver.dir/http_conn.o.provides: CMakeFiles/webserver.dir/http_conn.o.requires
	$(MAKE) -f CMakeFiles/webserver.dir/build.make CMakeFiles/webserver.dir/http_conn.o.provides.build
.PHONY : CMakeFiles/webserver.dir/http_conn.o.provides

CMakeFiles/webserver.dir/http_conn.o.provides.build: CMakeFiles/webserver.dir/http_conn.o


CMakeFiles/webserver.dir/log.o: CMakeFiles/webserver.dir/flags.make
CMakeFiles/webserver.dir/log.o: ../src/log.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muyi/webserver/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/webserver.dir/log.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/webserver.dir/log.o -c /home/muyi/webserver/src/log.cpp

CMakeFiles/webserver.dir/log.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/webserver.dir/log.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muyi/webserver/src/log.cpp > CMakeFiles/webserver.dir/log.i

CMakeFiles/webserver.dir/log.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/webserver.dir/log.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muyi/webserver/src/log.cpp -o CMakeFiles/webserver.dir/log.s

CMakeFiles/webserver.dir/log.o.requires:

.PHONY : CMakeFiles/webserver.dir/log.o.requires

CMakeFiles/webserver.dir/log.o.provides: CMakeFiles/webserver.dir/log.o.requires
	$(MAKE) -f CMakeFiles/webserver.dir/build.make CMakeFiles/webserver.dir/log.o.provides.build
.PHONY : CMakeFiles/webserver.dir/log.o.provides

CMakeFiles/webserver.dir/log.o.provides.build: CMakeFiles/webserver.dir/log.o


CMakeFiles/webserver.dir/main.o: CMakeFiles/webserver.dir/flags.make
CMakeFiles/webserver.dir/main.o: ../src/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muyi/webserver/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/webserver.dir/main.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/webserver.dir/main.o -c /home/muyi/webserver/src/main.cpp

CMakeFiles/webserver.dir/main.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/webserver.dir/main.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muyi/webserver/src/main.cpp > CMakeFiles/webserver.dir/main.i

CMakeFiles/webserver.dir/main.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/webserver.dir/main.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muyi/webserver/src/main.cpp -o CMakeFiles/webserver.dir/main.s

CMakeFiles/webserver.dir/main.o.requires:

.PHONY : CMakeFiles/webserver.dir/main.o.requires

CMakeFiles/webserver.dir/main.o.provides: CMakeFiles/webserver.dir/main.o.requires
	$(MAKE) -f CMakeFiles/webserver.dir/build.make CMakeFiles/webserver.dir/main.o.provides.build
.PHONY : CMakeFiles/webserver.dir/main.o.provides

CMakeFiles/webserver.dir/main.o.provides.build: CMakeFiles/webserver.dir/main.o


CMakeFiles/webserver.dir/mysql_connection_pool.o: CMakeFiles/webserver.dir/flags.make
CMakeFiles/webserver.dir/mysql_connection_pool.o: ../src/mysql_connection_pool.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/muyi/webserver/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/webserver.dir/mysql_connection_pool.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/webserver.dir/mysql_connection_pool.o -c /home/muyi/webserver/src/mysql_connection_pool.cpp

CMakeFiles/webserver.dir/mysql_connection_pool.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/webserver.dir/mysql_connection_pool.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/muyi/webserver/src/mysql_connection_pool.cpp > CMakeFiles/webserver.dir/mysql_connection_pool.i

CMakeFiles/webserver.dir/mysql_connection_pool.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/webserver.dir/mysql_connection_pool.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/muyi/webserver/src/mysql_connection_pool.cpp -o CMakeFiles/webserver.dir/mysql_connection_pool.s

CMakeFiles/webserver.dir/mysql_connection_pool.o.requires:

.PHONY : CMakeFiles/webserver.dir/mysql_connection_pool.o.requires

CMakeFiles/webserver.dir/mysql_connection_pool.o.provides: CMakeFiles/webserver.dir/mysql_connection_pool.o.requires
	$(MAKE) -f CMakeFiles/webserver.dir/build.make CMakeFiles/webserver.dir/mysql_connection_pool.o.provides.build
.PHONY : CMakeFiles/webserver.dir/mysql_connection_pool.o.provides

CMakeFiles/webserver.dir/mysql_connection_pool.o.provides.build: CMakeFiles/webserver.dir/mysql_connection_pool.o


# Object files for target webserver
webserver_OBJECTS = \
"CMakeFiles/webserver.dir/http_conn.o" \
"CMakeFiles/webserver.dir/log.o" \
"CMakeFiles/webserver.dir/main.o" \
"CMakeFiles/webserver.dir/mysql_connection_pool.o"

# External object files for target webserver
webserver_EXTERNAL_OBJECTS =

webserver: CMakeFiles/webserver.dir/http_conn.o
webserver: CMakeFiles/webserver.dir/log.o
webserver: CMakeFiles/webserver.dir/main.o
webserver: CMakeFiles/webserver.dir/mysql_connection_pool.o
webserver: CMakeFiles/webserver.dir/build.make
webserver: CMakeFiles/webserver.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/muyi/webserver/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable webserver"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/webserver.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/webserver.dir/build: webserver

.PHONY : CMakeFiles/webserver.dir/build

CMakeFiles/webserver.dir/requires: CMakeFiles/webserver.dir/http_conn.o.requires
CMakeFiles/webserver.dir/requires: CMakeFiles/webserver.dir/log.o.requires
CMakeFiles/webserver.dir/requires: CMakeFiles/webserver.dir/main.o.requires
CMakeFiles/webserver.dir/requires: CMakeFiles/webserver.dir/mysql_connection_pool.o.requires

.PHONY : CMakeFiles/webserver.dir/requires

CMakeFiles/webserver.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/webserver.dir/cmake_clean.cmake
.PHONY : CMakeFiles/webserver.dir/clean

CMakeFiles/webserver.dir/depend:
	cd /home/muyi/webserver/bin && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/muyi/webserver /home/muyi/webserver/src /home/muyi/webserver/bin /home/muyi/webserver/bin /home/muyi/webserver/bin/CMakeFiles/webserver.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/webserver.dir/depend

