#include "shared/Core/fix/mpcxc.h"

#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <cstring>
#include <map>
#include <deque>

#include "ace/OS.h" // not Thread_Manager.h - is bad
#include "ace/Basic_Types.h"

#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"

#include "garver.h"
#include "gardefs.h"
#include "newdoc.h"
#include "stdbase.h"
#include "refcol.h"
#include "btiter.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "long.caddr_t.SplayMap.h"
#include "u_int64_t.SplaySet.h"
#include "u_int32_t.SplaySet.h"
#include "CaseString.defs.h"
#include "clTreeNode.SplaySet.h"
#include "long.long.SplayMap.h"
#include "long.SplaySet.h"
#include "pscreen.h"
#include "gclog.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "StorableSplaySet.h"
#include "rev.h"
#include "stringz.h"

#include "gl.h"
#include "zlib.h"
#include "pack.h"

#include "shared/GCL/data/DirectMap.h"

#ifdef NO_LONG_HIGHLIGHTING
	#define MENU_PARA_STYLE PS_JUSTIFIED
#else
	#define MENU_PARA_STYLE PS_PREFORMATTED
#endif

#ifndef NO_LONG_HIGHLIGHTING
	#define NO_LONG_HIGHLIGHTING
#endif

#define	FIRST_CALL		1
#define LAST_CALL		2
#define	FEDERAL_CALL	3
#define	OTHER_CALL		4
#define	PART_CALL		5

ACE_UINT64	SuperBaseRecSize = 0;
ACE_UINT64	SuperBaseDocSize = 0;
ACE_UINT64	SuperBaseCommonDocSize = 0;

bool b_english_base = false;
bool bIgnoreFatal = false;
bool b_recode = true;
bool b_inpharm = false;
bool bIgnoreTvsErrors = false;

#ifdef	VERSION63
#define	NEW_MAX_MULTI	MAX_MULTI /*( 48000 / sizeof( Ref ) )*/
#else
#define	NEW_MAX_MULTI	MAX_MULTI
#endif

static const char *msgWWWTitle = 0;
static const char *getHotDatesMsg = 0;
static const char *getBlobsMsg = 0;
static const char *readDocsInfoMsg = 0;
static const char *removeTmpMsg = 0;
static const char *openIndMsg = 0;
static const char *msgWindowTitle = 0;
static const char *makeMainMenuMsg = 0;
static const char *makeNewDocsMenuMsg = 0;
static const char *makeCalendarMsg = 0;
static const char *makeUserMenuMsg = 0;
static const char *makeDictionaryMsg = 0;
static const char *makeMDictionaryMsg = 0;
static const char *makeWWWMsg;
static const char *collectSuperbaseMsg = 0;

static const char *sAllDocs = 0;
static const char *sDocum = 0;
static const char *sChrono = 0;
static const char *sTrash = 0;
static const char *sComms = 0;
static const char *sForms = 0;
static const char *sCales = 0;
static const char *sBusiness = 0;
static const char *sUseri = 0;
static const char *sProjs = 0;
static const char *sPrakt = 0;
static const char *sInter = 0;
static const char *sQuest = 0;
static const char *sBrefe = 0;
static const char *sPublished = 0;
static const char *sFuckOff1 = 0;
static const char *sFuckOff2 = 0;
static const char *sDocInc1 = 0;
static const char *sDocInc2 = 0;
static const char *sYear = 0;
static const char *sYears = 0;
static const char *sDocs = 0;
static const char *sBelow = 0;
static const char *sSpace = 0;
static const char *sNewDocs = 0;
static const char *sChaDocs = 0;
static const char *sAboDocs = 0;
static const char *sFutDocs = 0;
static const char *sNexDocs = 0;
static const char *sOffDocs = 0;
static const char *sJan = 0;
static const char *sFeb = 0;
static const char *sMar = 0;
static const char *sApr = 0;
static const char *sMay = 0;
static const char *sJun = 0;
static const char *sJul = 0;
static const char *sAug = 0;
static const char *sSep = 0;
static const char *sOct = 0;
static const char *sNov = 0;
static const char *sDec = 0;
static const char *sBaseName = 0;
static const char *sCopyr = 0;
static const char *sFederalDocs = 0;
static const char *sOtherDocs = 0;
static const char *sPart = 0;
static const char *ssPart = 0;

static unsigned char Koi2Dos [ 256 ] = {
0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F,
0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77,
0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F,
0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x8D, 0x8E, 0x8F,
0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
0x98, 0x99, 0x9A, 0x9B, 0x9C, 0x9D, 0x9E, 0x9F,
0xA0, 0xA1, 0xA2, 0xF1, 0xA4, 0xA5, 0xA6, 0xA7,
0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF,
0xB0, 0xB1, 0xB2, 0xF0, 0xB4, 0xB5, 0xB6, 0xB7,
0xB8, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF,
0xEE, 0xA0, 0xA1, 0xE6, 0xA4, 0xA5, 0xE4, 0xA3,
0xE5, 0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE,
0xAF, 0xEF, 0xE0, 0xE1, 0xE2, 0xE3, 0xA6, 0xA2,
0xEC, 0xEB, 0xA7, 0xE8, 0xED, 0xE9, 0xE7, 0xEA,
0x9E, 0x80, 0x81, 0x96, 0x84, 0x85, 0x94, 0x83,
0x95, 0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x8D, 0x8E,
0x8F, 0x9F, 0x90, 0x91, 0x92, 0x93, 0x86, 0x82,
0x9C, 0x9B, 0x87, 0x98, 0x9D, 0x99, 0x97, 0x9A
};

#define FIRST_MY_DOC 100
#define LOCAL_ERROR -2

#define DEAD_LINE    6  
// means saturday 
/* days since Sunday [0, 6] 
 * see man mktime (struct tm )
 */

#define BY_DATE		0
#define BY_PRIOR	1
#define BUTTONS		9			// # of root entries
//
// local variables
//
static ProgressScreen *pscreen =0;
static Base		*b;			// current base
static NewDocument	*d = 0;			// current document
static ContextIndex	*auxInd;		// auxIndex
//static AttrIndex	*attrInd;		// attrIndex
static unsigned		next = FIRST_MY_DOC;		 // first free topic
static unsigned		next2= next;
static int		direction = 1;		 // direction for sorting
static int bIsBreeder = 0;
static BaseInfo		SuperBase;

static int hcount= 0;
static short *heres= 0;
extern int iMakeAllDocs, iMakeAllDocsParaMax;
extern long iMakeAllDocsSizeMax;

typedef	std::vector<Ref>	RefsVector;
typedef	std::vector<RefsVector>	RefsTopic;	
typedef	std::map<long,RefsTopic> GlTopicsMap;
typedef GCL::StrVector RefNamesList;
typedef std::map<long,RefNamesList> GlRefNames;
GlTopicsMap	*gltopics = new GlTopicsMap;
GlRefNames *glrefnames = new GlRefNames;

std::deque<long> docs_with_force;
std::deque<u_int64_t> deque_doc_atolnumber;

int compare_using_number (const void *arg1, const void *arg2)
{
	long* ptr1 = (long*) arg1, *ptr2 = (long*) arg2;
	long id1 = *ptr1, id2 = *ptr2;
	long n1 = *(ptr1+1), n2 = *(ptr2+1);
	int result = n2 - n1;
	if (!result)
		result = id1 - id2;
	return result;
}

class TN {
public:
	class Filter
	{
	public:
		virtual int shouldCopy(TN *) =0;
	};
	class NullFilter : public Filter
	{
	public:
		virtual int shouldCopy(TN *tn);
	};
	class HProcessor
	{
	public:
		virtual int doit(TN *, char *pathbuf) = 0;
	};
	class UserNodeInserter
	{
	public:
		virtual int countUserNodes(TN*parent,char*textkey, int isFinal ) =0;
		virtual void setUserNodes(TN*parent,TN*target,int nnodes,
			char*name,int final) =0;
	};
	class Printer : public HProcessor
	{
	public:
		virtual int doit(TN *, char *pathbuf);
		static void printKey(HIndex *idx, void *key, const char *add);
	};
	struct Tree
	{
		TN *root;
		char *buffer;
	};
	TN():
	key(0),nm(0),lastn(0),got(0),child(0),idx(0),
		isUserNode(0),hdrop(1), stop_path(0),restore_type(0),
		UserNode_stop_path(0), UserNode_key(0)
	{}
	~TN();
	HIndex::HIndexKey *key;
	const char *nm;
	unsigned char restore_type;
	int lastn;
	int got;
	TN *child;
	HIndex *idx;
	union {
		int a;
		void *p;
	} data;
	char * stop_path;
	int take(char *bf );
	const char *name() const {	return nm?nm:idx->Text(key); }
	const char *text() const {	return idx->Text(key); }
	int level() const { return idx->Level(key); }
	int ownChildrenCount() const { return idx->OwnChildrenCount(key); }
	int childrenCount() const { return lastn; }
	void init(HIndex *i, char *thekey );
	void build(char *bf);
	void hcopy(TN *, Filter *f);
	void hprocess(HProcessor *p, int needPath = 0);
	void hprocess(HProcessor *p, char *pathbuf);
	int hcount();
	void collapseSingleNodes();
	int collapseEmptyNodes();
	TN * findNode(const char *textkey) const;
	void addTextNode_(char *textkey, UserNodeInserter * );
	void addTextNode( const char *textkey, UserNodeInserter * );
	void addSubTree( TN * , int );
	static int readHIndex(HIndex *,TN::Tree *);
	static int cmpTNtext(const void *, const void * );
	char* UserNode_stop_path;
	HIndex::HIndexKey* UserNode_key;
	int isUserNode;
protected:
	TN * findNode_(char *textkey) const;
	int hdrop;
};

class TNClassFilter: public TN::Filter
{
public:
	TNClassFilter(ZStrings *p) : pfx(p) {}
	virtual int shouldCopy(TN *);
protected:
	ZStrings *pfx;
};

void TN::collapseSingleNodes()
{
	for( int i =0; i<lastn; i++ )
		child[i].collapseSingleNodes();

	if( lastn == 1 && !strcmp(idx->Name,"Class") && idx->Level(key) != -1) {
		nm = idx->Text(key);
		TN * saveChild = child;
		lastn = child->lastn;
		key = child->key;
		got = child->got;
		child = child->child;
	}
}

int TN::collapseEmptyNodes()
{
	int empty_childs = 0;
	TN ** new_childs = new TN*[lastn];
	for( int i =0; i<lastn; i++ ) {
		TN * t = &(child[i]);
		if (t->collapseEmptyNodes())
			empty_childs ++;
		else
			new_childs[i-empty_childs] = t;
	}

	if (lastn) {
		if (empty_childs == lastn) {
			delete [] new_childs;
			return 1;
		} else if (empty_childs > 0) {
			lastn -= empty_childs;

			child = new TN[lastn];
			for (int j = 0; j < lastn; j++)
				child[j] = *new_childs[j];

			delete [] new_childs;
			return 0;
		} else if (empty_childs == 0) {
			delete [] new_childs;
			return 0;
		}
	} else {
		if (strcmp(idx->Name,"DocKind") == 0) {
			delete [] new_childs;
			return 1;
		} else {
			delete [] new_childs;
			return 0;
		}
	}

	delete [] new_childs;
	return 0;
}

int TN::NullFilter::shouldCopy(TN *)
{
	return 1;
}

int TNClassFilter :: shouldCopy(TN *tn)
{
	Stream *str = tn->idx->keyOpen(tn->key,1);
	if( !str )
		return 0;
	char *data = (char*)malloc(str->Length());
	str->Read(data,str->Length());
	ZStrings tnstrings(data,str->Length());
	tn->idx->Close(str);
	for( int i=0; i<pfx->count(); i++ ){
		if( tnstrings.hasStringHIPart((*pfx)[i]) ){
			free(data);
			return 1;
		}
	}
	free(data);
	return 0;
}

void TN::hcopy(TN *tn, TN::Filter *f)
{
	key = tn->key;
	idx = tn->idx;
	lastn = 0;
	if( tn->lastn == 0 )
		return;

	char* c = (char*)alloca(sizeof(int)*tn->lastn);
	int nnew = 0;
	for( int i=0; i<tn->lastn; i++ ) {
		if( f->shouldCopy(tn->child+i) ) {
			nnew ++;
			c[i] = 1;
		} else {
			c[i] = 0;
		}
	}
	if( nnew ) {
		child = new TN[ nnew  ];
		for( int i = 0; i<tn->lastn; i++ ) {
			if( c[i] ) {
				child[lastn++].hcopy( tn->child+i, f );
			}
		}
	}
}

void TN::Printer::printKey(HIndex *idx, void *key, const char *add)
{
	for( int i=0; i< idx->Level(key); i++)
		printf("\t");
	printf("%s %s %d %d\n", idx->Text(key), add,
		   idx->AllChildrenCount(key),
		   idx->OwnChildrenCount(key));
}

TN::~TN()
{
	if( hdrop ){
		if( child ) 
			delete [] child;
		if(UserNode_key)
			free(UserNode_key);
		if(UserNode_stop_path)
			free(UserNode_stop_path);
	}
}
int TN::hcount()
{
	int count=0;
	for( int i=0; i<lastn; i++ )
		count+=child[i].hcount();
	return count+1;
}
void TN::hprocess(TN::HProcessor *p, int needPath)
{
	char * buf = NULL;
	if ( needPath ) {
		buf = (char * )malloc( idx->KeyLength * MAX_HINDEX_LEVELS );
		buf[0] = 0;
	}
	hprocess(p, buf );
	if( buf ) 
		free( buf );
}

void TN::hprocess(TN::HProcessor *p, char *pathbuf )
{
	int mylength;
	if( pathbuf ){
		mylength = strlen( pathbuf );
		if( mylength )
			pathbuf[mylength] = '\\';
		if( strlen( text() ) ){
			if( mylength )
				strcpy(  pathbuf + mylength +1, text() );
			else
				strcpy(  pathbuf, text() );
		}
	}
	
	if (p->doit(this, pathbuf)) {
		for( int i=0; i<lastn; i++ ) {
			child[i].hprocess(p, pathbuf);
		}
	}
	if( pathbuf )
		pathbuf[mylength]='\0';
}


int TN::Printer::doit(TN *tn, char *pathbuf)
{
	(void)pathbuf;
	if( tn->idx->Level(tn->key) != -1 ){
		printKey(tn->idx,tn->key,tn->nm?tn->nm:"");
	}
	return 1;
}

int TN::take(char *k )
{
	if( got == (int)idx->AllChildrenCount(key) )
		return 0;
	if( idx->Level(key) < idx->Level(k) ){
		if( idx->Id(key) == idx->Parent(k) ){ // my key
			child[lastn].init(idx, k );
			lastn++;
			got++;
			return 1;
		}
		for( int i=0; i<lastn; i++ ){
			if( child[i].take(k) ){
				got ++;
				return 1;
			}
		}
	}
	return 0;
}
int TN::cmpTNtext(const void *p1, const void *p2 )
{
	const TN *t1 = (const TN *) p1;
	const TN *t2 = (const TN *) p2;
	return t1->idx->CompareKeys(t1->text(), t2->text());
}

void TN::addTextNode_(char *textkey, UserNodeInserter *ins )
{
	int done = 0;
	char *ptr = strchr(textkey, '\\');
	if( ptr ) { 
		*ptr = '\0';
	}

	int i;
	for( i=0; i<lastn; i++){
		TN *t = & (child[i]);
		if( t->idx->CompareKeys( t->text(), textkey ) == 0 )
			break;
	}
	if ( i<lastn ) {
		if( ptr ){
			// send adding request to that child
			child[i].addTextNode_( ptr+1, ins );
		}
	}else{
		// no such child found; insert special node for this key
		for( i=0; i<lastn; i++){
			TN *t = & (child[i]);
			if( t->idx->CompareKeys( t->text(), textkey ) > 0 )
				break;
		}
		int nnew = ins->countUserNodes(this, textkey, ptr == NULL );
		if( nnew ) {
			TN *nchild = new TN[lastn + nnew];

			for( int c = 0; c < lastn; c++ ){
				if( c < i ){
					nchild[c] = child[c];
				}else{
					nchild[c+nnew] = child[c];
				}
			}
			ins->setUserNodes(this, &( nchild[i] ), 
							  nnew, textkey, ptr != NULL );
			if( ptr ){
				nchild[i].addTextNode_( ptr+1, ins );
			}
			for( i = 0; i<lastn; i++ ){
				child[i].hdrop = 0;
			}
			if( child ) delete [] child;
			child = nchild;
			lastn += nnew;
			qsort(nchild,lastn,sizeof(TN),cmpTNtext);
		}
	}
}


void TN::addTextNode( const char *textkey, UserNodeInserter *i )
{
	char *bf  = (char *)malloc( strlen(textkey)+1 );
	strcpy(bf, textkey );
	addTextNode_(bf,i);
	free(bf);
}

void TN::addSubTree( TN* subtree, int num )
{
	int i,k;
	int new_num = num;
	for (k=0; k<num; k++)
	{
		for( i=0; i<lastn; i++)
		{
			TN *t = & (child[i]);
			if( strcmp( t->name(), subtree[k].name() ) == 0 )
			{
				t->addSubTree(subtree[k].child,subtree[k].lastn);
				new_num--;
				break;
			}
		}
	}

	if (new_num == 0)
		return;
	
	TN *nchild = new TN[lastn + new_num];
	
	for( i = 0; i < lastn; i++ )
		nchild[i] = child[i];

	for( i = 0; i<lastn; i++ )
		child[i].hdrop = 0;

	if( child ) delete [] child;
	child = nchild;
	int pos = 0;
	for (k=0; k<num; k++)
	{
		for( i=0; i<lastn; i++)
		{
			TN *t = & (child[i]);
			if( strcmp( t->name(), subtree[k].name() ) == 0 )
			{
				break;
			}
		}
		if (i == lastn)
		{
			child[lastn+pos] = subtree[k];
			pos++;
		}
	}
	lastn += new_num;

	qsort(child,lastn,sizeof(TN),cmpTNtext);
}

TN * TN::findNode( const char *textkey ) const
{
	char *bf  = (char *)malloc( strlen(textkey)+1 );
	strcpy(bf, textkey );
	TN *tn = findNode_(bf);
	free(bf);
	return tn;
}

TN * TN::findNode_( char *textkey ) const
{
	TN *rv = NULL;

	if( level() != -1 ){
		char *ptr = strchr(textkey, '\\');
		if( ptr ) { // try to match first part against self
			*ptr = '\0';
			int bCompare = idx->CompareKeys( name(), textkey );
			*ptr = '\\';
			if( bCompare == 0 ){
				// me
				for( int i=0; i<lastn && !rv; i++){
					rv = child[i].findNode_(ptr+1);
				}
			}
		}else{
			if( idx->CompareKeys( name(), textkey ) == 0 ){
				rv = (TN*) this;
			}
		}
	}else{
		for( int i=0; i<lastn && !rv; i++){
			rv = child[i].findNode_(textkey);
		}
	}
	return rv;
}

void TN::init(HIndex *i, char *k )
{
	idx = i;
	key = (HIndex::HIndexKey *)k;
	if( idx->OwnChildrenCount(k) ){
		child = new TN[ idx->OwnChildrenCount(k) ];
	}
}

int TN::readHIndex(HIndex * idx, TN::Tree *tree)
{
	int kl = idx->KeyLength;
	int kc = idx->KeyCount;

	char *bf = (char*) malloc( kl*(kc+1));
	bzero(bf, kl*(kc+1));
	int tkk = 0;
	char *ptr  = bf + kl;
	for(BTIterator it(idx); !it.End(); ++it) {
		void *key = (void*) it.Key();
//		TN::printKey(idx,key);
		memcpy(ptr, key, kl );
		if( idx->Level(ptr) == 0 )
			tkk ++;

		ptr += kl;
	}
	idx->Level(bf) = -1;
	idx->OwnChildrenCount(bf) = tkk;
	idx->AllChildrenCount(bf) = kc;
	TN *root = new TN() ;
	root->init(idx, bf );
	ptr  = bf + kl;
	for( int i = 0; i< kc ; i++ ){
		root->take(ptr);
		ptr += kl;
	}
	tree->root = root;
	tree->buffer = bf;
	return kc;
}

