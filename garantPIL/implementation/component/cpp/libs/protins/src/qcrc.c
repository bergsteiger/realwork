#define CRC32_POLY 0x04c11db7l     /* AUTODIN II, Ethernet, & FDDI */

unsigned long crc32_table[256];

void init_crc32(void)
{
	int i, j;
	unsigned long c;

	for (i = 0; i < 256; ++i) {
		for (c = (long) i << 24, j = 8; j > 0; --j)
			c = c & 0x80000000l ? (c << 1) ^ CRC32_POLY : (c << 1);
		crc32_table[i] = c;
	}
}

unsigned long prot_crc32(unsigned char *buf, unsigned int len)
{
	unsigned char *p;
	unsigned long  crc;

	if (!crc32_table[1])    /* if not already done, */
		init_crc32();   /* build table */
	crc = 0xffffffffl;      /* preload shift register, per CRC-32 spec */
	for (p = buf; len > 0; ++p, --len)
		crc = (crc << 8) ^ crc32_table[(crc >> 24) ^ *p];
	return ~crc;            /* transmit complement, per CRC-32 spec */
}

