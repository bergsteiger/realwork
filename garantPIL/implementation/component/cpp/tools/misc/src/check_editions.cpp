#include "shared/Core/fix/mpcxc.h"

#include "stdbase.h"
#include "shared\GCL\alg\set_operations.h"

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

YBase *base;
std::map<long, std::vector<long> > map_doc_editions;
std::map<long,long> map_edition_doc;
std::vector<long> editions, docs;

void	LoadEdis ()
{
	Stream *str = base->FindIndex ("Aux")->Open ("Edis");
	if (!str) {
		if (!base->FindIndex ("Aux")->Open ("InfL")) {
			printf ( "run gl first!\n");
			exit (EXIT_FAILURE);
		}
	} else {
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		base->FindIndex ("Aux")->Close (str);
		size >>= 3;
		for (int i = 0; i < size; i++) {
			long edition = *ptr;
			editions.push_back (edition);
			ptr++;
			long doc = *ptr;
			docs.push_back (doc);
			ptr++;

			map_edition_doc.insert (std::map<long,long>::value_type (edition,doc));
			std::map<long,std::vector<long> >::iterator map_it = map_doc_editions.find (doc);
			if (map_it == map_doc_editions.end ()) {
				std::vector<long> editions;
				editions.push_back (edition);
				map_doc_editions.insert (std::map<long,std::vector<long> >::value_type (doc, editions));
			} else {
				map_it->second.push_back (edition);
			}
		}
	}
	for (std::map<long,std::vector<long> >::iterator map_it = map_doc_editions.begin (); map_it != map_doc_editions.end (); map_it++)
		std::sort (map_it->second.begin (), map_it->second.end ());
	std::sort (editions.begin (), editions.end ());
	std::sort (docs.begin (), docs.end ());
}

int main_logic ( int argc, char *argv[] )
{
	base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->IsOk ();
	LoadEdis ();
	std::map<long, std::vector<long> > old_map; old_map.swap (map_doc_editions);
	std::vector<long> old_editions; old_editions.swap (editions);
	std::map<long,long> old_map_edition_doc; old_map_edition_doc.swap (map_edition_doc);
	std::vector<long> old_docs; old_docs.swap (docs);
	delete base;

	base = new YBase (argv [2], ACE_OS_O_RDONLY);
	base->IsOk ();
	LoadEdis ();
	std::map<long, std::vector<long> > new_map;
	new_map.swap (map_doc_editions);
	std::map<long,long> new_map_edition_doc; new_map_edition_doc.swap (map_edition_doc);
	std::vector<long> new_docs; new_docs.swap (docs);

	std::set<long> bad_processed;

	for (std::map<long, std::vector<long> >::const_iterator new_it = new_map.begin (); new_it != new_map.end (); new_it++) {
		long doc = new_it->first;
		std::map<long, std::vector<long> >::const_iterator old_it = old_map.find (doc);
		if (old_it == old_map.end ())
			continue;
		std::vector<long> old_editions = old_it->second;
		GCL::set_difference (old_editions, new_it->second);
		for (std::vector<long>::const_iterator it = old_editions.begin (); it != old_editions.end (); it++) {
			long id = *it;
			DocInfo docinfo;
			if (base->FindDocInfo (id, docinfo) != sizeof (DocInfo)) {
				bad_processed.insert (id);
				printf ("%ld\n", id - ID_BORDER);
			}
		}
	}

	for (std::vector<long>::const_iterator it = old_editions.begin (); it != old_editions.end (); it++) {
		long edition = *it;
		if (bad_processed.find (edition) != bad_processed.end ())
			continue;
		DocInfo docinfo;
		if (base->FindDocInfo (edition, docinfo) == sizeof (DocInfo)) {
			//в дневном огрызке есть топик
			if (!(docinfo.Status & DS_EDITION)) {
				//и это нередакция
				long old_doc = old_map_edition_doc.find (edition)->second;
				//если в новой базе нет этого документа, то его надо удалить
				if (base->FindDocInfo (old_doc, docinfo) != sizeof (DocInfo)) {
					bad_processed.insert (old_doc);
					printf ("doc %ld\n", old_doc - ID_BORDER);
				}
			}
		} else {
			//в новой базе топика-редакции нет, надо проверить, не замещен ли "документ" (из цепочки с этой редакцией) на другой
			long old_doc = old_map_edition_doc.find (edition)->second;
			if (base->FindDocInfo (old_doc, docinfo) == sizeof (DocInfo)) {
				//в дневном огрызке вместо документа что-то есть. Если это документ с редакциями, то проверка и удаление редакции была в прошлом цикле
				//сейчас же оказалось, что вместо старого документа с цепочкой подключили что-то другое. 
				bad_processed.insert (edition);
				printf ("%ld\n", edition - ID_BORDER);
			} else {
				//если вся цепочка неизменная, то просто её нет в новой базе, т.е. все ок.
				std::map<long,std::vector<long> >::const_iterator map_it = old_map.find (old_doc);
				if (new_map.find (old_doc) == new_map.end ()) {
					bool b_ok = true;
					for (std::vector<long>::const_iterator edi_it = map_it->second.begin (); edi_it != map_it->second.end (); edi_it++) {
						long edi = *edi_it;
						if (base->FindDocInfo (edi, docinfo) == sizeof (DocInfo))
							b_ok = false;
					}
					if (!b_ok) {
						bad_processed.insert (edition);
						printf ("%ld\n", edition - ID_BORDER);
					}
				}
			}
		}
	}

	for (std::vector<long>::const_iterator doc_it = old_docs.begin (); doc_it != old_docs.end (); doc_it++) {
		//документ в старой базе имел редакции
		long doc_id = *doc_it;
		if (bad_processed.find (doc_id) != bad_processed.end ())
			continue;
		if (!std::binary_search (new_docs.begin (), new_docs.end (), doc_id)) {
			//его нет в новой базе с цепочкой редакций. А есть ли он вообще в новой базе?
			DocInfo docinfo;
			if (base->FindDocInfo (doc_id, docinfo) != sizeof (DocInfo)) {
				//если его нет, и всей цепочке редакций нет - то просто его нет в новой базе, все ок
				bool b_ok = true;
				std::map<long,std::vector<long> >::const_iterator map_it = old_map.find (doc_id);
				for (std::vector<long>::const_iterator edi_it = map_it->second.begin (); edi_it != map_it->second.end (); edi_it++) {
					long edi = *edi_it;
					if (base->FindDocInfo (edi, docinfo) == sizeof (DocInfo))
						b_ok = false;
				}
				if (!b_ok) {
					printf ("doc %ld\n", doc_id - ID_BORDER);
				}
			}
		}
	}

	delete base;

	return 0;
}
