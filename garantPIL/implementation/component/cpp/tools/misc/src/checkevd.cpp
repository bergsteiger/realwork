#include "shared/Core/fix/mpcxc.h"

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "newdoc.h"
#include "SearchB.h"

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

std::map<long, long> map_edition_doc;
std::set<long> docs;
std::map<long, std::set<long> > map_doc_editions;

void	LoadEdis (Base* base)
{
	Stream *str = base->FindIndex ("Aux")->Open ("Edis");
	if (!str) {
		if (!base->FindIndex ("Aux")->Open ("InfL")) {
			printf ("run gl first!\n");
			exit (EXIT_FAILURE);
		}
	} else {
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		base->FindIndex ("Aux")->Close (str);
		size >>= 3;
		for (int i = 0; i < size; i++) {
			long edition = *ptr;
			ptr++;
			long doc = *ptr;
			docs.insert (doc);
			ptr++;

			map_edition_doc.insert (std::map<long,long>::value_type (edition, doc));
			if (map_edition_doc.find (doc) == map_edition_doc.end ())
				map_edition_doc.insert (std::map<long,long>::value_type (doc, doc));

			std::map<long, std::set<long> >::iterator it = map_doc_editions.find (doc);
			if (it == map_doc_editions.end ()) {
				std::set<long> editions;
				editions.insert (edition);
				editions.insert (doc);
				map_doc_editions.insert (std::map<long, std::set<long> >::value_type (doc, editions));
			} else {
				it->second.insert (edition);
			}
		}
	}
}

