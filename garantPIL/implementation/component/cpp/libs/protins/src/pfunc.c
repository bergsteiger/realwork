#include <string.h>
#include <stdio.h>
#include <stdlib.h>

short Pfunc ( short code )
{
	char s [10];
	char w [10];
	short i, j;
	long L;

	sprintf ( s, "%d", code );
	memset ( w, 0, 10 );

	for ( i = 0, j = strlen ( s ) - 1; j >= 0; i++, j-- )
		w [i] = s [j];

	L = atol ( w );
	L *= L;
	L = L * 194526L + 720745L;
	L ^= 12345678L;

	return (short)(~L & 0x7FFF);
}
