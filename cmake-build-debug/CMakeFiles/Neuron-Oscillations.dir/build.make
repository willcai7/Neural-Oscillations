# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.17

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "E:\Programs\JetBrains\CLion 2020.3\bin\cmake\win\bin\cmake.exe"

# The command to remove a file.
RM = "E:\Programs\JetBrains\CLion 2020.3\bin\cmake\win\bin\cmake.exe" -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = D:\Work\Github\Neural-Oscillations

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = D:\Work\Github\Neural-Oscillations\cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/Neuron-Oscillations.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Neuron-Oscillations.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Neuron-Oscillations.dir/flags.make

CMakeFiles/Neuron-Oscillations.dir/Markov_simple.cpp.obj: CMakeFiles/Neuron-Oscillations.dir/flags.make
CMakeFiles/Neuron-Oscillations.dir/Markov_simple.cpp.obj: ../Markov_simple.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=D:\Work\Github\Neural-Oscillations\cmake-build-debug\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Neuron-Oscillations.dir/Markov_simple.cpp.obj"
	E:\Programs\mingw64\bin\g++.exe  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\Neuron-Oscillations.dir\Markov_simple.cpp.obj -c D:\Work\Github\Neural-Oscillations\Markov_simple.cpp

CMakeFiles/Neuron-Oscillations.dir/Markov_simple.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Neuron-Oscillations.dir/Markov_simple.cpp.i"
	E:\Programs\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E D:\Work\Github\Neural-Oscillations\Markov_simple.cpp > CMakeFiles\Neuron-Oscillations.dir\Markov_simple.cpp.i

CMakeFiles/Neuron-Oscillations.dir/Markov_simple.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Neuron-Oscillations.dir/Markov_simple.cpp.s"
	E:\Programs\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S D:\Work\Github\Neural-Oscillations\Markov_simple.cpp -o CMakeFiles\Neuron-Oscillations.dir\Markov_simple.cpp.s

# Object files for target Neuron-Oscillations
Neuron__Oscillations_OBJECTS = \
"CMakeFiles/Neuron-Oscillations.dir/Markov_simple.cpp.obj"

# External object files for target Neuron-Oscillations
Neuron__Oscillations_EXTERNAL_OBJECTS =

Neuron-Oscillations.exe: CMakeFiles/Neuron-Oscillations.dir/Markov_simple.cpp.obj
Neuron-Oscillations.exe: CMakeFiles/Neuron-Oscillations.dir/build.make
Neuron-Oscillations.exe: CMakeFiles/Neuron-Oscillations.dir/linklibs.rsp
Neuron-Oscillations.exe: CMakeFiles/Neuron-Oscillations.dir/objects1.rsp
Neuron-Oscillations.exe: CMakeFiles/Neuron-Oscillations.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=D:\Work\Github\Neural-Oscillations\cmake-build-debug\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable Neuron-Oscillations.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\Neuron-Oscillations.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Neuron-Oscillations.dir/build: Neuron-Oscillations.exe

.PHONY : CMakeFiles/Neuron-Oscillations.dir/build

CMakeFiles/Neuron-Oscillations.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles\Neuron-Oscillations.dir\cmake_clean.cmake
.PHONY : CMakeFiles/Neuron-Oscillations.dir/clean

CMakeFiles/Neuron-Oscillations.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" D:\Work\Github\Neural-Oscillations D:\Work\Github\Neural-Oscillations D:\Work\Github\Neural-Oscillations\cmake-build-debug D:\Work\Github\Neural-Oscillations\cmake-build-debug D:\Work\Github\Neural-Oscillations\cmake-build-debug\CMakeFiles\Neuron-Oscillations.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Neuron-Oscillations.dir/depend