int main_logic ( int argc, char **argv )
{
	if (argc < 2)
		return 0;

	bool b_fix = false;
	if ((argv [2] && !stricmp (argv [2], "fix")) || (argv [2] && argv [3] && !stricmp (argv [3], "fix")))
		b_fix = true;

	YBase* aBase = new YBase (argv [1], ACE_OS_O_RDONLY);
	aBase->IsOk ();

	DocCollection* alltopics = aBase->AllTopics (ID_BORDER);

	std::set<long> docswoedis_tofix, docswithedis_tofix, splash_topics;
	Stream* str = aBase->FindIndex ("Aux")->Open ("Spla");
	if (str) {
		for (int i = 0; i < str->Length () / sizeof (long); i++) {
			long id;
			str->Read (&id, sizeof (id));
			splash_topics.insert (id);
		}
		aBase->FindIndex ("Aux")->Close (str);
	}

	std::set<long> docs_with_dups;
	for ( int i = 0; i < alltopics->ItemCount; i++ ) {
		long docid = (*alltopics)[i];
		if ((splash_topics.find (docid) != splash_topics.end ()) || (docid == 100104) || ((docid >= ID_DIC_LO) && (docid <= ID_DIC_HI)) || ((docid > BIG_INFO_DOC) && (docid < BIG_INFO_DOC + BIG_INFO_COUNT)))
			continue;

		DocInfo docInfo;
		aBase->FindDocInfo( docid, docInfo );
		bool b_checktext = true;
		if ( !( docInfo.Status & DS_EVD )) {
			printf( "%ld не в формате EVD\n", docid );
			b_checktext = false;
		} else {
			if (0 == docInfo.lastParaID) {
				printf ("lastParaId равен 0 у %ld\n", docid);
				if (docInfo.ParaCount && b_fix) {
					if (0 == docInfo.prevEdition + docInfo.nextEdition) {
						docswoedis_tofix.insert (docid);
					} else {
						if (docInfo.Status & DS_DOC)
							docswithedis_tofix.insert (docid);
						else
							docswithedis_tofix.insert (map_edition_doc.find (docid)->second);
					}
				}
			}
		}
		{
			Document *doc = aBase->GetDoc( docid );
			long count;
			long* paraids = (long*) aBase->LoadAttrEx( docid, IDD2_PARAIDS, count );
			count /= sizeof( long );

			bool error = false;

			if ( !count || count != doc->Stat.ParaCount ) {
				error = true;
				printf( "%ld Количество параграфов документов != количеству уникальных номеров параграфов в индексе\n", docid );
			}

			std::set<long> uids;
			long words_count = 0;
			if (count) for ( int paras = 0; paras < doc->Stat.ParaCount; paras++ ) {
				char* _para = doc->GetPara( paras );
				unsigned len = doc->EVDTextSize(_para);
				char *para = doc->EVDParaText (_para, true);
				if (b_checktext) {
					bool local_error = false;
					for ( int c = 0; c < len && !local_error; c++ ) {
						unsigned char uc = (unsigned char)para[c];
						if (uc == 251 || uc == 253 || (uc < 16 && uc != 10 && uc != 9)) {
							local_error = true;
							printf( "%ld подозрительный параграф %s\n", docid, para );
						}
					}
					error |= local_error;
					para = doc->EVDParaText (_para, false);
					bool b_inword = false;
					while (len) {
						if (IS_CTX_CHAR_NORMLS_62(*para)) {
							if (!b_inword) {
								words_count++;
								b_inword = true;
							}
						} else {
							b_inword = false;
						}
						len--;
						para++;
					}
				}
				long uid = paraids[paras];
				if (uid  < 0 ) {
					error = true;
					printf( "%ld уникальный номер параграфа %ld у %s\n", docid, uid, para );
				} else if (uid != 0) {
					if (uids.find (uid) == uids.end ())
						uids.insert (uid);
					else {
						error = true;
						printf( "%ld (%s) дубль уникальный номер параграфа %ld у %s\n", docid, doc->Stat.Status & DS_DOC ? "DS_DOC" : (doc->Stat.Status & DS_EDITION ? "DS_EDITION" : "DS_NODOC"), uid, para);
						docs_with_dups.insert (docid);
					}
				}
			}

			if (uids.size () == 0)
				printf( "%ld среди уникальных номеров параграфов только 0\n", docid);

			free( paraids );

			if (docInfo.Status & (DS_DOC|DS_EDITION)) {
				if (words_count > 0xFFFF0) {
					printf ("%ld В документе слишком много слов\n", docid);
				}
			}			

			if (b_fix && (docInfo.Status & DS_DOC)) {
				long prev = docInfo.prevEdition;
				while (prev) {
					DocInfo docinfo;
					aBase->FindDocInfo (prev, docinfo);
					if (docinfo.lastParaID != docInfo.lastParaID) {
						printf ("%ld and %ld разные lastParaId\n", docid, prev);
						docswithedis_tofix.insert (docid);
					}
					prev = docinfo.prevEdition;
				}
				long next = docInfo.nextEdition;
				while (next) {
					DocInfo docinfo;
					aBase->FindDocInfo (next, docinfo);
					if (docinfo.lastParaID != docInfo.lastParaID) {
						printf ("%ld and %ld разные lastParaId\n", docid, next);
						docswithedis_tofix.insert (docid);
					}
					next = docinfo.nextEdition;
				}
			}

			delete doc;
		}
	}
	delete aBase;

	printf ("Docs with dups: %ld\n", docs_with_dups.size ()); fflush (stdout);
	if (argv [2] && stricmp (argv [2], "fix")) {
		FILE *out_file = fopen (argv [2], "wt");
		for (std::set<long>::const_iterator it = docs_with_dups.begin (); it != docs_with_dups.end (); it++)
			fprintf (out_file, "%ld\n", *it);
		fclose (out_file);
	}

	if ((argv [2] && !stricmp (argv [2], "fix")) || (argv [2] && argv [3] && !stricmp (argv [3], "fix"))) {
		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		for (std::set<long>::const_iterator it = docswoedis_tofix.begin (); it != docswoedis_tofix.end (); it++) {
			long docid = *it;
			DocInfo docinfo;
			base->FindDocInfo (docid, docinfo);

			long max_id = 0, size, *data = (long*) base->LoadAttrEx (docid, IDD2_PARAIDS, size), *ptr = data;
			for (long i = 0; i < size / sizeof (long); i++, ptr++)
				if (*ptr > 0)
					max_id = std::max (max_id, (*ptr & 0x3FFFFFFF) + 1);
			gk_free (data);
			docinfo.lastParaID = max_id;
			base->ReplaceAttr (docid, IDD_INFO, &docinfo, sizeof (DocInfo));
		}
		for (std::set<long>::const_iterator it = docswithedis_tofix.begin (); it != docswithedis_tofix.end (); it++) {
			long docid = *it, max_id;
			DocInfo docinfo;
			base->FindDocInfo (docid, docinfo);
			max_id = docinfo.lastParaID;
			std::map<long, std::set<long> >::const_iterator map_it = map_doc_editions.find (docid);
			std::set<long>::const_iterator edi_it;
			for (edi_it = map_it->second.begin (); edi_it != map_it->second.end (); edi_it++) {
				long edi = *edi_it;
				DocInfo edi_docinfo;
				base->FindDocInfo (edi, edi_docinfo);
				max_id = std::max (max_id, edi_docinfo.lastParaID);
			}
			if (max_id == 0) {
				long size, *data = (long*) base->LoadAttrEx (docid, IDD2_PARAIDS, size), *ptr = data;
				for (long i = 0; i < size / sizeof (long); i++, ptr++)
					if (*ptr > 0)
						max_id = std::max (max_id, (*ptr & 0x3FFFFFFF) + 1);
				gk_free (data);
				for (edi_it = map_it->second.begin (); edi_it != map_it->second.end (); edi_it++) {
					long edi = *edi_it, size, *data = (long*) base->LoadAttrEx (edi, IDD2_PARAIDS, size), *ptr = data;
					for (long i = 0; i < size / sizeof (long); i++, ptr++)
						if (*ptr > 0)
							max_id = std::max (max_id, (*ptr & 0x3FFFFFFF) + 1);
					gk_free (data);
				}
			}

			docinfo.lastParaID = max_id;
			base->ReplaceAttr (docid, IDD_INFO, &docinfo, sizeof (DocInfo));
			for (edi_it = map_it->second.begin (); edi_it != map_it->second.end (); edi_it++) {
				long edi = *edi_it;
				DocInfo edi_docinfo;
				base->FindDocInfo (edi, edi_docinfo);
				edi_docinfo.lastParaID = max_id;
				base->ReplaceAttr (edi, IDD_INFO, &edi_docinfo, sizeof (DocInfo));
			}
		}
		delete base;
	}

	return 0;
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
