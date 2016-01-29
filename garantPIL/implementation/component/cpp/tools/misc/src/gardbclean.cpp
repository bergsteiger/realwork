#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "stdbase.h"
#include "btiter.h"

static void cleanBasesList(YBase *base);
static u_int16_t *collectBases(YBase *base, u_int16_t& count);

int main(int argc, char *argv[])
{
	if(argc < 2) {
		printf("Usage:\t%s <base>\n", argv[0]);
		return -2;
	}
	YBase *base = new YBase(argv[1], ACE_OS_O_RDWR);
	if (!(base && base->IsOk())) {
		if (base) delete base;
		printf("Base %s does not exist or is not valid.\n", argv[1]);
		return -3;
	}
	cleanBasesList(base);
	delete base;
	return 0;
}

static void cleanBasesList(YBase *base);
static u_int16_t *collectBases(YBase *base, u_int16_t& count);

static void cleanBasesList(YBase *base)
{
	u_int16_t *segments, segcount, sc;
	struct BaseInfo *pbi, bi;
	int i, bc, zero=0;
	Index *aux;
	Stream *str;
	
	segments = collectBases(base, segcount);
	pbi = (struct BaseInfo *) malloc((segcount+1) * sizeof(struct BaseInfo));
	bzero((caddr_t)pbi, (segcount+1) * sizeof(struct BaseInfo));
	aux = base->FindIndex("Aux");
	str = aux->Open("Base");
	bc = str->Length() / sizeof(struct BaseInfo);
	for(i=0, sc=0; i<bc && sc < segcount; i++) {
		str->Read(&bi, sizeof(struct BaseInfo));
		if(bi.BaseId == 0) {
			memcpy(pbi+sc+zero, &bi, sizeof(struct BaseInfo));
			zero++;
		}
		else {
			if(bi.BaseId == segments[sc]) {
				memcpy(pbi+sc+zero, &bi, sizeof(struct BaseInfo));
				sc++;
			}
		}
	}
	str->Seek(0);
	str->Write(pbi, (segcount+zero)*sizeof(struct BaseInfo));
	str->Trunc();
	aux->Close(str);
}

static u_int16_t *collectBases(YBase *base, u_int16_t& count)
{
	u_int16_t *ss, *sh, cs, ch, *s1, *s2, c1, c2, *segs, *s;
	Index *segind, *aux;
	Stream *str;
	int i;

	segind = base->FindIndex("Segment");
	if (!segind) return 0;
	cs = segind->KeyCount;
	ss = (u_int16_t *)malloc(cs<<1);
	bzero((caddr_t)ss, cs<<1);
	{
		BTIterator it(segind);
		for(i=0; !it.End(); ++it, i++) ss[i] = *((u_int16_t *)it.Key());
	}
	aux = base->FindIndex("Aux");
	str = aux->Open("Here");
	ch = str->Length() >> 1;
	sh = (u_int16_t *)malloc(ch << 1);
	bzero((caddr_t)sh, ch<<1);
	str->Read(sh, ch << 1);
	aux->Close(str);
	count = 0;
	s1 = ss; s2 = sh; c1 = cs; c2 = ch;
	while(c1 && c2) {
		if(*s1 < *s2) {
			s1++; c1--;
		}
		else if (*s2 < *s1) {
			s2++; c2--;
		}
		else {
			s1++; c1--;
			s2++; c2--;
		}
		count++;
	}
	if(c1) count += c1;
	else count += c2;
	s = segs = (u_int16_t *)malloc(count << 1);
	bzero((caddr_t)segs, count << 1);
	s1 = ss; s2 = sh; c1 = cs; c2 = ch;
	while(c1 && c2) {
		if(*s1 < *s2) {
			*s++ = *s1++; c1--;
		}
		else if (*s2 < *s1) {
			*s++ = *s2++; c2--;
		}
		else {
			*s++ = *s1++; c1--;
			s2++; c2--;
		}
	}
	if(c1) memcpy(s, s1, c1<<1);
	else if(c2) memcpy(s, s2, c2<<1);
	free(ss); free(sh);
	return segs;
}







