include config.mk
include rules.mk

CFLAGS += -D$(TARGET_PLATFORM)

Q := @

INCLUDES += libopencm3/include
LIB_DIRS += libopencm3/lib

SOURCEDIRS += $(SDIR) 

OBJS += $(patsubst %.c, %.o, $(wildcard $(addsuffix /*.c, $(SOURCEDIRS))))

LDLIBS = -l$(LIBNAME) 

LDFLAGS	+= -Wl,-Map=$(TARGET).map

CFLAGS += $(addprefix -I, $(INCLUDES))

LDFLAGS += -static -T$(LDSCRIPT)
LDFLAGS += $(addprefix -L, $(LIB_DIRS))


VPATH := $(SOURCEDIRS)

all: hex bin size

include $(wildcard $(addsuffix /*.d, $(SOURCEDIRS)))

-include local.mk

