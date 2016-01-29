#include "shared/Core/fix/mpcxc.h"
#include <cstdio>

#include "stdbase.h"

static int dump_heres(const char *base_name);
static int write_heres(const char *base_name, u_int16_t *heres, u_int16_t hcount);
static void usage(void);

int shrtcmp(const void *k1, const void *k2)
{
	if (*((u_int16_t *)k1) > *((u_int16_t *)k2)) return 1;
	if (*((u_int16_t *)k1) < *((u_int16_t *)k2)) return -1;
	return 0;
}

int main(int argc, char **argv)
{
	u_int16_t *heres, hcount;
	int i;

	if(argc < 2)
		usage();
	else if(argc == 2)
		dump_heres(argv[1]);
	else {
		heres = (u_int16_t *)alloca((argc-2)*sizeof(u_int16_t));
		for(i=0, hcount=0; i<argc-2; i++) {
			heres[hcount] = (u_int16_t)atoi(argv[2+i]);
			if(heres[hcount]) hcount++;
		}
		qsort(heres, hcount, sizeof(u_int16_t), shrtcmp);
		write_heres(argv[1], heres, hcount);
	}
}

static int dump_heres(const char *base_name)
{
	printf("Base %s contains the following bases:\n", base_name);
	return 0;
}

static int write_heres(const char *base_name, u_int16_t *heres, u_int16_t hcount)
{
	YBase *base;
	Index *aux;
	Stream *str;

	base = new StdBigBase(base_name, ACE_OS_O_RDWR);
	if (!base || !base->IsOk()) {
		fprintf(stderr, "Can't open or check the base %s\n", base_name);
		return 0;
	}
	aux = base->FindIndex("Aux");
	str = aux->Open("Here");
	str->Write(heres, hcount * sizeof(u_int16_t));
	str->Trunc();
	aux->Close(str);
	delete base;
	return 1;
}

static void usage(void)
{
	printf("Usage is :\n");
	printf("write-here base [here1 ...]\n");
}



