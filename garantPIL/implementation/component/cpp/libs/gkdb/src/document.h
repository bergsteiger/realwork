//
// Class for access to paragraph-based documents
// supports infinite-sized documents, various para styles
//
// Author : Alex V. Boreskoff
// Last Modification 21.11.96
//
//
// Paragraph header structure:
//
// char   Style;	PS_PRE, PS_CENTER, etc
// short  Size;         size of _ALL_ following data
// short  TextStart;	offset from the start of para
// char   LeftMargin;
// char   RightMargin;
// char   RedLine;
// char   data []	paragraph text
//

#ifndef	__DOCUMENT__
#define	__DOCUMENT__

#include "gar_defs.hpp"
#include "collect.h"

#define		MAX_PARA_PER_BLOCK	16000	// max. # of paragraphs per 1 block
#ifndef	__DOC_POS__
#define	__DOC_POS__

struct	DocPos					// specifies position in a document
{
	long	Para;				// paragraph, unit or etc
	int	Offs;				// offset, line or etc
	int	Attr;				// attribute of this pos.
};

struct	DocBlock				// specifies any continuous block of text
{
	DocPos	Start;
	DocPos	End;
};

#endif

class IGarDoc
{
public:
	virtual char *GetParaTextBytes(long ID_Para, int *pRetStyle, long* pRetFlag, int *pRetSize)= 0;
	virtual long GetParaCount()= 0;
	virtual int IsDOS_RUS()= 0;
	virtual long GetDocTextSize()= 0;
	virtual void *SetDocInfo( DocInfo *, long Id= 0)= 0;
	virtual int Load( long, const DocInfo* p_DocInfo = 0 ) = 0;
};

#include "streams.h"

class	Document : public IGarDoc
{
public:
	char *GetParaTextBytes(long ID_Para, int *pRetStyle, long* pRetFlag, int *pRetSize);
	long GetParaCount();
	int IsDOS_RUS() {return 1;}
	long GetDocTextSize();
	void *SetDocInfo( DocInfo *, long Id= 0);
public:
	Stream *runsStr, *blocksStr;
	long m_RunCount, m_BlockCount;
	PageRun	 * runsT;
	BlockRec * blocksT;

	long	   DocId;			// id of current document
	Base     * base;			// document base in use
	DocInfo	   Stat;			// info about current doc. text
	PageRun	 * runs;			// pointer to an array of PageRuns
	BlockRec * blocks;			// pointer to an array of BlockDescs
	SubDesc*   subs;			// pointer to an array of SubDescs
	long	   RunCount;
	long	   BlockCount;
	long	   SubCount;
	int	subsLoaded;

	int	   CurBlock;			// current block #
	long	   FirstPara;			// # of 1st paragraph in a CurBlock
	int	   BlockParaCount;		// # of paragraphs in current block
	int	ParaOffs1 [MAX_PARA_PER_BLOCK];	// offsets for every loaded para from 1st block into Buf
	int	ParaOffs2 [MAX_PARA_PER_BLOCK];	// offsets for every loaded para from 2nd block into Buf
	int	ParaCount [2];			// # of paragraphs for each block
	char  * Buf;				// buffer to hold blocks CurBlock, CurBlock + 1
	int	BlockSize [2];			// sizes of loaded in Buf blocks
	int	hideMask;			// mask to hide text/paragraphs with given attr. flags

	int m_OnlyTextDocByDoc;

	Document ( Base * b, long id, const DocInfo* p_DocInfo = 0);
	virtual ~Document ();

	int	IsOk        () const;
	virtual char  * GetPara( long no );	// get text of a paragraph with a given #
	long	GetParaOffs ( long no );	// get approximate offset of para from
						// beginning of document
	int	Load        ( long id, const DocInfo* p_DocInfo = 0 );	// load new document
	long	FindSub     ( long sub );	// returns 1st para of given sub
	bool	FindSub     ( long sub, long &para );	// returns 1st para of given sub
	virtual void	LoadSubs();
	long	FindPara    ( long Offs );	// returns para containing given offset
	void	Reset ();

private:
	char	EVDPara [MAX_PARA_LEN];
public:
	//в зависимости от кодировки надо текст отконвертировать, т.е. любой
	//текст попадает в буфер EVDPara, конвертится и возвращается как результат.
	char*	EVDParaText( char*, bool convert2Dos = true );
	char*	EVDParaText( const char* pBin ){
		return EVDParaText( (char*)pBin, true );
	}
	short	EVDTextSize( char* );
	short	EVDTextSize( const char *pBin ){
		return EVDTextSize( (char*)pBin );
	};
	short	EVDCodePage( char* );
	long	EVDFlags( char* aPara );

	void	FreeStructs ();			// free runs, blocks, subs
	int	FindBlock ( long para );	// locate block containing given paragraph
protected:
	void destroy ();
protected:
	int	markDummy;
	int	LockPara  ( long para );	// assures that given para is loaded
	int	LockBlock ( int no );		// assures that given block is loaded
	virtual int	LoadBlock ( int block, char * buf );
	int	LoadPrev  ();
	int	LoadNext  ();
	void	BuildParaTable ();		// compute paragraphs from data in Buf
	void	ProcBlock   ( int no );		// build para table for spec. block
	int	StripPara   ( int offs );	// strip para by hideMask
	int m_currentBlockSize;
	virtual int read_block(int, char *);
	virtual int blocks_from_base(int);
};


inline	short&	ParaSize ( const char * buf )
{
	return * (short *)( buf + 1 );
}

/*inline	short	ParaSize ( const char * buf )
{
	return * (short *)( buf + 1 );
}*/

inline	char&	ParaStyle ( char * buf )
{
	return * buf;
}

inline	char	ParaStyle ( const char * buf )
{
	return * buf;
}

inline	char  * ParaText ( char * buf )
{
	return buf + * (short *)( buf + 3 );
}

inline	const char  * ParaText ( const char * buf )
{
	return buf + * (short *)( buf + 3 );
}

inline	char	LeftMargin ( const char * buf )
{
	return buf [5];
}

inline	char	RightMargin ( const char * buf )
{
	return buf [6];
}

inline	char	RedLine ( const char * buf )
{
	return buf [7];
}

inline	short	HeaderSize ( const char * buf )
{
	return * (short *)( buf + 3 );
}

inline	short	TextSize ( const char * buf )
{
	return ParaSize ( buf ) - HeaderSize ( buf ) + 3;
}

inline	void	SetTextSize ( char * buf, short newSize )
{
	ParaSize ( buf ) = newSize + HeaderSize ( buf ) - 3;
}
#endif