void	GenerateFiltered (char* aux_source, char* index_name, char* aux_dest, long max_levels)
{
	std::map<std::string,long> map_key_levels;
	Stream* str = b->FindIndex ("Aux")->Open (aux_source);
	long size = 0;
	char *data= 0;
	if (str) {
		size = str->Length ();
		data = new char[size];
		str->Read (data, size);
		b->FindIndex ("Aux")->Close (str);
	} else {
		if (!strcmp (aux_source, AUX_fCla)) {
			data = strdup ("Основы государственно-правового устройства:3|Гражданское право:3|Налоги и сборы:3|Бухгалтерский учет:2|Банковская деятельность:2|Валютное регулирование и валютный контроль:2|Таможенное право, внешнеэкономическая деятельность:3|Ценные бумаги, рынок ценных бумаг:2|Жилые и нежилые помещения, коммунальное хозяйство:3|Земельное право, природоохранная деятельность, природные ресурсы:2|Общие вопросы хозяйственной и предпринимательской деятельности:3|Регулирование отдельных видов деятельности:3|Гражданский и арбитражный процесс, исполнительное производство:2|Труд, трудоустройство, занятость населения:3|Социальная защита, пенсии, компенсации:2|Семейное право, акты гражданского состояния:2|Здравоохранение, образование, наука, культура, спорт и туризм:2|Оборона, воинская обязанность и военная служба. Оружие:2|Охрана правопорядка, безопасность, правоохранительные органы:2|Суд и судоустройство, адвокатура, нотариат, органы юстиции:2|Уголовное, уголовно-процессуальное, уголовно-исполнительное право:2|Административные правонарушения, административная ответственность:3|Международное право, международные отношения:3");
		} else if (!strcmp (aux_source, AUX_fPre)) {
			data = strdup ("Акты органов власти:1|Судебная практика:1|Проекты законов:1");
		} else if (!strcmp (aux_source, AUX_fPub)) {
			data = strdup ("Газета \"Московский налоговый курьер\":4|Журнал \"Автономные организации: бухгалтерский учет и налогообложение\":4|Журнал \"Актуальные вопросы бухгалтерского учета и налогообложения\":4|Журнал \"Акты и комментарии для бухгалтера\":4|Журнал \"Аптека: бухгалтерский учет и налогообложение\":4|Журнал \"Аудит и налогообложение\":4|Журнал \"БУХ.1С\":4|Журнал \"Бухгалтерский учет в издательстве и полиграфии\":4|Журнал \"Бухгалтерский учет в бюджетных и некоммерческих организациях\":4|Журнал \"Бюджет\":4|Журнал \"Бюджетный учет\":4|Журнал \"Бюджетные организации: акты и комментарии для бухгалтера\":4|Журнал \"Бюджетные организации: бухгалтерский учет и налогообложение\":4|Журнал \"Бюджетные учреждения здравоохранения: бухгалтерский учет и налогообложение\":4|Журнал \"Бюджетные учреждения образования: бухгалтерский учет и налогообложение\":4|Журнал \"Вмененка\":4|Журнал \"Все для бухгалтера\":4|Журнал \"Единый налог на вмененный доход: бухгалтерский учет и налогообложение\":4|Журнал \"Жилищно-коммунальное хозяйство: бухгалтерский учет и налогообложение\":4|Журнал \"Индивидуальный предприниматель: бухгалтерский учет и налогообложение\":4|Журнал \"Консультант\":4|Журнал \"Консультант бухгалтера\":4|Журнал \"Малая бухгалтерия\":4|Журнал \"Международный бухгалтерский учет\":4|Журнал \"Московский бухгалтер\":4|Журнал \"Налог на прибыль: учет доходов и расходов\":4|Журнал \"Налоговая политика и практика\":4|Журнал \"Налоговая проверка\":4|Журнал \"Налоговый вестник\":4|Журнал \"Налоговый вестник: комментарии к нормативным документам для бухгалтеров\":4|Журнал \"Налоговый учет для бухгалтера\":4|Журнал \"Налогообложение, учет и отчетность в страховой компании\":4|Журнал \"НДС: проблемы и решения\":4|Журнал \"Новая бухгалтерия\":4|Журнал \"Нормативные акты для бухгалтера\":4|Журнал \"Оплата труда в государственном (муниципальном) учреждении: акты и комм. для бухгалтера\":4|Журнал \"Оплата труда в государственном (муниципальном) учреждении: бухучет и налогообложение\":4|Журнал \"Официальные материалы для бухгалтера. Комментарии и консультации\":4|Журнал \"Пищевая промышленность: бухгалтерский учет и налогообложение\":4|Журнал \"Практический бухгалтерский учет\":4|Журнал \"Предприятия общественного питания: бухгалтерский учет и налогообложение\":4|Журнал \"Промышленность: бухгалтерский учет и налогообложение\":4|Журнал \"Расчет\":4|Журнал \"Российский налоговый курьер\":4|Журнал \"Силовые министерства и ведомства: бухгалтерский учет и налогообложение\":4|Журнал \"Современный предприниматель. Индивидуальный подход к бизнесу\":4|Журнал \"Страховые организации: бухгалтерский учет и налогообложение\":4|Журнал \"Строительство: акты и комментарии для бухгалтера\":4|Журнал \"Строительство: бухгалтерский учет и налогообложение\":4|Журнал \"Торговля: бухгалтерский учет и налогообложение\":4|Журнал \"Транспортные услуги: бухгалтерский учет и налогообложение\":4|Журнал \"Туристические и гостиничные услуги: бухгалтерский учет и налогообложение\":4|Журнал \"Упрощенка\":4|Журнал \"Упрощенная система налогообложения: бухгалтерский учет и налогообложение\":4|Журнал \"Услуги связи: бухгалтерский учет и налогообложение\":4|Журнал \"Учреждения культуры и искусства: бухгалтерский учет и налогообложение\":4|Журнал \"Финансовый вестник: финансы, налоги, страхование, бухгалтерский учет\":4|Журнал \"Финансы\":4|Журнал \"ЭЖ Вопрос-Ответ\":4|Журнал \"Бюджетные учреждения: ревизии и проверки финансово-хозяйственной деятельности\":4|Журнал \"Оплата труда: акты и комментарии для бухгалтера\":4|Журнал \"Оплата труда: бухгалтерский учет и налогообложение\":4|Журнал \"Учреждения физической культуры и спорта: бухгалтерский учет и налогообложение\":4|Журнал \"Актуальная бухгалтерия\":4|Журнал \"Клуб главных бухгалтеров\":4|Журнал \"Практический бухгалтерский учет. Официальные материалы и комментарии (720 часов)\":4|Журнал \"Бухгалтерия и банки\":4|Журнал \"Налогообложение, учет и отчетность в коммерческом банке\":4|Журнал \"МСФО и МСА в кредитной организации\":4|Журнал \"Управление финансами и рисками в лизинговой компании\":4|Журнал \"Практическая бухгалтерия\". Приложение к бераторам:4|Журнал \"Зарплата\":4|Журнал \"Бухгалтерский учет\":4|Газета \"Финансовая газета\": 4|Журнал \"Бухгалтерский учет и налогообложение в бюджетных организациях\":4|Журнал \"Бухучет в здравоохранении\":4|Журнал \"Бухучет в сельском хозяйстве\":4|Журнал \"Бухучет в строительных организациях\":4|Журнал \"Налоги и налоговое планирование\":4|Журнал \"Автономные учреждения: акты и комментарии для бухгалтера\":4|Журнал \"Российский бухгалтер\":4");
		} else if (!strcmp (aux_source, AUX_fPJU)) {
			data = strdup ("Газета \"Новая адвокатская газета\":4|Газета \"эж-ЮРИСТ\":4|Журнал \"Адвокат\":4|Журнал \"Административное право\":4|Журнал \"Гражданин и право\":4|Журнал \"Жилищное право\":4|Журнал \"Журнал российского права\":4|Журнал \"Законодательство и экономика\":4|Журнал \"Законодательство\":4|Журнал \"Законы России: опыт, анализ, практика\":4|Журнал \"Имущественные отношения в Российской Федерации\":4|Журнал \"Корпоративный юрист\":4|Журнал \"Право в Вооруженных Силах\":4|Журнал \"Право и экономика\":4|Журнал \"Российский юридический журнал\":4|Журнал \"Трудовое право\":4|Журнал \"Экономико-правовой бюллетень\":4|Журнал \"Юридическая работа в кредитной организации\":4|Журнал \"Юрисконсульт в строительстве\":4|Журнал \"Юрист вуза\":4|Журнал \"Кадровик. Трудовое право для кадровика\":4|Журнал \"Медицинское право\":4|Журнал \"Налоговый вестник\":4|Журнал \"Налоговая проверка\":4|Журнал \"Налоговая политика и практика\":4|Журнал \"Налоги и налоговое планирование\":4|Журнал \"Управление персоналом\":4|Журнал \"Юридическая работа в кредитной организации\":4");
		} else if (!strcmp (aux_source, AUX_fPHR)) {
			data = strdup ("Журнал \"Вопросы трудового права\":4|Журнал \"Кадровая служба и управление персоналом предприятия\":4|Журнал \"Кадровик\":4|Журнал \"Кадровик. Кадровое делопроизводство\":4|Журнал \"Кадровик. Кадровый менеджмент\":4|Журнал \"Кадровик. Рекрутинг для кадровика\":4|Журнал \"Кадровик. Трудовое право для кадровика\":4|Журнал \"Кадровик.ру\":4|Журнал \"Отдел кадров бюджетного учреждения\":4|Журнал \"Отдел кадров коммерческой организации\":4|Журнал \"Трудовое право\":4|Журнал \"Управление персоналом\":4");
		} else if (!strcmp (aux_source, AUX_fPBO)) {
			data = strdup ("Журнал \"Автономные организации: бухгалтерский учет и налогообложение\":4|Журнал \"Автономные учреждения: акты и комментарии для бухгалтера\":4|Журнал \"Бухгалтерский учет в бюджетных и некоммерческих организациях\":4|Журнал \"Бухгалтерский учет и налогообложение в бюджетных организациях\":4|Журнал \"Бухучет в здравоохранении\":4|Журнал \"Бюджет\":4|Журнал \"Бюджетные организации: акты и комментарии для бухгалтера\":4|Журнал \"Бюджетные организации: бухгалтерский учет и налогообложение\":4|Журнал \"Бюджетные учреждения здравоохранения: бухгалтерский учет и налогообложение\":4|Журнал \"Бюджетные учреждения образования: бухгалтерский учет и налогообложение\":4|Журнал \"Бюджетные учреждения: ревизии и проверки финансово-хозяйственной деятельности\":4|Журнал \"Бюджетный учет\":4|Журнал \"Казенные учреждения: бухгалтерский учет и налогообложение\":4|Журнал \"Оплата труда в государственном (муниципальном) учреждении: акты и комм. для бухгалтера\":4|Журнал \"Оплата труда в государственном (муниципальном) учреждении: бухучет и налогообложение\":4|Журнал \"Отдел кадров бюджетного учреждения\":4|Журнал \"Разъяснения органов исполнительной власти по ведению финансово-хозяйственной деятельности в бюджетной сфере\":4|Журнал \"Руководитель автономного учреждения\":4|Журнал \"Руководитель бюджетной организации\":4|Журнал \"Силовые министерства и ведомства: бухгалтерский учет и налогообложение\":4|Журнал \"Советник бухгалтера бюджетной сферы\":4|Журнал \"Советник бухгалтера в здравоохранении\":4|Журнал \"Советник в сфере образования\":4|Журнал \"Учреждения культуры и искусства: бухгалтерский учет и налогообложение\":4|Журнал \"Учреждения физической культуры и спорта: бухгалтерский учет и налогообложение\":4");
		} else if (!strcmp (aux_source, AUX_fAdo)) {
			data = strdup ("Органы судебной власти РФ и СССР:4|Государственные фонды:4|Органы законодательной власти России и СССР:3|Центральный Банк Российской Федерации (Банк России) и другие банки:3|Государственные фонды:3|Президент России и СССР:2|Правительство России и СССР:2|Органы прокуратуры:2|Федеральные министерства и ведомства:2|Органы власти Московской области:2|Органы власти г. Санкт-Петербурга:2|Органы власти Ленинградской области:2|Органы власти Республики Башкортостан:2|Органы власти Республики Татарстан:2|Органы власти Удмуртской Республики:2|Органы власти Чувашской Республики:2|Органы власти Алтайского края:2|Органы власти Красноярского края:2|Органы власти Приморского края:2|Органы власти Астраханской области:2|Органы власти Белгородской области:2|Органы власти Брянской области:2|Органы власти Волгоградской области:2|Органы власти Воронежской области:2|Органы власти Иркутской области:2|Органы власти Калининградской области:2|Органы власти Калужской области:2|Органы власти Камчатского края:2|Органы власти Кемеровской области:2|Органы власти Костромской области:2|Органы власти Курской области:2|Органы власти Липецкой области:2|Органы власти Омской области:2|Органы власти Орловской области:2|Органы власти Пензенской области:2|Органы власти Псковской области:2|Органы власти Ростовской области:2|Органы власти Рязанской области:2|Органы власти Саратовской области:2|Органы власти Свердловской области:2|Органы власти Тамбовской области:2|Органы власти Тверской области:2|Органы власти Томской области:2|Органы власти Тульской области:2|Органы власти Ульяновской области:2|Органы власти Челябинской области:2|Органы власти Ярославской области:2|Органы власти Ханты-Мансийского автономного округа - Югры:2|Органы власти Смоленской области:2|Органы власти Самарской области:2|Органы власти Новосибирской области:2|Органы власти Нижегородской области:2|Органы власти Кировской области:2|Органы власти Ивановской области:2|Органы власти г. Москвы:2|Органы власти Краснодарского края:2|Органы власти Амурской области:2|Органы власти Владимирской области:2|Органы власти Пермского края:2|Органы власти Забайкальского края:2|Органы власти Тюменской области:2|Средства массовой информации (СМИ)\\Журнал \"Арбитражное правосудие в России\":1|Субъект права законодательной инициативы:1|ЦИК России (Центральная избирательная комиссия РФ):1|Прочие органы и организации\\Агентство по реструктуризации кредитных организаций:1|Прочие органы и организации\\Государственная корпорация \"Агентство по страхованию вкладов\":1|Прочие органы и организации\\Государственная корпорация \"Фонд содействия реформированию жилищно-коммунального хозяйства\":1|Прочие органы и организации\\Государственная корпорация по атомной энергии \"Росатом\":1|Прочие органы и организации\\ВЦСПС:1|Прочие органы и организации\\Госстандарт Республики Беларусь:1|Прочие органы и организации\\Институт профессиональных бухгалтеров и аудиторов России (ИПБ России):1|Прочие органы и организации\\Координационный центр по ценообразованию и сметному нормированию в строительстве:1|Прочие органы и организации\\Межведомственный совет по присуждению премий Правительства РФ в области образования:1|Прочие органы и организации\\ММВБ (Московская межбанковская валютная биржа):1|Прочие органы и организации\\ГГК \"Газпром\":1|Прочие органы и организации\\РАО \"Газпром\":1|Прочие органы и организации\\ОАО \"РЖД\" (ОАО \"Российские железные дороги\"):1|Прочие органы и организации\\Общероссийский профсоюз авиационных работников:1|Прочие органы и организации\\Общероссийский профсоюз работников автомобильного транспорта и дорожного хозяйства:1|Прочие органы и организации\\Общероссийское отраслевое объединение работодателей электроэнергетики:1|Прочие органы и организации\\Общественная палата Российской Федерации:1|Прочие органы и организации\\Палата налоговых консультантов:1|Прочие органы и организации\\Профсоюз работников автомобильного и сельскохозяйственного машиностроения РФ:1|Прочие органы и организации\\Профсоюз работников государственных учреждений и общественного обслуживания РФ:1|Прочие органы и организации\\Профсоюз работников народного образования и науки РФ:1|Прочие органы и организации\\Профсоюз работников нефтяной, газовой отраслей промышленности и строительства РФ:1|Прочие органы и организации\\РАН:1|Прочие органы и организации\\РАО ЕЭС:1|Прочие органы и организации\\Рослеспрофсоюз (Профсоюз работников лесных отраслей Российской Федерации):1|Прочие органы и организации\\Российская академия медицинских наук:1|Прочие органы и организации\\Российская трехсторонняя комиссия по регулированию социально-трудовых отношений:1|Прочие органы и организации\\Российский независимый профсоюз работников угольной промышленности:1|Прочие органы и организации\\Росхимпрофсоюз (Российский профессиональный союз работников химических отраслей промышленности):1|Прочие органы и организации\\Совет Федерации независимых профсоюзов России:1|Прочие органы и организации\\Счетная палата Российской Федерации:1|Прочие органы и организации\\Торгово-промышленная палата России:1|Прочие органы и организации\\Уполномоченный по правам человека в Российской Федерации:1|Прочие органы и организации\\Федеральный центр ценообразования в строительстве и промышленности строит. материалов (ФЦЦС):1|Прочие органы и организации\\ЦК КПСС:1|Прочие органы и организации\\ЦК Общероссийского профсоюза жизнеобеспечения:1|Прочие органы и организации\\ФГУП \"Почта России\":1|Органы власти Республики Коми:2|Органы власти Республики Карелия:2|Органы власти Республики Марий Эл:2|Органы власти Республики Дагестан:2|Органы власти Республики Мордовия:2|Органы власти Ямало-Ненецкого автономного округа:2|Органы власти Карачаево-Черкесской Республики:2|Органы власти Республики Северная Осетия-Алания:2|Органы власти Республики Ингушетия:2|Органы власти Республики Саха (Якутия):2|Органы власти Курганской области:2|Органы власти Еврейской автономной области:2|Органы власти Чеченской республики:2|Органы власти Республики Бурятия:2|Органы власти Новгородской области:2|Органы власти Мурманской области:2|Органы власти Республики Алтай:2|Органы власти Сахалинской области:2|Органы власти Магаданской области:2|Органы власти Чукотского автономного округа:2|Органы власти Архангельской области:2|Органы власти Ненецкого автономного округа:2|Органы власти Республики Адыгея:2|Органы власти Республики Хакасия:2|Органы власти Республики Тыва:2|Органы власти Псковской области:2|Органы власти Республики Калмыкия:2|Органы власти Вологодской области:2|Органы власти Оренбургской области:2|Органы власти Ставропольского края:2|Органы власти Хабаровского края:2|Органы власти Кабардино-Балкарской Республики:2");
		} else
			return ;

		size = strlen (data) + 1;
		for (int i = 0; i < size; i++) {
			if (data [i] == '|')
				data [i] = '\0';
		}
	}
	char *ptr = data;
	for (;ptr - data < size;) {
		char* delimiter_pos = strrchr (ptr, ':');
		long levels = atol (delimiter_pos+1);
		*delimiter_pos = '\0';
		map_key_levels.insert (std::map<std::string,long>::value_type (ptr, levels));
		delimiter_pos++;
		ptr = delimiter_pos + strlen (delimiter_pos) + 1;
	}

	TreeNodeLevel *node = 0;
	long count = 0;
	HIndex* index = (HIndex*) b->FindIndex (index_name);

	std::map<long,long> map_id_parentid;
	std::map<long,std::string> map_id_shortname, map_id_fullname;
	BTIterator *it = new BTIterator (index);
	for (; !it->End (); ++(*it)) {
		HIndex::HIndexKey* key = (HIndex::HIndexKey*)it->Key ();
		if (key->level > max_levels)
			break;
		map_id_parentid.insert (std::map<long,long>::value_type (key->id, key->parent));
		map_id_shortname.insert (std::map<long,std::string>::value_type (key->id, key->text+4));
	}
	delete it;

	for (std::map<long,long>::const_iterator map_it = map_id_parentid.begin (); map_it != map_id_parentid.end (); map_it++) {
		long id = map_it->first, parent_id = id;
		std::string name;
		while (parent_id != 0) {
			if (name.size ())
				name = "\\" + name;
			name = map_id_shortname.find (parent_id)->second.c_str () + name;
			parent_id = map_id_parentid.find (parent_id)->second;
		}
		map_id_fullname.insert (std::map<long,std::string>::value_type (id, name));
	}

	for (std::map<long,std::string>::const_iterator map_ite = map_id_fullname.begin (); map_ite != map_id_fullname.end (); map_ite++) {
		long id = map_ite->first;
		std::map<std::string,long>::const_iterator it = map_key_levels.find (map_ite->second.c_str ());
		if (it != map_key_levels.end ()) {
			node = (TreeNodeLevel*) realloc (node, sizeof (TreeNodeLevel) * (count+1));
			node [count].id = id;
			node [count].level = (short) it->second;
			count++;
		}
	}
	if (count) {
		Stream* str = auxInd->Open (aux_dest, 1);
		if (str) {
			str->Write (node, sizeof (TreeNodeLevel) * count);
			str->Trunc ();
			auxInd->Close (str);
		}
		free (node);
	} else {
		auxInd->Delete (aux_dest);
	}
	if(data)
		delete []data;
}

bool	FindGlTopic( long docid )
{
	return gltopics->find( docid ) != gltopics->end();
}

struct history_info
{
	int hitems;
	struct {
		date start;
		date end;
	} dates[HISTORY_DEPTH];
};

struct editionStruct {
	long id;
	long doc;
}__PACKED__;

std::deque<ShortCommonAttribute> fastInfos;
std::deque<DSSAttribute> dss_attribs;
std::deque<InpharmAttribute> fastInpharms;
std::deque<long> annos;
std::deque<u_int64_t> annos_docs;
long bigdic_count = 0, smldic_count = 0, annos_count = 0;

static revision currentRevision;
std::map<std::string, u_int64_tSplaySet*> pfx_Info;

static u_int32_tSplaySet * onlyDocs = 0;
static u_int32_tSplaySet *all_docs = 0;

static const char *IndName [5] =
	{ "VIncluded", "VChanged", "VAbolished", "VAnonced", "VLControl" };

static const char *revstatus [5];

static int makeMenuTopics(Base *b);
static int makePublishedTopics(Base *b);
static int makeFastDicIdx(Base *b, longSplaySet dicIDs );
static int makeFastMDicIdx(Base *b, bool);
void	makeFastSnippet (Base *b);

static void addDummyPara( NewDocument *nd, int n = 1 );
static int makeSplashData(long *tpcs, int nitems);
static int makeBannerData(long *tpcs, int nitems);
static int  defineInfoTopics();

static int MakeTrashTopic    ( struct history_info * );
static void FillHotDates	     ( struct history_info * );
static void DatePlus	     ( const date*, date*, int );
int DayOfWeek ( const date* );
static void AddDummyPara(void);
static void AddDummies	     ( int );
static int AddParaWithList   ( char*, char*, DocCollection*, int, int, int );
static int GetCol( DocCollection*, const date*, const date*, DateIndex *);
static void PutPara	     ( char*, unsigned );
static int loadRefsFromDocStream( Stream *str, RefCollection *refs );

static int CreateDoc	     ( int, const char* );

extern "C" {
static int SortRefs ( Ref *ref, int count, int method, int dir );
static int sort_function(const void*, const void*);
static int findbidcmp(const void *key, const void *rec);
}

static int CollectInfo(void);

inline long date_to_long(unsigned day, unsigned mon, unsigned year) {
	long val = 0;
	if(day == 0 || mon == 0 || year == 0) {
		return val;
	}
	val = ((year & 0xFFFF) << 16) | ((mon & 0xFF) << 8) | (day & 0xFF);
	return val;
}

static u_int64_tSplaySet * readRefs(Stream * str)
{
 	u_int64_tSplaySet *t = new u_int64_tSplaySet;
	u_int64_t * buf = (u_int64_t *)malloc(str->Length());
	unsigned long nrefs = str->Read(buf,str->Length()) / sizeof(u_int64_t);
	for (unsigned long i = 0; i < nrefs; i++ )
#ifdef	BLOCKSINHERIT
		if ( !(( buf[i] >> 32 ) & 0x40000000 ))
#endif
		t->add(buf[i]);
	free(buf);
	return t;
}

static u_int32_tSplaySet * readDocs(Stream * str)
{
 	u_int32_tSplaySet *t = new u_int32_tSplaySet;
	u_int32_t * buf = (u_int32_t *)malloc(str->Length());
	unsigned long ndocs = str->Read(buf,str->Length()) / sizeof(u_int32_t);
	for (unsigned long i = 0; i < ndocs; i++ )
		t->add(buf[i]);
	free(buf);
	return t;
}

static u_int64_tSplaySet * filterRefs(Index *idx, const char *auxn )
{
 	u_int64_tSplaySet *t = new u_int64_tSplaySet;
 
 	Index *idxAux = b->FindIndex("Aux");
 	Stream *str = idxAux->Open(auxn);
 	if( str ) {
 		char *data = (char*) malloc(str->Length());
 		str->Read(data, str->Length());
 		ZStrings dp(data, str->Length());
 		idxAux->Close(str);
 		for( int i = 0; i< dp.count(); i++) {
			std::map<std::string,u_int64_tSplaySet*>::const_iterator it = pfx_Info.find (dp[i]->ptr);
			if (it != pfx_Info.end ())
				t->set_or (it->second);
 		}
		free(data);
 	}
 	return t;
}

class UTreeExpander : public TN::HProcessor
{
public:
	class UserNodeClassInserter : public TN :: UserNodeInserter {
	public:
		UserNodeClassInserter( TN::Tree *ct, int it, const char*d, const char *p ): clTree( ct ), instype(it), clname(d), path(p) {};
		void setUserNodes(TN *parent, TN *target, int nnodes, char *name,int final);
		int countUserNodes(TN*parent,char*textkey, int isFinal );
	protected:
		TN::Tree *clTree;
		int instype;
		const char *clname;
		const char *path;
	};

	UTreeExpander(TN::Tree *ct ): clTree( ct ) {};
	virtual int doit(TN *, char *path);
protected:
	TN::Tree *clTree;
};

int UTreeExpander::UserNodeClassInserter::countUserNodes(TN *parent, char *name,int final)
{
		return 1;
}

void UTreeExpander::UserNodeClassInserter::setUserNodes(TN *parent, TN *target,int nnodes, char *name,int final)
{
	target->UserNode_stop_path= target->stop_path = strdup(parent->stop_path);
	target->idx = parent->idx;
	target->UserNode_key= target->key = (HIndex::HIndexKey*) calloc( parent->idx->KeyLength, 1 );
	strcpy( (char*) (target->text()), name );
	target->idx->Level(target->key) = parent->level()+1;
	target->isUserNode= 1;
}


int UTreeExpander::doit(TN *tn, char * path)
{
	if( tn->isUserNode == 1 ){
		return 0;
	}
	
	tn->stop_path = strdup(path);
	Stream *str = (tn->idx)->keyOpen(tn->key,1);
	if( str ) {
		if( str->Length() ) {
			char *data = (char*) malloc(str->Length());
			str->Read(data, str->Length());
			ZStrings zs(data, str->Length());
			(tn->idx)->Close(str);
			for( int i=0; i< zs.count(); i++ ) {
				char * ptr = (char*)zs[i]->ptr;
				char * p = ptr;
				int unt;
				char namebuf[1024];
				char clbuf[1024];
				
				char * q = strchr(p,':');
				if (!q) {
					gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Bad data of prefix second stream.\n");
					break;
				}
				
				*q = 0;	
				unt = atoi(p);		
				*q = ':'; p = q+1; q = strchr(p,':');
				
				if (!q) {
					gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Bad data of prefix second stream.\n");
					break;
				}
				
				*q = 0;
				strcpy(namebuf,p);
				strcpy(clbuf,q+1);
				
				if (*namebuf) {
					UserNodeClassInserter* ci = new UserNodeClassInserter(clTree, unt, clbuf, path);
					tn->addTextNode_( namebuf, ci );
					delete ci;
				}
			}
		}else
				(tn->idx)->Close(str);
	}
	return 1;
}

class UTreeConnector : public TN::HProcessor
{
public:
	UTreeConnector(TN::Tree *ct ): clTree( ct ) {};
	virtual int doit(TN *, char *path);
protected:
	TN::Tree *clTree;
};

int UTreeConnector::doit(TN *tn, char * path)
{
	if (tn->level() == -1)
		return 1;

	if (strcmp(tn->idx->Name, "Class") == 0)
		return 0;

	Stream *str = ((HIndex*)(tn->idx))->OpenN(tn->stop_path,1);
	if( str ) {
		if( str->Length() ) {
			char *data = (char*) malloc(str->Length());
			str->Read(data, str->Length());
			ZStrings zs(data, str->Length());
			((HIndex*)(tn->idx))->Close(str);

			ZStrings prfx(tn->stop_path, strlen(tn->stop_path)+1);
			TNClassFilter cf(&prfx);
			TN * fcl = new TN;
			fcl->hcopy(clTree->root, &cf);
			int notActual= 1;
			for( int i=0; i< zs.count(); i++ ) {
				char * ptr = (char*)zs[i]->ptr;
				char * p = ptr;
				int unt;
				char namebuf[1024];
				char clbuf[1024];
				
				char * q = strchr(p,':');
				if (!q) {
					gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Bad data of prefix second stream.\n");
					break;
				}
				
				*q = 0;	
				unt = atoi(p);		
				*q = ':'; p = q+1; q = strchr(p,':');
				
				if (!q) {
					gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Bad data of prefix second stream.\n");
					break;
				}
				
				*q = 0;
				strcpy(namebuf,p);
				strcpy(clbuf,q+1);
				
				if (!strcmp(path,tn->stop_path) && *namebuf) continue;

				if (strlen(path) > strlen(tn->stop_path)) {
					if (strcmp(path+strlen(tn->stop_path)+1,namebuf)) continue;
				}

				TN * subcl = (*clbuf)?fcl->findNode(clbuf):fcl;

				if (subcl == 0){	
					if (!bIsBreeder){
						gllog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"Попытка добавить несуществующую ветку '");
						gllog.printfCP(AdvLogger::CD_ALT,"%s",clbuf);
						gllog.printfCP(AdvLogger::CD_WIN,"' для префикса '");
						gllog.printfCP(AdvLogger::CD_ALT,"%s",tn->text());
						gllog.printfCP(AdvLogger::CD_WIN,"'.\n");
					}
					if(notActual)
						delete fcl;
					return 0;
				}
				if (unt == 0){
					if (*clbuf){
						tn->addSubTree(subcl,1);
						notActual= 0;
					}else{
						tn->addSubTree(subcl->child,subcl->lastn);
						notActual= 0;
					}
				}
				if (unt == 1){
					if (subcl->lastn == 0){
						tn->nm = tn->UserNode_stop_path= strdup(tn->name());
						tn->idx = subcl->idx;
						tn->UserNode_key= tn->key = (HIndex::HIndexKey*) calloc( subcl->idx->KeyLength, 1 );
						strcpy( (char*) (tn->text()), subcl->text() );
						tn->idx->Level(tn->key) = subcl->idx->Level(subcl->key);
						tn->idx->Parent(tn->key) = subcl->idx->Parent(subcl->key);
						tn->idx->Id(tn->key) = subcl->idx->Id(subcl->key);
					}else{
						tn->addSubTree(subcl->child,subcl->lastn);
						notActual= 0;
					}
				}
				if (unt == 2){
					tn->lastn = 0;
					tn->child = 0;
					tn->nm = tn->UserNode_stop_path= strdup(tn->name());
					tn->idx = subcl->idx;
					tn->UserNode_key= tn->key = (HIndex::HIndexKey*) calloc( subcl->idx->KeyLength, 1 );
					strcpy( (char*) (tn->text()), subcl->text() );
					tn->idx->Level(tn->key) = subcl->idx->Level(subcl->key);
					tn->idx->Parent(tn->key) = subcl->idx->Parent(subcl->key);
					tn->idx->Id(tn->key) = subcl->idx->Id(subcl->key);
				}
			}
			if(notActual)
				delete fcl;
			free(data);
		}else{
			((HIndex*)(tn->idx))->Close(str);
			if (!tn->lastn){
				ZStrings prfx(tn->stop_path, strlen(tn->stop_path)+1);
				TNClassFilter cf(&prfx);
				TN * fcl = new TN;
				fcl->hcopy(clTree->root, &cf);
				tn->addSubTree(fcl->child,fcl->lastn);
			}
		}
	}
	return 1;
}

class TNPrefixFilter: public TN::Filter
{
public:
	TNPrefixFilter(ZStrings *p) : pfx(p) {}
	virtual int shouldCopy(TN *);
protected:
	ZStrings *pfx;
};

int TNPrefixFilter :: shouldCopy(TN *tn)
{
	const char * data = tn->name();
	ZStrings tnstrings(data,strlen(data)+1);
	for( int i=0; i<pfx->count(); i++ ){
		if( tnstrings.hasStringHIPart((*pfx)[i]) )
			return 1;
	}
	return 0;
}


class ClassEnumerator : public TN::HProcessor
{
public:
	ClassEnumerator(int start) : lastn(start) {}
	virtual int doit(TN *, char *pathbuf);
	int next() const { return lastn; }
protected:
	int lastn;
};
int ClassEnumerator::doit (TN *tn, char *pathbuf)
{
	(void)pathbuf;
	tn->data.a = lastn++;
	for (unsigned long i = 0; i < (unsigned long)tn->lastn; i++)
		if ((tn->child+i)->stop_path == 0)
			(tn->child+i)->stop_path = tn->stop_path;
	return 1;
}

class PrefixReader : public TN::HProcessor
{
public:
	PrefixReader() {}
	virtual int doit(TN *, char *pathbuf);
protected:
};

int PrefixReader::doit (TN *tn, char *pathbuf)
{
	if (tn->level() == -1)
		return 1;

	Stream *str = ((HIndex*)(tn->idx))->OpenN(pathbuf,0);
	if (str) {
		u_int64_tSplaySet * pfx_rf = readRefs(str);
		((HIndex*)(tn->idx))->Close(str);
		pfx_Info.insert(std::map<std::string, u_int64_tSplaySet*>::value_type (pathbuf, pfx_rf));
	}
	return 1;
}

class ClassTreeToDoc : public TN::HProcessor
{
public:
	ClassTreeToDoc(const char * _pfx_type);
	virtual int doit(TN *, char *pb_);
	NewDocument * newDoc(int docid, const char *name){
		NewDocument *md = new NewDocument ( b, docid, name, currentRevision, PM_ZIP );
		if (!md || !md->IsOk()){
			gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "пЫЙВЛБ УПЪДБОЙС ОПЧПЗП ДПЛХНЕОФБ.\n");
			return 0;
		}
#ifdef VERSION61
		Ref rrr;
		rrr.DocId= docid;
		rrr.Sub= 0;
		Stream *str=b->FindIndex("SubName")->Open(&rrr, 1);
		str->Write(name,strlen(name)+1);
		str->Trunc();
		b->FindIndex("SubName")->Close(str);
#else
		b->docInd->Put(docid,IDD_NAME,name,strlen(name)+1);
#endif
		return md;
	}
	int noffs;
	char ir;
	const char * pfx_type;
};


ClassTreeToDoc::ClassTreeToDoc(const char * _pfx_type)
{
	noffs = 4;
	ir = 1;
	pfx_type = _pfx_type;
}

int ClassTreeToDoc::doit(TN *tn,char *pb_)
{
	(void)pb_;
	if( tn->childrenCount() ) {
		GlTopicsMap::iterator it = gltopics->insert( GlTopicsMap::value_type( tn->data.a, RefsTopic() )).first;
			
		for( int i = 0; i < tn->lastn; i++ ) {
			TN *t = tn->child+i;
			std::string refname = t->name()+noffs; //это собственно говоря имя ссылки
			GlRefNames::iterator names = glrefnames->insert( GlRefNames::value_type( tn->data.a, RefNamesList() )).first;
			names->second.push_back( refname );

			if ( t->lastn ) {
				// single reference
				RefsVector singleref;
				Ref aRef = { t->data.a, 0 };
				singleref.push_back( aRef );
				it->second.push_back( singleref );
			} else {
				u_int64_tSplaySet *rfFilter = 0;
				if (t->stop_path)
					rfFilter = pfx_Info.find (t->stop_path)->second;
				else
					rfFilter = pfx_Info.find (pfx_type)->second;
				Stream* str = ((HIndex*)(t->idx))->Index::OpenN(t->key,0);
				if( str ) {
					u_int64_tSplaySet *refs = readRefs(str);
					(*refs) &= (*rfFilter);
					(*refs) &= (*onlyDocs);
					if ( !refs->length()) {
						str->Seek(0);
						u_int64_tSplaySet *nrefs = readRefs(str);
						(*nrefs) &= (*rfFilter);
						*refs = *nrefs;
						delete nrefs;
					}

					int itc = refs->length();
					if ( itc ) {
						u_int64_t* allRefs = new u_int64_t[ itc ];
						u_int64_t* ptrRef = allRefs;
						for ( Pix aRef = refs->first(); aRef; refs->next( aRef ))
							*ptrRef++ = (*refs)(aRef);

						SortRefs((Ref*)allRefs,itc,BY_PRIOR,1);
						ptrRef = allRefs;

						RefsVector vrefs;
						for ( int i = 0; i < itc; i++ ) {
							vrefs.push_back( *(Ref*)ptrRef );
							ptrRef++;
						}
						it->second.push_back( vrefs );

						delete allRefs;
						delete refs;
					}
					else {
						if ( !bIsBreeder )
							gllog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, "Пустой список для ключа %s.\n", t->key );
					}
					((HIndex*)(t->idx))->Close(str);
				} else {
					if ( !bIsBreeder ) {
						gllog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"Нет данных для ключа %s.\n", t->key );
					}
				}
			}
		}
	}
	return 1;
}

struct xRef
{
	long	data;
	Ref	ref;
};
//
// for qsort proc
//
int sort_function ( const void *a, const void *b )
{
	long	s = ( (xRef*) a ) -> data - ( (xRef*) b ) -> data;
	if( s ) {
		if( s * direction > 0 )
			return 1;
		else
			return -1;
	}
	s = ( (xRef*) a ) -> ref.DocId - ( (xRef*) b ) -> ref.DocId ;
	if( s ) {
		if( s * direction > 0 )
			return 1;
		else
			return -1;
	}
	s = ( (xRef*) a ) -> ref.Sub - ( (xRef*) b ) -> ref.Sub;
	return s ? ( ( ( direction * s ) > 0 ) ? 1 : -1 ) : 0;
}

