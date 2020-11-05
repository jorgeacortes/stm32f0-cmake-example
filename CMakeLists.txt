cmake_minimum_required(VERSION 3.15)

project(stm32-cmake-basic C ASM)
set(TARGET ${PROJECT_NAME}.elf )

macro(set_target_compile_and_link_options)
# Build type compilation options and flags
    set( DEBUG_COMPILE_OPTIONS
        -O0
        -g3
        # Use relative build path for debugging when building with Docker image
        -fdebug-prefix-map=/home/stm32/ws/=
    )
    set( DEBUG_COMPILE_FLAGS
        DEBUG
    )
    set( RELEASE_COMPILE_OPTIONS
        -O2
    )
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        message("-- Compiling in debug mode")
        target_compile_options( ${TARGET} PRIVATE ${DEBUG_COMPILE_OPTIONS})
        target_compile_definitions(${TARGET} PRIVATE ${DEBUG_COMPILE_FLAGS})
    else()
        message("-- Compiling in release mode")
        target_compile_options( ${TARGET} PRIVATE ${RELEASE_COMPILE_OPTIONS})
    endif(CMAKE_BUILD_TYPE STREQUAL "Debug")
# Generic compilation options
    target_compile_options(
        ${TARGET}
        PRIVATE
        -std=gnu11
        -ffunction-sections
        -fdata-sections
        -Wall
        -fstack-usage
    )
# STM32 flags
    target_compile_definitions(
        ${TARGET}
        PRIVATE
            USE_HAL_DRIVER
            STM32F072xB
            DEBUG
    )
# Processor compile options
    target_compile_options(
        ${TARGET}
        PRIVATE
            -mcpu=cortex-m0
            --specs=nano.specs
            -mthumb
            -mfloat-abi=soft
        PRIVATE
            $<$<COMPILE_LANGUAGE:ASM>: -x assembler-with-cpp >
    )
# Processor link options
    target_link_options(
        ${TARGET}
        PRIVATE
            -mcpu=cortex-m0
            -Wl,-Map=${PROJECT_NAME}.map
            -Wl,--gc-sections
            -static
            -mfloat-abi=soft
            -mthumb
    )
# Use custom linker script
    target_link_options(
        ${TARGET} PRIVATE -T ${CMAKE_SOURCE_DIR}/STM32F072RBTX_FLASH.ld
    )
# Link standard libraries libc and libm
    target_link_libraries(${TARGET} -lc -lm)
endmacro()

# STM32/CMSIS Drivers and HAL

include_directories(
    Drivers/STM32F0xx_HAL_Driver/Inc
    Drivers/STM32F0xx_HAL_Driver/Inc/Legacy
    Drivers/CMSIS/Device/ST/STM32F0xx/Include
    Drivers/CMSIS/Include
)

set(HAL_SOURCES
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_tim.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_tim_ex.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_uart.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_uart_ex.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_rcc.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_rcc_ex.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_i2c.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_i2c_ex.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_gpio.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_dma.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_cortex.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_pwr.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_pwr_ex.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_flash.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_flash_ex.c
    Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_exti.c
)

# STM32 System sources

set(SYSTEM_SOURCES
    Core/Startup/startup_stm32f072rbtx.s
    Core/Src/syscalls.c
    Core/Src/sysmem.c
    Core/Src/system_stm32f0xx.c
    Core/Src/stm32f0xx_it.c
    Core/Src/stm32f0xx_hal_msp.c
)

# Application includes and sources

include_directories(
    Core/Inc
)

set(APP_SOURCES
    Core/Src/main.c
)

# Generate target

set(PROJECT_SOURCES
    ${HAL_SOURCES}
    ${SYSTEM_SOURCES}
    ${APP_SOURCES}
)

add_executable(${TARGET} ${PROJECT_SOURCES})
set_target_compile_and_link_options()
