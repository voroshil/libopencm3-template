MEMORY
{
	ram (rwx) : ORIGIN = 0x20000000, LENGTH = 6K
	rom (rx) : ORIGIN = 0x08002000, LENGTH = 32K
}

INCLUDE libopencm3_stm32f1.ld
