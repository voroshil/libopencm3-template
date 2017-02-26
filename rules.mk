PREFIX ?= arm-none-eabi
CC = $(PREFIX)-gcc
LD = $(PREFIX)-gcc
SZ = $(PREFIX)-size
OBJCOPY = $(PREFIX)-objcopy

LDLIBS += -Wl,--start-group -lc -lgcc -lnosys -Wl,--end-group -mthumb
LDLIBS += -nostartfiles
LDLIBS += -Wl,--gc-sections

CFLAGS += -mcpu=cortex-m3 -mthumb -fno-builtin
CFLAGS += -pipe -Wall -Os

AFLAGS = -mcpu=cortex-m3 -mthumb

%.hex: %.elf
	@printf "  OBJCOPY $(*).hex\n"
	$(Q)$(OBJCOPY) -Oihex $(*).elf $(*).hex

%.bin: %.elf
	@printf "  OBJCOPY $(*).bin\n"
	$(Q)$(OBJCOPY) -Obinary $(*).elf $(*).bin

%.o: %.c
	@printf "  CC      $(<F)\n"
	$(Q)$(CC) $(CFLAGS) -MD -o $@ -c $<

clean:
	@printf "  CLEAN\n"
	$(Q)rm -f *.elf *.bin *.hex *.srec *.list *.map $(OBJS) $(SDIR)/*.d

size:
	@echo "--------------------------"
	@$(SZ) $(TARGET).elf

hex: $(TARGET).hex
elf: $(TARGET).elf
bin: $(TARGET).bin

$(TARGET).elf: $(OBJS) $(LDSCRIPT)
	@printf "  LD      $@\n"
	$(Q)$(LD) $(LDFLAGS) $(ARCH_FLAGS) $(OBJS) $(LDLIBS) -o $@

.PHONY: clean elf hex bin size

	