#ifndef __PARA_COLLECTION__
#define __PARA_COLLECTION__

/*
#include "refcol.h"
#include "garutils.h"
#include "stdbase.h"

// GARANT_GCC

class	BlockCollection : public RefCollection
{
public:
	BlockCollection() : RefCollection() {}

	virtual int Get( Store* str, bool titles = false, bool ignoreForm = true, char form = 0 );
};

class	ParaCollection : public RefCollection
{
public:
	ParaCollection() : RefCollection() {}

	virtual int Get( Store* str );

	virtual int Intersect( ParaCollection& );
	int IntersectStore( Store* );
	int StoreIntersect( Store* );
	int IntersectStores( Store*, Store* );

	virtual int Merge( ParaCollection& );
	int MergeStore( Store* );
	int MergeStores( Store*, Store* );

	virtual int Minus( ParaCollection& );
	int MinusStore( Store* );
	int MinusStores( Store*, Store* );
	int StoreMinus( Store* );

	DocCollection*	GetDocs();

private:
	long	aCount, aToRead, aRefs, aRefsReaded, *aBuffer, *aPos;
	Ref	aRef;

	bool	ReadMore( Store* str, long tail = 0 );
	void	ReadRefs( Ref* aRefs, Store* str );
};

enum	CalcResult_Type { SLOVO, LIST };

struct	CalcResult {
	CalcResult_Type	Type;
	union {
		char* word;
		ParaCollection* list;
	};
};

class	Calc {
public:
	Calc( Base* );

private:
	void	GetToken();

	char*	formula;
	char*	pCurrPos;
	char	tokenValue[ 32 ];

	enum Token_Type { NUMBER, OPERATOR, END };
	Token_Type currToken;

	long	paraworddifference;
	long	paraparadifference;
};
*/

#endif
