#include "gdbapi.h"
#include "base.h"
#include "platform.h"

int shrtcmp(const void *l1, const void *l2)
{
  return (*((u_int16_t *)l1) > *((u_int16_t *)l2)) ?
		1 : (*((u_int16_t *)l1) < *((u_int16_t *)l2)) ? -1 : 0;
}

#ifdef	BLOCKSINHERIT
int	supercompare = 1;
#define	INHERITED_BLOCK		0x40000000
#define	MINUS_INHERITED_BLOCK	0x3fffffff
#endif

int refcmp(const void *a1, const void *a2)
{
  if(((ref_st *)a1)->id > ((ref_st *)a2)->id) return 1;
  if(((ref_st *)a1)->id < ((ref_st *)a2)->id) return -1;
#ifdef	BLOCKSINHERIT
  if ( !supercompare ) {
      if (((ref_st *)a2)->sub & INHERITED_BLOCK ) {
          if ( ((ref_st*)a1)->sub == ( ((ref_st*)a2)->sub & MINUS_INHERITED_BLOCK ) )
              return 1;
          if ( ((ref_st*)a1)->sub  > ( ((ref_st*)a2)->sub & MINUS_INHERITED_BLOCK ) )
              return 1;
          return -1;
      }
  }
#endif
  if(((ref_st *)a1)->sub > ((ref_st *)a2)->sub) return 1;
  if(((ref_st *)a1)->sub < ((ref_st *)a2)->sub) return -1;
  return 0;
}

int ref2cmp(const void *a1, const void *a2)
{
	int s;
	if ( ((ref_st *)a1)->sub == 0 ) {
		if ( ((ref_st *)a2)->sub == 0 )
			s = ((ref_st *)a1)->id - ((ref_st *)a2)->id;
		else
			s = -1;			
	} else {
		if ( ((ref_st *)a2)->sub == 0 )
			s = 1;
		else
			s = ((ref_st *)a1)->id - ((ref_st *)a2)->id;
	}
	if ( s )
		return s > 0 ? 1 : -1;

	if(((ref_st *)a1)->sub > ((ref_st *)a2)->sub) return 1;
	if(((ref_st *)a1)->sub < ((ref_st *)a2)->sub) return -1;
	return 0;
}

int datecmp(const void *a1, const void *a2)
{
  if(((date_st *)a1)->year > ((date_st *)a2)->year) return 1;
  if(((date_st *)a1)->year < ((date_st *)a2)->year) return -1;
  if(((date_st *)a1)->month > ((date_st *)a2)->month) return 1;
  if(((date_st *)a1)->month < ((date_st *)a2)->month) return -1;
  if(((date_st *)a1)->day > ((date_st *)a2)->day) return 1;
  if(((date_st *)a1)->day < ((date_st *)a2)->day) return -1;
  return 0;
}

int ctxcmp(const void *ctx1, const void *ctx2)
{
  return strncmp((const char *)ctx1, (const char *)ctx2, 8);
}

#ifdef MULTI_INDEX_STREAM_FILE
int ctxcmp64(const void *ctx1, const void *ctx2)
{
	if(*(u_int64_t*)ctx1 < *(u_int64_t*)ctx2)
		return -1;
	if(*(u_int64_t*)ctx1 == *(u_int64_t*)ctx2)
		return 0;
	return 1;
}
#endif

int hindcmp(const void *phk1, const void *phk2)
{
	int ret;
	if(((hierkey_st *)phk1)->level > ((hierkey_st *)phk2)->level) return 1;
	if(((hierkey_st *)phk1)->level < ((hierkey_st *)phk2)->level) return -1;
	if(((hierkey_st *)phk1)->pid > ((hierkey_st *)phk2)->pid) return 1;
	if(((hierkey_st *)phk1)->pid < ((hierkey_st *)phk2)->pid) return -1;

	ret= stricmp(((hierkey_st *)phk1)->key, ((hierkey_st *)phk2)->key);

	if(ret > 0)
		return 1;
	if(ret < 0)
		return -1;

	return 0;
}

int hkwcmp(const void *phk1, const void *phk2)
{
	int ret;
	if(((hierkey_st *)phk1)->level > ((hierkey_st *)phk2)->level) return 1;
	if(((hierkey_st *)phk1)->level < ((hierkey_st *)phk2)->level) return -1;
	if(((hierkey_st *)phk1)->pid > ((hierkey_st *)phk2)->pid) return 1;
	if(((hierkey_st *)phk1)->pid < ((hierkey_st *)phk2)->pid) return -1;

	ret= strcmp(((hierkey_st *)phk1)->key, ((hierkey_st *)phk2)->key);

	if(ret > 0)
		return 1;
	if(ret < 0)
		return -1;

	return 0;
}
