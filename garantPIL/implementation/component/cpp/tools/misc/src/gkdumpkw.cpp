
#include "shared/Core/fix/mpcxc.h"

// gkdumpi.cc
#include <cstdio>
#include <cstdlib>
#include <ctime>
//#include <unistd.h>
#include <getopt.h>

#include "gardefs.h"
#include "stdbase.h"
#include "newdoc.h"
#include "refcol.h"
#include "btiter.h"
#include "long.caddr_t.SplayMap.h"
#include "clTreeNode.SplaySet.h"
#include "long.longSplaySet.SplayMap.h"
#include "long.long.SplayMap.h"
#include "cdflts.h"
#include <cstdio>
#include <cstring>

#include "garver.h"
#include "basemask.h"

static clTreeNode * readHindex( HIndex *idx);
static void printKwTree1(HIndex *hi, clTreeNode &me, FILE* theOut);
static void printKwTree2(HIndex *hi, clTreeNode &me, FILE* theOut, const char *prev);

static unsigned long DocOffSet = 0;

void usage(char *str)
{
	printf("GARANT Base keyword dumper v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
	printf("Usage: %s [-n] <base>\n", str);
	printf("\t-n  - print real document numbers\n");
}

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GKDUMPKW;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GKDUMPKW Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	int rv = 0;
	clTreeNode *tn = 0;

	if (argc < 2) {
		usage(argv[0]);
		return 1;
	}

	if (argc == 3)
	{
		if (strcmp(argv[1],"-n") == 0)
		{
			DocOffSet = 100000;
		}
	}

	Base *base = new YBase( argv[argc-1], ACE_OS_O_RDONLY );
	if( !base || !base->IsOk()){
		printf("Base %s not ok.\n", argv[1]);
	}
	HIndex *hi = (HIndex *) base->FindIndex("KeyWord");
	if( !hi ){
		printf("No index.\n");
		rv = 1;
	} else {
		tn = readHindex( hi );
		if( !tn ){
			printf("Can't read tree for index!\n");
			rv = 2;
		} else {
			if( tn->items ){
				for( Pix i = tn->items->first(); i; tn->items->next(i) ){
					printKwTree1(hi, (*(tn->items))(i), stdout);
				}
			}
		}
	}
	delete base;
	return rv;
}

static void printKwTree1(HIndex *hi, clTreeNode &me, FILE* theOut)
{
	fprintf(theOut, "!KEY %s\n", me.name.chars());
	if( me.items ){
		for( Pix i = me.items->first(); i; me.items->next(i) ){
			printKwTree2(hi, (*(me.items))(i), theOut, me.name.chars());
		}
	}
}

static void printKwTree2(HIndex *hi, clTreeNode &me, FILE* theOut, const char *prev)
{
	char key_buf[200];

	fprintf(theOut, "\t%s: ", me.name.chars());

	sprintf(key_buf, "%s\\%s", prev, me.name.chars());
	Stream *str = hi->Open(key_buf);
	if (!str) {
		fprintf(theOut, "Key not found: %s\n", key_buf);
		return ;
	}
	Ref *buffer = (Ref *)(new char[str->Length()+1]);
	str->Read(buffer, str->Length());
	for (unsigned int i = 0; i < str->Length() / sizeof(Ref); i++) {
		if (buffer[i].Sub)
			fprintf(theOut, "%ld.%ld ", buffer[i].DocId - DocOffSet, buffer[i].Sub);
		else
			fprintf(theOut, "%ld ", buffer[i].DocId - DocOffSet);
	}
	fprintf(theOut, "\n");
	hi->Close(str);
}

static clTreeNode * readHindex( HIndex *idx)
{
	longcaddr_tSplayMap 	*id2node = new longcaddr_tSplayMap(0);
	clTreeNode  *clTreeRoot = new clTreeNode();

	(*id2node) [0] = (caddr_t) clTreeRoot;
	clTreeRoot->items = 0;

	unsigned dleoffset = idx->KeyLength - idx->ImmDataSize - 4;

	for( BTIterator it(idx ); ! it.End(); ++it ){
		const void * k = it.Key() ;
		long id = idx->Id(k);
		long pid = idx->Parent(k);
		int  children = idx->AllChildrenCount(k);
		unsigned long dchildren = idx->OwnChildrenCount(k);

		clTreeNode *pn = (clTreeNode *) (*id2node)[pid];
		if( !pn ){
			printf("No parent for node id %ld\n", id);
			return 0; 
		}
		if( ! pn-> items )
			pn -> items = new clTreeNodeSplaySet();

		clTreeNode t;
		t.name = idx->Text(k);
		t.items = 0;
		t.id = id;
		t.pid = pid;
		t.dlen = *(u_int32_t*)((const char*)k+dleoffset);
		t.children = children;
		t.dchildren = dchildren;

		Pix pc = pn -> items -> add(t);
		caddr_t iptr =  (caddr_t) & (*(pn->items))(pc); 

		(*id2node)[id] =  iptr;
	
	}
	delete id2node;
	return  clTreeRoot;
}