int	sort_function_63 ( const void *a, const void *b )
{
	long s = ((Ref*)a)->DocId - ((Ref*)b)->DocId;
	if ( s ) return s;
	return ((Ref*)a)->Sub - ((Ref*)b)->Sub;
}


//
// Sort an array of refs
//

int SortRefs ( Ref *ref, int count, int method, int dir )
{
	Ref	*xref = (Ref*) malloc( count * sizeof( Ref ));

	int i;
	if ( !xref ) {
		gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "нБМП РБНСФЙ ДМС УПТФЙТПЧЛЙ УУЩМПЛ.\n");
		return 1;
	}

	for ( i = 0; i < count; i++ ) {
		xref[i].DocId = ref[i].DocId;
		xref[i].Sub   = ref[i].Sub;
	}

	qsort( xref, count, sizeof(Ref), sort_function_63);

	for ( i = 0; i < count; i++ ) {
		ref[i].DocId = xref[i].DocId;
		ref[i].Sub   = xref[i].Sub;
	}

	free(xref);
	return 0;
}
//
// Add a paragraph
//
static void PutPara ( char *para, unsigned size )
{
	if(  size > MAX_PARA_LEN )
	{
		if (!bIsBreeder)
		{
			gllog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, 
				"дМЙОБ РБТБЗТБЖБ (%ld) РТЕЧПУИПДЙФ НБЛУЙНБМШОХА %ld.\n",MAX_PARA_LEN);
		}
		size = MAX_PARA_LEN -1;
	}

	*para = 8;
	*(long*) ( para + 1 ) = 0;
	d -> AddPara ( PS_PREFORMATTED, size, para );
}
//
// Add empty line for current document
//
static void AddDummyPara ( void )
{
	static char dummypara [5] = { 8, 0, 0, 0, 0 };
	PutPara ( dummypara, 5 );
}
//
// Add 'n' empty lines for current document
//
static void AddDummies ( int n )
{
	for ( ; n > 0; n-- )
		AddDummyPara ( );
}
//
// creates new document
//
static int CreateDoc ( int topic, const char *head )
{
	d = new NewDocument ( b, topic, (char*) head, currentRevision, PM_ZIP );
	if (!d || !d->IsOk()) {
		gllog.printfC(AdvLogger::LOG_ERROR,
					  AdvLogger::CD_KOI, 
					  "пЫЙВЛБ УПЪДБОЙС ДПЛХНЕОФБ %d.\n",
					  topic);
		return 1;
	}

	if (strlen(head))
#ifdef VERSION61
	{
		Ref rrr;
		rrr.DocId= d->DocId;
		rrr.Sub= 0;
		Stream *str=b->FindIndex("SubName")->Open(&rrr, 1);
		str->Write(head,strlen(head)+1);
		str->Trunc();
		b->FindIndex("SubName")->Close(str);
	}
#else
		b->docInd->Put(d->DocId, IDD_NAME, (char *)head, strlen(head)+1);
#endif

	return 0;
}

static void tm_to_date(const struct tm *t, date *d )
{
	d->da_day = t->tm_mday; 
	d->da_mon = t->tm_mon +1;
	d->da_year = t->tm_year + 1900;
}

static void date_to_tm(struct tm *t, const date *d )
{
	t->tm_sec=t->tm_min=t->tm_hour = 12;
	t->tm_wday = t->tm_yday = t->tm_isdst  = 0;
	t->tm_mday = d->da_day;
	t->tm_mon = d->da_mon - 1;
	t->tm_year = d->da_year - 1900;
}

int DayOfWeek ( const date *d )
{
	struct tm t;
	date_to_tm(&t,d);
	mktime(&t); // this should correct value of t.tm_wday
	return t.tm_wday;
}

static void DatePlus ( const date *d, date *ret, int n )
{
	struct tm t;
	date_to_tm(&t, d);

	time_t ts = mktime(&t);
	ts+=n*24*3600;
	tm_to_date(localtime(&ts), ret);
}

static int isDocsBetween(const date *start, const date *finish )
{
	DateIndex *di;
	for ( int i = 0; i < 5; i++ ){
		di=(DateIndex*) b->FindIndex(IndName[i]);
		DocCollection docs;
		GetCol(&docs, start, finish, di);
		if( docs.ItemCount )
		  return 1;
	}
	return 0;
}
void FillHotDates ( struct history_info *hi )
{
	int ni = 0;
	unsigned char end_of_week = 0;
	date hotdate;
	DateIndex *di;
	hotdate.da_year = hotdate.da_mon = hotdate.da_day = 0;
	int i, 	last_week = 5;

	for ( i = 4; i >= 0; i-- ) {
		di=(DateIndex*) b->FindIndex(IndName[i]);

		date dt; 
		// assume we're at "plus-range" time :)
		dt.da_year = dt.da_mon = dt.da_day = 0;
		for( BTIterator it(di); !it.End(); ++it ) {
			if ( i == 0 ) { //VIncluded
				date dt_ = *((date*) it.Key());
				if ( CompDates(&dt_, &hotdate) > 0 ) {
					Stream* str = di->Open( &dt_ );
					DocCollection vincludeds;
					if ( str ) {
						vincludeds.Get( str );
						di->Close(str);
					}

					DateIndex* di_anonce = (DateIndex*) b->FindIndex( "VAnonced" );
					for( BTIterator it_anonce(di_anonce); !it_anonce.End(); ++it_anonce ) {
						date anonce_date = *((date*) it_anonce.Key());;
						if ( CompDates( &dt_, &anonce_date ) > 0 ) {
							str = di_anonce->Open( &anonce_date );
							if ( str ) {
								DocCollection vanonceds;
								vanonceds.Get(str);
								di_anonce->Close(str);
								vincludeds.Minus( vanonceds );
							}
						}
					}
					if ( vincludeds.ItemCount ) {
						dt = dt_;
					}
				}
			} else {
				dt = *((date*) it.Key());
			}
		}

		if ( CompDates(&dt, &hotdate) > 0 )
			hotdate = dt;
	}

	if (hotdate.da_year == 0 || hotdate.da_mon == 0 || hotdate.da_day == 0)
		return;

	if ( DayOfWeek ( &hotdate ) == DEAD_LINE )
		end_of_week = 1;

	while ( DayOfWeek ( &hotdate ) != DEAD_LINE ) {
		DatePlus ( &hotdate, &hotdate, 1 );
	}

	// now hotdate is nearest saturday after last date
	/*
	 * well, let's decide whether we have some documents
	 * from sunday to friday
	 */
#undef DateMinus
#define DateMinus(a,b,c) DatePlus((a),(b),0-(c))

	date date_end; DateMinus(&hotdate, &date_end, 1); // friday
	date date_start; DateMinus(&hotdate, &date_start, 6); // sunday

	if( !end_of_week && isDocsBetween(&date_start, &date_end ) ) {
		// daily
		for( i = 0; i<7; i++ ) {
			DateMinus(&hotdate,&date_start, i );
			if( isDocsBetween(&date_start, &date_start ) ) {
				// note that GetCol returns _inclusive_
				hi->dates[ni].start = date_start;
				hi->dates[ni].end = date_start;
				ni ++;
				last_week = 6;
			}
		}
	} else {
		// weekly
		hi->dates[ni].end = hotdate;
		hi->dates[ni].start = date_start; // last sunday
		ni ++;
	}

	// apply last 5 weeks
	for( i = 1; i <= last_week; i++) {
		DateMinus(&hotdate,&hi->dates[ni].start, (i+1)*HISTORY_INTERVAL-1);
		DateMinus(&hotdate,&hi->dates[ni].end, i*HISTORY_INTERVAL);
		ni ++;
	}
	hi->hitems=ni;
}

revision	magic_date;

int MakeTrashTopic(struct history_info *hi)
{
	gk_bzero (&magic_date, sizeof (magic_date));
	magic_date.RevisionDate.da_year= 2013;
	magic_date.RevisionDate.da_mon = 4;
	magic_date.RevisionDate.da_day = 6;

	if (hi->hitems == 0)
		return 0;

	GlTopicsMap::iterator it = gltopics->insert( GlTopicsMap::value_type( NEWMENU, RefsTopic() )).first;
	GlRefNames::iterator names = glrefnames->insert( GlRefNames::value_type( NEWMENU, RefNamesList() )).first;

	int i, j;
	for ( i = 0; i < hi->hitems; i++ ) {
		date hds, hde;
		hds = hi->dates[i].start;
		hde = hi->dates[i].end;
		if( CompDates(&hds, &hde) == 0 ){
			DateMinus(&hde,&hds,1);
		}

		RefsVector singleref;
		Ref aRef = { next+i, 0 };
		singleref.push_back( aRef );
		it->second.push_back( singleref );

		char para[ 256 ];

		revision hde_revision;
		gk_bzero (&hde_revision, sizeof (hde_revision));
		hde_revision.RevisionDate = hde;

		long days_from_magic_date = rev_daysdiff (hde_revision, magic_date);
		long class6_newdocs_prefix = 999 - days_from_magic_date;
		if (class6_newdocs_prefix < 0 || class6_newdocs_prefix > 999)
			class6_newdocs_prefix = i;

		sprintf( para, "%03d=%s %02d/%02d/%04d %s %02d/%02d/%04d", class6_newdocs_prefix, sDocInc1, hds.da_day, hds.da_mon, hds.da_year, sDocInc2, hde.da_day, hde.da_mon, hde.da_year );
		names->second.push_back( para );
	}
	
	next2=next+i;

	for ( i = 0; i < hi->hitems; i++ ) {
		date hds, hde;
		hds = hi->dates[i].start;
		hde = hi->dates[i].end;
		if( CompDates(&hds, &hde) == 0 ){
			// advance start one day before
			DateMinus(&hde,&hds,1);
		}
		it = gltopics->insert( GlTopicsMap::value_type( next+i, RefsTopic() )).first;
		GlRefNames::iterator names = glrefnames->insert( GlRefNames::value_type( next+i, RefNamesList() )).first;

		int ch;
		for ( ch = j = 0; j < 5; j++ ) {
			DateIndex *di = (DateIndex*) b -> FindIndex ( IndName [j] );
			if (!di || !di->IsOk()) {
				gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "пЫЙВЛБ ТБВПФЩ У ЙОДЕЛУПН %s.\n", IndName[j]);
				return 1;
			}

			DocCollection docs;
			if ( b_english_base ) {
				if (GetCol(&docs, &hi->dates[i].start, &hi->dates[i].end, di))
					return 1;
			} else {
				if ( j != 3 && j != 4 ) {
					GetCol(&docs, &hi->dates[i].start, &hi->dates[i].end, di);
					if ( j == 0 ) {
						//сначала надо ушибить тех, у которых есть VANONCED
						for ( int aDoc = 0; aDoc < docs.ItemCount; ) {
							long lDocId = docs[ aDoc ];
							long anSize;
							date* anonce = (date*) b->LoadAttr( lDocId, IDD_VANONCED, anSize );
							if ( anSize ) {
								//есть VANONCED. если он в пределах hds..hde, то оставить
								if ( CompDates( anonce, &hds ) < 0 || CompDates( anonce, &hds ) >= 0 )
									docs.atDelete(aDoc);
								else
									aDoc++;
								gk_free( anonce );
							}
							else
								aDoc++;
						}
						docs.Compact ();

						DocCollection docs2;
						di = (DateIndex*) b -> FindIndex ( IndName [3] );
						GetCol(&docs2, &hi->dates[i].start, &hi->dates[i].end, di);
						docs.Merge(docs2);
					}
				}
			}

			if ( docs.ItemCount ) {
				RefsVector vrefs;
				for ( int ii = 0; ii < docs.ItemCount; ii++ ) {
					Ref atii = { docs[ii], 0 };
					vrefs.push_back( atii );
				}
				it->second.push_back( vrefs );

				names->second.push_back( revstatus[j] );

				ch++;
			}
		}
	}
	next = next2;
	return 0;
}

#undef DateMinus

static int GetCol (DocCollection *docs, const date *start, const date *finish, DateIndex * dI )
{
	for ( BTIterator it ( dI, (date*) start ); !it.End ( ); ++it ) {
		date	*key = (date*) it.Key ( );

		if ( dI -> Compare ( key, (date*) finish ) > 0 )
			return 0;

		Stream	*str = dI -> Open ( key );
		if (!str) {
			gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
				"пЫЙВЛБ ПФЛТЩФЙС РПФПЛБ.\n");
			return 1;
		}
		u_int32_tSplaySet * tdocs = readDocs(str);
		dI -> Close ( str );

		if (!tdocs->length()) {
			gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
						  "нОПЦЕУФЧП ДПЛХНЕОФПЧ РХУФП.\n");
			return 1;
		}

		(*tdocs) &= (*onlyDocs);

		if (!tdocs->length()) {
			gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
						  "пЫЙВЛБ РЕТЕУЕЮЕОЙС НОПЦЕУФЧ.\n");
			return 1;
		}

		for (Pix pix2 = tdocs->first(); pix2; tdocs->next(pix2))
			docs->Add((*tdocs)(pix2));
		delete tdocs;
	}
	return 0;
}

static int CheckFederal(short *belongs, int count)
{
	for(int i=0; i < count; i++)
		if (
			(belongs[i] <= 18) || 
			(belongs[i] == 20) || 
			(belongs[i] == 26) || 
			(belongs[i] == 28) || 
			(belongs[i] == 29) || 
			(belongs[i] == 30) || 
			(belongs[i] == 36) || 
			(belongs[i] == 38) || 
			(belongs[i] == 199) || 
			(belongs[i] == 206) || 
			(belongs[i] == 207) || 
			(belongs[i] == CLASSIC_SEGMENT) || 
			(belongs[i] == DICTIONARY_SEGMENT) || 
			(belongs[i] == DICTIONARY_SEGMENT_SML)
		   ) return 1;

	return 0;
}

static int AddParaWithList(char *title, char *para, DocCollection *docs, int type, int dir, int call)
{
	if ( docs -> ItemCount )
	{
		int icount = docs -> ItemCount;

		if( (unsigned) icount > NEW_MAX_MULTI - (80/sizeof(Ref)) )
		{
			if (call == FIRST_CALL)
			{
				DocCollection federal;
				DocCollection other;

				for(int i=0; i < icount; i++)
				{
					long	docID = (*docs)[i];
					short	belongs[MAX_BASES];
					int		count = b->FindDocAttr(docID,IDD_BASES,belongs,sizeof(belongs))/sizeof(short);

					if (CheckFederal(belongs,count) == 1)
					{
						federal.Add(docID);
					}
					else
					{
						other.Add(docID);
					}
				}

				if ((federal.ItemCount == 0) || (other.ItemCount == 0))
				{
					goto fast_part;
				}

				NewDocument *d_save;
				
				d_save=d;

				if (CreateDoc(next2,title))
				{
					d=d_save;
					return 1;
				}
				unsigned docID = next2;

				next2++;

				AddDummies(7);

				char	*sub_para = (char*)malloc(MAX_PARA_LEN);
				if (!sub_para) 
				{
					gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оЕФ РБНСФЙ ДМС РБТБЗТБЖБ.\n");
					return 1;
				}

				memset(sub_para,' ',128);

				sub_para[sprintf(sub_para,"     \4 %s", sFederalDocs)]=' ';
				sub_para[5+72+1]=4;

				if (AddParaWithList((char *)sFederalDocs,sub_para,&federal,BY_PRIOR,1,PART_CALL) == LOCAL_ERROR)
				{
					free(sub_para);
					delete d;
					d=d_save;
					return LOCAL_ERROR;
				}

				AddDummyPara();

				memset(sub_para,' ',128);

				sub_para[sprintf(sub_para,"     \4 %s", sOtherDocs)]=' ';
				sub_para[5+72+1]=4;

				if (AddParaWithList((char *)sOtherDocs,sub_para,&other,BY_PRIOR,1,PART_CALL) == LOCAL_ERROR)
				{
					free(sub_para);
					delete d;
					d=d_save;
					return LOCAL_ERROR;
				}

				free(sub_para);
				delete d;
				d=d_save;

				para[79]=REFTYPE_REFLIST;

				*(unsigned short*)(para+80)=0;
				*(long *)(para+82)=docID;
				*(long *)(para+86)=0;

				PutPara(para,82+sizeof(Ref));

				return 1;
			} else 
			if (call == PART_CALL)
			{
fast_part:
				int part = 1;
				int pcount = NEW_MAX_MULTI - (80/sizeof(Ref));

				DocCollection parts;

				NewDocument *d_save;
				
				d_save=d;

				if (CreateDoc(next2,title))
				{
					d=d_save;
					return 1;
				}
				unsigned docID = next2;

				next2++;

				AddDummies(7);

				char	*sub_para = (char*)malloc(MAX_PARA_LEN);
				if (!sub_para) 
				{
					gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оЕФ РБНСФЙ ДМС РБТБЗТБЖБ.\n");

					delete d;
					d=d_save;
					return 1;
				}

				char	*sub_title = (char*)malloc(SUB_NAME_SIZE+1);
				if (!sub_title) 
				{
					gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оЕФ РБНСФЙ ДМС РБТБЗТБЖБ.\n");

					free(sub_para);
					delete d;
					d=d_save;
					return 1;
				}

				for(int i=0;i<icount;i++)
				{
					parts.Add((*docs)[i]);
					pcount--;

					if (pcount == 0)
					{
						sprintf(sub_title,sPart,part);

						memset(sub_para,' ',128);

						sub_para[sprintf(sub_para,"     \4 %s", sub_title)]=' ';
						sub_para[5+72+1]=4;

						if (AddParaWithList(sub_title,sub_para,&parts,BY_PRIOR,1,LAST_CALL) == LOCAL_ERROR)
						{
							free(sub_title);
							free(sub_para);
							delete d;
							d=d_save;
							return LOCAL_ERROR;
						}

						AddDummyPara();

						parts.FreeAll();

						part++;
						pcount = NEW_MAX_MULTI - (80/sizeof(Ref));
					}
				}

				if (parts.ItemCount != 0)
				{
					sprintf(sub_title,sPart,part);

					memset(sub_para,' ',128);

					sub_para[sprintf(sub_para,"     \4 %s", sub_title)]=' ';
					sub_para[5+72+1]=4;

					if (AddParaWithList(sub_title,sub_para,&parts,BY_PRIOR,1,LAST_CALL) == LOCAL_ERROR)
					{
						free(sub_title);
						free(sub_para);
						delete d;
						d=d_save;
						return LOCAL_ERROR;
					}

					AddDummyPara();

					parts.FreeAll();
				}

				free(sub_title);
				free(sub_para);
				delete d;
				d=d_save;

				para[79]=REFTYPE_REFLIST;

				*(unsigned short*)(para+80)=0;
				*(long *)(para+82)=docID;
				*(long *)(para+86)=0;

				PutPara(para,82+sizeof(Ref));

				return 1;
			}
		}

		para[79] = REFTYPE_REFLIST;
		*(unsigned short*) ( para + 80 ) = icount;
		int i;
		for ( i = 0; i < icount; i++ )
		{
			*(long *) ( para + 82 + i * sizeof ( Ref ) ) = (*docs) [i];
			*(long *) ( para + 86 + i * sizeof ( Ref ) ) = 0;
		}

		if (SortRefs((Ref*)(para+82), icount, type, dir)) {
			return LOCAL_ERROR;
		}

		PutPara ( para, 82 + i * sizeof ( Ref ) );
		return 1;
	}
	return 0;
}

int isHereValid(short *here,int count,short key)
{
	for(int i=0;i<count;i++){
		if (here[i] == key) {
			return 1;
		}
	}
	return 0;
}

static int  defineInfoTopics()
{
	BaseInfo *bases = 0;
	size_t l;

	Stream *str = auxInd->Open("Base");
	l = str->Length();
	if( !l )
	{
		if (!bIsBreeder)
		{
			gllog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,
				"пФУХФУФЧХЕФ ЙОЖПТНБГЙС П ВБЪБИ.\n");
		}
		auxInd->Close(str);
		return 1;
	}
	if( l % sizeof(BaseInfo) )
	{
		if (!bIsBreeder)
		{
			gllog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,
				"йОЖПТНБГЙС П ВБЪБИ ЙУРПТЮЕОБ.\n");
		}
	}

	int nitems = l / sizeof(BaseInfo);
	if( !nitems ){
		gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
					  "пЫЙВЛБ ЮФЕОЙС ЙОЖПТНБГЙЙ П ВБЪЕ.\n");
		auxInd->Close(str);
		return 1;
	}
	bases = new BaseInfo[nitems];
	str->Read(bases, nitems * sizeof(BaseInfo));
	auxInd->Close(str);
	long  *splash_topics = new long [nitems];
	long  *banner_topics = new long [nitems];
	int	splash_n=0;
	int	banner_n=0;

#ifdef	EXTENDED_USERINFO
	if ( b->FindDoc( 65776 ))
		userinfo_topics[ userinfo_n++ ] = 65776 + ID_BORDER;
#endif

	for( int i=0; i< nitems; i++ ){
		if((bases[i].BaseId) && (isHereValid(heres,hcount,bases[i].BaseId))){
			if( bases[i].SplashTopic ){
				int thereis = 0;
				for( int j=0; j<splash_n && !thereis; j++){
					thereis = splash_topics[j] == bases[i].SplashTopic;
				}
				if( !thereis ){
					splash_topics[ splash_n++] = bases[i].SplashTopic;
				}
			}
			if( bases[i].BannerTopic ){
				int thereis = 0;
				for( int j=0; j<banner_n && !thereis; j++){
					thereis = banner_topics[j] == bases[i].BannerTopic;
				}
				if( !thereis ){
					banner_topics[ banner_n++] = bases[i].BannerTopic;
				}
			}
		}
	}
	if (makeSplashData(splash_topics, splash_n))
		return 1;
	if (makeBannerData(banner_topics, banner_n))
		return 1;
	delete bases;
	delete splash_topics;
	delete banner_topics;
	return 0;
}

static int makeSplashData(long *tpcs, int nitems)
{
	const char *key = AUX_SPLASH;
	if (nitems == 0)
	{
		auxInd -> Delete ( key );	// delete all previous data
		return 0;
	}
	Stream *str = auxInd -> Open ( key, 1 );
	if (!str) {
		gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
					  "пЫЙВЛБ ПФЛТЩФЙС РПФПЛБ.\n");
		return 1;
	}
	str    -> Write ( &(*tpcs), nitems*sizeof(long) );
	str->Trunc ();
	auxInd -> Close ( str );
	return 0;
}

static int makeBannerData(long *tpcs, int nitems)
{
	const char *key = AUX_BANNERS;
	if (nitems == 0) {
		auxInd -> Delete ( key );	// delete all previous data
		return 0;
	}
	Stream *str = auxInd -> Open ( key, 1 );
	if (!str) {
		gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "пЫЙВЛБ ПФЛТЩФЙС РПФПЛБ.\n");
		return 1;
	}
	str    -> Write ( &(*tpcs), nitems*sizeof(long) );
	str->Trunc ();
	auxInd -> Close ( str );
	return 0;
}

static int CollectInfo ( void )
{
	SortedCollection BaseCol( sizeof( BaseInfo ), 5 );

	Stream *str = auxInd -> Open( "Base" );
	if (!str) {
		gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оЕФ ЙОЖПТНБГЙЙ П ВБЪБИ.\n");
		return 1;
	}

	if (!BaseCol.Get(str)) {
		gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "пЫЙВЛБ ЮФЕОЙС УРЙУЛБ ВБЪ.\n");
		return 1;
	}

	for ( long i = 0; i < BaseCol.ItemCount; i++) {
		BaseInfo *temp = (BaseInfo *)BaseCol[i];
		if (!temp->BaseId)
			BaseCol.Delete(temp);
		else
		if ( temp->BaseId == ANNO_SEGMENT)
			temp->CommonDocCount = annos_count;
		else
		if ( temp->BaseId == DICTIONARY_SEGMENT)
			temp->CommonDocCount = bigdic_count;
		else
		if ( temp->BaseId == DICTIONARY_SEGMENT_SML)
			temp->CommonDocCount = smldic_count;
	}
	BaseCol.Insert (&SuperBase);
	str->Seek (0);
	BaseCol.Put (str);
	auxInd->Close (str);
	return 0;
}

int findbidcmp(const void *key, const void *rec)
{
	if (*((u_int16_t *)key) > ((BaseInfo *)rec)->BaseId) return 1;
	if (*((u_int16_t *)key) < ((BaseInfo *)rec)->BaseId) return -1;
	return 0;
}

void fillSuperName()
{
	Stream *biStr, *compStr;
	int bicount;
	BaseInfo *bi, *hbi;
	int i;
	
	SuperBase.Weight = 0;
	biStr = auxInd->Open("Base");
	bicount = biStr->Length()/sizeof(BaseInfo);
	bi = (BaseInfo *)malloc(biStr->Length());
	biStr->Read(bi, sizeof(BaseInfo));
	
	// Leave the user-defined name unchanged
	// But calculate the weight of base
	if (bi->BaseId == 0 && bi->UserName) { 
		strcpy(SuperBase.Name, bi->Name);
		strcpy(SuperBase.NameEng, bi->NameEng);
		SuperBase.UserName = 1;
	}
	else { // Name isn't user-defined
		SuperBase.UserName = 0;
	}

	if(!bi->BaseId) { // Skip 0' BaseInfo (old Super BaseInfo)
		bicount--;
		biStr->Read(bi, bicount*sizeof(BaseInfo));
	}
	else biStr->Read(bi+1, (bicount-1)*sizeof(BaseInfo));
	auxInd->Close(biStr);

	// If only 1 segment => move it's name to SuperBase name
	if (hcount == 1) {
		hbi = (BaseInfo *)bsearch(heres, bi, bicount, sizeof(BaseInfo), findbidcmp);
		if (!hbi) { // No appropriate BaseInfo : ERROR
			gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
				"пФУХФУФЧХЕФ УФТХЛФХТБ ДМС ВБЪЩ %d.\n", *heres);
			exit(-5);
		}
		else {
			if (!SuperBase.UserName) {
				strcpy(SuperBase.Name, hbi->Name);
				strcpy(SuperBase.NameEng, hbi->NameEng);
			}
			SuperBase.Weight = hbi->Weight;
		}
	}
	// More than 1 segment : 
	// calc weight and assign the appropriate name if necessary
	else { 
		for(i=0; i<hcount; i++) { // SuperBase weight calc...
			hbi = (BaseInfo *)bsearch(heres+i, bi, bicount, sizeof(BaseInfo), findbidcmp);
			if (!hbi) { // No appropriate BaseInfo : ERROR
				gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
					"пФУХФУФЧХЕФ УФТХЛФХТБ ДМС ВБЪЩ %d.\n", heres[i]);
				exit(-5);
			} else {
				SuperBase.Weight += hbi->Weight;
			}
		}
		if (!SuperBase.UserName) { // And new name search & assign...
			compStr = auxInd->Open("Comp");
			BaseWeight *wts = (BaseWeight *)malloc(compStr->Length());
			compStr->Read(wts, compStr->Length());
			bicount = compStr->Length()/sizeof(BaseWeight);
			auxInd->Close(compStr);

			for(i=0; i<bicount && SuperBase.Weight > wts[i].max; i++);

			short foundFAS = 0;
			short FASIDs[] = { 1,19,72,73,74,100,102,124,130,134,140 };
			if ( ( SuperBase.Weight > 39 && SuperBase.Weight < 300 ) || ( SuperBase.Weight > 1039 && SuperBase.Weight < 1070 )) {
				// если по весу - Максимум, есть федеральный сегмент (ЗаквоРоссии == 1) и все ФАСы
				// то это ГАРАНТ-Максимум. Практика ФАС округов
				for ( short ii = 0; ii < hcount; ii++ ) {
					for ( short j = 0; j < sizeof( FASIDs ) / sizeof( short ); j++ )
						if ( heres[ ii ] == FASIDs[ j ] ) {
							foundFAS++;
							break;
						}
				}
			}

			bool foundAnno = false;
			for ( short ii = 0; ii < hcount && !foundAnno; ii++ )
				if ( heres[ ii ] == ANNO_SEGMENT )
					foundAnno = true;

			if ( foundFAS == sizeof( FASIDs ) / sizeof( short )) {
				if ( SuperBase.Weight > 1000 ) {
#ifdef	WINENCODE
					strcpy(SuperBase.Name, "ГАРАНТ-СтройМаксимум. Практика ФАС округов" );
					if ( foundAnno ) strcat(SuperBase.Name, ". ПРАЙМ" );
#else
					strcpy(SuperBase.Name, "ѓЂђЂЌ’-‘ва®©Њ ЄбЁ¬г¬. Џа ЄвЁЄ  ”Ђ‘ ®ЄагЈ®ў" );
#endif
					strcpy(SuperBase.NameEng, "Garant-Maximum. Construction. Cases of the Federal Arbitration Courts" );
				} else {
#ifdef	WINENCODE
					strcpy(SuperBase.Name, "ГАРАНТ-Максимум. Практика ФАС округов" );
					if ( foundAnno ) strcat(SuperBase.Name, ". ПРАЙМ" );
#else
					strcpy(SuperBase.Name, "ѓЂђЂЌ’-Њ ЄбЁ¬г¬. Џа ЄвЁЄ  ”Ђ‘ ®ЄагЈ®ў" );
#endif
					strcpy(SuperBase.NameEng, "GARANT-Maximum. Cases of the Federal Arbitration Courts of the Regions" );
				}
			} else {
				strcpy(SuperBase.Name, wts[i].name);
#ifdef	WINENCODE
				if ( foundAnno && SuperBase.Weight < 1070 ) strcat(SuperBase.Name, ". ПРАЙМ" );
#endif
				strcpy(SuperBase.NameEng, wts[i].nameEng);
			}
			free(wts);
		}
	}
	free(bi);
}

