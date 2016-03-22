#include "gar_defs.hpp"
#include "garutils.h"

#include <fstream>
#include <cctype>
#include "boost/regex.hpp"
#include "ace/Dirent_Selector.h"
#include "shared/GCL/os/FileOp.h"

char *gbase_FilesExt [] = {"ndt", "str", "key", "uid"};

unsigned const short static CrcTab [256] =
{
	0x0000, 0xc0c1, 0xc181, 0x0140, 0xc301, 0x03c0, 0x0280, 0xc241,
	0xc601, 0x06c0, 0x0780, 0xc741, 0x0500, 0xc5c1, 0xc481, 0x0440,
	0xcc01, 0x0cc0, 0x0d80, 0xcd41, 0x0f00, 0xcfc1, 0xce81, 0x0e40,
	0x0a00, 0xcac1, 0xcb81, 0x0b40, 0xc901, 0x09c0, 0x0880, 0xc841,
	0xd801, 0x18c0, 0x1980, 0xd941, 0x1b00, 0xdbc1, 0xda81, 0x1a40,
	0x1e00, 0xdec1, 0xdf81, 0x1f40, 0xdd01, 0x1dc0, 0x1c80, 0xdc41,
	0x1400, 0xd4c1, 0xd581, 0x1540, 0xd701, 0x17c0, 0x1680, 0xd641,
	0xd201, 0x12c0, 0x1380, 0xd341, 0x1100, 0xd1c1, 0xd081, 0x1040,
	0xf001, 0x30c0, 0x3180, 0xf141, 0x3300, 0xf3c1, 0xf281, 0x3240,
	0x3600, 0xf6c1, 0xf781, 0x3740, 0xf501, 0x35c0, 0x3480, 0xf441,
	0x3c00, 0xfcc1, 0xfd81, 0x3d40, 0xff01, 0x3fc0, 0x3e80, 0xfe41,
	0xfa01, 0x3ac0, 0x3b80, 0xfb41, 0x3900, 0xf9c1, 0xf881, 0x3840,
	0x2800, 0xe8c1, 0xe981, 0x2940, 0xeb01, 0x2bc0, 0x2a80, 0xea41,
	0xee01, 0x2ec0, 0x2f80, 0xef41, 0x2d00, 0xedc1, 0xec81, 0x2c40,
	0xe401, 0x24c0, 0x2580, 0xe541, 0x2700, 0xe7c1, 0xe681, 0x2640,
	0x2200, 0xe2c1, 0xe381, 0x2340, 0xe101, 0x21c0, 0x2080, 0xe041,
	0xa001, 0x60c0, 0x6180, 0xa141, 0x6300, 0xa3c1, 0xa281, 0x6240,
	0x6600, 0xa6c1, 0xa781, 0x6740, 0xa501, 0x65c0, 0x6480, 0xa441,
	0x6c00, 0xacc1, 0xad81, 0x6d40, 0xaf01, 0x6fc0, 0x6e80, 0xae41,
	0xaa01, 0x6ac0, 0x6b80, 0xab41, 0x6900, 0xa9c1, 0xa881, 0x6840,
	0x7800, 0xb8c1, 0xb981, 0x7940, 0xbb01, 0x7bc0, 0x7a80, 0xba41,
	0xbe01, 0x7ec0, 0x7f80, 0xbf41, 0x7d00, 0xbdc1, 0xbc81, 0x7c40,
	0xb401, 0x74c0, 0x7580, 0xb541, 0x7700, 0xb7c1, 0xb681, 0x7640,
	0x7200, 0xb2c1, 0xb381, 0x7340, 0xb101, 0x71c0, 0x7080, 0xb041,
	0x5000, 0x90c1, 0x9181, 0x5140, 0x9301, 0x53c0, 0x5280, 0x9241,
	0x9601, 0x56c0, 0x5780, 0x9741, 0x5500, 0x95c1, 0x9481, 0x5440,
	0x9c01, 0x5cc0, 0x5d80, 0x9d41, 0x5f00, 0x9fc1, 0x9e81, 0x5e40,
	0x5a00, 0x9ac1, 0x9b81, 0x5b40, 0x9901, 0x59c0, 0x5880, 0x9841,
	0x8801, 0x48c0, 0x4980, 0x8941, 0x4b00, 0x8bc1, 0x8a81, 0x4a40,
	0x4e00, 0x8ec1, 0x8f81, 0x4f40, 0x8d01, 0x4dc0, 0x4c80, 0x8c41,
	0x4400, 0x84c1, 0x8581, 0x4540, 0x8701, 0x47c0, 0x4680, 0x8641,
	0x8201, 0x42c0, 0x4380, 0x8341, 0x4100, 0x81c1, 0x8081, 0x4040
};

