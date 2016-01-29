#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <iomanip>

#include <sys/types.h>
#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "SplaySet.h"
#include "advlog.h"

using namespace std;

int main_logic ( int argc, char *argv[] );

StdBigBase *base;

std::map<long, long> map_edition_doc;
std::set<long> docs;
std::map<long, std::set<long> > map_doc_editions;

void	LoadEdis ()
{
	Stream *str = base->FindIndex ("Aux")->Open ("Edis");
	if (!str) {
		if (!base->FindIndex ("Aux")->Open ("InfL")) {
			mpcxc_printfwin ( "run gl first!\n");
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
	if (argc < 2)
		return 0;

	base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	base->open_saw_bases (ACE_OS_O_RDWR);
	LoadEdis ();
	bool b_english_base = false;
	{
	Index* auxInd = base->FindIndex ( "Aux" );
	Stream *hereStr = auxInd->Open("Here");
	short hcount = (short) hereStr->Length () / sizeof (short), *heres = (short*) malloc (hereStr->Length ());
	hereStr->Read (heres, hereStr->Length ());
	auxInd->Close (hereStr);

	for (int i = 0; i<hcount; i++)
		if (heres [i] == 32 || (heres [i] >= 240 && heres [i] <= 255)) {
			b_english_base = true;
			break;
		}
	}

	DocCollection* allTopics = base->AllTopics (ID_BORDER);
	long i;

	for (i = 0; i < allTopics->ItemCount; i++) {
		long id = (*allTopics) [i];
		if (id < ID_ANNOPLUS+ID_BORDER)
			continue;
		char longName [DOC_NAME_SIZE + 32], newName [DOC_NAME_SIZE + 32];
		if (!base->FindDocName (id, longName)) {
			DocInfo docInfo;
			base->FindDocInfo (id, docInfo);
			long owner = GetDocMonitoring (&docInfo);
			if (base->FindDocName (owner, longName)) {
				strcat (strcpy (newName, "АННОТАЦИЯ К: "), longName);
				long length = strlen (newName)+1;
				if (length >= DOC_NAME_SIZE) {
					strcpy (newName+DOC_NAME_SIZE-4, "...");
					length = DOC_NAME_SIZE;
				}
				Ref ref = {id, 0};
				cout << id << " " << newName << "\n";
				base->SetSubName (ref.DocId, ref.Sub, newName, length);
			}
		}
	}

	std::set<long> nodocs, relateds;
	std::map<long, std::set<long> > related_owners;

	for (i = 0; i < allTopics->ItemCount; i++) {
		long docId = (*allTopics) [i];
		char longName [DOC_NAME_SIZE], newName [DOC_SHORT_NAME_SIZE];
		newName [0] = 0;
		int	length = DOC_SHORT_NAME_SIZE - 1;
		if (base->FindDocName (docId, longName)) {
			int longLength = strlen (longName);
			DocInfo docInfo;
			base->FindDocInfo (docId, docInfo);

			long related = docInfo.Related;
			if ((docInfo.Status & (DS_EDITION | DS_DOC)) && related) {
				std::map<long, std::set<long> >::iterator it = related_owners.find (related);
				if (it == related_owners.end ()) {
					std::set<long> docs;
					docs.insert (docId);
					related_owners.insert (std::map<long, std::set<long> >::value_type (related, docs));
				} else {
					bool b_founddocoredition = false;
					for (std::set<long>::const_iterator set_it = it->second.begin (); set_it != it->second.end () && !b_founddocoredition; set_it++) {
						long check_id = *set_it;
						if (docInfo.Status & DS_DOC) {
							std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (docId);
							if (map_it != map_doc_editions.end ())
								b_founddocoredition = (map_it->second.find (check_id) != map_it->second.end ());
						} else {
							//а не является ли check_id другой редакцией документа в мапе
							long owner = docId;
							if (docs.find (owner) == docs.end ())
								owner = map_edition_doc.find (owner)->second;
							std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (owner);
							if (map_it != map_doc_editions.end ())
								b_founddocoredition = (map_it->second.find (check_id) != map_it->second.end ());
						}
					}
					if (!b_founddocoredition) it->second.insert (docId);
				}
			}

			if (docInfo.Status & DS_EDITION) {
				relateds.insert (related);
				char edition [32];
				strcpy (edition, b_english_base ? "Document wording: " : "Редакция документа: ");
				char noActive [32];
				strcpy (noActive, b_english_base ? " (wording is not active)" : " (ред. не действует)");
				length -= strlen (edition) + strlen (noActive);
				if (longLength - length > 0) {
					longName [length - 3] = 0;
					strcat (longName, "...");
				}
				strcat (newName, edition);
				strcat (newName, longName);
				strcat (newName, noActive);
			} else if (docInfo.Status & DS_DOC) {
				relateds.insert (related);
				char noActive [32];
				noActive [0] = 0;
				if (docInfo.Status & (DS_PREACTIVE | DS_ABOLISHED)) {
					char *left_bracket = strrchr (longName, '('), *right_bracket = strrchr (longName, ')');
					if (left_bracket && right_bracket && (right_bracket > left_bracket) && (right_bracket - left_bracket < 32) && (longLength - (long)(left_bracket - longName) < 32)) {
						std::string na_str;
						na_str.assign (left_bracket, right_bracket);
						strcpy (noActive, left_bracket);
						*left_bracket = '\0';
						longLength = strlen (longName);
					} else {
						strcpy (noActive, b_english_base ? "(not active)" : "(не действует)");
					}
					length -= strlen (noActive);
				}
				if (longLength - length > 0) {
					longName [length - 3] = 0;
					strcat (longName, "...");
				}
				strcat (newName, longName);
				strcat (newName, noActive);
			} else {
				nodocs.insert (docId);
				continue;
			}
			cout << docId << " " << newName << "\n";
			strcpy (docInfo.Title, newName);
			base->ReplaceAttr (docId, IDD_INFO, &docInfo, sizeof (DocInfo));
		}
	}

	cout << "Processing nodocs\n";
	for (std::set<long>::const_iterator it = nodocs.begin (); it != nodocs.end (); it++) {
		long id = *it;
		if (relateds.find (id) == relateds.end ()) {
			char longName [DOC_NAME_SIZE];
			if (base->FindDocName (id, longName)) {
				if (strlen (longName) >= DOC_SHORT_NAME_SIZE)
					strcpy (longName + DOC_SHORT_NAME_SIZE - 4, "...");

				DocInfo docInfo;
				base->FindDocInfo (id, docInfo);
				strcpy (docInfo.Title, longName);
				cout << id << " (n) " << docInfo.Title << "\n";
				base->ReplaceAttr (id, IDD_INFO, &docInfo, sizeof (DocInfo));
			}
		} else {
			std::map<long, std::set<long> >::const_iterator map_it = related_owners.find (id);
			if (map_it == related_owners.end ()) {
				cout << id << " ERROR\n";
			} else {
				if (map_it->second.size () == 1) {
					long owner = *map_it->second.begin ();
					char longName [DOC_NAME_SIZE];
					if (base->FindDocName (owner, longName)) {
						int longLength = strlen (longName);
						char related_str [32];
						if (b_english_base) strcpy (related_str, "Reference on "); else strcpy (related_str, "Справка к: ");
						int	length = DOC_SHORT_NAME_SIZE - 1 - strlen (related_str);
						if (longLength - length > 0) {
							longName [length - 3] = 0;
							strcat (longName, "...");
						}
						DocInfo docInfo;
						base->FindDocInfo (id, docInfo);
						strcpy (docInfo.Title, related_str);
						strcat (docInfo.Title, longName);
						cout << id << " (s) " << docInfo.Title << "\n";
						base->ReplaceAttr (id, IDD_INFO, &docInfo, sizeof (DocInfo));
					} else if (base->FindDocName (id, longName)) {
						if (strlen (longName) >= DOC_SHORT_NAME_SIZE)
							strcpy (longName + DOC_SHORT_NAME_SIZE - 4, "...");

						DocInfo docInfo;
						base->FindDocInfo (id, docInfo);
						strcpy (docInfo.Title, longName);
						cout << id << " " << docInfo.Title << "\n";
						base->ReplaceAttr (id, IDD_INFO, &docInfo, sizeof (DocInfo));
					}
				} else {
					char longName [DOC_NAME_SIZE];
					if (base->FindDocName (id, longName)) {
						if (strlen (longName) >= DOC_SHORT_NAME_SIZE)
							strcpy (longName + DOC_SHORT_NAME_SIZE - 4, "...");

						DocInfo docInfo;
						base->FindDocInfo (id, docInfo);
						strcpy (docInfo.Title, longName);
						cout << id << " (m) " << docInfo.Title << "\n";
						base->ReplaceAttr (id, IDD_INFO, &docInfo, sizeof (DocInfo));
					}
				}
			}
		}
	}
	/*
	for (i = 0; i < allTopics->ItemCount; i++) {
		long id = (*allTopics) [i];
		if (id < ID_ANNOPLUS+ID_BORDER)
			continue;
		char longName [DOC_NAME_SIZE];
		if (!baseFindDocName (id, longName)) {
			DocInfo docinfo;
			baseFindDocInfo (id, docinfo);
			long owner = GetDocMonitoring (&docinfo);
			baseFindDocInfo (owner, docinfo);
			strcat (strcpy (longName, "АННОТАЦИЯ К: "), docinfo.Title);
			Ref ref = {id, 0};
			printf ("%ld %s\n", id, longName);
			basesubNames->AddData (&ref, longName, strlen (longName)+1);
		}
	}
	*/
	cout << "\n";
	
	base->close_saw_bases ();
	delete base;

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