#ifdef	WINENCODE
#define STR_ASSIGN(v, s) \
	{ v = strdup(s); \
	for (unsigned int i_MACRO_STR_ASSIGN = 0; v[i_MACRO_STR_ASSIGN]; \
                                             i_MACRO_STR_ASSIGN++) \
	((unsigned char*)v)[i_MACRO_STR_ASSIGN]=Koi2Dos[((unsigned char *)v)\
                                                [i_MACRO_STR_ASSIGN]];\
	Recoding(cd_dos,cd_win,(char*)v); }
#else
#define STR_ASSIGN(v, s) \
	{ v = strdup(s); \
	for (unsigned int i_MACRO_STR_ASSIGN = 0; v[i_MACRO_STR_ASSIGN]; \
                                             i_MACRO_STR_ASSIGN++) \
	((unsigned char*)v)[i_MACRO_STR_ASSIGN]=Koi2Dos[((unsigned char *)v)\
                                                [i_MACRO_STR_ASSIGN]];}
#endif


#define CHECK_OK(a) \
	if (a) { \
		result_code = 1; \
		pscreen->CloseScreen();\
		return result_code;\
	} 

Base* aBase;
HIndex* aClass6;

int	ProcessGlTopic( long aTopic, long parent, char level, const char* aKeyText, long &aId, bool b_newdocs = false)
{
	HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)alloca(512);
	char aNewText[BLOCK_SIZE]; aNewText[0] = 0;
	RefCollection aRefs;

	strncpy(aKey->text,aKeyText,CLASS_KEY_SIZE-1);
	aKey->text[CLASS_KEY_SIZE-1] = 0;
	aKey->id=aId;
	aKey->level=level;
	aKey->parent=parent;
	aKey->chCount=aKey->achCount=0;

	bool	anythingAdded = false;

	RefsTopic paras = gltopics->find(aTopic)->second;
	RefsTopic::iterator para = paras.begin();
	RefNamesList names = glrefnames->find(aTopic)->second;
	RefNamesList::iterator name = names.begin();

	for ( ; para != paras.end(); para++, name++ ) {
		RefsVector atpara = *para;
		aId++;

		short aRefCount = atpara.size();
		if ( !aRefCount ) {
			continue;
		}

		long at0 = atpara.begin()->DocId;
		if (b_newdocs && (name->c_str () [3] == '=')) {
			sprintf(aNewText,"%s",name->c_str());
			++aKey->chCount;
		} else {
			sprintf(aNewText,"%03d=%s",++aKey->chCount,name->c_str());
		}

		if ( aRefCount == 1 && ( at0 < ID_BORDER && at0 > 0 )) {
			u_int32_t chCount = ProcessGlTopic(at0,aKey->id,aKey->level+1,aNewText,aId, b_newdocs);
			if ( chCount ) {
				aKey->achCount += chCount + 1;
				anythingAdded = true;
			}
			else
				aKey->chCount--;
		} else {
			//мультиссылка или уже не glный топик
			aKey->achCount++;

			HIndex::HIndexKey* aLastKey = (HIndex::HIndexKey*)alloca(512);
			strncpy( aLastKey->text, aNewText,CLASS_KEY_SIZE-1 );
			aLastKey->text[CLASS_KEY_SIZE-1] = 0;
			aLastKey->level = level+1;
			aLastKey->id = aId;
			aLastKey->parent = aKey->id;
			aLastKey->chCount=aLastKey->achCount=0;

			RefsVector::iterator aRef = atpara.begin();
			for ( ; aRef != atpara.end(); aRef++ ) {
				Ref atRef = *aRef;
				aRefs.Collection::Add(&atRef);
			}

			Stream* str = aClass6->Index::OpenN(aLastKey,0,1);
			aRefs.Put(str);
			aClass6->Close(str);

			aRefs.FreeAll();
			anythingAdded = true;
		}
	}

	if ( anythingAdded ) {
		Ref aRef; aRef.DocId=aTopic; aRef.Sub = 0;
		aRefs.Collection::Add(&aRef);
		Stream* str = aClass6->Index::OpenN(aKey,0,1);
		aRefs.Put(str);
		aClass6->Close(str);
	}

	return aKey->achCount;
}

int	ProcessTopic( long aTopic, long parent, char level, char* aKeyText, long &aId )
{
	HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)alloca(512);
#ifdef	VERSION63
	char aText[ADD_BLOCK_SIZE], aNewText[ADD_BLOCK_SIZE];
#else
	char aText[BLOCK_SIZE], aNewText[BLOCK_SIZE];
#endif
	RefCollection aRefs;

	strncpy(aKey->text,aKeyText,CLASS_KEY_SIZE-1);
	aKey->text[CLASS_KEY_SIZE-1] = 0;
	aKey->id=aId;
	aKey->level=level;
	aKey->parent=parent;
	aKey->chCount=aKey->achCount=0;

	bool	anythingAdded = false;

	Document* aDoc = aBase->GetDoc(aTopic);
	for ( int I = 0; I < aDoc->Stat.ParaCount; I++ ) {
		char* ptr = aDoc -> GetPara( I );
		if ( !ptr || !TextSize(ptr) ) continue;

		ptr = ParaText( ptr );
		gk_bzero(aText,sizeof(aText));

		aId++;
		if (!strchr(ptr+1,4)) {
			//За этот период никаких изменений не было
			continue;
		}

		char* aSpace;
		for ( aSpace = ptr + 1; *aSpace == ' '; aSpace++ ) ;
		sprintf(aNewText,"%03d=%s",++aKey->chCount,strncpy(aText,aSpace,strchr(aSpace,4)-aSpace));
		for ( aSpace = &aNewText[ strlen( aNewText ) - 1 ]; *aSpace == ' '; aSpace-- ) *aSpace = '\0';
		//в aNewText - имя нового ключа. Он может быть как вложенным, так и конечным

		ptr=strchr(strchr(ptr,4)+1,4)+2;
		short aRefCount = GetHTRefCount(*(short*)ptr);
		ptr+=2;
		if ( aRefCount == 1 && ((Ref*)ptr)->DocId < ID_BORDER && ((Ref*)ptr)->DocId > 0 ) {
			u_int32_t chCount = ProcessTopic(((Ref*)ptr)->DocId,aKey->id,aKey->level+1,aNewText,aId);
			if ( chCount ) {
				aKey->achCount += chCount + 1;
				anythingAdded = true;
			}
			else
				aKey->chCount--;
		} else {
			if ( aRefCount == 1 && ((Ref*)ptr)->DocId == -6 ) {
				aKey->chCount--;
				continue; // ежедневно новые документы на www.garant.ru
			}

			//мультиссылка или уже не glный топик
			aKey->achCount++;

			HIndex::HIndexKey* aLastKey = (HIndex::HIndexKey*)alloca(512);
			strncpy( aLastKey->text, aNewText,CLASS_KEY_SIZE-1 );
			aLastKey->text[CLASS_KEY_SIZE-1] = 0;
			aLastKey->level = level+1;
			aLastKey->id = aId;
			aLastKey->parent = aKey->id;
			aLastKey->chCount=aLastKey->achCount=0;
			for ( int aRef = 0; aRef < aRefCount; aRef++, ptr += sizeof( Ref ) )
				aRefs.Collection::Add(ptr);

			Stream* str = aClass6->Index::OpenN(aLastKey,0,1);
			aRefs.Put(str);
			aClass6->Close(str);

			aRefs.FreeAll();
			anythingAdded = true;
		}
	}
	delete aDoc;

	if ( anythingAdded ) {
		Ref aRef; aRef.DocId=aTopic; aRef.Sub = 0;
		aRefs.Collection::Add(&aRef);
		Stream* str = aClass6->Index::OpenN(aKey,0,1);
		aRefs.Put(str);
		aClass6->Close(str);
	}

	return aKey->achCount;
}

void	CreateNode( long aId, long parent, char level, const char* aKeyText, long chCount, long achCount )
{
	HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)alloca(512);
	RefCollection aRefs;

	strncpy(aKey->text,aKeyText,CLASS_KEY_SIZE-1);
	aKey->text[CLASS_KEY_SIZE-1] = 0;
	aKey->id=aId;
	aKey->level=level;
	aKey->parent=parent;
	aKey->chCount=chCount;
	aKey->achCount=achCount;

	Stream* str = aClass6->Index::OpenN(aKey,0,1);
	aRefs.Put(str);
	aClass6->Close(str);
}

long	FindAux( char* aKey )
{
	ContextIndex* ind = (ContextIndex*) aBase->FindIndex( "Aux" );
	Stream* str = ind -> Open( aKey );
	if ( str == 0 )
		return 0L;

	long aDocId;
	long size = str->Length();
	if ( str -> Read( &aDocId, sizeof( aDocId )) < sizeof( aDocId ))
		aDocId = 0;

	ind -> Close( str );
	return aDocId;
}

long	CreateAuxNode( char* aAuxKey, long& aId, long parent, char level, char* aKeyText )
{
	long aDocId = FindAux( aAuxKey );
	if ( !aDocId || !aBase->FindDoc( aDocId ))
		return 0;

	aId++;

	HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)alloca(512);
	RefCollection aRefs;
	Ref aRef; aRef.DocId = aDocId; aRef.Sub = 0;
	aRefs.Collection::Add(&aRef);

	aKey->id=aId;
	aKey->level=level;
	aKey->parent=parent;
	strncpy(aKey->text,aKeyText,CLASS_KEY_SIZE-1);
	aKey->text[CLASS_KEY_SIZE-1] = 0;

	if ( aDocId < ID_BORDER ) {
		return ProcessTopic(aDocId,parent,level,aKeyText,aId);
	} else {
		aKey->chCount=aKey->achCount=0;
		Stream* str = aClass6->Index::OpenN(aKey,0,1);
		aRefs.Put(str);
		aClass6->Close(str);
		return 1;
	}
}

long	ProcessServiceInfo (long& aId, long parent, char level, long& si_children, long keys_on_level0, long keys_in_class)
{
	Index* idx = aBase->FindIndex ("ServiceInfo");

	std::map<long,long> map_id_id;
	map_id_id.insert (std::map<long,long>::value_type (0, parent));

	long hack_id = 0;
	if (b_english_base) {
		std::string eta_key = "001=Quick Reference\\002=Legal Guide";
		HIndex::HIndexKey *key_to_hack = (HIndex::HIndexKey*) idx->FullKey (eta_key.c_str ());
		if (key_to_hack)
			hack_id = key_to_hack->id;
	}

	long new_id = aId+1;
	BTIterator it (idx);
	for (; !it.End (); ++it) {
		HIndex::HIndexKey* aKey = (HIndex::HIndexKey*) it.Key();
		if (!aKey->level) si_children++;
		map_id_id.insert (std::map<long,long>::value_type (aKey->id, new_id));
		new_id++;
	}

	it.Set (0);
	HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)alloca(512);
	for (; !it.End (); ++it) {
		aId++;
		HIndex::HIndexKey* siKey = (HIndex::HIndexKey*) it.Key();

		aKey->id = map_id_id.find (siKey->id)->second;
		aKey->level = level + siKey->level;
		strcpy (aKey->text, siKey->text);
		if (siKey->id == hack_id) {
			aKey->chCount = keys_on_level0;
			aKey->achCount = keys_in_class;
		} else {
			aKey->chCount = siKey->chCount;
			aKey->achCount = siKey->achCount;
		}
		aKey->parent = map_id_id.find (siKey->parent)->second;

		RefCollection aRefs;
		Stream* str = idx->Index::OpenN (siKey,0);
		if (str) {
			aRefs.Get (str);
			idx->Close (str);
		}

		str = aClass6->Index::OpenN(aKey,0,1);
		if (str) {
			aRefs.Put(str);
			aClass6->Close(str);
		}
	}

	return map_id_id.size ()-1;
}

long	ProcessClass (long& aId, long& cl_children)
{
	DocCollection *alldocs = aBase->AllDocs ();
	Index* idx = aBase->FindIndex ("Class");

	std::map<long,long> map_id_id;
	map_id_id.insert (std::map<long,long>::value_type (0, 1));

	BTIterator it (idx);
	RefCollection aRefs;
	HIndex::HIndexKey* aKey = (HIndex::HIndexKey*) alloca (aClass6->KeyLength);
	for (long new_id = ++aId; !it.End (); ++it, new_id++, aId++) {
		HIndex::HIndexKey* classKey = (HIndex::HIndexKey*) it.Key();

		aKey->id = new_id;
		aKey->parent = map_id_id.find (classKey->parent)->second;
		aKey->level = 1 + classKey->level;
		strcpy (aKey->text, classKey->text);
		aKey->chCount = classKey->chCount;
		aKey->achCount = classKey->achCount;

		Stream* str = idx->Index::OpenN (classKey,0);
		if (str) {
			aRefs.Get (str);
			idx->Close (str);
		}

		long saved = aClass6->KeyCount;
		str = aClass6->Index::OpenN (aKey, 0, 1);
		long correct_id = aKey->id;
		if (str) {
			correct_id = ((HIndex::HIndexKey*) str->IndexBuf)->id;
			aRefs.Intersect (alldocs);
			aRefs.InheritPress ();
			aRefs.Put(str);
			aClass6->Close(str);
		}
		if (aClass6->KeyCount == saved)
			aClass6->KeyCount++;
		 
		map_id_id.insert (std::map<long,long>::value_type (classKey->id, correct_id));

		if (1 == aKey->level) cl_children++;
	}

	delete alldocs;
	return map_id_id.size ()-1;
}

void ProcessClass (long& aId, long parent, char level)
{
	Index* idx = aBase->FindIndex ("Class");

	std::map<long,long> map_id_id;
	map_id_id.insert (std::map<long,long>::value_type (0, parent));

	long new_id = aId+1;
	BTIterator it (idx);
	for (; !it.End (); ++it) {
		HIndex::HIndexKey* aKey = (HIndex::HIndexKey*) it.Key();
		map_id_id.insert (std::map<long,long>::value_type (aKey->id, new_id));
		new_id++;
	}

	it.Set (0);
	HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)alloca(512);
	for (; !it.End (); ++it) {
		aId++;
		HIndex::HIndexKey* classKey = (HIndex::HIndexKey*) it.Key();

		aKey->id=map_id_id.find (classKey->id)->second;
		aKey->level=level + classKey->level;
		strcpy (aKey->text, classKey->text);
		aKey->chCount = classKey->chCount;
		aKey->achCount = classKey->achCount;
		aKey->parent = map_id_id.find (classKey->parent)->second;

		RefCollection aRefs;
		Stream* str = idx->Index::OpenN (classKey,0);
		if (str) {
			aRefs.Get (str);
			aRefs.InheritPress ();
			idx->Close (str);
		}

		str = aClass6->Index::OpenN(aKey,0,1);
		if (str) {
			aRefs.Put(str);
			aClass6->Close(str);
		}
	}
}

enum SetLicenceCode { 
	gl_PL_OK = 0, gl_PL_INVARG = -1, gl_PL_INVDB = -2, gl_PL_PUTATTR = -3, gl_PL_EXCPT = -4 
};

const unsigned long gl_SI_LEGACY_STORAGE = 1;
const unsigned long gl_SI_PROFILE_STORAGE = 2;

const unsigned long gl_CI_TOPIC = (gl_SI_LEGACY_STORAGE << 16) | 1;
const unsigned long gl_CI_BLOB = (gl_SI_LEGACY_STORAGE << 16) | 2;
const unsigned long gl_CI_GROUP = (gl_SI_PROFILE_STORAGE << 16) | 0;
const unsigned long gl_CI_USER = (gl_SI_PROFILE_STORAGE << 16) | 1;

const unsigned long gl_AI_GET_FULL_ATTRIBUTES = 102;
const unsigned long gl_AI_GET_PARAGRAPH_TEXT = 101;
const unsigned long gl_AI_GET_OBJECT_STREAM = 201;
const unsigned long gl_AI_ADMINISTRATOR = 500;
const unsigned long gl_AI_CHANGE_IDLE_TIMEOUT = 302;

const char* gl_ATTR_NAME_MAX_USERS			= "MU"; //"MaxUsers";
const char* gl_ATTR_NAME_PERM_USERS		= "PU"; //"PermUsers";
const char* gl_ATTR_NAME_MAX_PROFILES		= "MP"; //"MaxProfiles";
const char* gl_ATTR_NAME_BASE_ACL_COUNT	= "BRC";//"BaseRightsCount";
const char* gl_ATTR_NAME_BASE_ACL_ARRAY	= "BRA";//"BaseRightsArray";
const char* gl_ATTR_NAME_TOPIC_ACL_COUNT	= "TC";//"TopicCount";
const char* gl_ATTR_NAME_TOPIC_ACL_ARRAY	= "TA";//"TopicArray";
const char* gl_ATTR_NAME_BLOB_ACL_COUNT	= "OC";//"ObjectCount";
const char* gl_ATTR_NAME_BLOB_ACL_ARRAY	= "OA";//"ObjectArray";
const char* gl_ATTR_NAME_GROUP_ACL_COUNT	= "GC";//"GroupCount";
const char* gl_ATTR_NAME_GROUP_ACL_ARRAY	= "GA";//"GroupArray";
const char* gl_ATTR_NAME_USER_ACL_COUNT	= "UC";//"UserCount";
const char* gl_ATTR_NAME_USER_ACL_ARRAY	= "UA";//"UserArray";
const char* gl_ATTR_NAME_CRC				= "CIV"; //"CRC MU+PU+MP";
const char* gl_ATTR_NAME_GUEST_ENABLED		= "GE"; //"Guest Enabled";
const char* gl_ATTR_NAME_VERSION			= "VER"; //"Version";
const unsigned gl_SEED_FOR_ADLER32			= 0x31304947;//(unsigned)"GI01";

unsigned long gl_VERSION = 1;

typedef struct _acl_t {
	unsigned short m_aid;
	unsigned char m_right;
} acl_t;

int gl_PutAttributeArray(PagedFile* pNDT, const char* pCountName, const char* pArrayName, unsigned char nCount, acl_t* pAcl)
{
	if(!pNDT->PutAttr(pCountName, &nCount, sizeof(unsigned char)))
		return gl_PL_PUTATTR;

	if(nCount > 0)
		if(!pNDT->PutAttr(pArrayName, pAcl, sizeof(acl_t)*nCount))
			return gl_PL_PUTATTR;

	return 0;
}

void	gl_SetLicence( PagedFile* pNDT, int max_profiles, int max_num, int max_perm)
{
	int guest_enabled = 1;

	pNDT->PutAttr(gl_ATTR_NAME_VERSION, &gl_VERSION, sizeof(gl_VERSION));
	pNDT->PutAttr(gl_ATTR_NAME_MAX_USERS, &max_num, sizeof(int));
	pNDT->PutAttr(gl_ATTR_NAME_PERM_USERS, &max_perm, sizeof(int));
	pNDT->PutAttr(gl_ATTR_NAME_MAX_PROFILES, &max_profiles, sizeof(int));
	pNDT->PutAttr(gl_ATTR_NAME_GUEST_ENABLED, &guest_enabled, sizeof(int));

	int buf[4];
	buf[0] = max_num; buf[1] = max_perm; buf[2] = max_profiles; buf[3]=guest_enabled;
	unsigned crc = adler32 ( gl_SEED_FOR_ADLER32, (unsigned char*) buf, sizeof (buf) );
	pNDT->PutAttr(gl_ATTR_NAME_CRC, &crc, sizeof(int));

	unsigned char nTopic = 0, nBlob = 0, nUser = 0, nGroup = 0;
	acl_t aclTopic[] = { {gl_AI_GET_PARAGRAPH_TEXT, 0}, {gl_AI_GET_FULL_ATTRIBUTES, 0} };
	acl_t aclBlob[] = { {gl_AI_GET_OBJECT_STREAM, 0}};
	acl_t aclUser[] = { {gl_AI_ADMINISTRATOR, 0}, {gl_AI_CHANGE_IDLE_TIMEOUT, 0} };
	acl_t aclGroup[] = { {gl_AI_ADMINISTRATOR, 0}};

	//internal
	nTopic = sizeof(aclTopic) / sizeof(acl_t);
	aclTopic[0].m_right = 1;
	aclTopic[1].m_right = 1;
	nBlob = sizeof(aclBlob) / sizeof(acl_t);
	aclBlob[0].m_right = 1;

	gl_PutAttributeArray(pNDT, gl_ATTR_NAME_TOPIC_ACL_COUNT, gl_ATTR_NAME_TOPIC_ACL_ARRAY,nTopic, aclTopic);
	gl_PutAttributeArray(pNDT, gl_ATTR_NAME_BLOB_ACL_COUNT, gl_ATTR_NAME_BLOB_ACL_ARRAY, nBlob, aclBlob);
	gl_PutAttributeArray(pNDT, gl_ATTR_NAME_USER_ACL_COUNT, gl_ATTR_NAME_USER_ACL_ARRAY,	nUser, aclUser);
	gl_PutAttributeArray(pNDT, gl_ATTR_NAME_GROUP_ACL_COUNT, gl_ATTR_NAME_GROUP_ACL_ARRAY, nGroup, aclGroup);
}

/*
struct GarlinkParams {
	Base* base_ptr;
	ProgressScreen* screen_ptr;
	int base_type;
	int bcheck_info;
	int breeder_info;
	int bwww_info;
	int bclass6_info;
	FILE* log_file_ptr;
};

int garlink_logic(Base *, ProgressScreen *, int , int , int , int , int , FILE *);

ACE_THR_FUNC_RETURN run_garlink_ (void* ptr) {
	GarlinkParams* garlink_params_ptr = reinterpret_cast<GarlinkParams*> (ptr);
	return (ACE_THR_FUNC_RETURN) garlink_logic(
		garlink_params_ptr->base_ptr
		, garlink_params_ptr->screen_ptr
		, garlink_params_ptr->base_type
		, garlink_params_ptr->bcheck_info
		, garlink_params_ptr->breeder_info
		, garlink_params_ptr->bwww_info
		, garlink_params_ptr->bclass6_info
		, garlink_params_ptr->log_file_ptr
	);
}

int run_garlink (GarlinkParams* garlink_params_ptr) {
	const size_t GARLINK_STAKCSIZE = 64*1024*1024;
	char* garlink_stack_ptr = new char [GARLINK_STAKCSIZE];
	ACE_thread_t working_thread_id = 0;
	ACE_hthread_t working_thread_handle = 0;
	int res = ACE_OS::thr_create (
		run_garlink_
		, garlink_params_ptr
		, THR_NEW_LWP | THR_JOINABLE
		, &working_thread_id
		, &working_thread_handle
		, ACE_DEFAULT_THREAD_PRIORITY
		, garlink_stack_ptr
		, GARLINK_STAKCSIZE
	);
	if (res < 0) {
		//LOG_E (("can't spawn thread for garlink"));
		std::cerr<<"can't spawn thread for garlink"<<std::endl;
		abort();
	}
	ACE_THR_FUNC_RETURN status = 0;
	res = ACE_OS::thr_join (working_thread_handle, &status);
	delete [] garlink_stack_ptr;
	return (int)status;
}

int garlink(Base *b, ProgressScreen *screen, int baseType, int bCheckInfo, int bBreeder, int bWWW, int bClass6, FILE *el) {
	GarlinkParams garlink_params;
	garlink_params.base_ptr = b;
	garlink_params.screen_ptr = screen;
	garlink_params.base_type = baseType;
	garlink_params.bcheck_info = bCheckInfo;
	garlink_params.breeder_info = bBreeder;
	garlink_params.bwww_info = bWWW;
	garlink_params.bclass6_info = bClass6;
	garlink_params.log_file_ptr = el;
	return run_garlink(&garlink_params);
}
*/

char*	FindPrefix (char* prefix_key) {
	Stream* str = aBase->FindIndex ("Aux")->Open (prefix_key);
	char *result = 0;
	if (str) {
		result = (char*) malloc (str->Length ());
		str->Read (result, str->Length ());
		aBase->FindIndex ("Aux")->Close (str);
	}
	return result;
}