int IsAlNumWin (int ch) {
	return ((ch >= '0' && ch <= '9') || (ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z') || ch == '-' || ch == '/' || (ch >= 'а' && ch <= 'я') || (ch >= 'А' && ch <= 'Я') || ch == 'е' || ch == 'Ё' );
}

int IsAlNumWin63 (int ch) {
	return ((ch >= '0' && ch <= '9') || (ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z') || ch == '/' || (ch >= 'а' && ch <= 'я') || (ch >= 'А' && ch <= 'Я') || ch == 'е' || ch == 'Ё' );
}

int IsAlNum (int ch) {
	return ( ( ch >= '0' && ch <= '9' ) ||
		( ch >= 'A' && ch <= 'Z' ) ||
		( ch >= 'a' && ch <= 'z' ) ||
		( ch >= 'Ђ' && ch <= 'џ' ) ||
		( ch >= ' ' && ch <= 'Ї' ) ||
		( ch >= 'а' && ch <= 'п' ) ||
		( ch == '-') || (ch == '­') || 
		( ch == 'с') || (ch == 'р') || 
		( ch == '/') );
}

int	IsAlNumWin (const char* buf, int Offset) {
	if (buf[ Offset ] == '.') {
		if ( Offset == 0 || buf[ Offset + 1 ] == '\0' )
			return 0;
		return ( buf[ Offset - 1 ] >= '0' && buf[ Offset - 1 ] <= '9' && buf[ Offset + 1 ] >= '0' && buf[ Offset + 1 ] <= '9' );
	}
	else
		return IsAlNumWin( buf[ Offset ] );
}

int	IsAlNumWin63 (const char* buf, int Offset) {
	if (buf[ Offset ] == '.') {
		if ( Offset == 0 || buf[ Offset + 1 ] == '\0' )
			return 0;
		return ( buf[ Offset - 1 ] >= '0' && buf[ Offset - 1 ] <= '9' && buf[ Offset + 1 ] >= '0' && buf[ Offset + 1 ] <= '9' );
	}
	else
		return IsAlNumWin63( buf[ Offset ] );
}

int	IsAlNum (const char* buf, int Offset) {
	if (buf[ Offset ] == '.') {
		if ( Offset == 0 || buf[ Offset + 1 ] == '\0' )
			return 0;
		return ( buf[ Offset - 1 ] >= '0' && buf[ Offset - 1 ] <= '9' && buf[ Offset + 1 ] >= '0' && buf[ Offset + 1 ] <= '9' );
	}
	else
		return IsAlNum( buf[ Offset ] );
}

int ToUpper (int ch) {
	if ( ch >= 'a' && ch <= 'z' )
		return ch + 'A' - 'a';
	if ( ch >= ' ' && ch <= 'Ї' )
		return ch + 'Ђ' - ' ';
	if ( ch >= 'а' && ch <= 'п' )
		return ch + 'ђ' - 'а';
	if ( ch == 'р' || ch == 'с' )
		return '…';
	else
		return ch;
}

int ToUpperWin (int ch) {
	if ( ch >= 'a' && ch <= 'z' )
		return ch + 'A' - 'a';
	if ( ch >= 'а' && ch <= 'я' )
		return ch + 'А' - 'а';
	if ( ch == 'ё' || ch == 'Ё' )
		return 'Е';
	if ( ch == 'ў' )
		return 'Ў';
	else
		return ch;
}

int ToLowerWin (int ch) {
	if ( ch >= 'A' && ch <= 'Z' )
		return ch - 'A' + 'a';
	if ( ch >= 'А' && ch <= 'Я' )
		return ch - 'А' + 'а';
	if ( ch == 'Ё' || ch == 'ё' )
		return 'e';
	else
		return ch;
}

int ToLower (int ch) {
	if ( ch >= 'A' && ch <= 'Z' )
		return ch + 'a' - 'A';
	if ( ch >= 'Ђ' && ch <= 'Џ' )
		return ch + ' ' - 'Ђ';
	if ( ch >= 'ђ' && ch <= 'џ' )
		return ch + 'а' - 'ђ';
	if ( ch == 'р' || ch == 'с' )
		return 'Ґ';
	else
		return ch;
}

char* StrUpr (char* str) {
	for (char * s = str; * s != '\0'; s++)
		*s = ToUpper (* s);

	return str;
}

char* WinStrUpr (char* str) {
	for (char* s = str; *s != '\0'; s++)
		*s = ToUpperWin (*s);

	return str;
}

char* StrLwr (char* str) {
	for (char* s = str; *s != '\0'; s++)
		*s = ToLower (*s);

	return str;
}

int StrNICmp (const char* s1, const char* s2, int max_len) {
	for (int i = 0; i < max_len; i++) {
		int c1 = ToUpper (s1 [i]);
		int c2 = ToUpper (s2 [i]);

		if (c1 != c2)
			return c1 - c2;
		if ( c1 == 0 )
			return 0;
	}
	return 0;
}

#ifdef	GKGETRTF
char aTableChars[]   = "ЪїАЩГґВБіДЕ";
char aConvertChars[] = "++++||--|-+";
#endif

// convert character to ANSI ( Windows ) encoding
char ToWin (char ch) {
	if ( static_cast<unsigned char>(ch) < static_cast<unsigned char>('Ђ') ) // GARANT_W343
		return ch;
	else
	if ( ch <= 'Ї' )        // Ђ - Ї
		return ch - 'Ђ' + 0xC0;
	else
#ifdef	GKGETRTF
	if ( ch >= 'а' && ch <= 'п' )
		return ch - 'а' + 0xF0;
	else
	if ( strchr( aTableChars, ch ))
		return aConvertChars[ strchr( aTableChars, ch ) - aTableChars ];
#else
	if ( ch <= 'п' )
		return ch - 'а' + 0xF0;
#endif
	else
		return ch;
}

char* Str2Win (char * str) {
	for (int i = 0; str [i] != '\0'; i++)
		str [i] = ToWin (str [i]);
	return str;
}

char* ForceExt (char*
#ifdef MULTI_INDEX_STREAM_FILE
				  nameEtl
#else
				  name
#endif
				  , const char * ext )
{
#ifdef MULTI_INDEX_STREAM_FILE
	char *name=StrLwr(strcpy((char*)malloc(256),nameEtl));
#endif
	int i;
	for (i = strlen(name)-1; i >= 0 && name[i] != '.' && name[i] != '\\' && name[i] != '/'; i-- )
	  ;

	if ( i>=0 && name [i] != '.' ){
#ifdef MULTI_INDEX_STREAM_FILE
				strcpy(name, nameEtl);
#endif
                strcat ( name, "." );
        }else
#ifdef MULTI_INDEX_STREAM_FILE
			if(strcmp(name+i+1,GB_KEY_EXT) && strcmp(name+i+1,GB_STR_EXT) && strcmp(name+i+1,GB_NDT_EXT))
			{
				strcpy(name, nameEtl);
                strcat ( name, "." );
			}
			else
#endif
			{
#ifdef MULTI_INDEX_STREAM_FILE
				strcpy(name, nameEtl);
#endif
				name[++i] = 0;
			}
        strcat ( name, ext );
#ifdef MULTI_INDEX_STREAM_FILE
		strcpy(nameEtl, name);
		free(name);
		name= nameEtl;
#endif
        return name;
}

short crc ( void * buf, int count )
{
	unsigned crc = 0;
	char   * ptr = ( char * ) buf;

	while ( count-- > 0 )
		crc = (crc >> 8) ^ CrcTab [ (unsigned char) ((crc ^ *ptr++) & 0xFF) ];

	return ((int) crc);
}

short crc ( void * buf, int count, int start_crc ) // Added by Max (23.09.97)
{
	unsigned crc = (unsigned) start_crc;
	char   * ptr = ( char * ) buf;

	while ( count-- > 0 )
		crc = (crc >> 8) ^ CrcTab [ (unsigned char) ((crc ^ *ptr++) & 0xFF) ];

	return ((int) crc);
}

int GetHTRefCount (int cnt) {
	return cnt > 0 ? cnt : 1;
}

unsigned short DIBNumColors(char *lpbi)
{
	if (IS_WIN30_DIB(lpbi)) {
		unsigned long dwClrUsed = ((PBITMAPINFOHEADER)lpbi)->biClrUsed;
		if (dwClrUsed != 0) return (unsigned short)dwClrUsed;
	}

	unsigned short wBitCount;

	if (IS_WIN30_DIB(lpbi)) wBitCount = ((PBITMAPINFOHEADER)lpbi)->biBitCount;
	else wBitCount = ((PBITMAPCOREHEADER)lpbi)->bcBitCount;

	switch (wBitCount) {
		case 1: return 2;
		case 4: return 16;
		case 8: return 256;

		default: return 0;
	}
}

unsigned short PaletteSize(char *lpbi)
{
	if (IS_WIN30_DIB (lpbi)) return (unsigned short)(DIBNumColors(lpbi)*sizeof(RGBQUAD));
	else return (unsigned short)(DIBNumColors(lpbi)*sizeof(RGBTRIPLE));
}

unsigned long BitmapSize( unsigned long dwWidth, unsigned long dwHeight, unsigned short wBitCount)
{
	BITMAPINFOHEADER    bi;

    if (wBitCount <= 1) wBitCount = 1; 
    else if (wBitCount <= 4) wBitCount = 4; 
    else if (wBitCount <= 8) wBitCount = 8; 
    else if (wBitCount <= 24) wBitCount = 24; 
    else wBitCount = 4;

    bi.biSize = sizeof(BITMAPINFOHEADER); 
    bi.biWidth = dwWidth;
    bi.biHeight = dwHeight;
    bi.biPlanes = 1;
    bi.biBitCount = wBitCount;
    bi.biCompression = BI_RGB;     
    bi.biSizeImage = 0;
    bi.biXPelsPerMeter = 0; 
    bi.biYPelsPerMeter = 0; 
    bi.biClrUsed = 0; 
    bi.biClrImportant = 0; 

    return sizeof(BITMAPINFOHEADER)+PaletteSize((char*)&bi)+(WIDTHBYTES(wBitCount*dwWidth)*dwHeight)+sizeof(BITMAPFILEHEADER);
}
//#endif

short ParaIsComment (char* aText, char cParaStyle, short aTextSize) {
	if (cParaStyle == PS_PREFORMATTED && aTextSize > 3 && ( ( aText[ 0 ] == 5 && aText[ 1 ] == 4 ) || ( aText[ 0 ] == 5 && aText[ 1 ] == 2 )))
		return 1; // оглавление
	else if (aTextSize > 3 && aText [0] == 32 && aText[ 1 ] == 5 && aText[ 2 ] == 3)
		return 1; // комментарий
	else if (aTextSize > 2 && aText [0] ==  5 && aText[ 1 ] == 3)
		return 1; // комментарий

	return 0;
}

long GetDocMonitoring (DocInfo* docInfo) {
#ifdef	VERSION56
	return ((unsigned long)docInfo->reserved_short << 16) + (unsigned long)docInfo->reserved_short2;
#else
	return 0;
#endif
}

unsigned short GetDocStatusExEx (DocInfo* docInfo) {
	return ((unsigned short)docInfo->Status_exex_part1 << 8) + (unsigned short)docInfo->Status_exex_part2;
}

void SetDocStatusExEx (DocInfo* docInfo, unsigned short status_exex) {
	docInfo->Status_exex_part1 = (unsigned char)(status_exex >> 8);
	docInfo->Status_exex_part2 = (unsigned char)(status_exex & 0xFF);
}

u_int64_t GetDocRespondents64 (DocInfo* docInfo) {
	u_int64_t result = (((u_int64_t) docInfo->hi_long_respondents) << 32) + docInfo->long_respondents;
	return result;
}

unsigned long GetDocRespondents (DocInfo* docInfo) {
	return docInfo->long_respondents;
}

void SetDocMonitoring (DocInfo* docInfo, long aId) {
#ifdef VERSION56
	docInfo->reserved_short = (unsigned short)(aId >> 16);
	docInfo->reserved_short2= (unsigned short)(aId & 0xFFFF);
#endif
}

inline int Sign (int x) {
	return (x > 0 ? 1 : (x < 0 ? -1 : 0));
}

inline int Sign (long x) {
	return (x > 0 ? 1 : (x < 0 ? -1 : 0));
}

int CompRefsStrong (Ref* r1, Ref* r2) {
	int s = Sign ( r1 -> DocId - r2 -> DocId );
	if ( s ) return s;
	if ( r1->Sub & INHERITED_BLOCK )
		if ( ( r1->Sub & MINUS_INHERITED_BLOCK ) <= r2->Sub )
			return -1;
		else
			return 1;
	else
		return Sign( r1 -> Sub - r2 -> Sub );
}

int CompRefwWeight (RefwWeight* r1, RefwWeight* r2) {
	int s = Sign ( r1 -> DocId - r2 -> DocId );
	if ( s ) return s;
	return Sign( r1 -> Sub - r2 -> Sub );
}

int CompRefs (Ref* r1, Ref* r2) {
	int s = Sign (r1->DocId - r2->DocId);

#ifdef	BLOCKSINHERIT
	return s ? s : Sign ((r1->Sub & MINUS_INHERITED_BLOCK) - (r2->Sub & MINUS_INHERITED_BLOCK));
#else
	return s ? s : Sign (r1->Sub - r2->Sub);
#endif
}

int CompRefsPlus (Ref* r1, Ref* r2) {
	int s = Sign ( r1->DocId - r2->DocId );
	if (s) return s;

	if (!r1->Sub || !r2->Sub) return 0;

#ifdef	BLOCKSINHERIT
	return Sign ((r1->Sub & MINUS_INHERITED_BLOCK ) - (r2->Sub & MINUS_INHERITED_BLOCK));
#else
	return Sign (r1->Sub - r2->Sub);
#endif
}

int CompRefsMinus (Ref* r1, Ref* r2) {
	int s = Sign ( r1->DocId - r2->DocId );

	if (s) return s;

	if (!r1->Sub) return 0;

#ifdef	BLOCKSINHERIT
	return Sign ((r1->Sub & MINUS_INHERITED_BLOCK) - (r2->Sub & MINUS_INHERITED_BLOCK));
#else
	return Sign (r1->Sub - r2->Sub);
#endif
}

int	CompRele (const void* p1, const void* p2) {
	RefwRele* at1 = (RefwRele*) p1;
	RefwRele* at2 = (RefwRele*) p2;
	int s = at2->Rele - at1->Rele;
	if (s) return s;
	return at1->DocId - at2->DocId;
}

int	CompReleDocId (const void* p1, const void* p2) {
	RefwRele* at1 = (RefwRele*) p1;
	RefwRele* at2 = (RefwRele*) p2;
	int s = at1->DocId - at2->DocId;
	if (s) return s;
	return at2->Rele - at1->Rele;
}

int	CompDocRele (const void* p1, const void* p2) {
	DocRele* at1 = (DocRele*) p1;
	DocRele* at2 = (DocRele*) p2;
	int s = at2->Rele - at1->Rele;
	if (s) return s;
	return at1->DocId - at2->DocId;
}

int CompDates (date * d1, date * d2) {
	if ( d1 -> da_year < d2 -> da_year )
		return -1;
	else
		if ( d1 -> da_year > d2 -> da_year )
			return 1;
		else
			if ( d1 -> da_mon < d2 -> da_mon )
				return -1;
			else
				if ( d1 -> da_mon > d2 -> da_mon )
					return 1;

	return (int)(d1 -> da_day) - (int)(d2 -> da_day);
}

int cdecl CompRevs (const revision *r1, const revision *r2) {
	int s;

	if ( 0 != ( s = CompDates ( (date*) &r1 -> RevisionDate, (date*) &r2 -> RevisionDate ) ) )
		return s;
	if ( 0 != ( s = r1 -> RevisionTime.ti_hour - r2 -> RevisionTime.ti_hour ) )
		return s;
	if ( 0 != ( s = r1 -> RevisionTime.ti_min  - r2 -> RevisionTime.ti_min ) )
		return s;
	if ( 0 != ( s = r1 -> RevisionTime.ti_sec  - r2 -> RevisionTime.ti_sec ) )
		return s;
	return r1 -> RevisionTime.ti_hund - r2 -> RevisionTime.ti_hund;
}

bool is_morpho_search_possible (const DocInfo& docinfo) {
	if ((docinfo.Status & (DS_DOC|DS_EDITION)) || (docinfo.Status_ex & DS_MEDTOPIC))
		return true;
	else
		return false;
}

int is_eq(date one, date two) {
	return one.da_day==two.da_day && one.da_mon==two.da_mon && one.da_year==two.da_year;
}

int is_lt(date one, date two) {
	if (one.da_year<two.da_year) return true;
	if (one.da_year>two.da_year) return false;
	if (one.da_mon<two.da_mon) return true;
	if (one.da_mon>two.da_mon) return false;
	if (one.da_day<two.da_day) return true;
	return false;
}

date date_plusdays (date aDate, const short days) {
	time_t atime; 
	struct tm atm; 
	struct tm *ptm; 
	memset( &atm, 0, sizeof( atm )); 
	atm.tm_year = aDate.da_year - 1900; 
	atm.tm_mday = aDate.da_day; 
	atm.tm_mon  = aDate.da_mon - 1; 
	atime = mktime( &atm ); 
	atime += (long)days * 24l * 3600l; 
	ptm   = localtime( &atime );
	if ( ptm ) {
		aDate.da_year = ptm -> tm_year + 1900; 
		aDate.da_day = ptm -> tm_mday; 
		aDate.da_mon = ptm -> tm_mon + 1;	 
	}
	return aDate;
}

char*	convert_brackets (char* in) {
	int len = strlen (in), i;
	const char *from = in;
	long count_left = 0, count_right = 0, depth = 0;
	for (i = 0; i < len; i++, from++) {
		if (*from == '(') {
			depth++;
		} else if (*from == ')') {
			if (depth)
				depth--;
			else
				count_right++;
		}
	}
	count_left += depth;

	if (count_right) {
		char* out_ptr = in;
		for (i = 0; i < len; i++, out_ptr++) {
			if (*out_ptr == ')' && count_right) {
				*out_ptr = ' ';
				count_right--;
			}
		}
	}
	if (count_left) {
		char* out_ptr = in + len - 1;
		for (i = 0; i < len; i++, out_ptr--) {
			if (*out_ptr == '(' && count_left) {
				*out_ptr = ' ';
				count_left--;
			}
		}
	}
	return in;
}

char* convert_quotes (const char* in, bool& valid_quotes, bool& was_quotes, bool insert_exclam) {
	valid_quotes = true, was_quotes = false;
	int len = strlen (in);
	char *new_str = (char*) malloc (len+1), *to = new_str, *from = (char*)in;
	bool valid_quote = false, in_quotes = false, was_space = false, g_was_space = false;
	for (int i = 0; i < len; i++, from++) {
		if (*from == '\"') {
			if (in_quotes) {
				in_quotes = false;
			} else {
				was_quotes = true;
				bool found_next_quote = false;
				char *ptr;
				for (ptr = from+1; *ptr && !found_next_quote; ptr++)
					found_next_quote = *ptr == '\"';
				if (found_next_quote) {
					valid_quote = *ptr++ == '\0' && from == in;
					valid_quotes &= valid_quote;
					in_quotes = true;
					was_space = false;
				} else {
					valid_quotes = false;
				}
			}
		} else {
			if (in_quotes) {
				if (*from == ' ') {
					g_was_space = true;
					if (!was_space) {
						*to = valid_quote ? '-' : ' ';
						to++;
						was_space = true;
					}
				} else
				if (*from == '-') {
					if (!was_space) {
						*to = *from;
						to++;
					}
				} else {
					*to = *from;
					was_space = false;
					to++;
				}
			} else {
				*to = *from;
				to++;
			}
		}
	}
	if (insert_exclam && was_quotes && valid_quotes && !g_was_space && (!(*(to-1)=='*')) && (!(*(to-1)=='!')))
		*to++ = '!';
	*to = '\0';
	return new_str;
}

unsigned long hash_str (char* word) {
	unsigned long result = 0;
	for (unsigned char* ptr = (unsigned char*) word; *ptr; ptr++)
		if (*ptr > 191 && *ptr < 224)
			result |= 1 << (*ptr - 192);
	return result;
}

long leve_dist (char* s1, char* s2) {
	char leve_table [32][32];
	gk_bzero (leve_table, sizeof (leve_table));
	int M = strlen (s1), N = strlen (s2), i, j, diff;
	for (i = 0; i < M; i++)
		leve_table [i][0] = i;
	for (i = 0; i < N; i++)
		leve_table [0][i] = i;
	for (i = 1; i <= M; i++) {
		bool more = true;
		for (j = 1; j <= N; j++) {
			if (s1 [i-1] == s2 [j-1])
				diff = 0;
			else
				diff = 1;

			leve_table [i][j] = std::min (leve_table [i-1][j] + 1, std::min (leve_table [i][j-1] + 1, leve_table [i-1][j-1] + diff));
			if (leve_table [i][j] < 2)
				more = false;
		}
		if (more)
			return 100;
	}
	return leve_table [M][N];
}

int	compare_subdesc (const void* p1, const void* p2)
{
	SubDesc *s1 = (SubDesc*)p1, *s2 = (SubDesc*)p2;
	if (s1->Sub > s2->Sub) return 1; else return -1;
}

int	compare_subdescex (const void* p1, const void* p2)
{
	return ((SubDescEx *)p1)->Id - ((SubDescEx *)p2)->Id;
}

int	compare_docstruct (const void* p1, const void* p2)
{
	return ((DocStruct*)p1)->m_id - ((DocStruct*)p2)->m_id;
}

void	BuildPatternM( ContextPattern& ptn, char * str, bool b_upper)
{
	int	isLastBlank = 1;
	int	i = 0;
	ptn.WordCount = 0;

	for ( unsigned char *s = (unsigned char *) str; *s != '\0' && ptn.WordCount < 255 && i < 1000; s++ )
		if ( IS_CTX_CHAR_NORMLS_62( *s ) || *s == '*' || *s == '!') {
			if ( isLastBlank )
				ptn.Word [ptn.WordCount++] = &ptn.buf[ i ];

			ptn.buf[i] = *s;
			if ( ptn.buf[i] == 'Ё' )
				ptn.buf[i] = 'Е';
			i++;
			isLastBlank = 0;
		} else {
			ptn.buf [i++] = '\0';
			isLastBlank = 1;
		}

	ptn.buf [i] = '\0';
	ptn.Word [ptn.WordCount] = &ptn.buf [i++];
	for ( i = 0; i < ptn.WordCount; i++ ) {
		if (b_upper) WinStrUpr( ptn.Word[ i ] );
		char *ptr = ptn.Word [i], *begin = ptr;
		while (*ptr && ptr - begin < 30) ptr++;
		*ptr = '\0';
	}
}

int compare_subdesc_subs (const void *elem1, const void *elem2)
{
	long sub1 = ((SubDesc*)elem1)->Sub;
	long sub2 = ((SubDesc*)elem2)->Sub;
	if (sub1 == sub2)
		return 0;
	else
	if (sub1 < sub2)
		return -1;
	else
		return 1;
}

void hilite_word (const char* para, unsigned length, long word, long codepage, long& begin, long& end) {
	bool bInWord = false;
	const char* savedpara = para;
	long i = 0;
	begin = 0, end = 0;

	bool bWin  = (codepage == CP_ANSI) || (codepage == CP_TATAR);

	while (length) {
		if ((bWin && IS_CTX_CHAR_NORMLS_62(*para)) || (!bWin && IS_CTX_CHAR_NORMLS_56(*para))) {
			//нормальный символ
			if (!bInWord) {
				if (i == word) {
					//встали на нужное слово
					begin = (long)((para - savedpara)&0x7fffffff);

					while (length && ((bWin && IS_CTX_CHAR_NORMLS_62(*para)) || (!bWin && IS_CTX_CHAR_NORMLS_56(*para)))) {
						length--;
						para++;
					}

					end = (long)((para - savedpara)&0x7fffffff);
					break;
				}

				bInWord = true;
				i++;
			}
		} else {
			//разделитель
			bInWord = false;
		}

		++para;
		--length;
	}
}

int shortcmp (const void *l1, const void *l2)
{
	return (*((u_int16_t *)l1) > *((u_int16_t *)l2)) ? 1 : (*((u_int16_t *)l1) < *((u_int16_t *)l2)) ? -1 : 0;
}


void BuildPatternMNdot (ContextPattern& ptn, char * str)
{
	//разрезает строку на слова с учетом точки. Например, "ст.23 НК" разрежет на "ст","23","НК", а "ст.300.24 НК" разрежет на "ст","300.24","НК"
	int	isLastBlank = 1;
	int	i = 0;
	ptn.WordCount = 0;
	bool b_digits = true;

	for ( unsigned char *s = (unsigned char *) str; *s != '\0' && ptn.WordCount < 255 && i < 1000; s++ )
		if ( IS_CTX_CHAR_NORMLS_62( *s ) || *s == '*' || *s == '!' || *s == '-' || *s == '_' || *s == '/' || *s == '(' || *s == ')' || *s == (unsigned char)185) {
			if ( isLastBlank )
				ptn.Word [ptn.WordCount++] = &ptn.buf[ i ];

			ptn.buf[i] = *s;
			if (*s < '0' || *s > '9') {
				b_digits = false;
				if ( ptn.buf[i] == 'Ё' )
					ptn.buf[i] = 'Е';
				else
				if ( (unsigned char)ptn.buf[i] == (unsigned char)185 )
					ptn.buf[i] = 'N';
			}
			i++;
			isLastBlank = 0;
		} else 
		if (*s == '.' && b_digits) {
			bool b_nondigits = false;
			for (unsigned char* ptr = s+1; *ptr && *ptr != ' '; ptr++)
				if ((*ptr < '0' || *ptr > '9') && *ptr != '.')
					b_nondigits = true;
			if (b_nondigits) {
				ptn.buf [i++] = '\0';
				isLastBlank = 1;
			} else {
				ptn.buf [i] = '.';
				i++;
			}
		} else {
			ptn.buf [i++] = '\0';
			isLastBlank = 1;
			b_digits = true;
		}

	ptn.buf [i] = '\0';
	ptn.Word [ptn.WordCount] = &ptn.buf [i++];
	for (i = 0; i < ptn.WordCount; i++) {
		WinStrUpr (ptn.Word [i]);
		char *ptr = ptn.Word [i], *begin = ptr;
		bool b_special_symbols = false;
		for (; *ptr; ptr++)
			if (*ptr == '.' || *ptr == '-' || *ptr == '!' || *ptr == '*')
				b_special_symbols = true;
		if (!b_special_symbols) {
			ptr = begin;
			while (*ptr && ptr - begin < 30)
				ptr++;
			*ptr = '\0';
		}
	}
}


void BuildPatternMN (ContextPattern& ptn, char * str)
{
	int	isLastBlank = 1;
	int	i = 0;
	ptn.WordCount = 0;

	for ( unsigned char *s = (unsigned char *) str; *s != '\0' && ptn.WordCount < 255 && i < 1000; s++ )
		if ( IS_CTX_CHAR_NORMLS_62( *s ) || *s == '*' || *s == '!' || *s == '-' || *s == '_' || *s == '/' || *s == '(' || *s == ')' || *s == '.'  || *s == (unsigned char)185) {
			if ( isLastBlank )
				ptn.Word [ptn.WordCount++] = &ptn.buf[ i ];

			ptn.buf[i] = *s;
			if ( ptn.buf[i] == 'Ё' )
				ptn.buf[i] = 'Е';
			else
			if ( (unsigned char)ptn.buf[i] == (unsigned char)185 )
				ptn.buf[i] = 'N';
			i++;
			isLastBlank = 0;
		} else {
			ptn.buf [i++] = '\0';
			isLastBlank = 1;
		}

	ptn.buf [i] = '\0';
	ptn.Word [ptn.WordCount] = &ptn.buf [i++];
	for (i = 0; i < ptn.WordCount; i++) {
		WinStrUpr (ptn.Word [i]);
		char *ptr = ptn.Word [i], *begin = ptr;
		bool b_special_symbols = false;
		for (; *ptr; ptr++)
			if (*ptr == '.' || *ptr == '-' || *ptr == '!' || *ptr == '*')
				b_special_symbols = true;
		if (!b_special_symbols) {
			ptr = begin;
			while (*ptr && ptr - begin < 30)
				ptr++;
			*ptr = '\0';
		}
	}
}


bool	is_file_exists (char *name)
{
#if defined (WIN32) || defined (_MSC_VER)
	WIN32_FIND_DATA findData;
	HANDLE	handle = FindFirstFile (name, &findData);
	FindClose (handle);
	return handle != INVALID_HANDLE_VALUE;
#else
	std::ifstream f (name, std::ios_base::in | std::ios_base::binary);
	if (false == f.is_open ())
		return false;
	f.close ();
	return true;
#endif
}

std::vector<std::string> get_base_files (const char *path)
{
	struct local_DataFileSelector {
		static int selector (const dirent* d) {
			std::string name (d->d_name);
			for (size_t i = 0; i < name.size (); ++i) {
				name [i] = std::tolower (name [i]);
			}
			boost::match_results<const char*> what;
			boost::match_flag_type flags = boost::match_default;
			boost::regex expression 
				("(data[.]0e.{1})|(data[.]ke.{1})|(data[.]1e.{1})|(data[.]2e.{1})|(data[.]3e.{1})|(data[.]4t.{1})|(data[.]5e.{1})|(data[.]6.{2})|(data[.]7t.{1})|(data[.]8t.{1})|(data[.]9t.{1})|(data[.]nd.{1})|(data[.]st.{1})|(data[.]tmp[.].{3})|(data_0tmp\\d+[.].{3})|(data_0list[.].{3})"
				, boost::regex::normal | boost::regex::icase
				);	
			return boost::regex_search (name.c_str (), what, expression, flags);
		}
	};

	std::vector<std::string> names;

	std::string scan_directory (path);
	ACE_Dirent_Selector selector;
	std::string pip_scan_directory = platform_independent_path (scan_directory);
	selector.open (pip_scan_directory.c_str(), local_DataFileSelector::selector);
	for (int i = 0; i < selector.length (); ++i) {
		std::string name (path);
		if (name [name.size () - 1] != '\\')
			name += ACE_DIRECTORY_SEPARATOR_STR;
		name += selector[i]->d_name;
		names.push_back (name);
	}
	selector.close ();

	return names;
}

unsigned int gkdb_HashRot13 (const char * str)
{
    unsigned int hash = 0;

    for(; *str; str++)
    {
        hash += (unsigned char)(*str);
        hash -= (hash << 13) | (hash >> 19);
    }

    return hash;
}

