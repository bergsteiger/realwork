#include "shared/Core/fix/mpcxc.h"

#include "SearchB.h"
#include "newdoc.h"

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

int main_logic ( int argc, char *argv[] )
{
	YBase *from_base = new YBase (argv [2], ACE_OS_O_RDONLY);
	from_base->IsOk ();
	StdBigBase *to_base = new StdBigBase (argv [1], ACE_OS_O_RDWR);

	Index *subnames = to_base->FindIndex ("SubName");
	char name [DOC_NAME_SIZE * 2];

	for (int i = 3; i < argc; i++) {
		long id = atol (argv [i]);
		printf ("%ld\r", id);
		DocInfo docinfo;
		if (from_base->FindDocInfo (id, docinfo) == sizeof (DocInfo)) {
			bool is_doc = docinfo.Status & DS_DOC;

			std::map<long, char*> map_para_text;
			std::map<long, long> map_para_size;
			revision Revision = docinfo.Revision;
			Document *doc = from_base->GetDoc (id);
			for (int i = 0; i < doc->Stat.ParaCount; i++) {
				char *para = doc->GetPara (i);
				long size = ParaSize (para) + 3;
				char *data = new char [size + 1];
				memcpy (data, para, size);
				map_para_size.insert (std::map<long,long>::value_type (i, size));
				map_para_text.insert (std::map<long,char*>::value_type (i, data));
			}
			delete doc;
			if (map_para_text.size ()) {
				to_base->DelDoc (id);
				NewDocument *d = new NewDocument (to_base, id, "copy", Revision, PM_ZIP);
				std::map<long,char*>::iterator text_it = map_para_text.begin ();
				std::map<long,long>::iterator size_it = map_para_size.begin ();
				long count = 0;
				for (; text_it != map_para_text.end (); text_it++, size_it++, count++) {
					char* para = text_it->second;
					char style = ParaStyle (para);
					d->AddPara (style, size_it->second - 3, para + 3);
					delete []para;
				}
				delete d;
			}
			//скопировать IDD2_PARAIDS
			AttrKey key = {id, IDD2_PARAIDS};
			Stream *str = from_base->FindIndex ("Attribs")->Open (&key);
			if (str) {
				long size = str->Length ();
				char *data = new char [size];
				str->Read (data, size);
				from_base->FindIndex ("Attribs")->Close (str);

				str = to_base->FindIndex ("Attribs")->Open (&key, 1);
				if (str) {
					str->Write (data, size);
					str->Trunc ();
					to_base->FindIndex ("Attribs")->Close (str);
				}
				delete []data;
			}

			int len = from_base->FindSubName (id, 0, name);
			if (len) {
				Ref ref = {id, 0};
				Stream *str = subnames->Open (&ref, 1);
				if (str) {
					str->Write (name, len);
					str->Trunc ();
					subnames->Close (str);
				}
			}

			//скопировать все IDD_
			for (key.AttrTag = 1; key.AttrTag < 255; key.AttrTag++) {
				if (key.AttrTag == IDD_RUNS || key.AttrTag == IDD_BLOCKS)
					continue;
				Stream *str = from_base->FindIndex ("Attrs")->Open (&key);
				if (str) {
					long size = str->Length ();
					char *data = new char [size];
					str->Read (data, size);
					from_base->FindIndex ("Attrs")->Close (str);

					str = to_base->FindIndex ("Attrs")->Open (&key, 1);
					if (str) {
						str->Write (data, size);
						str->Trunc ();
						to_base->FindIndex ("Attrs")->Close (str);
					}

					if (key.AttrTag == IDD_SUBS) {
						SubDesc* ptr = (SubDesc*) data;
						for (int subs = 0; subs < size / sizeof (SubDesc); subs++, ptr++) {
							long sub = ptr->Sub, len = from_base->FindSubName (id, sub, name);
							if (len) {
								Ref ref = {id, sub};
								Stream *str = subnames->Open (&ref, 1);
								if (str) {
									str->Write (name, len);
									str->Trunc ();
									subnames->Close (str);
								}
							}
						}
					}

					if ((key.AttrTag == IDD_BASES) && is_doc) {
						short *ptr = (short*) data;
						for (int segs = 0; segs < size / sizeof (short); segs++, ptr++) {
							short seg = *ptr;
							Stream *str = to_base->FindIndex ("Segment")->Open (&seg, 1);
							if (str) {
								DocCollection docs;
								docs.Get (str);
								docs.Add (id);
								str->Seek (0);
								docs.Put (str);
								to_base->FindIndex ("Segment")->Close (str);
							}
						}
					}

					delete []data;
				}
			}
		}
	}
	printf ("\n");
	delete to_base;
	delete from_base;
	return 0;
}