int garlink (Base *b_, ProgressScreen *screen, int b_english_face, int bCheckInfo, int bBreeder, int bWWW, int bClass6, FILE *el, DBCore::RelevancyTuneData* chg_rel_data, int b_only_class6)
{
	b = b_;
	long all_docs_item_count = 0;
	int result_code = 0;
	bIsBreeder = 1;
	
	// (void)doVideo;
	pscreen = screen;

	auxInd = (ContextIndex*) b -> FindIndex ( "Aux" );
	if (!auxInd || !auxInd->IsOk()) {
		gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "пЫЙВЛБ ПВЭЕЗП ЙОДЕЛУБ.\n");
		result_code = 1;
		return result_code;
	}

	Stream *hereStr = auxInd->Open("Here");
	hcount = hereStr->Length()/sizeof(short);
	heres = (short *)malloc(hereStr->Length());
	hereStr->Read(heres, hereStr->Length());
	auxInd->Close(hereStr);

	{
	for (int i = 0; i<hcount; i++)
		if (heres[i] == 32 || (heres[i] >= 240 && heres[i] <= 255)) {
			b_english_base = true;
			break;
		}
	}

	if (b_english_base) {
		sDocInc1 = "Documents included in database from";
		sDocInc2 = "till"; 
		sYear = "year";
		sYears = "years";
		sNewDocs = "New documents";
		sChaDocs = "Amended documents";
		sAboDocs = "Abolished documents";
		sFutDocs = "Documents that are going to be included in database";
		sNexDocs = "Documents that are going to be included in database";
		sOffDocs = "Modified documents";
		sJan = "january";
		sFeb = "february";
		sMar = "march";
		sApr = "april";
		sMay = "may";
		sJun = "june";
		sJul = "july";
		sAug = "august";
		sSep = "september";
		sOct = "october";
		sNov = "november";
		sDec = "december";
	} else {
		STR_ASSIGN(sDocInc1, "дПЛХНЕОФЩ, ЧЛМАЮЕООЩЕ ЪБ РЕТЙПД У");
		STR_ASSIGN(sDocInc2, "РП");
		STR_ASSIGN(sYear, "ЗПДБ");
		STR_ASSIGN(sYears, "ЗПДПЧ");
		STR_ASSIGN(sNewDocs, "оПЧЩЕ РПУФХРМЕОЙС"
				   /*"дПЛХНЕОФЩ, РПДЛМАЮЕООЩЕ У РПМОПК АТЙДЙЮЕУЛПК ПВТБВПФЛПК"*/);
		STR_ASSIGN(sChaDocs, "дПЛХНЕОФЩ, Ч ЛПФПТЩЕ ВЩМЙ ЧОЕУЕОЩ ЙЪНЕОЕОЙС");

		STR_ASSIGN(sAboDocs,
				   "хФТБФЙЧЫЙЕ УЙМХ Й РТЕЛТБФЙЧЫЙЕ ДЕКУФЧЙЕ ДПЛХНЕОФЩ");
		STR_ASSIGN(sFutDocs, "дПЛХНЕОФЩ, РПДЗПФПЧМЕООЩЕ Ч УМЕДХАЭЙЕ ЧЕТУЙЙ");
		STR_ASSIGN(sNexDocs,
				   "дПЛХНЕОФЩ, АТЙДЙЮЕУЛБС ПВТБВПФЛБ ЛПФПТЩИ ОЕ ПЛПОЮЕОБ");
		STR_ASSIGN(sOffDocs, "уОСФЩЕ У ЛПОФТПМС ДПЛХНЕОФЩ");
		STR_ASSIGN(sJan, "СОЧБТС");
		STR_ASSIGN(sFeb, "ЖЕЧТБМС");
		STR_ASSIGN(sMar, "НБТФБ");
		STR_ASSIGN(sApr, "БРТЕМС");
		STR_ASSIGN(sMay, "НБС");
		STR_ASSIGN(sJun, "ЙАОС");
		STR_ASSIGN(sJul, "ЙАМС");
		STR_ASSIGN(sAug, "БЧЗХУФБ");
		STR_ASSIGN(sSep, "УЕОФСВТС");
		STR_ASSIGN(sOct, "ПЛФСВТС");
		STR_ASSIGN(sNov, "ОПСВТС");
		STR_ASSIGN(sDec, "ДЕЛБВТС");
	}

	gllog.setLogFile(el);

	gllog.globalNoHdr();
	if (b_english_face) {
		msgWWWTitle = "      Daily additions on website of Garant company WWW.GARANT.RU          ";
		msgWindowTitle = "Creating main menu for Garant system";
		openIndMsg = "Opening indexes";
		removeTmpMsg = "Removing temporary parts";
		readDocsInfoMsg =  "Reading documents info";
		getHotDatesMsg = "Getting hot dates";
		getBlobsMsg = "Getting blob infos";
		makeMainMenuMsg = "Making main menu";
		makeNewDocsMenuMsg = "Making new docs menu";
		makeCalendarMsg = "Making calendar";
		makeUserMenuMsg = "Making usermenu";
		makeDictionaryMsg = "Making dictionary index";
		makeMDictionaryMsg = "Making medicine dictionary index";
		makeWWWMsg = "Collection WWW info";
		collectSuperbaseMsg = "Collecting superbase info";

		sAllDocs = "All docs";
		sDocum = "Documents";
		sChrono = "Date search";
		sTrash = "Added and modified documents";
		sComms = "Comments to legislation";
		sForms = "Forms of documents";
		sCales = "Calender of tax payments";
		sBusiness = "Business spravka";
		sUseri = "Hot information";
		sProjs = "Projects of laws";
		sPrakt = "Court and arbitration cases";
		sInter = "International agreements";    
		sQuest = "Questions ans answers";       
		sBrefe = "Business references";
		sPublished = "Published by";
		sFuckOff1 = "No such documents in database";
		sFuckOff2 = "No changes for the period";
		sDocs = "documents";
		sBelow = " and before";
		sSpace = "               ";
		sBaseName = "INQUIRY-RETRIEVAL LEGAL SYSTEM \"GARANT\"";
		sCopyr = "COPYRIGHT (C) 1990-2001, GARANT-SERVICE";
		sFederalDocs = "Federal documents";
		sOtherDocs = "Regional documents";
		sPart = "Part %d";
		ssPart = ". Part %d";
	} else {
		msgWWWTitle = "      …¦Ґ¤­Ґў­лҐ Ї®бвгЇ«Ґ­Ёп ­  €­вҐа­Ґв-б ©вҐ Є®¬Ї ­ЁЁ \"ѓ а ­в\" WWW.GARANT.RU          ";
		msgWindowTitle = "уПЪДБОЙЕ ТХВТЙЛБФПТБ ЛПНРМЕЛФБ УЙУФЕНЩ збтбоф";
		openIndMsg = "пФЛТЩФЙЕ ЙОЖПТНБГЙПООПЗП ВБОЛБ";
		removeTmpMsg = "хДБМЕОЙЕ ЧТЕНЕООЩИ ЮБУФЕК";
		readDocsInfoMsg = "юФЕОЙЕ ЙОЖПТНБГЙЙ П ДПЛХНЕОФБИ";
		getHotDatesMsg = "рТПУНПФТ ДБФЩ ДПЛХНЕОФПЧ";
		getBlobsMsg = "рТПУНПФТ ПВЯЕЛФПЧ";
		makeMainMenuMsg = "уПЪДБОЙЕ ПУОПЧОПЗП НЕОА";
		makeNewDocsMenuMsg = "уПЪДБОЙЕ НЕОА ОПЧЩИ ДПЛХНЕОФПЧ";
		makeCalendarMsg = "уПЪДБОЙЕ ЛБМЕОДБТС";
		makeUserMenuMsg = "уПЪДБОЙЕ ЙОЖПТНБГЙЙ ДМС РПМШЪПЧБФЕМС";
		makeDictionaryMsg = "уПЪДБОЙЕ УМПЧБТОПЗП ЙОДЕЛУБ";
		makeMDictionaryMsg = "уПЪДБОЙЕ ЙОДЕЛУБ УМПЧБТОЩИ УФБФЕК йОЖБТНБ";
		makeWWWMsg = "пВТБВПФЛБ WWW-ПВТБЪПЧ";
		collectSuperbaseMsg = "ъБЛТЩФЙЕ ЙОЖПТНБГЙПООПЗП ВБОЛБ";

		// strings that is put in the base
		STR_ASSIGN(sAllDocs, "чУЕ ДПЛХНЕОФЩ");
		STR_ASSIGN(sDocum, "дПЛХНЕОФЩ");
		STR_ASSIGN(sChrono, "иТПОПМПЗЙЮЕУЛЙК РПЙУЛ");
		STR_ASSIGN(sTrash, "оПЧЩЕ ДПЛХНЕОФЩ");
		STR_ASSIGN(sComms, "тБЪЯСУОЕОЙС, ЛПННЕОФБТЙЙ, УИЕНЩ");
		STR_ASSIGN(sForms, "жПТНЩ ДПЛХНЕОФПЧ");
		STR_ASSIGN(sCales, "лБМЕОДБТШ ВХИЗБМФЕТБ");
		STR_ASSIGN(sBusiness, "вЙЪОЕУ УРТБЧЛЙ, НПОЙФПТЙОЗ");
		STR_ASSIGN(sUseri, "\"зПТСЮБС ЙОЖПТНБГЙС\"");
		STR_ASSIGN(sProjs, "рТПЕЛФЩ ЪБЛПОПЧ");
		STR_ASSIGN(sPrakt, "уХДЕВОБС Й БТВЙФТБЦОБС РТБЛФЙЛБ");
		STR_ASSIGN(sInter, "нЕЦДХОБТПДОЩЕ ДПЗПЧПТЩ");
		STR_ASSIGN(sQuest, "чПРТПУЩ Й ПФЧЕФЩ");
		STR_ASSIGN(sBrefe, "вЙЪОЕУ-УРТБЧЛЙ");
		STR_ASSIGN(sPublished, "йУФПЮОЙЛ ПРХВМЙЛПЧБОЙС");
		STR_ASSIGN(sFuckOff1, "ч ВБЪЕ ДБООЩИ ОЕ УПДЕТЦЙФУС ЬФПК ЙОЖПТНБГЙЙ");
		STR_ASSIGN(sFuckOff2, "ъБ ЬФПФ РЕТЙПД ОЙЛБЛЙИ ЙЪНЕОЕОЙК ОЕ ВЩМП");
		STR_ASSIGN(sDocs, "ДПЛХНЕОФЩ");
		STR_ASSIGN(sBelow, " Й ТБОЕЕ");
		STR_ASSIGN(sSpace, "               ");
		STR_ASSIGN(sBaseName, "уртбчпюобс ртбчпчбс уйуфенб \"збтбоф\"");
		sCopyr = "COPYRIGHT (C) 1990-2001, GARANT-SERVICE";
		STR_ASSIGN(sFederalDocs, "дПЛХНЕОФЩ ЖЕДЕТБМШОПЗП ХТПЧОС");
		STR_ASSIGN(sOtherDocs, "дПЛХНЕОФЩ УХВЯЕЛФПЧ тПУУЙКУЛПК жЕДЕТБГЙЙ");
		STR_ASSIGN(sPart, "юБУФШ %d");
		STR_ASSIGN(ssPart, ". юБУФШ %d");
	}
	
	revstatus[0] = sNewDocs; 
	revstatus[1] = sChaDocs;
	revstatus[2] = sAboDocs;
	revstatus[3] = sNexDocs;
	revstatus[4] = sOffDocs;
	
	time_t t_now;
	t_now = time(0);
	struct tm *tm_now = localtime( &t_now );
	currentRevision.RevisionDate.da_year = tm_now -> tm_year + 1900;
	currentRevision.RevisionDate.da_day = tm_now -> tm_mday ;
	currentRevision.RevisionDate.da_mon = tm_now -> tm_mon +1;
	currentRevision.RevisionTime.ti_min = tm_now -> tm_min;
	currentRevision.RevisionTime.ti_hour = tm_now -> tm_hour;
	currentRevision.RevisionTime.ti_hund = 0;
	currentRevision.RevisionTime.ti_sec =  tm_now -> tm_sec;

	char buffer [1000];
	sprintf(buffer, msgWindowTitle);
	pscreen->InitScreen(buffer);
	pscreen->SetMessage(openIndMsg);
	pscreen->SetProgress(0);

	bzero ( (caddr_t)&SuperBase, sizeof ( BaseInfo ) );
	strcpy ( SuperBase.AuthorName, sCopyr );
	SuperBase.LastUpdate = currentRevision;
	fillSuperName();

	pscreen->SetMessage(readDocsInfoMsg);
	pscreen->SetProgress(1);

	std::deque<long> only_docs, editions;

	if (iMakeAllDocs || bClass6) {
		onlyDocs = new u_int32_tSplaySet;
		all_docs = new u_int32_tSplaySet;
	}

	std::set<short> ignore_gl_belongs;
	{
		Stream* str = b->FindIndex ("Aux")->Open (AUX_IGNORE_GL_BELONGS);
		if (str) {
			int size = str->Length ();
			char *str_belongs = (char*)alloca(size), *ptr = str_belongs;
			str->Read (str_belongs, size);
			b->FindIndex ("Aux")->Close (str);
			for (int i = 0; i < size;) {
				short id = (short) atol (ptr);
				ignore_gl_belongs.insert (id);
				i += strlen (ptr) + 1;
				ptr += strlen (ptr) + 1;
			}
		}
	}

	DocInfo	Info;

	char	ADocName [4096*1024], *pOut;
	short	seg_buff [4096];
	long	seg_size, blocksAllSize= 0;
	int		sizeName, ParaSize, tmp;

	std::set<long> set_www_add, set_www_del;
	if (bWWW && !b_only_class6) {
		Document *aWWWDoc = b->GetDoc (ID_WWWDOC);
		if (aWWWDoc) {
			bool	aAddPhase = false, aRemovePhase = false;
			for (long aPara = 0; aPara < aWWWDoc->Stat.ParaCount; aPara++) {
				char* ptr = aWWWDoc -> GetPara (aPara);
				if (!ptr) continue;

				int	Size = aWWWDoc->EVDTextSize (ptr);
				ptr = aWWWDoc->EVDParaText (ptr);
				ptr [Size] = '\0';

				if (strstr (ptr, "[ADD]")) {
					aAddPhase = true;
					aRemovePhase = false;
				} else if (strstr (ptr, "[REMOVE]")) {
					aAddPhase = false;
					aRemovePhase = true;
				} else if (aAddPhase || aRemovePhase) {
					char	*sDocId = strtok (ptr, " ");
					while (sDocId != 0) {
						long	aDocId = atol (sDocId);
						sDocId = strtok (0, " ");

						if (aDocId) {
							aDocId += ID_BORDER;
							if (!b->FindDoc (aDocId))
								continue;

							if (aAddPhase)
								set_www_add.insert (aDocId);
							else if (aRemovePhase)
								set_www_del.insert (aDocId);
						}
					}
				}
			}
			delete aWWWDoc;
		}
	}

	std::map<long,long> map_docid_nextedition;
	long active_count = 1;
	{
		Index* status_ind = b->FindIndex ("Status");
		short status = DS_ACTIVE;
		Stream * str = status_ind->Open (&status);
		if (str) {
			active_count = str->Length () / sizeof (long);
			status_ind->Close (str);
		}
	}

	std::vector<std::string> bases_list;
	std::vector<Base*> bases_ptrs;
	bases_list.push_back ("this");
	bases_ptrs.push_back (b);
	Stream *str = b->FindIndex ("Aux")->Open (AUX_BASES_LIST);
	if (str) {
		long length = str->Length ();
		char *bases = new char [length], *ptr = bases;
		str->Read (bases, length);
		b->FindIndex ("Aux")->Close (str);
		for (; ptr - bases < length; ptr += strlen (ptr) + 1)
			bases_list.push_back (ptr);
		delete []bases;
	}

	std::set<long> resps;
	if (iMakeAllDocs) {
		AttrKey attrkey = {ID_BORDER, IDD_REFS};
		for (BTIterator it (b->FindIndex ("Attrs"), &attrkey); !it.End (); ++it) {
			AttrKey *key = (AttrKey*) it.Key ();
			if (key->AttrTag != IDD_REFS)
				break;

			long idd_refs_size;
			RespRef *idd_refs = (RespRef*) b->LoadAttr (key->DocId, IDD_REFS, idd_refs_size);
			idd_refs_size /= sizeof (RespRef);
			for (long aref = 0; aref < idd_refs_size; aref++)
				if (idd_refs [aref].DocId != key->DocId)
					resps.insert (idd_refs [aref].DocId);
			gk_free (idd_refs);
		}
	}

	std::set<long> aak_docs;
	longSplaySet docIDs, dicIDs;
	long max_counter = (active_count * 25) / 10, curr_perc = 1, cur_counter = 0, step = ( max_counter * 16 ) / 1000;

	std::map<long,Base*> map_doc_base;
	std::map<long,char> map_doc_basechar, map_blob_basechar;

	std::vector<std::string>::const_iterator bases_it;
	DocCollection likeable_docs, medfirmtopics;
	char basechar = 0;
	for (bases_it = bases_list.begin (); bases_it != bases_list.end (); bases_it++, basechar++) {
		if (bases_it == bases_list.begin ()) {
			HIndex* types = (HIndex*) b->FindIndex ("Type");
			std::vector<std::string> comments;
			comments.push_back ("Комментарии");
			IndexReq* req = build_req (b, "Type", comments, b_inpharm);
			if (req) {
				HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) ((char*) req + sizeof (IndexReq));
				Stream* str = types->::Index::OpenN (hkey, 0);
				if (str) {
					likeable_docs.FastLoadRefs (str);
					types->Close (str);
				}
				gk_free (req);
			}
		} else {
			b = new YBase (bases_it->c_str (), ACE_OS_O_RDONLY);
			bases_ptrs.push_back (b);
		}
		long likeable_ptr = 0, likeable_id = likeable_docs.ItemCount ? likeable_docs [likeable_ptr] : 0x7FFFFFFF;

		AttrKey begin_key = {ID_BORDER, IDD_INFO};
		BTIterator it (b->FindIndex ("Attrs"), &begin_key);

		for (; !it.End ();++it) {
			AttrKey *it_key = (AttrKey*) it.Key ();
			if (it_key->AttrTag > IDD_INFO)
				break;

			long docID = it_key->DocId;

			if (bases_list.size () > 1) {
				if (map_doc_base.find (docID) == map_doc_base.end ()) {
					map_doc_base.insert (std::map<long,Base*>::value_type (docID, b));
					map_doc_basechar.insert (std::map<long,char>::value_type (docID, basechar));
				}
			}

			b->FindDocAttr (docID, IDD_INFO, &Info, sizeof (Info));
			if (curr_perc < 81) {
				if (++cur_counter > step) {
					pscreen->SetProgress (++curr_perc);
					cur_counter = 0;
				}
			}

			SuperBaseRecSize += (u_int64_t) Info.Size;
			SuperBase.GreenComments += Info.GreenComments;
			SuperBase.HyperRefs += Info.HyperRefs;
			SuperBase.RecCount++;

			if (iMakeAllDocs && all_docs && !(Info.Status & DS_ANNO))
				all_docs->add (docID);
			
			if (Info.Status & DS_DOC) {
				all_docs_item_count++;

				if (onlyDocs) onlyDocs->add (docID);

				if (!b_only_class6)
					only_docs.push_back (docID);

				SuperBase.CommonDocCount++;
				SuperBaseCommonDocSize += (u_int64_t) Info.Size;
			}

			if (Info.Status_ex & DS_MEDTOPIC)
				b_inpharm = true;

			if (b_only_class6)
				continue;

			if (Info.Status & DS_EDITION)
				editions.push_back (docID);

			if (Info.prevEdition)
				map_docid_nextedition.insert (std::map<long,long>::value_type (Info.prevEdition, docID));

			if (Info.Status & DS_ANNO) {
				annos.push_back (docID);
				annos_count++;
			}

			DSSAttribute dss;
			dss.m_id = docID;
			if (Info.Status & DS_REFDOC)
				dss.m_flags = DSS_REF;
			else if (Info.Status & DS_BOOK)
				dss.m_flags = DSS_BOOK;
			else if (Info.Status_ex & DS_MEDTOPIC) {
				medfirmtopics.Add (docID);				
				dss.m_flags = DSS_MEDTOPIC;
			} else if (Info.Status_ex & DS_FIRMTOPIC) {
				medfirmtopics.Add (docID);
				dss.m_flags = DSS_MEDFIRM;
			}
			else if (Info.Status_ex & DS_MDICTTOPIC)
				dss.m_flags = DSS_MEDDICT;
			else if (Info.Status_ex & DS_FLASH)
				dss.m_flags = DSS_FLASH;
			else if (GetDocStatusExEx (&Info) & DS_AAKCONTENT) {
				aak_docs.insert (docID);
				dss.m_flags = DSS_AAKCONTENTS;
			} else if (GetDocStatusExEx (&Info) & DS_AAKTEXT) {
				aak_docs.insert (docID);
				dss.m_flags = DSS_AAKTOPIC;
			} else if (docID >= ID_DIC_LO && docID <= ID_DIC_HI)
				dss.m_flags = DSS_DIC;
			else if (docID == DOC_TIP_OF_THE_DAY) {
				dss.m_flags = DSS_TIP;
				long start_tip = DOC_TIP_OF_THE_DAY_LOW;
				for (BTIterator blob_it (b->FindIndex ("Blob"), &start_tip); !blob_it.End (); ++blob_it) {
					int blob_tip = *(long*) blob_it.Key ();
					if (blob_tip >= DOC_TIP_OF_THE_DAY_LOW && blob_tip < DOC_TIP_OF_THE_DAY_HI) {
						dss.m_id = blob_tip;
						dss_attribs.push_back (dss);
					} else {
						break;
					}
				}
				dss.m_id = docID;
			}
			else
				dss.m_flags = 0;

			if (docID == likeable_id)
				dss.m_flags |= DSS_LIKEABLE;
			if ((docID >= likeable_id) && (likeable_ptr < likeable_docs.ItemCount - 1))
				likeable_id = likeable_docs [++likeable_ptr];

			if (dss.m_flags)
				dss_attribs.push_back (dss);

			if ((Info.Status & (DS_DOC | DS_EDITION)) || (Info.Status_ex & DS_MEDTOPIC)) {
				ShortCommonAttribute ca;
				ca.m_id = docID;
				ca.m_force = Info.Force;
				ca.m_status = Info.Status;
				if (set_www_add.find (docID) != set_www_add.end ())
					ca.m_status |= DS_WWW;
				else
				if (set_www_del.find (docID) != set_www_del.end ())
					ca.m_status &= ~DS_WWW;

				ca.m_changed = date_to_long (Info.LastDate.da_day, Info.LastDate.da_mon, Info.LastDate.da_year);
				ca.m_published = date_to_long (Info.FirstDate.da_day, Info.FirstDate.da_mon, Info.FirstDate.da_year);

				fastInfos.push_back (ca);
				docs_with_force.push_back (docID);
			}

			if (Info.Status_ex & DS_MEDTOPIC /*&& (processed_inpharms.find (docID) == processed_inpharms.end ())*/) {
				SuperBase.CommonDocCount++;
				SuperBaseRecSize += (u_int64_t) Info.Size;
				SuperBaseCommonDocSize += (u_int64_t) Info.Size;
				SuperBase.GreenComments += Info.GreenComments;
				SuperBase.HyperRefs += Info.HyperRefs;
				SuperBase.RecCount++;

				InpharmAttribute ia;
				ia.m_id = docID;
				ia.m_status_ex = Info.Status_ex;
				ADocName [0] = 0;
				b->FindSubName (docID, 0, ADocName);
				ia.name = strdup (ADocName);
				fastInpharms.push_back (ia);
			}

			long anno = GetDocMonitoring (&Info);
			if (anno && !(Info.Status & DS_ANNO)) {
				u_int64_t value = ((u_int64_t)anno << 32) + docID;
				annos_docs.push_back (value);
			}
		}
	}
	likeable_docs.FreeAll ();

	if (bases_list.size () > 1) {
		std::sort (docs_with_force.begin (), docs_with_force.end ());
		std::sort (only_docs.begin (), only_docs.end ());
		std::sort (dss_attribs.begin (), dss_attribs.end ());
		dss_attribs.erase (std::unique (dss_attribs.begin (), dss_attribs.end ()), dss_attribs.end ());
		std::sort (fastInfos.begin (), fastInfos.end ());
		fastInfos.erase (std::unique (fastInfos.begin (), fastInfos.end ()), fastInfos.end ());
	}

	b = *bases_ptrs.begin ();
	BTIterator* it = new BTIterator (b->FindIndex ("Attrs"));

	int b_is_demo = 0;
	if (b->FindIndex ("Context.str")->KeyCount == 0) {
		Index* swords_index = b->FindIndex ("SWords");
		if (swords_index->streams->Fat && swords_index->KeyCount < all_docs_item_count) {
			b_is_demo = 1;
			for (std::deque<DSSAttribute>::iterator it = dss_attribs.begin (); it != dss_attribs.end (); it++) {
				if (aak_docs.find (it->m_id) != aak_docs.end ()) {
					it->m_flags &= ~DSS_AAKTOPIC;
					it->m_flags &= ~DSS_AAKCONTENTS;
				}
			}
		}
	}

	{
	long parts = 0;
	Stream *str = auxInd->Open (AUX_PARTS);
	if (str) {
		str->Read (&parts, sizeof (parts));
		auxInd->Close (str);
	}
	if (parts) {
		DocCollection olddocs;
		int i;
		for (i = 0; i <= parts; i++) {
			char key [5];
			if (i == parts)
				strcpy (key, "PrtE");
			else
				sprintf (key, "Prt%ld", i);
			str = auxInd->Open (key);
			if (str) {
				DocCollection docs;
				docs.Get (str);
				auxInd->Close (str);
				olddocs.Merge (docs);
			}
		}
		//в olddocs - список изначально проиндексированных документов
		//если из него вычесть те документы, которые есть в Status.DS_DOC+DS_EDITION, то получим список документов, которые удалились (или стали неидексируемыми)
		for (i = 0; i < 2; i++) {
			short status = (i == 0 ? DS_DOC : DS_EDITION);
			str = b->FindIndex ("Status")->Open (&status);
			if (str) {
				DocCollection docs;
				docs.Get (str);
				b->FindIndex ("Status")->Close (str);
				olddocs.Minus (docs);
			}
		}

		DocCollection docsincontext;
		for (BTIterator it (b->FindIndex ("SWords")); !it.End (); ++it) {
			long id = *(long*) it.Key ();
			docsincontext.Collection::Add (&id);
		}
		docsincontext.Minus (medfirmtopics);
		docsincontext.Merge (olddocs);

		str = auxInd->Open ("PrtM", 1);
		if (str) {
			docsincontext.Put (str);
			str->Trunc ();
			auxInd->Close (str);
		}
	}
	}

	if (!b_only_class6) {
		if (!b_english_face) pscreen->SetMessage ("юФЕОЙЕ ЙОЖПТНБГЙЙ П ОПНЕТБИ ДПЛХНЕОФПЧ");

		for (std::deque<long>::const_iterator it = docs_with_force.begin (); it != docs_with_force.end (); it++) {
			long id = *it, size = 0;
			char* buffer = map_doc_base.size () ? (char*) map_doc_base.find (id)->second->LoadAttr (id, IDD_ID, size) : (char*) b->LoadAttr (id, IDD_ID, size);
			if (size) {
				std::string s_number ("");
				for (unsigned char* ptr = (unsigned char*) buffer; *ptr; ptr++) {
					if (*ptr >= '0' && *ptr <= '9') {
						std::string to_append;
						to_append.assign ((char*) ptr, 1);
						s_number.append (to_append);
					}
				}
				u_int64_t dan = (((u_int64_t)id) << 32) + atol (s_number.c_str ());
				deque_doc_atolnumber.push_back (dan);
				gk_free (buffer);
			}
		}
		std::deque<long> empty;
		docs_with_force.swap (empty);
	}

	std::vector<Base*>::const_iterator bases_ptr_it;
	for (bases_ptr_it = bases_ptrs.begin (); bases_ptr_it != bases_ptrs.end (); bases_ptr_it++) {
		AttrKey bases_key = {ID_DIC_LO, IDD_BASES};
		if (!b_only_class6) for (BTIterator it ((*bases_ptr_it)->FindIndex ("Attrs"), &bases_key); !it.End (); ++it) {
			AttrKey *it_key = (AttrKey*) it.Key ();
			if (it_key->AttrTag != IDD_BASES || it_key->DocId > ID_DIC_HI)
				break;
			long docID = it_key->DocId;
			seg_size = (*bases_ptr_it)->FindDocAttr (docID, IDD_BASES, seg_buff, 4096) / sizeof (*seg_buff);
			for (int i= 0; i < seg_size; i++) {
				if (seg_buff [i] == DICTIONARY_SEGMENT) {
					bigdic_count++;
					if (!dicIDs.contains (docID))
						dicIDs.add (docID);
				} else if (seg_buff [i] == DICTIONARY_SEGMENT_SML) {
					smldic_count++;
					if (!dicIDs.contains (docID))
						dicIDs.add (docID);
				}
			}
		}
	}

	std::map<long, std::deque <long> > map_doc_invlens;
	if (!b_only_class6) for (bases_ptr_it = bases_ptrs.begin (); bases_ptr_it != bases_ptrs.end (); bases_ptr_it++) {
		AttrKey invisible_key = {ID_BORDER, IDD_INVISIBLELENS};
		for (BTIterator it ((*bases_ptr_it)->FindIndex ("Attrs"), &invisible_key); !it.End (); ++it) {
			AttrKey *keyptr = (AttrKey*) it.Key ();
			if (keyptr -> AttrTag != IDD_INVISIBLELENS)
				break;

			long id = keyptr->DocId, size = 0, *invlens = (long*) (*bases_ptr_it)->LoadAttr (id, IDD_INVISIBLELENS, size), *ptr = invlens;
			size /= (sizeof (long) * 3);
			std::deque<long> lens;
			lens.push_back (size);
			for (; size; size--) {
				lens.push_back (*ptr);
				ptr++;
				lens.push_back (*ptr);
				ptr++;
				lens.push_back (*ptr);
				ptr++;
			}
			map_doc_invlens.insert (std::map <long, std::deque <long> >::value_type (id, lens));
			gk_free (invlens);
		}
	}

	std::map<long, std::deque <long> > map_doc_invreles;
	if (!b_only_class6) for (bases_ptr_it = bases_ptrs.begin (); bases_ptr_it != bases_ptrs.end (); bases_ptr_it++) {
		AttrKey invisiblerele_key = {ID_BORDER, IDD_INVISIBLERELES};
		for (BTIterator it ((*bases_ptr_it)->FindIndex ("Attrs"), &invisiblerele_key); !it.End (); ++it) {
			AttrKey *keyptr = (AttrKey*) it.Key ();
			if (keyptr -> AttrTag != IDD_INVISIBLERELES)
				break;

			long id = keyptr->DocId, size = 0, *invreles = (long*) (*bases_ptr_it)->LoadAttr (id, IDD_INVISIBLERELES, size), *ptr = invreles;
			size /= (sizeof (long) * 2);
			std::deque<long> reles;
			reles.push_back (size);
			for (; size; size--) {
				reles.push_back (*ptr);
				ptr++;
				reles.push_back (*ptr);
				ptr++;
			}
			map_doc_invreles.insert (std::map <long, std::deque <long> >::value_type (id, reles));
			gk_free (invreles);
		}
	}

	if (!b_only_class6) {
		long* annoleafs = new long [annos.size () * 2], *leafptr = annoleafs;

		for (std::deque<long>::const_iterator it = annos.begin (); it != annos.end (); it++) {
			long id = *it, size;
			DocStruct* ds = map_doc_base.size () ? (DocStruct*) map_doc_base.find (id)->second->LoadAttr (id, IDD_DOCSTRUCT, size) : (DocStruct*) b->LoadAttr (id, IDD_DOCSTRUCT, size);
			if (size) {
				*leafptr = id;
				leafptr++;
				*leafptr = ds->m_para_list_type & 0xFFFFFF;
				leafptr++;
				gk_free (ds);
			}
		}

		Stream* str = auxInd->Open (AUX_ANNO_LEAFS, 1);
		if (str) {
			str->Write (annoleafs, annos.size () * 2 * sizeof (long));
			str->Trunc();
			auxInd->Close( str );
		}
		delete annoleafs;

		DocCollection withAnnos;
		for (std::deque<u_int64_t>::const_iterator it = annos_docs.begin (); it != annos_docs.end (); it++) {
			long anno_id = (long)(*it >> 32);
			if (std::binary_search (annos.begin (), annos.end (), anno_id))
				withAnnos.Add ((long)(*it & 0xFFFFFFFF));
		}

		char* key = "WAno";
		str = auxInd->Open (key, 1);
		withAnnos.Put (str);
		str->Trunc();
		auxInd->Close (str);

		{
		std::deque<long> empty;
		annos.swap (empty);
		}

		{
		std::deque<u_int64_t> empty;
		annos_docs.swap (empty);
		}
	}

	if (iMakeAllDocs && !b_only_class6) {
		DocCollection gl_docs;

		int ADocsNumber = 0;
		for (Point p = all_docs->first (); p; all_docs->next (p)) {
			long docID = (*all_docs) (p);
			if (resps.find (docID) == resps.end () && !onlyDocs->contains (docID))
				continue;

			seg_size = b->FindDocAttr (docID, IDD_BASES, seg_buff, 4096) / sizeof (*seg_buff);
			int newDocsNumber = BIG_INFO_DOC + ((docID-ID_BORDER) / iMakeAllDocsParaMax);
			if (newDocsNumber != ADocsNumber) {
				if (d && ADocsNumber) {
					if (d->ParaCount) {
						//закрыть текущий документ
						gl_docs.Add (d->DocId);
						SuperBase.RecCount++;
						delete d;
						d = 0;
					} else {
						delete d;
						d = 0;
						b->DelDoc (ADocsNumber);
					}
				}
				ADocsNumber = newDocsNumber;
				if (ADocsNumber >= BIG_INFO_DOC && ADocsNumber < BIG_INFO_DOC + BIG_INFO_COUNT) {
					//создать новый документ
					b->DelDoc (ADocsNumber);
					CreateDoc (ADocsNumber, "AllDocsNote");
					d->pInfo->Status = DS_NODOC;
					b->PutAttr (ADocsNumber, IDD_BASES, heres, hcount*sizeof(*heres));
				}
			}

			if (d) {
				int jj, i;
				for (i= 0, jj = 0; i < seg_size; i++) {
					if (ignore_gl_belongs.find (seg_buff [i]) != ignore_gl_belongs.end ())
						continue;
					if (!jj++) {
						*ADocName= 8;
						*(long*)(ADocName+1)= 0;
						sizeName=sprintf(ADocName+5, "%d", docID);
						ADocName[sizeName+5] = BIG_INFO_DELIMITER;
						pOut= ADocName+sizeName+5+1;
						ParaSize= (long)pOut - (long)ADocName + 1;
						tmp=b->FindDocName(docID,pOut)-1;
						if(tmp < 1)
							tmp= 0;
						ParaSize += tmp+1;
						pOut += tmp;
						*pOut= BIG_INFO_DELIMITER;pOut++;
					}
					tmp= sprintf(pOut, "%d%c", seg_buff[i], BIG_INFO_DELIMITER);
					ParaSize += tmp;
					pOut += tmp;
				}
				if (jj && ParaSize < MAX_PARA_LEN)
					d->AddPara(PS_PREFORMATTED,ParaSize,ADocName);
			}
		}
		if (d) {
			long number = d->DocId;
			if (d->ParaCount) {
				/*
				DSSAttribute dss = {number, 0};
				bool b_found = false;
				std::deque<DSSAttribute>::iterator it;
				for (it = dss_attribs.begin (); it != dss_attribs.end () && !b_found; it++) {
					if (it->m_id == number) 
						b_found = true;
					else if (it->m_id > number) {
						dss_attribs.insert (it, dss);
						b_found = true;
					}
				}
				if (!b_found)
					dss_attribs.push_back (dss);
				*/

				gl_docs.Add (d->DocId);
				SuperBase.RecCount++;
				delete d;
				d = 0;
			} else {
				delete d;
				d = 0;
				b->DelDoc (number);
			}
		}
		short nodocs_status = DS_NODOC;
		Stream *str = b->FindIndex ("Status")->Open (&nodocs_status, 1);
		if (str) {
			DocCollection docs;
			docs.Get (str);
			docs.Merge (gl_docs);
			str->Seek (0);
			docs.Put (str);
			b->FindIndex ("Status")->Close (str);
		}
	}
	delete it;

	if (!b_only_class6) {
		pscreen->SetMessage (removeTmpMsg);
		for (Pix pix = docIDs.first(); pix; docIDs.next (pix)) {
			if (!b -> DelDoc (docIDs (pix))) {
				gllog.printfC (AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "пЫЙВЛБ РТЙ ХДБМЕОЙЙ ДПЛХНЕОФБ.\n");
				exit (-1);
			}
		}
		docIDs.clear();
	}

	curr_perc = 80;
	if (!b_only_class6) {
		long tips_count = 0;
		std::set<long> processed;
		for (basechar = 0, bases_ptr_it = bases_ptrs.begin (); bases_ptr_it != bases_ptrs.end (); bases_ptr_it++, basechar++) {
			Index* blobs = (*bases_ptr_it)->FindIndex ("Blob");

			max_counter = blobs->KeyCount / 10, cur_counter = 0;
			pscreen->SetMessage(getBlobsMsg);
			ObjInfo objinfo;
			for (BTIterator blobit (blobs); !blobit.End (); ++blobit) {
				if (++cur_counter > max_counter) {
					pscreen->SetProgress (++curr_perc);
					cur_counter = 0;
				}

				long id = *(long*) blobit.Key ();
				if (processed.find (id) != processed.end ())
					continue;
				processed.insert (id);
				map_blob_basechar.insert (std::map<long,char>::value_type (id, basechar));

				if (id >= DOC_TIP_OF_THE_DAY_LOW && id < DOC_TIP_OF_THE_DAY_HI) {
					tips_count++;
				} else {
					Stream *str = blobs->OpenN (&id, 0);
					if (str) {
						str->Read (&objinfo, sizeof (ObjInfo));
						blobs->Close (str);
						if (objinfo.type == EOT_XLS || objinfo.type == EOT_RTF)
							SuperBase.FormsCount++;
					}
				}
			}
		}
		if (tips_count) {
			Stream* str = auxInd->Open (AUX_TIPS, 1);
			str->Write (&tips_count, sizeof (tips_count));
			str->Trunc ();
			auxInd->Close (str);
		} else {
			auxInd->Delete (AUX_TIPS);
		}
		pscreen->SetProgress(80);
	}

	//pscreen->SetProgress(99);
	SuperBase.CommonDocCount += dicIDs.length ();
	SuperBase.RecSize = (long)(SuperBaseRecSize / 1024);
	SuperBase.DocSize = (long)(SuperBaseDocSize / 1024);
	SuperBase.CommonDocSize = (long)(SuperBaseCommonDocSize / 1024);
	if (bCheckInfo) CHECK_OK(CollectInfo());

	if (bClass6) {
		pscreen->SetMessage(getHotDatesMsg);
		pscreen->SetProgress(81);

		struct history_info hi;
		bzero((char *)&hi, sizeof(hi));
		FillHotDates(&hi);

		pscreen->SetMessage(makeMainMenuMsg);
		pscreen->SetProgress(82);
		//makeMenuTopics(b);
		pfx_Info.clear ();

		pscreen->SetMessage(makeNewDocsMenuMsg);
		pscreen->SetProgress(95);
		CHECK_OK(MakeTrashTopic(&hi));
	}

	if (!b_only_class6) {
		pscreen->SetMessage(makeCalendarMsg);
		pscreen->SetProgress(97);
		defineInfoTopics();

		pscreen->SetMessage(makeDictionaryMsg);
		pscreen->SetProgress(98);
	#ifndef	_DEBUG
		makeFastDicIdx(b,dicIDs);
	#endif
		dicIDs.clear();
	}

	if (!b_only_class6) {
		pscreen->SetMessage(makeMDictionaryMsg);
		makeFastMDicIdx(b, bClass6);
	}

	//makeFastSnippet (b);

	if (bWWW && !b_only_class6) {
		DocInfo docinfo;
		pscreen->SetMessage(makeWWWMsg);
		std::set<long>::const_iterator it;
		for (it = set_www_add.begin (); it != set_www_add.end (); it++) {
			long aDocId = *it;
			if ((b->FindDocInfo (aDocId, docinfo) == sizeof (docinfo)) && ((docinfo.Status & DS_WWW) == 0)) {
				docinfo.Status |= DS_WWW;
				b->ReplaceAttr (aDocId, IDD_INFO, &docinfo, sizeof (docinfo));
			}
		}
		for (it = set_www_del.begin (); it != set_www_del.end (); it++) {
			long aDocId = *it;
			if ((b->FindDocInfo (aDocId, docinfo) == sizeof (docinfo)) && ((docinfo.Status & DS_WWW) == DS_WWW)) {
				docinfo.Status &= ~DS_WWW;
				b->ReplaceAttr (aDocId, IDD_INFO, &docinfo, sizeof (docinfo));
			}
		}
	}

	aBase = b_;
	long aId = 1;
	if (bClass6) {
		aClass6 = (HIndex*)aBase->FindIndex ("Class6");

		std::deque<HIndex::HIndexKey*> keys;
		for ( it = new BTIterator( aClass6 ); !it->End(); ++*it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) malloc (aClass6->KeyLength);
			memcpy (key, it->Key (), aClass6->KeyLength);
			keys.push_back (key);
		}
		for (std::deque<HIndex::HIndexKey*>::iterator key_it = keys.begin (); key_it != keys.end (); key_it++) {
			aClass6->Index::Delete (*key_it);
			free (*key_it);
		}
		aClass6->KeyCount = 0;
		aClass6->LastId = 0;

		long c6_navigator_id = aId, achCount = 0, chCount = 0, aEcoId = aId, aAuxCount=0, cl_children = 0, si_children = 0, keys_in_class = aBase->FindIndex ("Class")->KeyCount, keys_on_level0 = 0;
		{
		for (BTIterator it (aBase->FindIndex ("Class")); !it.End (); ++it) {
			HIndex::HIndexKey* aKey = (HIndex::HIndexKey*) it.Key();
			if (aKey->level)
				break;
			keys_on_level0++;
		}
		}
		if (aAuxCount = ProcessClass (aId, cl_children)) {
			chCount  += cl_children;
			achCount += aAuxCount-chCount;
		}
		if (chCount)
			CreateNode (c6_navigator_id, 0, 0, b_english_base ? class6NavigatorE : class6Navigator, chCount, achCount + chCount);

		bool ecoPresent = false;
		achCount = chCount = 0;
		aEcoId = ++aId;
		if (aAuxCount = ProcessServiceInfo (aId, aEcoId, 1, si_children, keys_on_level0, keys_in_class)) {
			chCount  += si_children; //количество детей у aEcoId увеличилось на количество первых уровней в ServiceInfo
			achCount += aAuxCount-chCount;
		}

		if ( FindGlTopic (NEWMENU)) {
			long c6_newdocs_id = ++aId;
			chCount++;
			long savedachCount = achCount;
			achCount += ProcessGlTopic (NEWMENU, aEcoId, 1, b_english_base ? class6NewDocsE : class6NewDocs, aId, true);
			if (savedachCount == achCount) {
				aId--;
				chCount--;
			}
		}

		if ( chCount ) {
			//создается узел "002=СправочнаяИнформация. Id=aEcoId, родитель - 0(т.е. нет)
			long c6_serviceinfo_id = aEcoId;
			CreateNode (c6_serviceinfo_id, 0, 0, b_english_base ? class6InfoE : class6Info, chCount, achCount + chCount);
			ecoPresent = true;
			++aId;
		}

		if (b_english_base) {
			std::string eta_key (class6InfoE);
			eta_key += "\\001=Quick Reference\\002=Legal Guide";
			HIndex::HIndexKey *key_to_hack = (HIndex::HIndexKey*) aClass6->FullKey (eta_key.c_str ());
			if (key_to_hack) {
				ProcessClass (aId, key_to_hack->id, key_to_hack->level+1);
				Stream* str = aClass6->Index::OpenN (key_to_hack, 0);
				if (str) {
					str->Trunc ();
					aClass6->Close (str);
				}
			}
		}
	}

	if (b_inpharm && bClass6) {
		DocCollection *mdocs = b->AllMDocs ();
		long medic_topic_inclass6 = 0;
		for (int i = 0; i < mdocs->ItemCount; i++) {
			long id = (*mdocs) [i], size = 0;
			short *bases = map_doc_base.size () ? (short*) map_doc_base.find (id)->second->LoadAttr (id, IDD_BASES, size) : (short*) b->LoadAttr (id, IDD_BASES, size);
			for (int base = 0; (base < size / sizeof (short)) && (0 == medic_topic_inclass6); base++)
				if (bases [base] == INPHARM_SEGMENT)
					medic_topic_inclass6 = id;
		}

		pscreen->SetMessage("уПЪДБОЙЕ УМХЦЕВОЩИ ЙОДЕЛУПЧ йОЖБТНБ");
		short status_ex = DS_NOTALLOWED;
		Stream* str = b->FindIndex ("Status_ex")->Open (&status_ex);
		RefCollection notallowed_refs;
		if (str) {
			notallowed_refs.Get (str);
			b->FindIndex ("Status_ex")->Close (str);
		}

		long c6_inpharm_id = aId++, inpharm_om_id;
		CreateNode (c6_inpharm_id, 0,0, class6Inpharm, 5, 10);

		HIndex::HIndexKey* key = (HIndex::HIndexKey*) alloca (512);
		strcpy (key->text, class6InpharmSearch);
		key->level = 1;
		key->id = aId++;
		key->parent = c6_inpharm_id;
		key->chCount = key->achCount = 0;

		RefCollection refs;
		Ref ref = {medic_topic_inclass6, 0};
		refs.Insert (&ref);
		str = aClass6->Index::OpenN (key,0,1);
		refs.Put (str);
		aClass6->Close (str);

		inpharm_om_id = key->id = aId++;
		strcpy (key->text, class6InpharmChapter);
		key->chCount = key->achCount = 5;
		str = aClass6->Index::OpenN (key,0,1);
		aClass6->Close (str);

		RefCollection crefs;
		Index *chapters = b->FindIndex ("Chapter");
		
		char str_key [256];
		strcpy (str_key, "001=Лекарственные средства, субстанции и вспомогательные вещества\\002=Лекарственные средства");
		str = chapters->Open (str_key);
		if (str) {
			crefs.Get (str);
			crefs.InheritPress ();
			if (notallowed_refs.ItemCount) crefs.Minus (notallowed_refs);
			chapters->Close (str);

			strcpy (key->text, class6InpharmCLeks);
			key->parent = inpharm_om_id;
			key->level = 2;
			key->id = aId++;
			key->chCount = key->achCount = 0;
			str = aClass6->Index::OpenN (key,0,1);
			crefs.Put (str);
			aClass6->Close (str);
		}

		strcpy (str_key, "001=Лекарственные средства, субстанции и вспомогательные вещества\\003=Лекарственные растения, сырье и препараты из них");
		str = chapters->Open (str_key);
		if (str) {
			crefs.Get (str);
			crefs.InheritPress ();
			if (notallowed_refs.ItemCount) crefs.Minus (notallowed_refs);
			chapters->Close (str);

			strcpy (key->text, class6InpharmCLekR);
			key->id = aId++;
			str = aClass6->Index::OpenN (key,0,1);
			crefs.Put (str);
			aClass6->Close (str);
		}

		strcpy (key->text, class6InpharmCImmuno);
		strcpy (str_key, "001=Лекарственные средства, субстанции и вспомогательные вещества\\004=Медицинские иммунобиологические препараты");
		str = chapters->Open (str_key);
		if (str) {
			crefs.Get (str);
			crefs.InheritPress ();
			if (notallowed_refs.ItemCount) crefs.Minus (notallowed_refs);
			chapters->Close (str);

			key->id = aId++;
			str = aClass6->Index::OpenN (key,0,1);
			crefs.Put (str);
			aClass6->Close (str);
		}

		strcpy (str_key, "001=Лекарственные средства, субстанции и вспомогательные вещества\\005=Гомеопатические средства");
		str = chapters->Open (str_key);
		if (str) {
			crefs.Get (str);
			crefs.InheritPress ();
			if (notallowed_refs.ItemCount) crefs.Minus (notallowed_refs);
			chapters->Close (str);

			strcpy (key->text, class6InpharmCGomeo);
			key->id = aId++;
			str = aClass6->Index::OpenN (key,0,1);
			crefs.Put (str);
			aClass6->Close (str);
		}

		strcpy (str_key, "001=Лекарственные средства, субстанции и вспомогательные вещества\\006=Поливитамины");
		str = chapters->Open (str_key);
		if (str) {
			crefs.Get (str);
			crefs.InheritPress ();
			if (notallowed_refs.ItemCount) crefs.Minus (notallowed_refs);
			chapters->Close (str);

			strcpy (key->text, class6InpharmCSubs);
			key->id = aId++;
			str = aClass6->Index::OpenN (key,0,1);
			crefs.Put (str);
			aClass6->Close (str);
		}

		key->level = 1;
		key->parent = c6_inpharm_id;
		key->id = aId++;
		strcpy (key->text, class6InpharmLekS);
		str = aClass6->Index::OpenN (key,0,1);
		refs.Put (str);
		aClass6->Close (str);

		key->id = aId++;
		strcpy (key->text, class6InpharmFirms);
		str = aClass6->Index::OpenN (key,0,1);
		refs.Put (str);
		aClass6->Close (str);

		key->id = aId++;
		strcpy (key->text, class6InpharmDic);
		str = aClass6->Index::OpenN (key,0,1);
		refs.Put (str);
		aClass6->Close (str);
	}

	if (bClass6)
		aClass6->LastId = aId + 1;

	if (!b_only_class6) {
		Stream* str = auxInd->Open (AUX_SERV);
		long size = 0;
		char *data;
		if (str) {
			size = str->Length ();
			data = (char*) malloc (size);
			str->Read (data, size);
			auxInd->Close (str);
		} else {
			data = strdup ("c6ab:002=Справочная информация\\001=Бизнес-справки|c6co:002=Справочная информация\\001=Бизнес-справки\\001=Кодексы Российской Федерации|c6ca:002=Справочная информация\\001=Бизнес-справки\\002=Налоговые и производственные календари|c6ms:002=Справочная информация\\004=Налоги, бухучет\\004=Формы учета и отчетности в MS-Word и MS-Excel|c6ob:002=Справочная информация\\001=Бизнес-справки\\005=Все бизнес-справки|c6mo:002=Справочная информация\\002=Мониторинг законодательства|c6hi:002=Справочная информация\\003=Горячая информация|c6nd:002=Справочная информация\\999=Новые поступления|c6na:001=Правовой навигатор|c6si:002=Справочная информация|c6ii:003=ИнФарм|c6is:003=ИнФарм\\001=Поиск лекарственных средств|c6ic:003=ИнФарм\\002=Разделы справочника|c6il:003=ИнФарм\\003=Лекарственные средства, разрешенные к применению|c6if:003=ИнФарм\\004=Фармацевтические фирмы|c6id:003=ИнФарм\\005=Словарь медицинских терминов|c6nf:002=Справочная информация\\004=Налоги, бухучет|c6ju:002=Справочная информация\\005=Юридические вопросы|c6hr:002=Справочная информация\\006=Кадровые вопросы|c6bo:002=Справочная информация\\007=Государственный сектор|csnf:002=Справочная информация\\004=Налоги, бухучет\\005=СМИ по налогам и бухучету|csju:002=Справочная информация\\005=Юридические вопросы\\005=СМИ для юриста|cshr:002=Справочная информация\\006=Кадровые вопросы\\005=СМИ по кадровым вопросам|csbo:002=Справочная информация\\007=Государственный сектор\\005=СМИ для государственного сектора");
			size = strlen (data) + 1;
			for (int i = 0; i < size; i++) {
				if (data [i] == '|')
					data [i] = '\0';
			}
			str = auxInd->Open (AUX_SERV, 1);
			str->Write (data, size);
			auxInd->Close (str);
		}
		std::map<std::string,std::string> map_auxkey_class6key;
		char *ptr = data, aux_key [5];
		while (ptr - data < size) {
			strncpy (aux_key, ptr, 4);
			aux_key [4] = '\0';
			map_auxkey_class6key.insert (std::map<std::string,std::string>::value_type (aux_key, ptr+5));
			ptr += strlen (ptr) + 1;
		}
		free (data);
		for (std::map<std::string,std::string>::const_iterator it = map_auxkey_class6key.begin (); it != map_auxkey_class6key.end (); it++) {
			BTKEY key = b->FindIndex ("Class6")->FullKey (it->second.c_str ());
			if (key) {
				Stream* str = auxInd->Open (it->first.c_str (), 1);
				long id = ((HIndex::HIndexKey*) key)->id;
				str->Write (&id, sizeof (id));
				str->Trunc ();
				auxInd->Close (str);
				free((void*)key);
			} else {
				auxInd->Delete (it->first.c_str ());
			}
		}
	}

	std::map <long, std::string> map_kind_id_str;
	std::map <std::string, long> map_kind_str_id;
	std::map <long, u_int64_t> map_kind_uid_bit;
	std::map <u_int64_t, long> map_kind_bit_uid;

	if (!b_only_class6) {
		pscreen->SetMessage("пВТБВПФЛБ ЧЙДПЧ РТБЧПЧПК ЙОЖПТНБГЙЙ ДПЛХНЕОФПЧ");
		Stream *str = aBase->FindIndex ("Aux")->Open (AUX_KIND_UIDS);
		if (!str) {
			map_kind_id_str.insert (std::map<long,std::string>::value_type (0,"BadKey"));
			map_kind_str_id.insert (std::map<std::string,long>::value_type ("BadKey",0));
		} else {
			long size = str->Length ();
			char* data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			while (ptr - data < size) {
				char* pos = strchr (ptr, '|');
				if (pos) {
					long id = atol (pos+1);
					*pos = 0;
					map_kind_id_str.insert (std::map<long,std::string>::value_type (id, ptr));
					map_kind_str_id.insert (std::map<std::string,long>::value_type (ptr, id));
					*pos = '|';
				}
				ptr += strlen (ptr) + 1;
			}
			gk_free (data);
			aBase->FindIndex ("Aux")->Close (str);
		}

		str = aBase->FindIndex ("Aux")->Open (AUX_KIND_BITS);
		if (!str) {
			map_kind_uid_bit.insert (std::map<long,u_int64_t>::value_type (0,0));
			map_kind_bit_uid.insert (std::map<u_int64_t,long>::value_type (0,0));
		} else {
			long size = str->Length ();
			char *data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			size /= sizeof (long) + sizeof (u_int64_t);
			while (size) {
				long uid = *(long*)ptr;
				ptr += sizeof (long);
				u_int64_t bit = *(u_int64_t*) ptr;
				ptr += sizeof (u_int64_t);
				map_kind_uid_bit.insert (std::map<long,u_int64_t>::value_type (uid, bit));
				map_kind_bit_uid.insert (std::map<u_int64_t,long>::value_type (bit, uid));
				size--;
			}
			gk_free (data);
			aBase->FindIndex ("Aux")->Close (str);
		}
	}

	long *map_doc_mask = 0, map_count = 0;
	if (!b_only_class6) {
		char full_key [1024];
		HIndex* index_kind = (HIndex*) aBase->FindIndex ("Kind");
		DocCollection docs_with_kind;

		for (it = new BTIterator (index_kind); !it->End(); ++*it) {
			HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)it->Key();
			if (aKey->chCount)
				continue;

			Stream *str = index_kind->Index::OpenN (aKey, 0);
			if (str) {
				DocCollection docs;
				docs.FastLoadRefs (str);
				index_kind->Close (str);
				docs_with_kind.Merge (docs);
			}
		}
		delete it;

		map_count = docs_with_kind.ItemCount;
		map_doc_mask = new long [map_count * 3];
		long *ptr = map_doc_mask;
		for (int i = 0; i < docs_with_kind.ItemCount; i++) {
			*ptr++ = docs_with_kind [i];
			*ptr++ = 0;
			*ptr++ = 0;
		}
		docs_with_kind.FreeAll ();

		for (BTIterator it2 (index_kind); !it2.End (); ++it2) {
			HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)it2.Key ();
			if (aKey->chCount)
				continue;

			index_kind->FullName (aKey, full_key);
			if (map_kind_str_id.find (full_key) == map_kind_str_id.end ())
				continue;
			long uid = map_kind_str_id.find (full_key)->second;
			if (!uid)
				continue;

			if (map_kind_uid_bit.find (uid) == map_kind_uid_bit.end ())
				continue;
			u_int64_t mask = map_kind_uid_bit.find (uid)->second;
			if (!mask)
				continue;

			Stream *str = index_kind->Index::OpenN (aKey, 0);
			if (str) {
				DocCollection docs;
				docs.FastLoadRefs (str);
				index_kind->Close (str);

				for (int i = 0; i < docs.ItemCount; i++) {
					long id = docs [i], *ptr = (long*) bsearch (&id, map_doc_mask, map_count, sizeof (long) * 3, longcmp);
					if (ptr) *(u_int64_t*)(++ptr) |= mask;
				}
			}
		}
	}

	if (!b_only_class6) {
		char* key = "InfL";
		Index *auxInd = aBase->FindIndex ("Aux");
		Stream *str = auxInd->Open (key, 1);
		long to_write = fastInfos.size ();
		str->Write (&to_write, sizeof (long));
		auxInd->Close (str);
	}

	if (!b_only_class6) {
		char* key = "DSSL";
		Index *auxInd = aBase->FindIndex ("Aux");
		Stream *str = auxInd->Open (key, 1);
		long to_write = dss_attribs.size ();
		str->Write (&to_write, sizeof (long));
		auxInd->Close (str);
	}

	if (!b_only_class6) {
		pscreen->SetMessage("уПТФЙТПЧЛБ УРЙУЛБ ДПЛХНЕОФПЧ");
		long docs_count = fastInfos.size (), *s_docs = new long [docs_count * 2], *docs_ptr = s_docs, i;
		std::deque<u_int64_t>::const_iterator deque_doc_atolnumber_it = deque_doc_atolnumber.begin ();
		for (std::deque<ShortCommonAttribute>::const_iterator fastInfos_it = fastInfos.begin (); fastInfos_it != fastInfos.end (); fastInfos_it++, docs_ptr++) {
			long id = fastInfos_it->m_id, number = 0;//0x7FFFFFFF;

			while (deque_doc_atolnumber_it != deque_doc_atolnumber.end ()) {
				long at = (long)((*deque_doc_atolnumber_it >> 32) & 0x7FFFFFFF);
				if (at == id) {
					number = (long) (*deque_doc_atolnumber_it & 0x7FFFFFFF);
					break;
				} else if (at < id){
					deque_doc_atolnumber_it++;
				} else {
					break;
				}
			}
			*docs_ptr = id;
			docs_ptr++;
			*docs_ptr = number;		
		}
		{
		std::deque<u_int64_t> empty;
		deque_doc_atolnumber.swap (empty);
		}

		qsort (s_docs, docs_count, sizeof (long) * 2, compare_using_number);
		u_int64_t *map_doc_posauxsort = new u_int64_t [docs_count], *ptr = map_doc_posauxsort;
		for (i = 0, docs_ptr = s_docs; i < docs_count; i++, docs_ptr += 2, ptr++)
			*ptr = ((u_int64_t)i << 32) + *docs_ptr;
		delete [] s_docs;
		qsort (map_doc_posauxsort, docs_count, sizeof (u_int64_t), longcmp);

		CommonAttribute* commonAttributes = new CommonAttribute [fastInfos.size ()], *ca_ptr = commonAttributes;
		for (std::deque<ShortCommonAttribute>::const_iterator fastInfos_it = fastInfos.begin (); fastInfos_it != fastInfos.end (); fastInfos_it++, ca_ptr++) {
			ShortCommonAttribute at_it = *fastInfos_it;
			long id = at_it.m_id, *ptr = (long*) bsearch (&id, map_doc_mask, map_count, sizeof (long) * 3, longcmp);
			CommonAttribute ca = {id, at_it.m_force, at_it.m_published, at_it.m_changed, at_it.m_status, ptr ? *(u_int64_t*)++ptr : 0, 0x7FFFFFFF};

			long* map_it = (long*) bsearch (&id, map_doc_posauxsort, docs_count, sizeof (u_int64_t), longcmp);
			if (map_it)
				ca.m_number = *++map_it;
			memcpy (ca_ptr, &ca, sizeof (ca));
		}
		delete [] map_doc_posauxsort;
		delete [] map_doc_mask;

		long buffer_size = 3096 * sizeof (CommonAttribute), length = fastInfos.size () * sizeof (CommonAttribute);
		char *src_ptr = (char*) commonAttributes, *packed_buffer = (char*) malloc (buffer_size + 1024), *key = "Inf7";
		Stream *str = aBase->FindIndex ("Aux")->Open (key, 1);
		if (str) {
			while (true) {
				long bytes_topack = std::min <long> (buffer_size, length);
				long packed_size = G_ZIP ((char*) src_ptr, bytes_topack, packed_buffer, bytes_topack + 1024);
				src_ptr += bytes_topack;
				str->Write (&packed_size, sizeof (long));
				str->Write (packed_buffer, packed_size);
				length -= bytes_topack;
				if (!length)
					break;
			}
			str->Trunc ();
			aBase->FindIndex ("Aux")->Close (str);
		}

		gk_free (packed_buffer);
		delete [] commonAttributes;
		std::deque<ShortCommonAttribute> empty;
		fastInfos.swap (empty);

		if (bases_list.size () > 1) {
			long size = map_doc_basechar.size () * (sizeof (long) + sizeof (char));
			char *data = new char [size], *ptr = data;
			for (std::map<long,char>::const_iterator doc_it = map_doc_basechar.begin (); doc_it != map_doc_basechar.end (); doc_it++) {
				long doc = doc_it->first;
				memcpy (ptr, &doc, sizeof (doc));
				ptr += sizeof (doc);
				*ptr = doc_it->second;
				ptr++;
			}
			Stream *str = aBase->FindIndex ("Aux")->Open (AUX_DOC_BASE, 1);
			if (str) {
				str->Write (data, size);
				str->Trunc ();
				aBase->FindIndex ("Aux")->Close (str);
			}
			delete []data;
			map_doc_basechar.clear ();

			size = map_blob_basechar.size () * (sizeof (long) + sizeof (char));
			data = new char [size], ptr = data;
			for (std::map<long,char>::const_iterator doc_it = map_blob_basechar.begin (); doc_it != map_blob_basechar.end (); doc_it++) {
				long doc = doc_it->first;
				memcpy (ptr, &doc, sizeof (doc));
				ptr += sizeof (doc);
				*ptr = doc_it->second;
				ptr++;
			}
			str = aBase->FindIndex ("Aux")->Open (AUX_BLOB_BASE, 1);
			if (str) {
				str->Write (data, size);
				str->Trunc ();
				aBase->FindIndex ("Aux")->Close (str);
			}
			delete []data;
			map_blob_basechar.clear ();
		}
	}

	if (!b_only_class6) {
		pscreen->SetMessage("уПТФЙТПЧЛБ УРЙУЛБ ДПЛХНЕОФПЧ");
		DSSAttribute* dssAttributes = new DSSAttribute [dss_attribs.size ()], *dss_ptr = dssAttributes;
		for (std::deque<DSSAttribute>::const_iterator dss_attribs_it = dss_attribs.begin (); dss_attribs_it != dss_attribs.end (); dss_attribs_it++, dss_ptr++) {
			DSSAttribute at_it = *dss_attribs_it;
			memcpy (dss_ptr, &at_it, sizeof (at_it));
		}

		long buffer_size = 4096 * sizeof (DSSAttribute), length = dss_attribs.size () * sizeof (DSSAttribute);
		char *src_ptr = (char*) dssAttributes, *packed_buffer = (char*) malloc (buffer_size + 1024), *key = "DSSF";
		Stream *str = aBase->FindIndex ("Aux")->Open (key, 1);
		if (str) {
			while (true) {
				long bytes_topack = std::min <long> (buffer_size, length);
				long packed_size = G_ZIP ((char*) src_ptr, bytes_topack, packed_buffer, bytes_topack + 1024);
				src_ptr += bytes_topack;
				str->Write (&packed_size, sizeof (long));
				str->Write (packed_buffer, packed_size);
				length -= bytes_topack;
				if (!length)
					break;
			}
			str->Trunc ();
			aBase->FindIndex ("Aux")->Close (str);
		}

		delete dssAttributes;
		gk_free (packed_buffer);

		std::deque<DSSAttribute> empty;
		dss_attribs.swap (empty);
	}

	if (!b_only_class6) {
		std::deque<std::string> numbers;
		{
		Index* index = b->FindIndex ("Number");
		for (BTIterator it (index); !it.End (); ++it) {
			char* number = (char*) it.Key ();
			numbers.push_back (number);
		}
		}

		if (numbers.size ()) {
			pscreen->SetMessage("уПТФЙТПЧЛБ УРЙУЛБ ОПНЕТПЧ ДПЛХНЕОФПЧ");
			long count = numbers.size ();
			Stream* str = aBase->FindIndex ("Aux")->Open (AUX_NUMBERS, 1);
			str->Write (&count, sizeof (count));
			static const long max_buffer_length = 1024*1024;
			static const long buffer_in_size = max_buffer_length + CODE_KEY_SIZE;
			static const long buffer_out_size = buffer_in_size + 128;
			char buffer [buffer_in_size], packed_buffer [buffer_out_size], *ptr;
			std::deque<std::string>::const_iterator it = numbers.begin ();
			while (it != numbers.end ()) {
				long size = 0;
				for (ptr = buffer; size < max_buffer_length && it != numbers.end (); it++) {
					strcpy (ptr, it->c_str ());
					long len = it->size ();
					ptr += len + 1;
					size += len + 1;
				}
				long packed_size = G_ZIP ((char*) buffer, size, packed_buffer, buffer_out_size);
				str->Write (&packed_size, sizeof (long));
				str->Write (&size, sizeof (long));
				str->Write (packed_buffer, packed_size);
			}
			str->Trunc ();
			aBase->FindIndex ("Aux")->Close (str);
			std::deque<std::string> empty;
			numbers.swap (empty);
		} else {
			aBase->FindIndex ("Aux")->Delete (AUX_NUMBERS);
		}

		std::deque<std::string> numbers_rcode;
		{
		Index *index = b->FindIndex ("RCode");
		for (BTIterator it (index); !it.End (); ++it) {
			char* number = (char*) it.Key ();
			numbers_rcode.push_back (number);
		}

		if (numbers_rcode.size ()) {
			pscreen->SetMessage("уПТФЙТПЧЛБ УРЙУЛБ ОПНЕТПЧ ДПЛХНЕОФПЧ");
			long count = numbers_rcode.size ();
			Stream* str = aBase->FindIndex ("Aux")->Open (AUX_NUMBERS_RCODE, 1);
			str->Write (&count, sizeof (count));
			static const long max_buffer_length = 1024*1024;
			static const long buffer_in_size = max_buffer_length + CODE_KEY_SIZE;
			static const long buffer_out_size = buffer_in_size + 128;
			char buffer [buffer_in_size], packed_buffer [buffer_out_size], *ptr;
			std::deque<std::string>::const_iterator it = numbers_rcode.begin ();
			while (it != numbers_rcode.end ()) {
				long size = 0;
				for (ptr = buffer; size < max_buffer_length && it != numbers_rcode.end (); it++) {
					strcpy (ptr, it->c_str ());
					long len = it->size ();
					ptr += len + 1;
					size += len + 1;
				}
				long packed_size = G_ZIP ((char*) buffer, size, packed_buffer, buffer_out_size);
				str->Write (&packed_size, sizeof (long));
				str->Write (&size, sizeof (long));
				str->Write (packed_buffer, packed_size);
			}
			str->Trunc ();
			aBase->FindIndex ("Aux")->Close (str);
			std::deque<std::string> empty;
			numbers_rcode.swap (empty);
		} else {
			aBase->FindIndex ("Aux")->Delete (AUX_NUMBERS_RCODE);
		}
		}
	}

	/*
	{
#ifndef	UPDATE_FACE
	if (!b_english_base) pscreen->SetMessage("рПДУЮЕФ ДМЙО ТХЮОЩИ НБУПЛ");
#endif
	long size = 0;
	std::map<long, std::vector<long> >::iterator it;
	for (it = map_doc_lens.begin (); it != map_doc_lens.end (); it++) {
		it->second.push_back (0);
		size += sizeof (long) + it->second.size () * sizeof (long);
	}
	if (size) {
		long *data = (long*) malloc (size), *ptr = data;
		for (it = map_doc_lens.begin (); it != map_doc_lens.end (); it++) {
			*ptr++ = it->first;
			for (std::vector<long>::const_iterator it2 = it->second.begin (); it2 != it->second.end (); it2++, ptr++)
				*ptr = *it2;
		}
		Stream* str = aBase->FindIndex ("Aux")->Open (AUX_HANDMASK_LENS, 1);
		if (str) {
			str->Write (data, size);
			str->Trunc ();
			aBase->FindIndex ("Aux")->Close (str);
		}
		gk_free (data);
	} else {
		aBase->FindIndex ("Aux")->Delete (AUX_HANDMASK_LENS);
	}
	}
	*/

	if (!b_only_class6) {
		long size = 0;
		std::map<long, std::deque<long> >::iterator it;
		for (it = map_doc_invlens.begin (); it != map_doc_invlens.end (); it++)
			size += sizeof (long) + it->second.size () * sizeof (long);
		if (size) {
			long *data = (long*) malloc (size), *ptr = data;
			for (it = map_doc_invlens.begin (); it != map_doc_invlens.end (); it++) {
				*ptr++ = it->first;
				for (std::deque<long>::const_iterator it2 = it->second.begin (); it2 != it->second.end (); it2++, ptr++)
					*ptr = *it2;
			}
			Stream* str = aBase->FindIndex ("Aux")->Open (AUX_INVISIBLE_LENS, 1);
			if (str) {
				str->Write (data, size);
				str->Trunc ();
				aBase->FindIndex ("Aux")->Close (str);
			}
			gk_free (data);
		} else {
			aBase->FindIndex ("Aux")->Delete (AUX_INVISIBLE_LENS);
		}
		map_doc_invlens.clear ();
	}

	if (!b_only_class6) {
		long size = 0;
		std::map<long, std::deque<long> >::iterator it;
		for (it = map_doc_invreles.begin (); it != map_doc_invreles.end (); it++)
			size += sizeof (long) + it->second.size () * sizeof (long);
		if (size) {
			long *data = (long*) malloc (size), *ptr = data;
			for (it = map_doc_invreles.begin (); it != map_doc_invreles.end (); it++) {
				*ptr++ = it->first;
				for (std::deque<long>::const_iterator it2 = it->second.begin (); it2 != it->second.end (); it2++, ptr++)
					*ptr = *it2;
			}
			Stream* str = aBase->FindIndex ("Aux")->Open (AUX_INVISIBLE_RELES, 1);
			if (str) {
				str->Write (data, size);
				str->Trunc ();
				aBase->FindIndex ("Aux")->Close (str);
			}
			gk_free (data);
		} else {
			aBase->FindIndex ("Aux")->Delete (AUX_INVISIBLE_RELES);
		}
		map_doc_invreles.clear ();
	}

	if (!b_only_class6) {
		//todo
		if (fastInpharms.size ()) {
			pscreen->SetMessage("ъБРЙУШ ЙНЕО НЕДЙГЙОУЛЙИ ФЕТНЙОПЧ");
			Stream *str = auxInd->Open (AUX_MEDTOPICS_SUBNAMES, 1);
			if (str) {
				std::deque<InpharmAttribute>::const_iterator it;
				char buffer [SUB_NAME_SIZE * 3];
				for (it = fastInpharms.begin (); it != fastInpharms.end (); it++) {
					long id = it->m_id, sub_count = 0, size;
					SubDesc *org_subs = (SubDesc*) aBase->LoadAttr (id, IDD_SUBS, sub_count), *ptr = org_subs;
					sub_count /= sizeof (SubDesc);
					std::map<long,std::string> sub_names;
					for (int i = 0; i < sub_count; i++, ptr++) {
						long sub = ptr->Sub;
						buffer [0] = '\0';
						if (b->FindSubName (id, sub, buffer))
							sub_names.insert (std::map<long,std::string>::value_type (sub, buffer));
					}
					if (sub_names.size ()) {
						size = sizeof (long) * 2 + sub_names.size () * sizeof (long);
						std::map<long,std::string>::const_iterator it;
						for (it = sub_names.begin (); it != sub_names.end (); it++)
							size += it->second.size () + 1;
						char* to_write = (char*) malloc (size), *to_put = to_write;
						*(long*)to_put = id; to_put += sizeof (long);
						*(long*)to_put = sub_names.size (); to_put += sizeof (long);
						for (it = sub_names.begin (); it != sub_names.end (); it++) {
							*(long*)to_put = it->first; to_put += sizeof (long);
							strcpy (to_put, it->second.c_str ());
							to_put += it->second.size () + 1;
						}
						str->Write (to_write, size);
						gk_free (to_write);
					}
					if(org_subs)
						free(org_subs);
				}
				str->Trunc ();
				auxInd->Close (str);
			}
		} else {
			auxInd->Delete (AUX_MEDTOPICS_SUBNAMES);
		}

		long size = 0;
		std::deque<InpharmAttribute>::const_iterator it;
		for (it = fastInpharms.begin (); it != fastInpharms.end (); it++)
			size += sizeof (it->m_id) + sizeof (it->m_status_ex) + strlen (it->name) + 1;
		InpharmAttribute *info = (InpharmAttribute*) malloc (size);
		char *ptr = (char*) info, *key = "IInf";
		for (it = fastInpharms.begin (); it != fastInpharms.end (); it++) {
			InpharmAttribute* put = (InpharmAttribute*)ptr;
			put->m_id = it->m_id; ptr += sizeof (put->m_id);
			put->m_status_ex = it->m_status_ex; ptr += sizeof (put->m_status_ex);
			strcpy (ptr, it->name); ptr += strlen (ptr) + 1;
			gk_free (it->name);
		}
		if (size) {
			Stream *str = auxInd->Open (key, 1);
			str->Write (info, size);
			str->Trunc();
			auxInd->Close (str);
			gk_free (info);
		} else {
			auxInd->Delete (key);
		}

		std::deque<InpharmAttribute> empty;
		fastInpharms.swap (empty);
	}

	std::map<long,long> map_firmtopic_firmid;
	if (!b_only_class6) {
		//todo
		DocCollection *firms = aBase->inpharm_firmtopics ();
		Index* firms_index = aBase->FindIndex ("PhFirm");
		for (BTIterator it (firms_index); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
			Stream* str = firms_index->Index::OpenN (key, 0);
			if (str) {
				DocCollection *docs = new DocCollection;
				docs->FastLoadRefs (str);
				firms_index->Close (str);
				docs->Intersect (*firms);
				if (docs->ItemCount)
					map_firmtopic_firmid.insert (std::map<long,long>::value_type ((*docs) [0], key->id));
				delete docs;
			}
		}

		std::map<std::string, std::set<long> > map_country_firmids;
		Index* country_index = aBase->FindIndex ("PhCountry");
		for (BTIterator it (country_index); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
			Stream* str = country_index->Index::OpenN (key, 0);
			if (str) {
				DocCollection *docs = new DocCollection;
				docs->FastLoadRefs (str);
				country_index->Close (str);
				docs->Intersect (*firms);
				if (docs->ItemCount) {
					std::set<long> firmids;
					for (int i = 0; i < docs->ItemCount; i++) {
						long doc_id = (*docs) [i];
						std::map<long,long>::const_iterator map_it = map_firmtopic_firmid.find (doc_id);
						if (map_it != map_firmtopic_firmid.end ()) {
							long id = map_it->second;
							firmids.insert (id);
						}
					}
					map_country_firmids.insert (std::map<std::string, std::set<long> >::value_type (key->text+4, firmids));
				}
				delete docs;
			}
		}

		long size = 0;
		std::map<std::string, std::set<long> > ::const_iterator i;
		for (i = map_country_firmids.begin (); i != map_country_firmids.end (); i++)
			size += i->first.size () + 1 + (i->second.size () + 1) * sizeof (long);
		if (size) {
			char *data = (char*) malloc (size), *ptr = data;
			for (i = map_country_firmids.begin (); i != map_country_firmids.end (); i++) {
				strcpy (ptr, i->first.c_str ());
				ptr += strlen (ptr) + 1;
				long* id = (long*) ptr;
				for (std::set<long>::const_iterator ids_it = i->second.begin (); ids_it != i->second.end (); ids_it++, id++, ptr += sizeof (long))
					*id = *ids_it;
				*id = 0;
				ptr += sizeof (long);
			}

			char* key = AUX_COUNTRY_FIRMS;
			Stream *str = aBase->FindIndex ("Aux")->Open (key, 1);
			str->Write (data, size);
			aBase->FindIndex ("Aux")->Close (str);
			gk_free (data);
		}
		delete firms;
	}

	if (!b_only_class6) {
		std::deque<editionStruct> fastEditions;
		pscreen->SetMessage("уПЪДБОЙЕ ЙОДЕЛУБ ТЕДБЛГЙК");
		for (std::map<long,long>::const_iterator it = map_docid_nextedition.begin (); it != map_docid_nextedition.end (); it++) {
			long id = it->first, docPos = std::binary_search (only_docs.begin (), only_docs.end (), id) ? 1 : 0;
			if (0 == docPos) {
				//натолкнулись на редакцию
				std::map<long,long>::const_iterator next_it = it;
				while (true) {
					long nextid = next_it->second;
					docPos = std::binary_search (only_docs.begin (), only_docs.end (), nextid) ? 1 : 0;
					if (0 == docPos) {
						//следующая редакция - по прежнему редакция, продолжим перебор
						next_it = map_docid_nextedition.find (nextid);
						if (next_it == map_docid_nextedition.end ())
							break;
						if (next_it->second == nextid)
							break;
					} else {
						//уперлись в документ
						editionStruct es;
						es.doc = nextid;
						es.id = id;
						fastEditions.push_back (es);
						break;
					}
				}
			} else {
				//натолкнулись на документ. надо для его всех будущих редакций записать, что у них есть "актуальный" документ
				std::map<long,long>::const_iterator next_it = it;
				while (true) {
					long nextid = next_it->second;
					if (nextid == id)
						break;
					editionStruct es;
					es.id = nextid;
					es.doc = id;
					fastEditions.push_back (es);

					next_it = map_docid_nextedition.find (nextid);
					if (next_it == map_docid_nextedition.end ())
						break;
					if (next_it->second == nextid)
						break;
				}
			}
		}
		
		char* key = "Edis";
		Stream* str = auxInd->Open (key, 1);
		if (str) {
			if (fastEditions.size ()) {
				for (std::deque<editionStruct>::const_iterator it = fastEditions.begin (); it != fastEditions.end (); it++) {
					editionStruct es = *it;
					if (std::binary_search (editions.begin (), editions.end (), es.id))
						str->Write (&es, sizeof (es));
				}
				str->Trunc();
				fastEditions.clear ();
			}
			auxInd->Close( str );
		}

		{
			std::deque<long> empty;
			only_docs.swap (empty);
		}
		{
			std::deque<long> empty;
			editions.swap (empty);
		}
	}
	map_docid_nextedition.clear ();

	if (!b_only_class6 && b->FindIndex ("Context.str")->KeyCount == 0) {
		if (b_is_demo) {
			Stream* str = auxInd->Open (AUX_DEMO, 1);
			if (str) {
				str->Write (&b_is_demo, sizeof (b_is_demo));
				auxInd->Close( str );
			}
		} else
			auxInd->Delete (AUX_DEMO);
	}

	if (!b_only_class6) {
		char *key = AUX_BASENAMES;
		Stream* str = auxInd->Open (key);
		if (str) {
			long size = str->Length ();
			char *data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			auxInd->Close (str);

			std::map<long,std::string> rus_names, eng_names;
			for (; ptr - data < size; ptr += strlen (ptr) + 1) {
				if (!strchr (ptr, ':'))
					continue;
				char id [16];
				gk_bzero (id, sizeof (id));
				strncpy (id, ptr, strchr (ptr, ':') - ptr);
				if (!atol (id)) {
					continue;
				}
				char *names = strchr (ptr, ':') + 1;
				char *delimiter = strchr (ptr, '|');
				if (!delimiter)
					continue;
				*delimiter = '\0';
				delimiter++;
				rus_names.insert (std::map<long,std::string>::value_type (atol (id), names));
				eng_names.insert (std::map<long,std::string>::value_type (atol (id), delimiter));
				delimiter--;
				*delimiter = '|';				
			}
			if (rus_names.size ()) {
				Stream *str = auxInd->Open ("Base");
				if (str) {
					long size = str->Length ();
					BaseInfo *data = (BaseInfo*) malloc (size);
					int n = str -> Read (data, size) / sizeof (BaseInfo);
					auxInd->Close (str);
					std::set<long> existed_ids;
					for (int i = 0; i < n; i++) {
						long id = data [i].BaseId;
						if (!id)
							continue;

						existed_ids.insert (id);

						if (rus_names.find (id) == rus_names.end ())
							continue;
						bool b_replace = false;
						if (strcmp (data [i].Name, rus_names.find (id)->second.c_str ())) {
							bool b_trial = strstr (data [i].Name, STR_TRIAL_VERSION);
							strcpy (data [i].Name, rus_names.find (id)->second.c_str ());
							if (b_trial)
								strcpy (data [i].Name + std::min <long> (strlen (data [i].Name), BASE_NAME_SIZE - strlen (STR_TRIAL_VERSION) - 5), STR_TRIAL_VERSION);
							b_replace = true;
						}
						if (strcmp (data [i].NameEng, eng_names.find (id)->second.c_str ())) {
							strcpy (data [i].NameEng, eng_names.find (id)->second.c_str ());
							b_replace = true;
						}
						if (b_replace)
							b->ReplaceBaseInfo (id, &data [i]);
					}

					std::set<long> new_ids;
					for (std::map<long, std::string>::const_iterator map_it = rus_names.begin (); map_it != rus_names.end (); map_it++) {
						long id = map_it->first;
						if (existed_ids.find (id) == existed_ids.end ())
							new_ids.insert (id);
					}

					if (new_ids.size ()) {
						data = (BaseInfo*) realloc (data, size + new_ids.size () * sizeof (BaseInfo));
						BaseInfo *ptr = data + n;
						for (std::set<long>::const_iterator it = new_ids.begin (); it != new_ids.end (); it++, ptr++) {
							gk_bzero (ptr, sizeof (BaseInfo));
							short id = (short) *it;
							ptr->BaseId = id;
							strcpy (ptr->Name, rus_names.find (id)->second.c_str ());
							strcpy (ptr->NameEng, eng_names.find (id)->second.c_str ());
						}
						n += new_ids.size ();
						for (int i = 0; i < n - 1; i++) {
				            if (data [i].BaseId > data [i+1].BaseId) {
								BaseInfo    baseInfo;
								baseInfo = data [i];
								data [i] = data [i+1];
								data [i+1] = baseInfo;
							}
						}
						Stream *str = auxInd->Open ("Base");
						if (str) {
							str->Write (data, n * sizeof (BaseInfo));
							auxInd->Close (str);
						}
					}
					
					free (data);
				}
			}
		}
	}

	if (!b_only_class6) { 
		GenerateFiltered (AUX_fCla, "Class", AUX_FILTERED_CLASS, 10);
		GenerateFiltered (AUX_fPre, "Kind", AUX_FILTERED_PREFIX, 10);
		GenerateFiltered (AUX_fAdo, "Adopted", AUX_FILTERED_ADOPTED, 10);
		GenerateFiltered (AUX_fKnd, "Kind",        AUX_FILTERED_KIND,      3);
		GenerateFiltered (AUX_fPub, "PublishedIn", AUX_FILTERED_PUBLISHED, 1);
		GenerateFiltered (AUX_fPJU, "PublishedIn", AUX_FILTERED_PUBLISHED_JU, 1);
		GenerateFiltered (AUX_fPHR, "PublishedIn", AUX_FILTERED_PUBLISHED_HR, 1);
		GenerateFiltered (AUX_fPBO, "PublishedIn", AUX_FILTERED_PUBLISHED_BO, 1);
		GenerateFiltered (AUX_fPPH, "PublishedIn", AUX_FILTERED_PUBLISHED_PH, 1);
		GenerateFiltered (AUX_fCor, "Kind",        AUX_FILTERED_CORR,      3);
		GenerateFiltered (AUX_fILF, "LekForm", AUX_FILTERED_LEKFORM, 10);
	}

	if (chg_rel_data->size () && !b_only_class6) {
		pscreen->SetMessage("уПЪДБОЙЕ УРЙУЛПЧ ТЕМЕЧБОФОПУФЙ");
		//CRel
		char *key = AUX_RELEVANCY_CALCULATED_CHANGES;
		Stream* str = auxInd->Open (key, 1);
		if (str) {
			long count = chg_rel_data->size ();
			str->Write (&count, sizeof (count));
			for (DBCore::RelevancyTuneData::const_iterator it = chg_rel_data->begin (); it != chg_rel_data->end (); it++) {
				int rele = it->relevancy;
				str->Write (&rele, sizeof (rele));
				long doc_count = it->docs.size (), *docs = new long [doc_count], *ptr = docs, *packed_docs = new long [doc_count];
				str->Write (&doc_count, sizeof (doc_count));
				for (DBCore::DocDeque::const_iterator doc_it = it->docs.begin (); doc_it != it->docs.end (); doc_it++, ptr++)
					*ptr = *doc_it;
				long packed_size = G_ZIP ((char*) docs, doc_count * sizeof (long), (char*) packed_docs, doc_count * sizeof (long));
				str->Write (&packed_size, sizeof (packed_size));
				if (packed_size)
					str->Write (packed_docs, packed_size);
				else
					str->Write (docs, doc_count * sizeof (long));
				delete [] packed_docs;
				delete [] docs;
			}
			auxInd->Close (str);
		}
	}

	aBase = b_;

	/*{
	DocInfo docinfo;
	long docs [] = {10103000, 10164072, 10900200, 12127526};
	for (int i = 0; i < sizeof (docs) / sizeof (long); i++) {
		long doc_id = docs [i];
		if (b->FindDocInfo (doc_id, docinfo) == sizeof (DocInfo)) {
			RefCollection *corrs = b->get_correspondent (doc_id, 0, true);
			AttrKey key = {doc_id, IDD_FASTCORRS};
			Stream* str = b->FindIndex ("Attrs")->Open (&key,1);
			if (str) {
				corrs->Put (str);
				b->FindIndex ("Attrs")->Close (str);
			}
			delete corrs;
		}
	}
	}*/

	if (!b_only_class6) {
		bool b_gchg = false;
		Stream* str = auxInd->Open ("gchg");
		if (str) {
			b_gchg = true;
			auxInd->Close (str);
		}
		if (b_gchg) {
			gl_SetLicence(aBase->textFile,1000,1000,0);
		} else {
		#ifdef	__FreeBSD__
			long MU;
			if ( !aBase->textFile->GetAttr("MU", &MU, sizeof(MU)))
				//надо прописать лицензионные настройки
				gl_SetLicence(aBase->textFile,32,32);
		#else
			long MU = 31;
			if (auxInd->IsExist ("InfP")) {
				aBase->textFile->PutAttr ("MU", &MU, sizeof (MU));
			} else {
				if (!aBase->textFile->GetAttr ("MU", &MU, sizeof(MU))) {
					MU = 13;
					aBase->textFile->PutAttr ("MU", &MU, sizeof (MU));
				}
			}
		#endif
		}
	}

	pscreen->SetMessage("");
	pscreen->SetProgress(100);

	free(heres);

	if (onlyDocs) delete onlyDocs;
	if (all_docs) delete all_docs;
	return 0;
}

