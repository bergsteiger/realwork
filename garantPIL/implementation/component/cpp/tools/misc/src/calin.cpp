#include "shared/Core/fix/mpcxc.h"

#include "stdbase.h"
#include "StorableSplaySet.h"

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
	StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	base->open_saw_bases (ACE_OS_O_RDWR);

	DocCollection aov_docs;
	BTKEY hkey = base->FindIndex ("Kind")->FullKey ("Акты органов власти");
	if (hkey) {
		Stream* str = base->FindIndex ("Kind")->Index::OpenN (hkey, 0);
		if (str) {
			aov_docs.FastLoadRefs (str);
			base->FindIndex ("Kind")->Close (str);
		}
	}

	Index *calin = base->FindIndex ("CalIn.str");
	for (std::vector<Base*>::const_iterator base_it = base->bases_ptrs.begin (); base_it != base->bases_ptrs.end (); base_it++) {
		AttrIndex* docInd = (AttrIndex*) (*base_it)->FindIndex( "Attrs" );
		static const AttrKey key = {ID_BORDER, IDD_INFO};
		BTIterator* it = new BTIterator (docInd, &key);

		for (; !it->End (); ++(*it)) {
			AttrKey *ptr = (AttrKey *) it->Key ();

			if (ptr->AttrTag != IDD_INFO)
				break;

			Stream* str = docInd->Open (ptr);
			if (!str)
				continue;

			DocInfo docinfo;
			str->Read (&docinfo, sizeof (docinfo));
			docInd->Close (str);

			long docid = ptr->DocId;

			if (docinfo.prevEdition == 0 && ((docinfo.Status & DS_NOTTM) == 0) && (docinfo.FirstDate.da_year || docinfo.LastDate.da_year) && aov_docs.IndexOf (&docid) != -1) {
				AttrKey calin_key = {docid, IDD_CALIN};
				if (!docInd->IsExist (&calin_key)) {
					printf ("%ld\r", docid);
					date calin_date;

					if (docinfo.FirstDate.da_year) {
						calin_date.da_year = docinfo.FirstDate.da_year;
						calin_date.da_mon = docinfo.FirstDate.da_mon;
						calin_date.da_day = docinfo.FirstDate.da_day;
					} else {
						calin_date.da_year = docinfo.LastDate.da_year;
						calin_date.da_mon = docinfo.LastDate.da_mon;
						calin_date.da_day = docinfo.LastDate.da_day;
					}

					(*base_it)->PutAttr (docid, IDD_CALIN, &calin_date, sizeof (calin_date));
					str = calin->Open (&calin_date, 1);
					if (str) {
						StorableSplaySet<long> docs;
						docs.Get (str);
						docs.add (docid);
						str->Seek (0);
						docs.Put (str);
						calin->Close (str);
					}
					continue;
				}
			}
			if ((docinfo.prevEdition == 0) && docinfo.nextEdition && ((docinfo.Status & DS_NOTTM) == 0)) {
				//первоначальная редакция, проверим наличие CalIn, см. http://mdp.garant.ru/pages/viewpage.action?pageId=496996586
				AttrKey calin_key = {docid, IDD_CALIN};
				if (!docInd->IsExist (&calin_key)) {
					printf ("%ld\r", docid);
					long id = docinfo.nextEdition, size = 0, count = 0;
					DocInfo nextdocinfo;
					if ((*base_it)->FindDocInfo (id, nextdocinfo) == sizeof (DocInfo) && ((nextdocinfo.Status & DS_NOTTM) == 0)) {
						calin_key.DocId = id;
						if (docInd->IsExist (&calin_key))
							continue;

						DocActivity *da = (DocActivity*) (*base_it)->LoadAttr (id, IDD_ACTIVE, size), *ptr = da;
						if (size) {
							date mindate;
							mindate.da_year = 2037;
							mindate.da_mon = 12;
							mindate.da_day = 31;
							while (count < size) {
								if (is_lt (ptr->from, mindate))
									mindate = ptr->from;
								const char* text = (const char*) ptr + sizeof (da->from) + sizeof (da->to);
								long plus = strlen (text) + 1;
								ptr = (DocActivity*)(text + plus);
								count += sizeof (ptr->from) + sizeof (ptr->to) + plus;
							}
							gk_free (da);
							(*base_it)->PutAttr (id, IDD_CALIN, &mindate, sizeof (mindate));
							str = calin->Open (&mindate, 1);
							if (str) {
								StorableSplaySet<long> docs;
								docs.Get (str);
								docs.add (id);
								str->Seek (0);
								docs.Put (str);
								calin->Close (str);
							}
							continue;
						}
					}
				}
			}
		}
	}

	base->close_saw_bases ();
	delete base;

	return 0;
}
