#include <stdlib.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"

int release_streams(stream_st *pstr, int count)
{
	int i;

	for(i=0; i<count; i++)
		release_stream(pstr++);
	return count;
}

int minkeyx(char **pkeys, int count, int *xmin, cmpfunc_ft keycmp)
{
	int i, mincount, unmatch;
	char *pmin;

	*xmin = 0;
	pmin = pkeys[0];
	mincount = 1;
	for(i=1; i<count; i++) {
		unmatch = (*keycmp)(pkeys[i], pmin);
		if(unmatch < 0) {
			mincount = 1;
			*xmin = i;
			pmin = pkeys[i];
		}
		else if (unmatch == 0) {
			xmin[mincount] = i;
			mincount++;
		}
	}
	return mincount;
}

stream_st *create_streams(int count)
{
	stream_st *pstr;

	pstr = (stream_st *)calloc(count, sizeof(stream_st));
	pstr->flags |= SF_NOALLOC;
	return pstr;
}

set_st *create_sets(int count, cmpfunc_ft rcmp, int reclen)
{
	set_st *pset;
	int i;

	pset = (set_st *)calloc(count, sizeof(set_st));
	if(rcmp) {
		for(i=0; i<count; i++) {
			pset[i].rcmp = rcmp;
			pset[i].reclen = reclen;
		}
	}
	else
		for(i=0; i<count; i++) pset[i].reclen = reclen;
	return pset;
}
