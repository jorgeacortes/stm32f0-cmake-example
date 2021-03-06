set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

find_program(CMAKE_C_COMPILER NAMES arm-none-eabi-gcc PATHS $ENV{ARM_TOOLCHAIN}/bin)
find_program(CMAKE_CXX_COMPILER NAMES arm-none-eabi-g++ PATHS $ENV{ARM_TOOLCHAIN}/bin)
find_program(CMAKE_ASM_COMPILER NAMES arm-none-eabi-gcc PATHS $ENV{ARM_TOOLCHAIN}/bin)

set(CMAKE_EXE_LINKER_FLAGS " --specs=nosys.specs --specs=nano.specs " CACHE INTERNAL "")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)