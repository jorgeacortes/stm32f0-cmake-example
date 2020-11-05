# About

![Build](https://github.com/jorgeacortes/stm32f0-cmake-example/workflows/Build/badge.svg)

This project contains a blinking led project example for compiling a STM32F072xB microcontroller with modern CMake and HAL drivers.

## Project contents

* `CMake/toolchain.cmake` arm-none-eabi toolchain loader for CMake.
* `CMakeLists.txt` with project CMake configuration.
* `basic.ioc` STM32CubeMX project.
* `debug.launch` debug configuration for STM32CubeIDE.
* `Docker/` scripts for compiling with [stm32-cmake Docker image](https://hub.docker.com/r/cortesja/stm32-cmake).
* `build.sh` and `clean.sh` for compiling in a Linux machine.

## Sample usage

```
# build project in debug mode
docker run --rm -v $(pwd):/home/stm32/ws cortesja/stm32-cmake:latest bash -c "sh build.sh"
```

## Notes

Toolchain is searched in the directory of the enviroment variable `ARM_TOOLCHAIN`, you can configure this as you require.
