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
	YBase *to_base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	Stream *str = to_base->FindIndex ("Aux")->Open ("Here");
	long belongs_size = 0;
	char *belongs_ptr = 0;
	if (str) {
		belongs_size = str->Length ();
		belongs_ptr = new char [belongs_size];
		str->Read (belongs_ptr, belongs_size);
		to_base->FindIndex ("Aux")->Close (str);
	}

	for (int id = BIG_INFO_DOC; id < BIG_INFO_DOC + BIG_INFO_COUNT; id++) {
		printf ("%ld\r", id);
		DocInfo docinfo;
		if (from_base->FindDocInfo (id, docinfo) == sizeof (DocInfo)) {
			//glный топик есть, надо его скопировать в to_base
			std::map<long, char*> map_para_text;
			revision Revision;
			gk_bzero (&Revision, sizeof (Revision));
			if (to_base->FindDocInfo (id, docinfo) == sizeof (DocInfo)) {
				Document *to_doc = to_base->GetDoc (id);
				Revision = to_doc->Stat.Revision;
				for (int i = 0; i < to_doc->Stat.ParaCount; i++) {
					char *para = to_doc->EVDParaText (to_doc->GetPara (i));
					long topic = atol (para);
					map_para_text.insert (std::map<long,char*>::value_type (topic, strdup (para)));
				}
				delete to_doc;
			}
			Document *doc = from_base->GetDoc (id);
			if (Revision.RevisionDate.da_year == 0)
				Revision = doc->Stat.Revision;
			for (int i = 0; i < doc->Stat.ParaCount; i++) {
				char *para = doc->EVDParaText (doc->GetPara (i));
				long topic = atol (para);
				if (map_para_text.find (topic) == map_para_text.end ())
					map_para_text.insert (std::map<long,char*>::value_type (topic, strdup (para)));
			}
			delete doc;
			if (map_para_text.size ()) {
				//записать их в базу
				to_base->DelDoc (id);
				NewDocument *d = new NewDocument (to_base, id, "AllDocsNote", Revision, PM_ZIP);
				d->pInfo->Status = DS_NODOC;
				if (belongs_size)
					to_base->ReplaceAttr (id, IDD_BASES, belongs_ptr, belongs_size);

				char	parabuff [4096*1024];
				for (std::map<long,char*>::iterator map_it = map_para_text.begin (); map_it != map_para_text.end (); map_it++) {
					long topic = map_it->first;
					char* para = map_it->second;
					*parabuff = 8;
					*(long*)(parabuff+1)= 0;
					strcpy (parabuff + 5, para);
					d->AddPara (PS_PREFORMATTED, strlen (para) + 6, parabuff);
					gk_free (para);
				}
				delete d;
			}
		}
	}
	printf ("\n");

	delete from_base;
	delete to_base;
	return 0;
}
