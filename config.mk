# Name of target firmware image
TARGET := template

# Target platform, supported by libopencm3
# E.g: STM32F1, STM32F0, etc
TARGET_PLATFORM := STM32F1

# Name of apropriate libopencm3 library
# Keep in sync woth TARGET_PLATFORM
LIBNAME = opencm3_stm32f1

# Directory with source files
SDIR := src

LDSCRIPT := $(TARGET).ld
