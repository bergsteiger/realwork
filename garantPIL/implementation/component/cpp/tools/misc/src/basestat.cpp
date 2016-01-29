#include "shared/Core/fix/mpcxc.h"
#include "osdep.h"

#include <cstring>
#include <cstdio>
#include <cstdlib>
//#include <unistd.h>
#include <getopt.h>

#include "stdbase.h"
#include "index.h"
#include "gardefs.h"

u_int32_t options = 0;

void dumpActiveInfo(BaseInfo *bi, int bcount, u_int16_t *heres, int hcount);
void dumpInactiveInfo(BaseInfo *bi, int bcount, u_int16_t *heres, int hcount);
void dumpFullInfo(BaseInfo *bi, int bcount, u_int16_t *heres, int hcount);
void dumpBaseInfo(BaseInfo *bi);

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	YBase *b;
	Index *aux;
	Stream *str;
	u_int32_t classver[4];
	BaseInfo *bi, *cbi;
	u_int16_t *heres, hcount, bicount;
	int i;

	if (argc < 2) {
		printf("Garant database BaseInfo dump utility.\n");
		printf("Usage: %s [-a | -u] <base name>\n", argv[0]);
		printf("Options:\n-a\tDump all found BaseInfo\n");
		printf("-u\tDump BaseInfo only for segments not in base.\n");
		printf("Note: -u always override -a\n");
		return 0;
	}
	while((i=getopt(argc, argv, "au"))!=-1) {
		switch(i) {
			case 'a':
				if(!(options & 0x00000002))
					options |= 0x00000001;
				break;
			case 'u':
				options &= 0xFFFFFFFE;
				options |= 0x00000002;
				break;
		}
	}
	b = new YBase(argv[optind], ACE_OS_O_RDONLY);
	if (!b || !b->IsOkWithoutText()) {
		printf("Can't open base %s\n", argv[1]);
		if (b) delete b;
		return 0;
	}
	aux = b->FindIndex("Aux");
	str = aux->Open("Clas");
	str->Read(classver, str->Length());
	aux->Close(str);
	printf("Classificator version: \t%d\n", classver[0]);
	str = aux->Open("Here");
	heres = (u_int16_t *)malloc(str->Length());
	hcount = (unsigned short)(str->Length() >> 1);
	str->Read(heres, str->Length());
	aux->Close(str);
	str = aux->Open("Base");
	bi = (BaseInfo *)malloc(str->Length());
	bzero(bi, str->Length());
	str->Read(bi, str->Length());
	bicount = str->Length() / sizeof(BaseInfo);
	aux->Close(str);
	printf("%d segments present in base: \n", (int)hcount);
	for (i=0, cbi=bi; i<hcount; i++) {
		while(cbi->BaseId != heres[i]) cbi++;
		printf("\t%d: %s\n", (int)(heres[i]), cbi->Name);
	}
	if(bi->BaseId == 0) {
		printf("\nMain base info:\n");
		printf("  Base Name: %s\n", bi->Name);
		printf("  Docs: %u\n", (unsigned)bi->DocCount);
		printf("  Comments: %u\n", (unsigned)bi->CommentsCount);
		printf("  Forms: %u\n", (unsigned)bi->FormsCount);
		printf("  Projects: %u\n", (unsigned)bi->ProjectCount);
		printf("  Praktik topics: %u\n", (unsigned)bi->PractikCount);
		printf("  Questions: %u\n", (unsigned)bi->QuestionCount);
		printf("  Business Refs: %u\n", (unsigned)bi->BReferCount);
		printf("  Account topic: %u\n", (unsigned)bi->AccountTopic);
		printf("  User info topic: %u\n", (unsigned)bi->UserInfoTopic);
		printf("  Alt menu topic: %u\n", (unsigned)bi->AltMenuTopic);
		printf("  Business topic: %u\n", (unsigned)bi->BusinessTopic);
		printf("  Base weight: %u\n\n", (unsigned)bi->Weight);
	}
	if(options & 1)
		dumpFullInfo(bi, bicount, heres, hcount);
	else if(options & 2)
		dumpInactiveInfo(bi, bicount, heres, hcount);
	else
		dumpActiveInfo(bi, bicount, heres, hcount);
	free(heres);
	free(bi);
	delete b;
	return 0;
}

void dumpActiveInfo(BaseInfo *bi, int bcount, u_int16_t *heres, int hcount)
{
	BaseInfo *cbi;
	int i;

	printf("\nPresent segments information:\n\n");
	for(i=0, cbi=bi; i<hcount; i++) {
		while(cbi->BaseId != heres[i]) cbi++;
		dumpBaseInfo(cbi);
	}
}

void dumpInactiveInfo(BaseInfo *bi, int bcount, u_int16_t *heres, int hcount)
{
	BaseInfo *cbi;
	int i, j;

	printf("\nAbsent segments information:\n\n");
	if(bi->BaseId == 0) {
		bi++;
		bcount--;
	}
	for(i=0, cbi=bi, j=0; i<bcount; i++, cbi++) {
		if(j<hcount) {
			while(j<hcount && i<bcount && cbi->BaseId == heres[j]) {
				cbi++;
				i++;
				j++;
			}
			if(i==bcount) return;
		}
		dumpBaseInfo(cbi);
	}
}

void dumpFullInfo(BaseInfo *bi, int bcount, u_int16_t *heres, int hcount)
{
	dumpActiveInfo(bi, bcount, heres, hcount);
	dumpInactiveInfo(bi, bcount, heres, hcount);
}

void dumpBaseInfo(BaseInfo *bi)
{
	printf("  Segment ID: %d\n", (int)(bi->BaseId));
	printf("  Segment Name: %s\n", bi->Name);
	printf("  Docs: %d\n", (int)bi->DocCount);
	printf("  Comments: %d\n", (int)bi->CommentsCount);
	printf("  Forms: %d\n", (int)bi->FormsCount);
	printf("  Projects: %d\n", (int)bi->ProjectCount);
	printf("  Praktik topics: %d\n", (int)bi->PractikCount);
	printf("  Questions: %d\n", (int)bi->QuestionCount);
	printf("  Business Refs: %d\n", (int)bi->BReferCount);
	printf("  Account topic: %d\n", (int)bi->AccountTopic);
	printf("  User info topic: %d\n", (int)bi->UserInfoTopic);
	printf("  Alt menu topic: %d\n", (int)bi->AltMenuTopic);
	printf("  Business topic: %d\n", (int)bi->BusinessTopic);
	printf("  Segment weight: %d\n\n", (int)bi->Weight);
}





