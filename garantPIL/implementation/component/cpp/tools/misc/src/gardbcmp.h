#ifndef __INDEX_COMPARATOR_H__
#define __INDEX_COMPARATOR_H__

#include "index.h"
#include "base.h"
#include "fstring.h"
#include "long.SplaySet.h"

class IndexComparator
{

public:

	IndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno );
	virtual ~IndexComparator();

protected:

	Index* idx1;
	Index* idx2;

	Stream* str1;
	Stream* str2;

	FString idxName;
	int strno;

	unsigned curStream;


	unsigned char idxHeaderCompare();

public:

	virtual unsigned char indexCompare() = 0;
};

class DocsIndexComparator: public IndexComparator
{
protected:

	unsigned char keyCompare(const void* key);

public:

	DocsIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ):IndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~DocsIndexComparator() {};
};

class StrDocsIndexComparator: public DocsIndexComparator
{
public:

	StrDocsIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ):DocsIndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~StrDocsIndexComparator() {};

	virtual unsigned char indexCompare();
};

class Int32DocsIndexComparator: public DocsIndexComparator
{
public:

	Int32DocsIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ):DocsIndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~Int32DocsIndexComparator() {};

	virtual unsigned char indexCompare();
};

class Int64DocsIndexComparator: public DocsIndexComparator
{
public:

	Int64DocsIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ):DocsIndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~Int64DocsIndexComparator() {};

	virtual unsigned char indexCompare();
};

class StrsIndexComparator: public IndexComparator
{
protected:
	
	unsigned char keyCompare(const void* key);

public:

	StrsIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ):IndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~StrsIndexComparator() {};
};

class BlobIndexComparator: public IndexComparator
{
protected:
	
	unsigned char keyCompare(const void* key);

public:

	BlobIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ):IndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~BlobIndexComparator() {};

	unsigned char indexCompare();
};

class RefIndexComparator: public StrsIndexComparator
{
public:

	RefIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ):StrsIndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~RefIndexComparator() {};

	unsigned char indexCompare();
};


const char *Rootc[] = { "Docs", "Comm", "Form", "Proj", "Prak", "Inte", "Ques", "Bref"};
const char *Rooti[] = { "User",	"Cale",	"Clas" };
class AuxIndexComparator: public IndexComparator
{
public:

	AuxIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ) :
	  IndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~AuxIndexComparator() {};

	unsigned char indexCompare();
};


const int TagIdInf[] = {IDD_INFO};
const int TagIdStr[] = {IDD_NAME,IDD_ID,IDD_TERRITORY,IDD_SOURCE,IDD_DIV,IDD_KEY,IDD_TYPE,IDD_RCODE,IDD_DOCKIND,IDD_WARNING,IDD_CATEGORY,IDD_PUBLISHEDIN};
const int TagIdDat[] = {IDD_DATE,IDD_VINCLUDED,IDD_VCHANGED,IDD_VABOLISHED,IDD_RDATE,IDD_SORTDATE,IDD_VANONCED,IDD_VLCONTROL,IDD_BASES,IDD_BLOB};
const int TagIdSub[] = {IDD_SUBS};

class AttrsIndexComparator: public IndexComparator
{
protected:

	Base *b1;
	Base *b2;

	AttrKey curKey;
	virtual int getTagIDs(const int*& tags) = 0;
	virtual unsigned char dataCompare(const void* data1, int len1, const void* data2, int len2) = 0;
	virtual unsigned char keyCompare(const void* key);

public:

	AttrsIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ):IndexComparator( _b1, _b2, _name, _strno ) 
	{
		b1 = (Base*)_b1; b2 = (Base*)_b2;
	};
	virtual ~AttrsIndexComparator() {};

	unsigned char docsCompare();
	unsigned char indexCompare();
};

class StrAttrsIndexComparator: public AttrsIndexComparator
{
protected:

	virtual int getTagIDs(const int*& tags)
	{
		tags = TagIdStr;
		return 12;
	}
	virtual unsigned char dataCompare(const void* data1, int len1, const void* data2, int len2);

public:

	StrAttrsIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ) :
	  AttrsIndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~StrAttrsIndexComparator() {};
};

class DateAttrsIndexComparator: public AttrsIndexComparator
{
protected:

	virtual int getTagIDs(const int*& tags)
	{
		tags = TagIdDat;
		return 8;
	}
	virtual unsigned char dataCompare(const void* data1, int len1, const void* data2, int len2);

public:

	DateAttrsIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ) :
	  AttrsIndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~DateAttrsIndexComparator() {};
};

class SubAttrsIndexComparator: public AttrsIndexComparator
{
protected:

	virtual int getTagIDs(const int*& tags)
	{
		tags = TagIdSub;
		return 1;
	}
	virtual unsigned char dataCompare(const void* data1, int len1, const void* data2, int len2);

public:

	SubAttrsIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ) :
	  AttrsIndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~SubAttrsIndexComparator() {};
};

class InfoAttrsIndexComparator: public AttrsIndexComparator
{
protected:

	virtual int getTagIDs(const int*& tags)
	{
		tags = TagIdInf;
		return 1;
	}
	virtual unsigned char dataCompare(const void* data1, int len1, const void* data2, int len2);

public:

	InfoAttrsIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ) :
	  AttrsIndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~InfoAttrsIndexComparator() {};
};

class HIndexComparator: public DocsIndexComparator, public StrsIndexComparator
{
public:

	HIndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno ) :
	  DocsIndexComparator( _b1, _b2, _name, _strno ), StrsIndexComparator( _b1, _b2, _name, _strno ) {};
	virtual ~HIndexComparator() {};

	unsigned char indexCompare();
};

#endif

