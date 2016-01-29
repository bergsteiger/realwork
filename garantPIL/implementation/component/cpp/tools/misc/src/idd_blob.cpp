#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "shared/Core/os/IniFile.h"
#include "gardefs.h"
#include "garutils.h"
#include "garver.h"
#include "stdbase.h"
#include "basemask.h"

#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"

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

std::map<long, DocInfo> map_doc_docinfo;
DocCollection *alldocs = 0;
StdBigBase* base = 0;
std::map<long, DocInfo>::iterator get_doc_info (long docid)
{
	if (alldocs->IndexOf (&docid) == -1)
		return map_doc_docinfo.end ();
	else {
		std::map<long,DocInfo>::iterator map_it = map_doc_docinfo.find (docid);
		if (map_it == map_doc_docinfo.end ()) {
			DocInfo docinfo;
			base->FindDocInfo (docid, docinfo);
			map_doc_docinfo.insert (std::map<long,DocInfo>::value_type (docid, docinfo));
			map_it = map_doc_docinfo.find (docid);
		}
		return map_it;
	}
}

int main_logic ( int argc, char *argv[] )
{
	{
		base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		
		std::set<long> blob_keys;
		for (BTIterator it (base->FindIndex ("Blob")); !it.End (); ++it) {
			long id = *(long*) it.Key ();
			blob_keys.insert (id);
		}

		alldocs = base->AllTopics (ID_BORDER);
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long doc_id = (*alldocs) [i];
			Document *doc = base->GetDoc (doc_id);

			std::set<long> set_blobs;

			if (doc->Stat.Status & DS_EVD) {
				EndtTools::EndtParser obj (base);
				EndtTools::LongVector *refs = obj.get_resp_documents (doc, true);
				if (refs->size()) {
					EndtTools::LongVector::const_iterator it = refs->begin ();
					for ( ; it != refs->end(); it++ ) {
						long docid = *it;
						if (blob_keys.find (docid) != blob_keys.end ()) {
							std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docid);
							if (map_it != map_doc_docinfo.end ()) {
								if (!(map_it->second.Status_ex & DS_FLASH))
									set_blobs.insert (docid);
							} else {
								set_blobs.insert (docid);
							}
						}
					}
				}
				delete refs;

				long blobs_size;
				char *blobs = (char*) base->LoadAttr (doc_id, IDD_BLOBS, blobs_size), *ptr = blobs;
				if (blobs_size) {
					u_int32_t ss = 0;
					std::set<long> processed_paras;
					BlobInfo* bi;
					long plus = sizeof (bi->Para) + sizeof (bi->type);
					while (ss < blobs_size) {
						bi = (BlobInfo*) ptr;
						char* text = ptr + plus;
						long lpara = bi->Para;
						if (processed_paras.find (lpara) == processed_paras.end ()) {
							processed_paras.insert (lpara);
							char* para = doc->GetPara (lpara);
							if (doc->EVDFlags (para) & ENDT_HAS_BMP) {
								para = ParaText (para) + ENDT_FLAGS_LEN + ENDT_CP_LEN;
								set_blobs.insert (*(long*)para);
							}
						}
						u_int32_t textlen = strlen (text) + 1;
						ss += textlen + plus;
						ptr = text + textlen;
					}
					gk_free (blobs);
				}

				if (set_blobs.size ()) {
					long *data = new long [set_blobs.size ()], *ptr = data;
					for (std::set<long>::const_iterator it = set_blobs.begin (); it != set_blobs.end (); it++, ptr++)
						*ptr = *it;
					base->ReplaceAttr (doc_id, IDD_BLOB, data, set_blobs.size () * sizeof (long));
					delete [] data;
				}
			}
			delete doc;
		}
		delete base;
		exit (EXIT_SUCCESS);
	}
}
