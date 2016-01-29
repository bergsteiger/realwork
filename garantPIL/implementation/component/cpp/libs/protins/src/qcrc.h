#ifdef __cplusplus
extern "C" {
#endif

#define CRC32_POLY 0x04c11db7l     /* AUTODIN II, Ethernet, & FDDI */
#define MAX_SIZE        0xF000l

unsigned long prot_crc32(unsigned char *buf, unsigned int len);

#ifdef __cplusplus
}
#endif