void addDummyPara( NewDocument *nd, int n )
{
	static char dp[5] = {8,0,0,0,0};
	while(n--){
		nd->AddPara(PS_PREFORMATTED,5,dp);
	}
}

int loadRefsFromDocStream( Stream *str, RefCollection *refs )
{
	int rv = 0;
	int n = str->Length()/sizeof(long);
	Ref r;
	r.Sub = 0;
	if( n ){
		long *ptr = (long *) malloc( n * sizeof(long) );
		if( ptr ){
			str->Read(ptr, n * sizeof(long) );
			for ( int i=0; i<n; i++ ){
				r.DocId = ptr[i];
				refs->Add(r);
			}
			free(ptr);
			return n;
		}
	}
	return rv;
}

#define MAKE_SPECIAL_NAME() \
			switch( mydid ){ \
				case ALLMENU: \
					me.name = FString(sAllDocs); \
					me.name.bDoFree = 1; \
					break; \
				case MAINMENU: \
					me.name = FString(sDocum); \
					me.name.bDoFree = 1; \
					break; \
				case COMMENU: \
					me.name = FString(sComms); \
					me.name.bDoFree = 1; \
					break; \
				case FORMENU: \
					me.name = FString(sForms); \
					me.name.bDoFree = 1; \
					break; \
				case PROJMENU: \
					me.name = FString(sProjs); \
					me.name.bDoFree = 1; \
					break; \
				case PRAKMENU: \
					me.name = FString(sPrakt); \
					me.name.bDoFree = 1; \
					break; \
				case INTMENU: \
					me.name = FString(sInter); \
					me.name.bDoFree = 1; \
					break; \
				case QUESMENU: \
					me.name = FString(sQuest); \
					me.name.bDoFree = 1; \
					break; \
				case BREFMENU: \
					me.name = FString(sBrefe); \
					me.name.bDoFree = 1; \
					break; \
				case PUBLISHEDMENU: \
					me.name = FString(sPublished); \
					me.name.bDoFree = 1; \
					break; \
				default: \
					if (!bIsBreeder) \
					{ \
						gllog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,  \
							"оЕЙЪЧЕУФОПЕ ЙНС ДМС ФПРЙЛБ ЧЕТИОЕЗП ХТПЧОС. йУРПМШЪХЕН ЙНС РП ХНПМЮБОЙА."); \
					} \
					slidx = me.name.index('\\'); \
					if( slidx > 0 ){ \
						me.name = FString( me.name.chars() + 4, slidx-4); \
						me.name.bDoFree = 1; \
					}else{ \
						me.name = FString( me.name.chars() + 4); \
						me.name.bDoFree = 1; \
					} \
					break; \
			}


