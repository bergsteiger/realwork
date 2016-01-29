#include <stdlib.h>
#include "osdep.h"

#if defined(__GNUC__)
	#include <unistd.h>
#elif defined(__BORLANDC__)
	#include "platform.h"
#elif defined(__MSVC__)
	#define usleep(s) _sleep((unsigned long)(s/1000))
#else
	#error Please, find sleep() function in your system and include right header.
#endif

#include "gdbapi.h"
/*
void *ml_malloc(size_t size)
{
	void *p;
	int i;

	i=0;
	do {
		p = malloc(size);
		i++;
		if(!p)
			usleep(1000000);
	} while (!p && i<4);
	if (!p)
		gb_set_last_error(0x501);
	return p;
}

void *ml_calloc(int count, size_t size)
{
	void *p;
	int i;

	i=0;
	do {
		p = calloc(count, size);
		i++;
		if (!p)
			usleep(1000000);
	} while (!p && i<4);
	if (!p)
		gb_set_last_error(0x501);
	return p;
}
*/

