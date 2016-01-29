#ifndef	__GARANT_UTILS__
#define	__GARANT_UTILS__

#include "gar_defs.hpp"

int shortcmp (const void *l1, const void *l2);

char* convert_quotes (const char*, bool&, bool&, bool insert_exclam = true);
bool is_morpho_search_possible (const DocInfo& docinfo);
char* convert_brackets (char* in);

int	is_eq(date one, date two);
int	is_lt(date one, date two);
int	IsAlNum (int ch ); // whether char is letter ( english or russian ) or digit
int	ToUpper (int ch);  // converts to upper case (even russian letters)
int	ToLower (int ch);  // converts to lower case (even russian letters)
int ToLowerWin (int ch);
int	StrNICmp  (const char* s1, const char* s2, int max_len);

char* StrUpr (char* str);
char* WinStrUpr (char* str);
char* StrLwr (char* str);
char* Str2Win (char* str); // convert string to ANSI ( Windows ) encoding
char* ForceExt (char* name, const char* ext); // force given extension to a file name

void BuildPatternM (ContextPattern& ptn, char* str, bool b_upper = true);
void BuildPatternMNdot (ContextPattern& ptn, char* str);
void BuildPatternMN (ContextPattern& ptn, char * str);

int GetHTRefCount (int);

short crc (void* buf, int count);
short crc (void* buf, int count, int start_crc);

long GetDocMonitoring (DocInfo* docInfo);
void SetDocMonitoring (DocInfo* docInfo, long aId);

unsigned short GetDocStatusExEx (DocInfo* docInfo);
void SetDocStatusExEx (DocInfo* docInfo, unsigned short status_exex);

short ParaIsComment (char* aText, char cParaStyle, short aTextSize);
void hilite_word (const char*, unsigned, long, long, long&, long&);

unsigned long GetDocRespondents (DocInfo* docInfo);
u_int64_t GetDocRespondents64 (DocInfo* docInfo);

int compare_subdescex (const void* p1, const void* p2);
int compare_subdesc   (const void* p1, const void* p2);
int compare_docstruct (const void* p1, const void* p2);

int CompRele (const void*, const void* r2);
int CompReleDocId (const void*, const void* r2);
int CompDocRele (const void*, const void* r2);
int CompRefs (struct Ref* r1, struct Ref* r2);
int CompRefsPlus (struct Ref* r1, struct Ref* r2);
int CompRefsMinus (struct Ref* r1, struct Ref* r2);
int CompRefsStrong (struct Ref* r1, struct Ref* r2);
int CompRevs (const struct revision*, const struct revision*);
int CompDates (struct date* d1, struct date* d2);
int CompRefwWeight (struct RefwWeight* r1, struct RefwWeight* r2);

int compare_subdesc_subs (const void *elem1, const void *elem2);

date date_plusdays (date aDate, const short days);

unsigned long hash_str (char*);
long leve_dist (char* s1, char* s2);

inline long GetTipsDoc (long id) {
	return id + ID_BORDER;
}

inline int fprintRev (FILE* pFile, revision * pRev, int iShort = 0) {
	if ( iShort ) return fprintf ( pFile, "%02d/%02d/%d",
		pRev->RevisionDate.da_day,
		pRev->RevisionDate.da_mon,
		pRev->RevisionDate.da_year );

	return fprintf ( pFile, "%02d/%02d/%d %02d:%02d:%02d:%02d",
		pRev->RevisionDate.da_day,
		pRev->RevisionDate.da_mon,
		pRev->RevisionDate.da_year,
		pRev->RevisionTime.ti_hour,
		pRev->RevisionTime.ti_min,
		pRev->RevisionTime.ti_sec,
		pRev->RevisionTime.ti_hund );
};

inline int printRev (revision * pRev, int iShort = 0) {
	if ( iShort ) return printf ( "%02d/%02d/%d",
		pRev->RevisionDate.da_day,
		pRev->RevisionDate.da_mon,
		pRev->RevisionDate.da_year);

	return printf ( "%02d/%02d/%d %02d:%02d:%02d:%02d",
		pRev->RevisionDate.da_day,
		pRev->RevisionDate.da_mon,
		pRev->RevisionDate.da_year,
		pRev->RevisionTime.ti_hour,
		pRev->RevisionTime.ti_min,
		pRev->RevisionTime.ti_sec,
		pRev->RevisionTime.ti_hund);
};

inline char* sprintRev (char* str, revision * pRev, int iShort = 0) {
	if ( iShort ) sprintf ( str, "%02d/%02d/%d",
		pRev->RevisionDate.da_day,
		pRev->RevisionDate.da_mon,
		pRev->RevisionDate.da_year);

	else sprintf ( str, "%02d/%02d/%d %02d:%02d:%02d:%02d",
		pRev->RevisionDate.da_day,
		pRev->RevisionDate.da_mon,
		pRev->RevisionDate.da_year,
		pRev->RevisionTime.ti_hour,
		pRev->RevisionTime.ti_min,
		pRev->RevisionTime.ti_sec,
		pRev->RevisionTime.ti_hund);

	return str;
};

inline int IsAttr (char ch) {
       return ch >= '\x01' && ch < '\x09';
}

inline unsigned	char AttrFlag (char at) {
      return 1 << at;
}

std::vector<std::string> get_base_files (const char *path);

unsigned int gkdb_HashRot13 (const char * str);

#endif