int makeDocs( long mydid, clTreeNode &me, const FString &prefix, 
			  Index *idx, int noffs, int ir, bool plusplus = true )
{
	if( me.items ){
		char *mykey = (char *) alloca (prefix.length()+me.name.length()+1);
		strcpy(mykey, prefix.chars());
		if( prefix.length() ){
			strcat(mykey, "\\");
			strcat(mykey, me.name.chars());
		}else{
			if( me.name.length() )
				strcpy(mykey, me.name.chars());
			else
				strcpy(mykey, "" );
		}
		int slidx;
		if( mydid >= FIRST_MY_DOC ){
			slidx = me.name.index('\\');
			if( slidx > 0 ){
				me.name = FString(me.name.chars() + noffs, slidx - noffs);
				me.name.bDoFree = 1;
			}else{
				me.name = FString(me.name.chars() + noffs);
				me.name.bDoFree = 1;
			}
		}else{ 
			MAKE_SPECIAL_NAME();
		}
		NewDocument *md = new NewDocument ( b, mydid, 
				(char*) me.name.chars(), currentRevision, PM_ZIP );
		if (!md || !md->IsOk()) {
			gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
				"пЫЙВЛБ УПЪДБОЙС ОПЧПЗП ДПЛХНЕОФБ.\n");
			return 1;
		}
#ifdef VERSION61
	{
		Ref rrr;
		rrr.DocId= md->DocId;
		rrr.Sub= 0;
		Stream *str=b->FindIndex("SubName")->Open(&rrr, 1);
		str->Write((char*)me.name.chars(),me.name.length()+1);
		str->Trunc();
		b->FindIndex("SubName")->Close(str);
	}
#else
		b->PutAttr(md->DocId,IDD_NAME,(char*)me.name.chars(),
			me.name.length()+1);
#endif
		int mitems = me.items->length();
		int spacing =0;
		if( mitems <=6 ){
			addDummyPara(md, 10 - mitems );
			spacing = 1;
		}else if( mitems <= 18 ){
			addDummyPara(md, 10 - (mitems+1)/2 );
		}

		for( Pix i = me.items->first(); i; me.items->next(i) ){
			clTreeNode *iptr =  &(*(me.items))(i); 

			slidx = iptr->name.index('\\');

			if( slidx <=0 )
				slidx = iptr->name.length();

			int tl = slidx - noffs;
		#ifdef NO_LONG_HIGHLIGHTING
			char *ptr = (char*)iptr->name.chars()+noffs;
		#else
			char ptr[72];
			if( tl >72 ) tl = 72 ;
			memset(ptr, ' ', sizeof(ptr) );
			memcpy(ptr, iptr->name.chars()+noffs, tl );
			tl = 72;
		#endif

			if ( iptr->items ){
				// single reference
				int len = tl + 5 /*parahdr*/
							+sizeof(Ref)+3 // reftype_reflist single
							+ 2; // 2 \004 bytes

				char *paraBuf = new char[ len ];
				bzero(paraBuf, len);
				paraBuf[0] = 8;
				paraBuf[5] = 4; //ref. begin
				memcpy(paraBuf+6, ptr, tl );
				paraBuf[6+tl] = 4;
				paraBuf[7+tl] = REFTYPE_REFLIST;
				// + 2bytes
				*(long *)(paraBuf + 10 + tl) = ++next;
				plusplus = false;
				md->AddPara(MENU_PARA_STYLE, len, paraBuf );
				delete paraBuf;
				if (makeDocs(next, *iptr, mykey,idx,noffs, ir, false )) return 1;
			}else{
				char *fk = (char *) alloca (strlen(mykey)+1+iptr->name.length()+2);
				strcpy(fk, mykey);
				strcat(fk, "\\");
				strcat(fk, iptr->name.chars());
				Stream *str = idx->Open(fk);
				if( str ){
					RefCollection* refs = new RefCollection;
					if((ir)?refs->Get(str):loadRefsFromDocStream(str,refs)){
						int itc = refs->ItemCount;
						if( itc ){
							if( (unsigned) itc > NEW_MAX_MULTI ) {
								if (!bIsBreeder) {
									gllog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_KOI,"уМЙЫЛПН НОПЗП УУЩМПЛ ДМС ЛМАЮБ ");
									gllog.printfCP(AdvLogger::CD_ALT,"%s.", fk);
									gllog.printfCP(AdvLogger::CD_KOI," хУФБОПЧМЕОП %d.", NEW_MAX_MULTI);
								}
								itc = NEW_MAX_MULTI;
							}
							int len = 7 + sizeof(Ref)*itc + 3 + tl;
							char *paraBuf = new char[ len ];
							bzero(paraBuf, len);
							paraBuf[0] = 8;
							paraBuf[5] = 4;
							memcpy(paraBuf+6, ptr, tl );
							paraBuf[6+tl] = 4;
							paraBuf[7+tl] = REFTYPE_REFLIST;
							*(short*)(paraBuf + 8 + tl) = itc;
							Ref *rptr = (Ref *) (paraBuf + 10 + tl);
							for( int j=0; j< itc; j++){
								*rptr++ = (*refs)[j];
							}
							if(SortRefs((Ref*)(paraBuf+10+tl),itc,BY_PRIOR,1)){
								delete refs;
								return 1;
							}
							md->AddPara(MENU_PARA_STYLE, len, paraBuf );
							delete paraBuf;
						} else {
							if (!bIsBreeder) {
								gllog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_KOI,"рХУФПК УРЙУПЛ ДМС ЛМАЮБ ");
								gllog.printfCP(AdvLogger::CD_ALT,"%s.\n", fk);
							}
						}
					} else {
						if (!bIsBreeder) {
							gllog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_KOI,"оЕ НПЗХ РПМХЮЙФШ УУЩМЛЙ ДМС ЛМАЮБ ");
							gllog.printfCP(AdvLogger::CD_ALT,"%s.\n", fk);
						}
					}
					idx->Close(str);
					delete refs;
				} else {
					if (!bIsBreeder) {
						gllog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_KOI,"оЕФ ДБООЩИ ДМС ЛМАЮБ ");
						gllog.printfCP(AdvLogger::CD_ALT,"%s.\n", fk);
					}
				}
			}
			if( spacing ) addDummyPara(md, spacing);
		}
		delete md;
	}else{
		// actually, you _may_ be there in case we're 
		// at top collapsed level or just 1 level...
		if( mydid < FIRST_MY_DOC )
		{
			if (!bIsBreeder)
			{
				gllog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, 
					"пФУХФУФЧХЕФ ДЕТЕЧП ДМС ХЪМБ "); 
				gllog.printfCP(AdvLogger::CD_ALT, "%s.\n", me.name.chars());
			}
			char *mykey = new char[prefix.length()+me.name.length()+128];
			strcpy(mykey, prefix.chars());
			strcat(mykey, me.name.chars());

			int slidx;
			MAKE_SPECIAL_NAME();
			NewDocument *md = new NewDocument ( b, mydid, 
					(char*) me.name.chars(), 
					currentRevision, PM_ZIP );
			if (!md || !md->IsOk()) {
				gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
					"пЫЙВЛБ УПЪДБОЙС ОПЧПЗП ДПЛХНЕОФБ.\n");
				return 1;
			}
