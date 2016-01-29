#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "newdoc.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "basemask.h"
#include "long.long.SplayMap.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if ( argc < 2 )
		return 0;

	{
		if (argc <5)
			return 0;

		Base *demo_base = new StdBigBase (argv [1], ACE_OS_O_RDWR), *source_base = new StdBigBase (argv [2], ACE_OS_O_RDONLY);
		short demo_seg = (short) atol (argv [3]);
		long demo_id = atol (argv [4]), i;

		Document *demo_doc = source_base->GetDoc (demo_id);
		Document* demo_related = source_base->GetDoc (demo_doc->Stat.Related);
		long demo_anno_id = GetDocMonitoring(&demo_doc->Stat);
		Document* demo_anno = source_base->GetDoc (demo_anno_id);
		if (!demo_doc || !demo_related || !demo_anno || !demo_doc->IsOk () || !demo_related->IsOk () || !demo_anno->IsOk ())
			exit (-1);

		long idd_refs_size;
		char *idd_refs = (char*) source_base->LoadAttr (demo_id, IDD_REFS, idd_refs_size);

		char **doc_buffers = new char* [demo_doc->Stat.ParaCount], **related_buffers = new char* [demo_related->Stat.ParaCount], **anno_buffers = new char* [demo_anno->Stat.ParaCount];
		long *doc_sizes = new long [demo_doc->Stat.ParaCount], *related_sizes = new long [demo_related->Stat.ParaCount], *anno_sizes = new long [demo_anno->Stat.ParaCount];
		for (i = 0; i < demo_doc->Stat.ParaCount; i++) {
			char *buffer = (char*) malloc (MAX_PARA_LEN), *para = demo_doc->GetPara (i);
			doc_sizes [i] = TextSize (para);
			doc_buffers [i] = buffer;
			buffer [0] = 8; *(long*)(buffer+1) = 0;
			memcpy (buffer+5, ParaText (para), TextSize (para));
		}
		for (i = 0; i < demo_related->Stat.ParaCount; i++) {
			char *buffer = (char*) malloc (MAX_PARA_LEN), *para = demo_related->GetPara (i);
			related_sizes [i] = TextSize (para);
			related_buffers [i] = buffer;
			buffer [0] = 8; *(long*)(buffer+1) = 0;
			memcpy (buffer+5, ParaText (para), TextSize (para));
		}
		for (i = 0; i < demo_anno->Stat.ParaCount; i++) {
			char *buffer = (char*) malloc (MAX_PARA_LEN), *para = demo_anno->GetPara (i);
			anno_sizes [i] = TextSize (para);
			anno_buffers [i] = buffer;
			buffer [0] = 8; *(long*)(buffer+1) = 0;
			memcpy (buffer+5, ParaText (para), TextSize (para));
		}

		IndexLoader loader (demo_base);
		DocCollection *all_docs = demo_base->AllDocs ();
		std::set<long> processed_ids, garbage_ids, refs_ids;

		//на первом шаге меняем тексты документов и справок к ним
		for (i = 0; i < all_docs->ItemCount; i++) {
			long id = (*all_docs)[i];

			DocInfo docinfo;
			demo_base->FindDocInfo (id, docinfo);
			if (!(docinfo.Status & DS_EVD)) {
				processed_ids.insert (id);
				continue;
			}

			long segs;
			INDEX_DATA (short) doc_segs = loader.load <short> (id, IDD_BASES, segs, true);
			if (!doc_segs.ptr ()) {
				processed_ids.insert (id);
				continue;
			}

			bool found = false;
			short* segs_ptr = doc_segs.ptr ();
			for (int seg = 0; seg < segs && !found; seg++, segs_ptr++)
				if (*segs_ptr == demo_seg)
					found = true;

			if (found) {
				processed_ids.insert (id);
				processed_ids.insert (docinfo.Related);
				processed_ids.insert (GetDocMonitoring (&docinfo));
				continue;
			}

			printf ("%ld\r", id);

			demo_base->DelText (id);
			garbage_ids.insert (id);
			NewDocument *new_doc = new NewDocument (demo_base, id, docinfo.Title, docinfo.Revision, PM_ZIP);
			for (int paras = 0; paras < demo_doc->Stat.ParaCount; paras++)
				new_doc->AddPara (PS_EVD, doc_sizes [paras]+5, doc_buffers [paras]);
			new_doc->pInfo->FirstDate = docinfo.FirstDate;
			new_doc->pInfo->LastDate = docinfo.LastDate;
			new_doc->pInfo->Force = docinfo.Force;
			new_doc->pInfo->HyperRefs = docinfo.HyperRefs;
			new_doc->pInfo->GreenComments = docinfo.GreenComments;
			new_doc->pInfo->Status = docinfo.Status;
			new_doc->pInfo->Related = docinfo.Related;
			new_doc->pInfo->prevEdition = docinfo.prevEdition;
			new_doc->pInfo->nextEdition = docinfo.nextEdition;
			new_doc->pInfo->lastParaID = docinfo.lastParaID;
			new_doc->pInfo->reserved_short = docinfo.reserved_short;
			new_doc->pInfo->reserved_short2 = docinfo.reserved_short2;
			delete new_doc;
			processed_ids.insert (id);
			refs_ids.insert (id);

			if (id = docinfo.Related) {
				demo_base->DelText (id);
				NewDocument *new_doc = new NewDocument (demo_base, id, docinfo.Title, docinfo.Revision, PM_ZIP);
				for (int paras = 0; paras < demo_related->Stat.ParaCount; paras++)
					new_doc->AddPara (PS_EVD, related_sizes [paras]+5, related_buffers [paras]);
				new_doc->pInfo->FirstDate = docinfo.FirstDate;
				new_doc->pInfo->LastDate = docinfo.LastDate;
				new_doc->pInfo->Force = docinfo.Force;
				new_doc->pInfo->HyperRefs = docinfo.HyperRefs;
				new_doc->pInfo->GreenComments = docinfo.GreenComments;
				new_doc->pInfo->Status = docinfo.Status;
				new_doc->pInfo->Related = docinfo.Related;
				new_doc->pInfo->prevEdition = docinfo.prevEdition;
				new_doc->pInfo->nextEdition = docinfo.nextEdition;
				new_doc->pInfo->lastParaID = docinfo.lastParaID;
				new_doc->pInfo->reserved_short = docinfo.reserved_short;
				new_doc->pInfo->reserved_short2 = docinfo.reserved_short2;
				delete new_doc;
				processed_ids.insert (id);
				garbage_ids.insert (id);
			}

			if (id = GetDocMonitoring (&docinfo)) {
				demo_base->DelText (id);
				NewDocument *new_doc = new NewDocument (demo_base, id, docinfo.Title, docinfo.Revision, PM_ZIP);
				for (int paras = 0; paras < demo_anno->Stat.ParaCount; paras++)
					new_doc->AddPara (PS_EVD, anno_sizes [paras]+5, anno_buffers [paras]);
				new_doc->pInfo->FirstDate = docinfo.FirstDate;
				new_doc->pInfo->LastDate = docinfo.LastDate;
				new_doc->pInfo->Force = docinfo.Force;
				new_doc->pInfo->HyperRefs = docinfo.HyperRefs;
				new_doc->pInfo->GreenComments = docinfo.GreenComments;
				new_doc->pInfo->Status = docinfo.Status;
				new_doc->pInfo->Related = docinfo.Related;
				new_doc->pInfo->prevEdition = docinfo.prevEdition;
				new_doc->pInfo->nextEdition = docinfo.nextEdition;
				new_doc->pInfo->lastParaID = docinfo.lastParaID;
				new_doc->pInfo->reserved_short = docinfo.reserved_short;
				new_doc->pInfo->reserved_short2 = docinfo.reserved_short2;
				delete new_doc;
				processed_ids.insert (id);
				garbage_ids.insert (id);
			}
		}

		printf ("\n");
		delete all_docs;
		all_docs = demo_base->AllTopics (ID_BORDER);
		//на втором шаге меняем тексты всех оставшихся документов
		for (i = 0; i < all_docs->ItemCount; i++) {
			long id = (*all_docs)[i];
			if (processed_ids.find (id) != processed_ids.end ())
				continue;

			DocInfo docinfo;
			demo_base->FindDocInfo (id, docinfo);
			if (!(docinfo.Status & DS_EVD))
				continue;
			printf ("%ld\r", id);

			demo_base->DelText (id);
			NewDocument *new_doc = new NewDocument (demo_base, id, docinfo.Title, docinfo.Revision, PM_ZIP);
			for (int paras = 0; paras < demo_doc->Stat.ParaCount; paras++)
				new_doc->AddPara (PS_EVD, doc_sizes [paras]+5, doc_buffers [paras]);
			new_doc->pInfo->FirstDate = docinfo.FirstDate;
			new_doc->pInfo->LastDate = docinfo.LastDate;
			new_doc->pInfo->Force = docinfo.Force;
			new_doc->pInfo->HyperRefs = docinfo.HyperRefs;
			new_doc->pInfo->GreenComments = docinfo.GreenComments;
			new_doc->pInfo->Status = docinfo.Status;
			new_doc->pInfo->Related = docinfo.Related;
			new_doc->pInfo->prevEdition = docinfo.prevEdition;
			new_doc->pInfo->nextEdition = docinfo.nextEdition;
			new_doc->pInfo->lastParaID = docinfo.lastParaID;
			new_doc->pInfo->reserved_short = docinfo.reserved_short;
			new_doc->pInfo->reserved_short2 = docinfo.reserved_short2;
			delete new_doc;
			garbage_ids.insert (id);
			refs_ids.insert (id);

			if (id = docinfo.Related) {
				demo_base->DelText (id);
				NewDocument *new_doc = new NewDocument (demo_base, id, docinfo.Title, docinfo.Revision, PM_ZIP);
				for (int paras = 0; paras < demo_related->Stat.ParaCount; paras++)
					new_doc->AddPara (PS_EVD, related_sizes [paras]+5, related_buffers[paras]);
				new_doc->pInfo->FirstDate = docinfo.FirstDate;
				new_doc->pInfo->LastDate = docinfo.LastDate;
				new_doc->pInfo->Force = docinfo.Force;
				new_doc->pInfo->HyperRefs = docinfo.HyperRefs;
				new_doc->pInfo->GreenComments = docinfo.GreenComments;
				new_doc->pInfo->Status = docinfo.Status;
				new_doc->pInfo->Related = docinfo.Related;
				new_doc->pInfo->prevEdition = docinfo.prevEdition;
				new_doc->pInfo->nextEdition = docinfo.nextEdition;
				new_doc->pInfo->lastParaID = docinfo.lastParaID;
				new_doc->pInfo->reserved_short = docinfo.reserved_short;
				new_doc->pInfo->reserved_short2 = docinfo.reserved_short2;
				delete new_doc;
				processed_ids.insert (id);
				garbage_ids.insert (id);
			}

			if (id = GetDocMonitoring (&docinfo)) {
				demo_base->DelText (id);
				NewDocument *new_doc = new NewDocument (demo_base, id, docinfo.Title, docinfo.Revision, PM_ZIP);
				for (int paras = 0; paras < demo_anno->Stat.ParaCount; paras++)
					new_doc->AddPara (PS_EVD, anno_sizes [paras]+5, anno_buffers [paras]);
				new_doc->pInfo->FirstDate = docinfo.FirstDate;
				new_doc->pInfo->LastDate = docinfo.LastDate;
				new_doc->pInfo->Force = docinfo.Force;
				new_doc->pInfo->HyperRefs = docinfo.HyperRefs;
				new_doc->pInfo->GreenComments = docinfo.GreenComments;
				new_doc->pInfo->Status = docinfo.Status;
				new_doc->pInfo->Related = docinfo.Related;
				new_doc->pInfo->prevEdition = docinfo.prevEdition;
				new_doc->pInfo->nextEdition = docinfo.nextEdition;
				new_doc->pInfo->lastParaID = docinfo.lastParaID;
				new_doc->pInfo->reserved_short = docinfo.reserved_short;
				new_doc->pInfo->reserved_short2 = docinfo.reserved_short2;
				delete new_doc;
				garbage_ids.insert (id);
				processed_ids.insert (id);
			}
		}

		printf ("\nremove garbage");
		AttrIndex* docInd = (AttrIndex*) demo_base->FindIndex( "Attrs" );
		std::set<long>::const_iterator it;
		for (it = garbage_ids.begin (); it != garbage_ids.end (); it++) {
			AttrKey delkey = {*it, IDD_SUBS};
			docInd->DelKey (&delkey);
			delkey.AttrTag = IDD_CONTENTS;
			docInd->DelKey (&delkey);
			delkey.AttrTag = IDD_REFS;
			docInd->DelKey (&delkey);
		}
		for (it = refs_ids.begin (); it != refs_ids.end (); it++) {
			demo_base->ReplaceAttr (*it, IDD_REFS, idd_refs, idd_refs_size);
		}
		printf ("\n");

		delete demo_base;
		delete source_base;
		exit (EXIT_SUCCESS);
	}
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}
