#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "shared/Core/os/IniFile.h"
#include "gardefs.h"
#include "garutils.h"
#include "garver.h"
#include "stdbase.h"
#include "basemask.h"

#include "SearchB.h"
#include "protect.h"

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
	/*if (strcmp (argv [2], "write")) {
		YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		Document *doc = base->GetDoc (10103000);
		for (int i = 0; i < doc->Stat.ParaCount; i++)
			printf ("%s\n", doc->EVDParaText (doc->GetPara (i)));
		delete base;
		exit (EXIT_SUCCESS);
	}*/

	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->IsOk ();
	DocCollection *alltopics = base->AllTopics (ID_BORDER);
	std::map<long,char*> map_doc_data;
	std::map<long,long> map_doc_datasize;
	std::map<long,long> map_doc_offset;
	long total_size = 0;
	for (int i = 0; i < alltopics->ItemCount; i++) {
		long id = (*alltopics) [i];
		Document* doc = base->GetDoc (id);
		if (doc->Stat.Status & (DS_DOC | DS_EDITION)) {
			map_doc_offset.insert (std::map<long,long>::value_type (id, total_size));
			long size = sizeof (short) * 2 + doc->BlockCount * sizeof (BlockRec) + doc->RunCount * sizeof (PageRun);
			total_size += size;
			char* data = new char [size], *ptr = data;
			*(short*)ptr = (short) (doc->BlockCount & 0xFFFF);
			ptr += sizeof (short);
			memcpy (ptr, doc->blocks, doc->BlockCount * sizeof (BlockRec));
			ptr += doc->BlockCount * sizeof (BlockRec);
			*(short*)ptr = (short) (doc->RunCount & 0xFFFF);
			ptr += sizeof (short);
			memcpy (ptr, doc->runs, doc->RunCount * sizeof (PageRun));
			map_doc_data.insert (std::map<long,char*>::value_type (id, data));
			map_doc_datasize.insert (std::map<long,long>::value_type (id, size));
		}
		delete doc;
	}
	printf ("offsets size: %ld\n", map_doc_data.size () * 8);
	printf ("total_size: %ld\n", total_size);

	long *offsets = new long [map_doc_data.size () * 2], *ptr = offsets;
	for (std::map<long,long>::const_iterator offset_it = map_doc_offset.begin (); offset_it != map_doc_offset.end (); offset_it++) {
		*ptr++ = offset_it->first;
		*ptr++ = offset_it->second;
	}
	char *data = new char [total_size], *dataptr = data;
	for (std::map<long,char*>::const_iterator data_it = map_doc_data.begin (); data_it != map_doc_data.end (); data_it++) {
		long id = data_it->first;
		//printf ("id: %ld ", id);
		long datasize = map_doc_datasize.find (data_it->first)->second;
		//printf ("datasize: %ld ", datasize);
		//printf ("offset: %ld ", dataptr - data);
		char* iddata = data_it->second, *ptr = iddata;
		short count = *(short*) ptr;
		printf ("blocks: %ld ", count);
		ptr += sizeof (short);
		ptr += count * sizeof (BlockRec);
		count = *(short*) ptr;
		//printf ("runs: %ld\n", count);
		memcpy (dataptr, iddata, datasize);
		dataptr += datasize;
	}

	delete alltopics;
	delete base;

	base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	Stream* str = base->FindIndex ("Aux")->Open ("DOCO", 1);
	if (str) {
		str->Write (offsets, map_doc_data.size () * 8);
		str->Trunc ();
		base->FindIndex ("Aux")->Close (str);
	}
	str = base->FindIndex ("Aux")->Open ("DOCD", 1);
	if (str) {
		str->Write (data, total_size);
		str->Trunc ();
		base->FindIndex ("Aux")->Close (str);
	}
	delete base;
	return 0;
}



