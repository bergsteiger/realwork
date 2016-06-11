#include <string.h>

;-----------------------------------------------------------------------
;
;Name		memcmp - compare two memory arrays
;
;Usage		int memcmp(const void *s1, const void *s2, size_t n);
;
;Prototype in	mem.h & string.h
;
;Description	memcmp compares two memory areas, s1 and s2, for a length
;		of exactly n bytes. This function compares bytes as
;		unsigned chars, so memcmp ("\0xFF", "\0x7F", 1) returns
;		a positive value.
;
;Return value	< 0 if s1 is less than s2
;		= 0 if s1 is the same as s2
;		> 0 if s1 is greater than s2
;
;-----------------------------------------------------------------------
int memcmp(const void *s1, const void *s2, size_t n)
{
    unsigned char *p1, *p2;

    p1 = s1;
    p2 = s2;

    while(n--)
    {
        if (*p1 != *p2)
	  return (*p1 < *p2)? -1 : 1;
	p1++;
	p2++;
    }
    return 0;
}