#ifdef VERSION61
	{
		Ref rrr;
		rrr.DocId= md->DocId;
		rrr.Sub= 0;
		Stream *str=b->FindIndex("SubName")->Open(&rrr, 1);
		str->Write((char*)me.name.chars(),me.name.length()+1);
		str->Trunc();
		b->FindIndex("SubName")->Close(str);
	}
#else
			b->PutAttr(md->DocId,IDD_NAME,(char*) me.name.chars(),
						   me.name.length()+1);
#endif
			addDummyPara(md, 10 );
			Stream *str = idx->Open(mykey);
			if( str ){
				RefCollection* refs = new RefCollection;
				if( (ir)?refs->Get(str):loadRefsFromDocStream(str,refs) ){
					int itc = refs->ItemCount;
					if( itc ){
						if( (unsigned) itc > NEW_MAX_MULTI )
						{
							if (!bIsBreeder)
							{
								gllog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_KOI,"уМЙЫЛПН НОПЗП УУЩМПЛ ДМС ЛМАЮБ ");
								gllog.printfCP(AdvLogger::CD_ALT,"%s.",mykey);
								gllog.printfCP(AdvLogger::CD_KOI,"хУФБОПЧМЕОП Ч %d.\n", NEW_MAX_MULTI);
							}
							itc = NEW_MAX_MULTI;
						}
						int tl = me.name.length();
				#ifdef NO_LONG_HIGHLIGHTING
						char *ptr = (char *)me.name.chars();
				#else
						char ptr[72];
						if( tl >72 ) tl = 72;
						memset(ptr, ' ', sizeof(ptr) );
						memcpy(ptr,me.name.chars(), tl );
						tl = 72;
				#endif

						int len = 7 + sizeof(Ref)*itc + 3 + tl;
						char *paraBuf = new char[ len ];
						bzero(paraBuf, len);
						paraBuf[0] = 8;
						paraBuf[5] = 4;
						memcpy(paraBuf+6, ptr, tl );
						paraBuf[6+tl] = 4;
						paraBuf[7+tl] = REFTYPE_REFLIST;
						*(short*)(paraBuf + 8 + tl) = itc;
						Ref *rptr = (Ref *) (paraBuf + 10 + tl);
						for( int j=0; j< itc; j++){
							*rptr++ = (*refs)[j];
						}
						if (SortRefs((Ref*)(paraBuf+10+tl),itc,BY_PRIOR,1)){
							delete refs;
							return 1;
						}
						md->AddPara(MENU_PARA_STYLE, len, paraBuf );
						delete paraBuf;
					}else{
							if (!bIsBreeder)
							{
								gllog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_KOI,"рХУФПК УРЙУПЛ ДМС ЛМАЮБ ");
								gllog.printfCP(AdvLogger::CD_ALT,"%s.\n",mykey);
							}
					}
				}else{
					if (!bIsBreeder)
					{
						gllog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_KOI,"оЕ НПЗХ РПМХЮЙФШ УУЩМЛЙ ДМС ЛМАЮБ ");
						gllog.printfCP(AdvLogger::CD_ALT,"%s.\n",mykey);
					}
				}
				idx->Close(str);
				delete refs;
			}else{
				if (!bIsBreeder)
				{
					gllog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_KOI,"оЕФ ДБООЩИ ДМС ЛМАЮБ ");
					gllog.printfCP(AdvLogger::CD_ALT,"%s.\n",mykey);
				}
			}
			delete md;
		}else{
			gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
						  "жБФБМШОБС ПЫЙВЛБ.\n");
		//	*errLog << "I should _NOT_ be there!." << endl;
		//	*errLog << "prefix  is " << prefix << endl;
		//	*errLog << "my name is " << me.name << endl;
		}
	}
	if ( plusplus ) next ++;
	return 0;
}
#undef MENU_PARA_STYLE

void collapsSingleNodes(int level, clTreeNode &me )
{
	if( me.items ){
		for( Pix i = me.items->first(); i; me.items->next(i) ){
			collapsSingleNodes( level +1, (*(me.items))(i) );
		}
		if( (me.items->length() == 1) && level){
			clTreeNodeSplaySet *tmp = me.items;
			Pix i = me.items->first();
			// *theOut << "collapsing me at " << me.name ;
			// *theOut << " => " << (*(me.items))(i).name << endl;
			char *tmp_buf = new char[me.name.length() + 1 + (*(me.items))(i).name.length()+ 2];
			strcpy(tmp_buf, me.name.chars());
			strcat(tmp_buf, "\\");
			strcat(tmp_buf, (*(me.items))(i).name.chars());
			me.name = FString(tmp_buf);
			me.name.bDoFree = 1;
			delete tmp_buf;
//			me.name += "\\" + (*(me.items))(i).name;
			me.items = (*(me.items))(i).items;
			delete tmp;
		}
	}
}

static TN * filterTree(TN *org, const char *auxn )
{
	TN *tmp = new TN();
	Index *idxAux = b->FindIndex("Aux");
	Stream *str = idxAux->Open(auxn);
	if( str ) {
		char *data = (char*) alloca(str->Length());
		str->Read(data, str->Length());
		ZStrings docPrefix(data, str->Length());
		idxAux->Close(str);
		TNClassFilter cf(&docPrefix);
		tmp->hcopy(org, &cf);
	}
	return tmp;
}

static TN * findTree(TN *org, const char *auxn )
{
	Index *idxAux = b->FindIndex("Aux");
	Stream *str = idxAux->Open(auxn);
	if( str )
	{
		char *data = (char*) alloca(str->Length());
		str->Read(data, str->Length());
		ZStrings docPrefix(data, str->Length());
		idxAux->Close(str);
		if (docPrefix.count() == 1)
			return org->findNode(docPrefix[0]->ptr);
		else
			return 0;
	}
	return 0;
}

static TN * cutTree(TN *org, const char *auxn )
{
	TN *tmp = new TN();
	Index *idxAux = b->FindIndex("Aux");
	Stream *str = idxAux->Open(auxn);
	if( str ) {
		char *data = (char*) alloca(str->Length());
		str->Read(data, str->Length());
		ZStrings docPrefix(data, str->Length());
		idxAux->Close(str);
		TN::NullFilter pf;
		tmp->hcopy(org, &pf);
	}
	return tmp;
}

int makeMenuTopics(Base *base)
{
	TN::Tree* clTree  = new TN::Tree;
	TN::Tree* pfxTree = new TN::Tree;

	HIndex *idx = (HIndex*) b->FindIndex ("Class");
	HIndex *idxP = (HIndex*) b->FindIndex ("DocKind");

	TN::readHIndex( idx, clTree);
	TN::readHIndex( idxP, pfxTree);
	
	static struct {	const char *auxn, *title; int topic; } bt[BUTTONS] = {
		{ PR_ALL,  sAllDocs, ALLMENU },
		{ PR_DOCS, sDocum, MAINMENU },
		{ PR_COMMENTS, sComms, COMMENU },
		{ PR_FORMS, sForms, FORMENU },
		{ PR_PROJECTS, sProjs,  PROJMENU },
		{ PR_PRACTICE, sPrakt, PRAKMENU },
		{ PR_INTERS, sInter, INTMENU },
		{ PR_QUES, sQuest, QUESMENU },
		{ PR_BREF, sBrefe, BREFMENU} };
		
	int i;
		
	PrefixReader *pr = new PrefixReader;
	pfxTree->root->hprocess(pr,1);
	delete pr;

	UTreeExpander *ute = new UTreeExpander( clTree );
	pfxTree->root->hprocess(ute,1);
	delete ute;
	
	UTreeConnector *utc = new UTreeConnector( clTree );
	pfxTree->root->hprocess(utc,1);
	delete utc;
	
	if (pfxTree->root->collapseEmptyNodes())	{
		//gllog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"Не могу добавить документы в основное меню\n");
		return 0;
	}

	pfxTree->root->collapseSingleNodes ();
	pscreen->SetProgress(83);
	
	for ( i = 0; i < 1/*BUTTONS*/; i++ ) {
		unsigned char bNeedDel = 0;
		TN * tmp = findTree(pfxTree->root, bt[i].auxn);
		if (!tmp) {
			tmp = filterTree(clTree->root, bt[i].auxn);
			tmp->collapseSingleNodes();
			bNeedDel = 1;
		}
		
		if( tmp->lastn ) {
			u_int64_tSplaySet * rf = filterRefs(idxP, bt[i].auxn);
			pfx_Info.insert (std::map<std::string,u_int64_tSplaySet*>::value_type (bt[i].auxn, rf));
			ClassEnumerator *cen = new ClassEnumerator(++next);
			tmp->hprocess( cen );
			next = cen->next();
			delete cen;
			ClassTreeToDoc *c2d = new ClassTreeToDoc(bt[i].auxn);
			const char * save_name = tmp->name();
			tmp->data.a = bt[i].topic;
			tmp->nm = bt[i].title;
			tmp->hprocess( c2d );
			delete c2d;
			tmp->nm = save_name;
		}
		pscreen->SetProgress(84+i);
		if (bNeedDel) delete tmp;
	}
	delete clTree->root;
	delete pfxTree->root;
	if(clTree->buffer) free(clTree->buffer);
	if(pfxTree->buffer) free( pfxTree->buffer );
	delete clTree;
	delete pfxTree;
	return 0;
}

int makePublishedTopics(Base *base)
{
	longcaddr_tSplayMap *id2node = new longcaddr_tSplayMap((caddr_t)0);
	clTreeNode clTreeRoot; /* = {
						FString("Published in"),
						0,
						0,
						0,
						0,
						0,
						0} ; */

	(*id2node) [0] = (caddr_t) &clTreeRoot;
	clTreeRoot.items = 0;
	HIndex *idx= (HIndex*)base->FindIndex("PublishedIn");
	if( !idx) return 1;

	for( BTIterator it(idx ); ! it.End(); ++it ){
		const void * k = it.Key();
		long id = idx->Id(k);
		long pid = idx->Parent(k);

		clTreeNode *pn = (clTreeNode *) (*id2node)[pid];
		if( !pn ){
			gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
						  "пЫЙВЛБ ЙЕТБТИЙЙ ДМС ХЪМБ %d.\n", id);
			exit(-1);
		}
		if( ! pn-> items )
			pn -> items = new clTreeNodeSplaySet();

		clTreeNode t;
		t.name = idx->Text(k);
		t.items = 0;

		Pix pc = pn -> items -> add(t);
		caddr_t iptr =  (caddr_t) & (*(pn->items))(pc); 

		(*id2node)[id] =  iptr;
	
	}
	delete id2node;
	id2node = 0;

	if( !clTreeRoot.items )
	{

/*		gllog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, 
			"рХОЛФЩ ДМС PIN НЕОА ПФУХФУФЧХАФ.\n");
*/		return 1;
	}

	// collapsSingleNodes( 0, clTreeRoot );

	if (makeDocs(PUBLISHEDMENU, clTreeRoot, FString(""),idx,4,0)){
		return 1;
	}
	next++;
	return 0;
}

/* 
!!!DEBUG ONLY!!!
#undef	FASTDICIDX
#define FASTDICIDX 1000000
!!!DEBUG ONLY!!! 
*/

#define LANGNUMB 6
#define PARASIZE MAX_PARA_LEN

char  *dicDOS2Win( char *buf, const char *str )
{
    for ( register int i = 0; str [i] != '\0'; i++ ) {
        switch ( str[i] ) {
        case (char)0xDE:
            buf[i] = (char)0xE2;
            break;
        case (char)0xD6:
            buf[i] = (char)0xC7;
            break;
        case (char)0xDD:
            buf[i] = (char)0xE9;
            break;
        case (char)0xDF:
            buf[i] = (char)0xD1;
            break;
        case (char)0xF8:
            buf[i] = (char)0xE0;
            break;
        case (char)0xF2:
            buf[i] = (char)0xE7;
            break;
        case (char)0xF3:
            buf[i] = (char)0xEA;
            break;
        case (char)0xF4:
            buf[i] = (char)0xE8;
            break;
        case (char)0xF5:
            buf[i] = (char)0xF1;
            break;
        case (char)0xF7:
            buf[i] = (char)0xC9;
            break;
        case (char)0xFD:
            buf[i] = (char)0xF4;
            break;
        case (char)0xFE:
            buf[i] = (char)0xF9;
            break;
        case (char)0xF6:
            buf[i] = (char)0xEC;
            break;
        case (char)0xa2:
            buf[i] = (char)0xf3;
            break;
		case (char)163:
            buf[i] = (char)0xfa;
            break;
		case (char)130:
            buf[i] = (char)0xe9;
            break;
		case (char)160:
            buf[i] = (char)0xe1;
            break;
		case (char)164:
            buf[i] = (char)0xf1;
            break;
		case (char)161:
            buf[i] = (char)0xed;
            break;
        default:
    		buf [i] = str [i];
            break;
        }
    }

	return buf;
}

int makeFastMDicIdx (Base *b, bool b_create)
{
	short key = DS_MDICTTOPIC;
	Stream *str = b->FindIndex ("Status_ex")->Open (&key);
	DocCollection docs;
	if (str) {
		docs.FastLoadRefs (str);
		b->FindIndex ("Status_ex")->Close (str);
	}

	if (docs.ItemCount == 0) {
		b->FindIndex ("Aux")->Delete (AUX_MEDICINE_GLOSSARY);
		b->FindIndex ("Aux")->Delete (AUX_MDICS);
	} else {
		str = b->FindIndex ("Aux")->Open (AUX_MEDICINE_GLOSSARY, 1);
		if (str) {
			for (long i = 0; i < docs.ItemCount; i++) {
				char name [DOC_NAME_SIZE];
				long id = docs [i], len = b->FindDocName (id, name);
				if (len) {
					str->Write (&id, sizeof (id));
					str->Write (name, len);
				}
			}
			str->Trunc ();
			b->FindIndex ("Aux")->Close (str);
		}

		str = b->FindIndex ("Aux")->Open (AUX_MDICS, 1);
		if (str) {
			str->Write (&docs.ItemCount, sizeof (docs.ItemCount));
			str->Trunc ();
			b->FindIndex ("Aux")->Close (str);
		}
	}

	return 0;
}

int makeFastDicIdx(Base *b, longSplaySet dicIDs )
{
	char* key = "Dics";

	short segment = 0;
	{
		for(short i=0; i<hcount; i++) {
			if (heres[i] == DICTIONARY_SEGMENT) {
				segment=DICTIONARY_SEGMENT;
				break;
			} else if (heres[i] == (DICTIONARY_SEGMENT_SML)) {
				segment=DICTIONARY_SEGMENT_SML;
				break;
			}
		}
	}
	if (segment == 0){
		auxInd->Delete( key );
		return 0;
	}

	b->DelDoc(FASTDICIDX);
	NewDocument *md = new NewDocument (b,FASTDICIDX,"FASTDICIDX",currentRevision,PM_ZIP);
	if (!md || !md->IsOk()) {
		auxInd->Delete( key );
		gllog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"пЫЙВЛБ УПЪДБОЙС ОПЧПЗП ДПЛХНЕОФБ.\n");
		return 1;
	}
	md->AddAttr(IDD_BASES,&segment,sizeof(segment));
	unsigned short ds[LANGNUMB]; // GARANT_SIGNED?
	char *dp=(char*)malloc(PARASIZE);
	memset(ds,0,LANGNUMB*sizeof(short));
	memset(dp,0,PARASIZE*sizeof(char));
	dp[0]=8;
	long para=0;
	{
		md->AddPara(PS_PREFORMATTED,5+sprintf(dp+5,"%s","EMPTY")+1,dp);
		para++;
	}
	{
		SubDescEx sub_desc = {1, para, SUBDESCEX_SUB, 1};
		b->PutAttr (FASTDICIDX, IDD_SUBS_EX, &sub_desc, sizeof (sub_desc));
	}
	char	names[ LANGNUMB ][ SUB_NAME_SIZE ];
	for ( Pix pix = dicIDs.first(); pix; dicIDs.next(pix) ) {
		long aId = dicIDs(pix);

		if ( aId >= BIG_INFO_DOC && aId <= BIG_INFO_DOC + BIG_INFO_COUNT )
			continue;

		long	namescount = 0;
		for ( long i = 0; i < LANGNUMB; i++ ) {
			long doc_id = dicIDs(pix);
			if (b->FindSubName(doc_id, i+1, names[ i ] )) {
				namescount++;
			} else
				names[ i ][ 0 ] = 0;
		}

		if ( namescount ) {
			md->AddPara(PS_PREFORMATTED,5+sprintf(dp+5,":%ld",dicIDs(pix))+1,dp);
			para++;

			for (long i = 0;i < LANGNUMB; i++ ) {
				char* sname = names[ i ];
				if ( sname[ 0 ] ) {
					if ( i > 1 ) dicDOS2Win( sname, sname );
					ds[ i ]++;
					md->AddPara(PS_PREFORMATTED,5+sprintf(dp+5,"%ld:%s",i+1,sname)+1,dp);
					para++;
				}
			}
		}
	}

	{
		SubDescEx sub_desc = {2, para, SUBDESCEX_SUB, 2};
		b->PutAttr (FASTDICIDX, IDD_SUBS_EX, &sub_desc, sizeof (sub_desc));
	}
	for (long i=1;i<=LANGNUMB;i++) {
		md->AddPara(PS_PREFORMATTED,5+sprintf(dp+5,"%ld",ds[i-1])+1,dp);
		para++;
	}

	Stream *str = auxInd->Open( key, 1 );
	if ( str ) {
		str->Write( &ds[0], sizeof( ds[0] ) );
		str->Trunc();
		auxInd->Close( str );
	}
	free(dp);
	delete md;
	return 0;
}

void	makeFastSnippet	(Base *m_base)
{
	Index* types_index   = m_base->FindIndex ("Type");
	Index* dates_index   = m_base->FindIndex ("Date");
	Index* status_index  = m_base->FindIndex ("Status");
	Index* adopted_index = m_base->FindIndex ("Adopted");

	long comments_id = 0;
	{
		for (BTIterator it (types_index); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
			char* key_text = key->text + 4;

			if (key->level == 0 && !strcmp (key_text, "Комментарии")) {
				comments_id = key->id;
				break;
			}
		}
	}

	DocCollection laws_plus, articles, books, berators, relateds, codexes, laws, decisions, norm_acts;

	Stream* str;
	{
		if (str = m_base->FindIndex ("Aux")->Open (AUX_RELEF_LAWS)) {
			laws_plus.Get (str);
			m_base->FindIndex ("Aux")->Close (str);
		}

		for (BTIterator it (types_index); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
			char* key_text = key->text + 4;

			if (key->level == 1 && key->parent == comments_id) {
				if (!strcmp (key_text, "Статья")) {
					if (str = types_index->keyOpen (key)) {
						articles.FastLoadRefs (str);
						types_index->Close (str);
					}
				} else if (!strcmp (key_text, "Книга")) {
					if (str = types_index->keyOpen (key)) {
						books.FastLoadRefs (str);
						types_index->Close (str);
					}
				} else if (!strcmp (key_text, "Бератор")) {
					if (str = types_index->keyOpen (key)) {
						berators.FastLoadRefs (str);
						types_index->Close (str);
					}
				} else if (!strcmp (key_text, "Справка")) {
					if (str = types_index->keyOpen (key)) {
						relateds.FastLoadRefs (str);
						types_index->Close (str);
					}
				}
			} else if (key->level == 0) {
				if (!strcmp (key_text, "Кодекс")) {
					if (str = types_index->keyOpen (key)) {
						codexes.FastLoadRefs (str);
						types_index->Close (str);
					}
				} else if (!strcmp (key_text, "Закон")) {
					if (str = types_index->keyOpen (key)) {
						laws.FastLoadRefs (str);
						types_index->Close (str);
					}
				} else if (!strcmp (key_text, "Постановление")) {
					if (str = types_index->keyOpen (key)) {
						decisions.FastLoadRefs (str);
						types_index->Close (str);
					}
				}
			}
		}
	}

	long government_id = 0;
	{
		for (BTIterator it (adopted_index); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();

			if (key->level == 0) {
				char* key_text = key->text + 4;

				if (!strcmp (key_text, "Правительство России и СССР")) {
					government_id = key->id;
				} else if (!strcmp (key_text, "Компания \"Гарант\"")) {
					if (str = adopted_index->keyOpen (key)) {
						DocCollection docs;
						docs.Get (str);
						adopted_index->Close (str);

						relateds.Merge (docs);
					}
				}				
			}
		}
	}

	{
		for (BTIterator it (adopted_index); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();

			if (key->level == 1 && key->parent == government_id) {
				if (!strcmp (key->text + 4, "Правительство России")) {
					if (str = adopted_index->keyOpen (key)) {
						DocCollection docs;
						docs.Get (str);
						adopted_index->Close (str);
						decisions.Intersect (docs);;
					}
					break;
				}
			}
		}

		short status_mojreg = DS_MOJREG;

		if (str = status_index->Open (&status_mojreg)) {
			norm_acts.Get (str);
			status_index->Close (str);
			norm_acts.Merge (decisions);
			norm_acts.Merge (laws_plus);
		}
	}

	date date_1_1_2005;
	date_1_1_2005.da_day = 1;
	date_1_1_2005.da_mon = 1;
	date_1_1_2005.da_year = 2005;
	DocCollection fresh_docs;
	{
		size_t size = 0, i = 0;

		for (BTIterator it (dates_index, &date_1_1_2005); !it.End (); ++it) {
			if (str = dates_index->keyOpen (it.Key ())) {
				DocCollection docs;
				docs.Get (str);
				dates_index->Close (str);
				fresh_docs.Merge (docs);
			}
		}

		articles.Intersect (fresh_docs);
		books.Intersect (fresh_docs);
		codexes.Intersect (fresh_docs);
	}

	DocCollection result;
	result.Merge (articles);
	result.Merge (relateds);
	result.Merge (books);
	result.Merge (norm_acts);
	result.Merge (berators);
	result.Merge (laws);
	result.Merge (codexes);

	DocCollection masks;
	AttrKey begin_key = {0, IDD_HANDMASK};
	BTIterator* it = new BTIterator (b->FindIndex ("Attrs"));
	it->Set (&begin_key);
	for (; !it->End ();++(*it)) {
		AttrKey *it_key = (AttrKey*) it->Key ();
		if (it_key->AttrTag > IDD_HANDMASK)
			break;
		masks.Collection::Add (&it_key->DocId);
	}
	delete it;
	result.Merge (masks);

	masks.FreeAll ();
	begin_key.AttrTag = IDD_HANDHANDMASK; begin_key.DocId = 0;
	it = new BTIterator (b->FindIndex ("Attrs"));
	it->Set (&begin_key);
	for (; !it->End ();++(*it)) {
		AttrKey *it_key = (AttrKey*) it->Key ();
		if (it_key->AttrTag > IDD_HANDHANDMASK)
			break;
		masks.Collection::Add (&it_key->DocId);
	}
	delete it;
	result.Merge (masks);

	char* key = AUX_FASTSNIPPETS_DOCS;
	if (str = b->FindIndex ("Aux")->Open (key, 1)) {
		if (result.ItemCount) {
			result.Put (str);
			str->Trunc ();
		}
		b->FindIndex ("Aux")->Close (str);
	}
}
