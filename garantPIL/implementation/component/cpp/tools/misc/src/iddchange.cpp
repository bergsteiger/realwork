#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "gardefs.h"
#include "garutils.h"
#include "garver.h"
#include "stdbase.h"
#include "basemask.h"

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
	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->open_saw_bases (ACE_OS_O_RDONLY);

	if (!base || !base->IsOk ())
		exit (EXIT_FAILURE);


	std::map<long, std::vector<long> > map_id_changedbyid;
	std::map<long, std::vector<char> > map_id_changedbyreason;
	std::set<long> docs_with_change;

	for (std::vector<Base*>::const_iterator base_it = base->bases_ptrs.begin (); base_it != base->bases_ptrs.end (); base_it++) {
		AttrIndex* attrs = (AttrIndex*) (*base_it)->FindIndex ("Attrs");
		AttrKey key = {ID_BORDER, IDD_CHANGE};
		for (BTIterator it (attrs, &key); !it.End (); it.next ()) {
			key = *(AttrKey*) it.Key ();
			if (key.AttrTag != IDD_CHANGE)
				break;
			long id = key.DocId, size = 0;
			docs_with_change.insert (id);
			printf ("%ld\r", id);
			IddChangeStruct *d = (IddChangeStruct*) (*base_it)->LoadAttr (id, IDD_CHANGE, size), *ptr = d;
			size /= sizeof (IddChangeStruct);
			for (int i = 0; i < size; i++, ptr++) {
				long changed = ptr->id;
				char reason = ptr->reason;
				std::map<long,std::vector<long> >::iterator it = map_id_changedbyid.find (changed);
				if (it == map_id_changedbyid.end ()) {
					std::vector<long> changes;
					changes.push_back (id);
					map_id_changedbyid.insert (std::map<long,std::vector<long> >::value_type (changed, changes));
				} else {
					it->second.push_back (changed);
				}

				std::map<long,std::vector<char> >::iterator r_it = map_id_changedbyreason.find (changed);
				if (r_it == map_id_changedbyreason.end ()) {
					std::vector<char> changes;
					changes.push_back (reason);
					map_id_changedbyreason.insert (std::map<long,std::vector<char> >::value_type (changed, changes));
				} else {
					r_it->second.push_back (reason);
				}
			}
		}
	}
	printf ("\n");
	base->close_saw_bases ();
	delete base;

	StdBigBase *out_base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	out_base->open_saw_bases (ACE_OS_O_RDWR);
	std::map<long, std::vector<long> >::const_iterator doc_it = map_id_changedbyid.begin ();
	std::map<long, std::vector<char> >::const_iterator reason_it = map_id_changedbyreason.begin ();
	char doc_name [DOC_NAME_SIZE];
	for (; doc_it != map_id_changedbyid.end (); doc_it++, reason_it++) {
		long id = doc_it->first, changed_by_count = doc_it->second.size (), count = 0;
		DocInfo docinfo;
		if (out_base->FindDocInfo (id, docinfo) != sizeof (docinfo))
			continue;
		std::string warning;
		if (changed_by_count == 1) {
			char reason = *reason_it->second.begin ();
			if (reason == '0')
				warning = "Обратите внимание на информацию о внесении изменений в настоящий документ, содержащуюся в документе \"";
			else
				warning = "Обратите внимание на информацию о признании настоящего документа утратившим силу, содержащуюся в документе \"";
			out_base->FindDocName (*doc_it->second.begin (), doc_name);
			warning += doc_name;
			warning += "\"";
		} else {
			long changed_0 = 0, changed_1 = 0;
			for (std::vector<char>::const_iterator char_it = reason_it->second.begin (); char_it != reason_it->second.end (); char_it++)
				if (*char_it == '0')
					changed_0++;
				else
					changed_1++;

			if (changed_0) {
				if (changed_0 == 1)
					warning = "Обратите внимание на информацию о внесении изменений в настоящий документ, содержащуюся в документе \"";
				else
					warning = "Обратите внимание на информацию о внесении изменений в настоящий документ, содержащуюся в документах ";

				std::vector<long>::const_iterator changed_it = doc_it->second.begin ();
				for (std::vector<char>::const_iterator char_it = reason_it->second.begin (); char_it != reason_it->second.end (); char_it++, changed_it++)
					if (*char_it == '0') {
						out_base->FindDocName (*changed_it, doc_name);
						if (count)
							warning += ", ";
						warning += "\"";
						warning += doc_name;
						warning += "\"";
						count++;
					}

				count = 0;
			}
			
			if (changed_1) {
				if (changed_1 == 1) {
					if (warning.size ())
						warning += ". Обратите внимание на информацию о признании настоящего документа утратившим силу, содержащуюся в документе ";
					else
						warning = "Обратите внимание на информацию о признании настоящего документа утратившим силу, содержащуюся в документе ";
				} else {
					if (warning.size ())
						warning += ". Обратите внимание на информацию о признании настоящего документа утратившим силу, содержащуюся в документах ";
					else
						warning += "Обратите внимание на информацию о признании настоящего документа утратившим силу, содержащуюся в документе ";
				}
				std::vector<long>::const_iterator changed_it = doc_it->second.begin ();
				for (std::vector<char>::const_iterator char_it = reason_it->second.begin (); char_it != reason_it->second.end (); char_it++, changed_it++)
					if (*char_it == '1') {
						out_base->FindDocName (*changed_it, doc_name);
						if (count)
							warning += ", ";
						warning += "\"";
						warning += doc_name;
						warning += "\"";
						count++;
					}
			}
		}
		printf ("%ld: %s\n", id, warning.c_str ());
		char* warning_str = strdup (warning.c_str ());
		out_base->ReplaceAttr (id, IDD_WARNING, warning_str, warning.size () + 1);
		gk_free (warning_str);
	}

	for (std::set<long>::const_iterator itit = docs_with_change.begin (); itit != docs_with_change.end (); itit++)
		out_base->DelAttr (*itit, IDD_CHANGE);

	out_base->close_saw_bases ();
	delete out_base;

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
