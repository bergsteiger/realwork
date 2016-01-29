#include "toys.h"


void otherIncProgress(void *);

void inc_progress(void *pCntxt)
{
	otherIncProgress(pCntxt);
}
