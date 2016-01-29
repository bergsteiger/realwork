
#include "shared/Core/mng/Var.h"
#include "shared/Core/GDS/StopWatch.h"

#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"

#include "stdbase.h"
#include "Logger.h" // GARANT_CASE

#define	MAX_WARN  256
#define	BSIZE     10*1024*1024

///////////////////////////////////////////////////////////////

extern Logger Log;

static const std::string nsrc_dir = "nsrc";
static const std::string blob_dir = "data";
static const std::string blob_name = "nsrc/$_$blob.nsr";

///////////////////////////////////////////////////////////////

template <typename T>
class IndexDataLoader {
public:
	IndexDataLoader (const bool is_array = true) : m_is_array (is_array) {
	}

	T* load (Base* base, const long doc_id, const int tag, long& count) {
		Core::Aptr <T> ret;
		count = 0;

		if (tag == IDD2_PARAIDS) {
			ret = (T*)base->LoadAttrEx (doc_id, tag, count);
		} else {
			ret = (T*)base->LoadAttr (doc_id, tag, count);
		}

		if (ret.ptr ()) {
			if (m_is_array) {
				count = count / sizeof (T);
			}
		} else {
			count = 0;
		}

		return ret._retn ();
	}
private:
	bool m_is_array;
};

struct FileDestructor {
	static void destroy (FILE* p) {
		if (p) {
			ACE_OS::fclose (p);
			p = 0;
		}
	}
};

struct CharArrayDestructor {
	static void destroy (char* p) {
		if (p) {
			delete [] p;
			p = 0;
		}
	}
};

typedef Core::Aptr <FILE, FileDestructor> FILE_aptr;
typedef Core::Aptr <DocCollection> DocCollection_aptr;

///////////////////////////////////////////////////////////////

#define	isdigit(c) (c >= '0' && c <= '9')

struct Belong {
	int id;
	int	Weight;
	char SName [255];
	char RName [255];
	char EName [255];
};

struct Warning {
	int id;
	char Name [512];
};

struct Publisher {
	int	id;
	char Name [512];
};

struct Month {
	int	days;
	char Name [255];
};

///////////////////////////////////////////////////////////////

//!
extern char* buf;
extern Belong Belongs [MAX_BASES];
extern Warning Warnings [MAX_WARN];
//!

///////////////////////////////////////////////////////////////

void out_doc (Document* doc, EndtTools::EndtParser* parser);
void out_blob (Base* base, FILE*, const int blob, char* fname, long& id);
void change_slashes (char* name) ;
void create_cat_file (Base* base, char* name);

const int make_file_dir (char* name);
const int erase_cat_files (const char* name);

///////////////////////////////////////////////////////////////

char* TruncateNSRCFile (char* str);
char* TranslatePublisher (char* ptr, int forDoc);
char* TruncString (char* str);

int	LoadBelongs(char *fn, Belong *b);
int	LoadWarnings(char *fn, Warning *w);
int	CreatePublishers(Base *base, char *name);
int	CreateClass(Base *base, char *name);
int	CreateNorm(Base *base, char *name);
int	CreateSource(Base *base, char *name);
int	CreateTerritory(Base *base, char *name);
int	CreateType(Base *base, char *name);
int	CreateAnno(Base *base, char *name, char* indexname);
int	CreateKeyWord(Base *base, char *name);
int	FindMonth(char *str);

bool SaveWarnings (char* fileName, Warning* w);

#ifdef VERSION56
int	OutActivite(Document *doc, FILE *file); 
int	OutEdition(Document *doc, FILE *file); 
int	OutVerlink(Document *doc, FILE *file);
int	OutChdate(Document *doc, FILE *file); 
#endif

int	OutBelongs(Document *doc, FILE *file);
int	OutName(Document *doc, FILE *file);
int	OutDate(Document *doc, FILE *file);
int	OutWarning(Document *doc, FILE *file);
int	OutPreactive(Document *doc, FILE *file);
int	OutNoActive(Document *doc, FILE *file);
int	OutRelated(Document *doc, FILE *file);
int	OutPriority(Document *doc, FILE *file);
int	OutPublishedin(Document *doc, FILE *file);
int	OutTerritory(Document *doc, FILE *file);
int	OutSource(Document *doc, FILE *file);
int	OutNoDoc(Document *doc, FILE *file);
int	OutNorm(Document *doc, FILE *file);
int	OutVChanged(Document *doc, FILE *file);
int	OutNotSure(Document *doc, FILE *file);
