#include "shared/Core/fix/mpcxc.h"
#include "stdbase.h"
#include "btiter.h"
#include "garver.h"

typedef struct _segInfo {
	u_int16_t id;
	char *name;
} SegInfo;

SegInfo* getSegId(YBase *base, int *segCount)
{
	char keyHere[5] = "Here";
	char keyBases[] = "Base";
	Index *ind = base->FindIndex("Aux");
	if (!ind) {
		printf("Cannot find index Aux\n");
		return 0;
	}
	Stream *str = ind->Open(keyHere);
	if (!str) {
		printf("Cannot find key %s in index Aux\n", keyHere);
		return 0;
	}
	*segCount = str->Length()/sizeof(u_int16_t);
	SegInfo *res = new SegInfo[*segCount];
	if (!res) {
		printf("Cannot alloc memory\n");
		return 0;
	}
	int i;
	for (i = 0; i < *segCount; i++)
		str->Read(&(res[i].id), sizeof(u_int16_t));
	ind->Close(str);

	str = ind->Open(keyBases);
	if (!str) {
		printf("Cannot find key %s in index Aux\n", keyBases);;
		return 0;
	}
	
	BaseInfo temp;
	temp.BaseId = 10000;
	for (i = 0; i < *segCount; i++) {
		while(temp.BaseId != res[i].id)
			str->Read(&temp, sizeof(BaseInfo));
		res[i].name = new char[strlen(temp.Name)+1];
		strcpy(res[i].name, temp.Name);
	}
	ind->Close(str);

	return res;
}

void countAttrs(YBase *base, SegInfo* segInfo, int segCount)
{
	u_int32_t totalTopicCount = 0;
	u_int32_t totalDocCount = 0;
	u_int32_t totalIsDocCount = 0;
	u_int32_t totalComCount = 0;
	u_int32_t totalRefCount = 0;
	u_int32_t totalLevel0 = 0;
	u_int32_t totalLevel1 = 0;
	
	u_int32_t* topicCount = new u_int32_t[segCount];
	memset(topicCount, 0, sizeof(u_int32_t)*segCount);

	u_int32_t* docCount = new u_int32_t[segCount];
	memset(docCount, 0, sizeof(u_int32_t)*segCount);

	u_int32_t* isdocCount = new u_int32_t[segCount];
	memset(isdocCount, 0, sizeof(u_int32_t)*segCount);

	u_int32_t* comCount = new u_int32_t[segCount];
	memset(comCount, 0, sizeof(u_int32_t)*segCount);

	u_int32_t* refCount = new u_int32_t[segCount];
	memset(refCount, 0, sizeof(u_int32_t)*segCount);

	AttrIndex *ind = (AttrIndex *)base->FindIndex("Attrs");
	if (!ind) {
		printf("Error find Attrs index\n");
		return;
	}
	AttrKey ak;
	ak.DocId = 0;
	ak.AttrTag = IDD_BASES;
	
	for (BTIterator iter(ind, &ak); !iter.End(); ++iter) {
		AttrKey *key = (AttrKey *)iter.Key();
		if (key->AttrTag != IDD_BASES)
			break;
		if (key->AttrTag == IDD_BASES) {
			Stream *str = ind->Open(key);
			if (!str) {
				printf("Error reading stream\n");
				return;
			}
			u_int16_t id;
			DocInfo *di = 0;
			for (unsigned int idCount = 0; idCount < str->Length()/sizeof(u_int16_t); 
					idCount ++) {
				str->Read(&id, sizeof(u_int16_t));
				
				if (key->DocId >= 100000) {
					long size;
					di = (DocInfo *)ind->Load(key->DocId, IDD_INFO, size);
					if (!di) {
						printf("DocInfo not found for docid = %ld\n", key->DocId);
						continue;
					}
					if (size != sizeof(DocInfo)) {
						printf("Too short DocInfo for docid = %ld\n", key->DocId);
						continue;
					}
				}
				if (!idCount) {	
					totalTopicCount++;
				
					if (key->DocId >= 100000) {
						if (di->Status & DS_DOC) totalDocCount++;
						if (di->Status & DS_ISDOC) totalIsDocCount++;
						totalComCount += di->GreenComments;
						totalRefCount += di->HyperRefs;
					}
				}

				for (int i = 0; i < segCount; i++) { 

					if (id == segInfo[i].id) {
						topicCount[i]++;
						
						if (key->DocId < 100000) continue; 
						
						if (di->Status & DS_DOC) docCount[i]++;
						if (di->Status & DS_ISDOC) isdocCount[i]++;
						comCount[i] += di->GreenComments;
						refCount[i] += di->HyperRefs;
					}
				}
			}
			ind->Close(str);
			if (di) free(di);
		}
	}
	printf("<table border=2><tr><td>Segment</td><td>IsDoc count</td>");
	printf("<td>Document count</td><td>Reference count</td>");
	printf("<td>Comments count</td><td>KeyWords level 1</td>");
	printf("<td>KeyWords level 2</td></tr>\n");
	for (int i = 0; i < segCount; i++) {
		printf("<tr><td>%s (%d)</td>", segInfo[i].name, segInfo[i].id);
		//printf("Topic count = %d\n", topicCount[i]);
		printf("<td>%d</td>", isdocCount[i]);
		printf("<td>%d</td>", docCount[i]);
		printf("<td>%d</td>", refCount[i]);
		printf("<td>%d</td><td></td><td></td></tr>\n", comCount[i] );
	}

	HIndex *key_ind = (HIndex *)base->FindIndex("KeyWord");
	if (!key_ind) {
		printf("Index KeyWord not found\n");
		return;
	}
	BTIterator key_iter(key_ind);
	while (!key_iter.End()) {
		const void *key = key_iter.Key();
		if (key_ind->Level(key) == 0) totalLevel0++;
		if (key_ind->Level(key) == 1) totalLevel1++;
		++key_iter;
	}
	printf("<tr><td>Total information</td>");
	//printf("Topic count = %d\n", totalTopicCount);
	printf("<td>%d</td>", totalIsDocCount);
	printf("<td>%d</td>", totalDocCount);
	printf("<td>%d</td>", totalRefCount);
	printf("<td>%d</td>", totalComCount);
	printf("<td>%d</td>", totalLevel0);
	printf("<td>%d</td>", totalLevel1);
	printf("</tr></table>\n");
	
	delete topicCount;
	delete docCount;
	delete isdocCount;
	delete refCount;
	delete comCount;
}

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if (argc < 2) {
		printf("GARANT Base statistics calculator v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
		printf("Usage: %s <base>\n", argv[0]);
		return -1;
	}
	YBase *base = new YBase(argv[1], ACE_OS_O_RDONLY);
	if (!base || !base->IsOk()) {
		printf("Error opening base.");
		return -1;
	}
	int segCount;
	SegInfo* segInfo = getSegId(base, &segCount);
	if (!segInfo) {
		printf("Error reading segments ids\n");
		return -1;
	}
/*
	for (int i = 0; i < segCount; i++) {
		printf("Found segment (%d) '%s'\n", 
			segInfo[i].id, segInfo[i].name);
	}
*/
	countAttrs(base, segInfo, segCount);

	delete segInfo;
	delete base;

	return 0;
}

