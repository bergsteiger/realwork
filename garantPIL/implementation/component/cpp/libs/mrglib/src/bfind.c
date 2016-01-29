#include <stdlib.h>

#include "gdbapi.h"

void *bfindge(void *key, void *array, int rcount, int size, cmpfunc_ft cmpf)
{
	int low, count, current;
	char *r1, *rec;
	int unmatch;

	if(!rcount) return NULL;
	if(rcount == 1)
		return ((*cmpf)(key, array) > 0) ? NULL : array;
	rec = (char *)array + (rcount-1)*size;
	if((*cmpf)(key, rec) > 0) return NULL;
	if((*cmpf)(key, array) <= 0) return array;
	r1 = (char *)array;
	low = 0;
	count = rcount;
	while(count>2) {
		current = (count-1) >> 1;
		rec = r1+current*size;
		unmatch = (*cmpf)(key, rec);
		if(!unmatch) return rec; // or low+current
		if(unmatch < 0)
			count -= count-current-1; 
		else {
			r1 = rec; 
			low += current;
			count -= current; 
		}
	}
	return r1+size; // or low+1;
}

int bfindgex(void *key, void *array, int rcount, int size, cmpfunc_ft cmpf)
{
	int low, count, current;
	char *r1, *rec;
	int unmatch;

	if(!rcount) return 0;
	if(rcount == 1)
		return ((*cmpf)(key, array) > 0) ? 1 : 0;
	rec = (char *)array + (rcount-1)*size;
	if((*cmpf)(key, rec) > 0) return rcount;
	if((*cmpf)(key, array) <= 0) return 0;
	r1 = (char *)array;
	low = 0;
	count = rcount;
	while(count>2) {
		current = (count-1) >> 1;
		rec = r1+current*size;
		unmatch = (*cmpf)(key, rec);
		if(!unmatch) return low+current;
		if(unmatch < 0)
			count -= count-current-1; 
		else {
			r1 = rec; 
			low += current;
			count -= current; 
		}
	}
	return low+1;
}

