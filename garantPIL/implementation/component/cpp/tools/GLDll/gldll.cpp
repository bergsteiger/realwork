
#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/sys/AutoInit.h"

#include "gldll.h"
#include "basemask.h"
#include "SearchB.h"

int garlink (Base* b_, ProgressScreen* screen, int baseType, int bCheckInfo, int bBreeder, int bWWW, int bClass6, FILE* el, DBCore::RelevancyTuneData* chg_rel_data, int b_class6_only);

int iMakeAllDocs= 0;
int iMakeAllDocsParaMax= 100000;

void load_relevancy_changes_ (const char* path, DBCore::RelevancyTuneData& obj) {
	Core::AutoInit init;
	SearchBase* base = new SearchBase (path);
	base->YBase::IsOk (); // чтобы прогрузились фаты
	base->check_version ();
	base->load_relevancy_changes (obj);
	delete base;
}

GLDLL_API void DoGL (char* aBasePath, char* aLogFile, ProgressScreen* screen) {
	DBCore::RelevancyTuneData obj;
	load_relevancy_changes_ (aBasePath, obj);

	Base* b = new StdBigBase (aBasePath, O_RDWR);

	if (b->IsOk ()) {
		FILE* log_file = mpcxc_fopen (aLogFile, "w");
		garlink (b, screen, 0,1,1,0,0, log_file, &obj, 0);
		fprintf (log_file, "0\n");
		fclose (log_file);
		b->SetReady (TID_GL);
	}
	delete b;
}

GLDLL_API void DoGL_language (char* aBasePath, char* aLogFile, ProgressScreen* screen, int language) {
	DBCore::RelevancyTuneData obj;
	load_relevancy_changes_ (aBasePath, obj);

	Base* b = new GLBase (aBasePath);

	bool b_indexok = true;
	Index *index = b->FindIndex ("NFContxt");
	if (index->streams->Fat) {
		BTIterator it (index);
		long keys = 0;
		while (!it.End ()) {
			it.next ();
			keys++;
		}
		if (keys != index->KeyCount)
			b_indexok = false;
	}

	if (b_indexok && b->IsOk ()) {
		FILE* log_file = mpcxc_fopen (aLogFile, "w");
		garlink (b, screen, language,1,1,0,0, log_file, &obj, 0);
		fprintf (log_file, "0\n");
		fclose (log_file);
		b->SetReady (TID_GL);
	}
	delete b;
}
