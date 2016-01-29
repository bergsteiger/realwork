/*
 * $Id: tempdoc.cpp,v 2.36 2014/04/09 14:58:34 young Exp $
 */

// TempDoc.cpp
// created by Max Kr.
// date 7.10.97
/////////////////////

//#define DEBUG_TEMPDOC

#include <stdlib.h>

#include "tempdoc.h"
#include "base.h"
#include "document.h"
#include "gardefs.h"
#include "stdio.h"
#include "Logger.h"

extern	Logger	logger;
extern	void	EVDWin2Dos( char*, long );


#define TD_MEM_ADDS	10240

TempDoc :: TempDoc ( Base* base, long docId, Document **ppDoc, DocInfo* pDocINFO)
{
	if(!(DocId= docId))
		return;
	Document* pDoc;

	pDoc= base->GetDoc ( docId );
	m_stat = pDoc->Stat;

	InitStatus(pDoc);

	unsigned long lFullDocSize = (unsigned long)pDoc->Stat.Size + (unsigned long)(m_ParaCount= pDoc->Stat.ParaCount) * 3;
	m_iLocalTextAlloc = 0;
	if (pDoc->Stat.ParaCount) {
		m_pLocalParaArray = (void**) malloc ( pDoc->Stat.ParaCount * sizeof ( void* ));
		if ( !m_pLocalParaArray ){
			logger.printf ( lt_fatal, "In doc %ld, base: %s: Temp Paras creation failed (count:%ld)\n", base->textFile->FileName, docId, pDoc->Stat.ParaCount );
			assert ( m_pLocalParaArray );
		}
	} else
		m_pLocalParaArray = 0;

	if (lFullDocSize) {
		m_pLocalParaArray[0] = malloc ( lFullDocSize );
		if ( !m_pLocalParaArray[0] ){
			   logger.printf ( lt_fatal, "Not enough memory (%lu) for TempDoc(%lu)\n", lFullDocSize, pDoc->DocId );
			   exit ( EXIT_FAILURE );
		}
	}

	CopyAllText(pDoc);
    delete pDoc;
}

const char * TempDoc :: GetPara ( long lParaPos )
{
	assert ( lParaPos < m_stat.ParaCount );
	return ( char* ) (getParaArray()[ lParaPos ]);
}

TempDoc :: ~TempDoc ()
{
	TextFree ();
}

int     TempDoc :: TextFree ()
{
	if(!DocId)
		return 1;

    if ( ! m_iLocalTextAlloc ) return 0;
    
    free ( m_pLocalParaArray[0] );
    free ( m_pLocalParaArray );
    m_iLocalTextAlloc = 0;
    return 1;
}

char*	TempDoc :: EVDParaText( const char* aPara )
{
	char	aParaStyle = ParaStyle( aPara );
	aPara = ParaText( aPara );
	if ( aParaStyle != PS_EVD )
		return (char*) aPara;

	long	flags = *(long*)aPara;
	aPara += ENDT_FLAGS_LEN;
	short	codePage = *(short*)aPara;
	aPara += ENDT_CP_LEN;
	if ( flags & ENDT_HAS_BMP )
		aPara += sizeof( long );
	long	aEVDLen = *(long*)aPara;
	aPara += aEVDLen + sizeof( aEVDLen );
	long aTextLen = *(long*)aPara;
	aPara += sizeof( aTextLen );
	if ( flags & ENDT_SBS ) {
		memcpy( EVDPara, aPara, aTextLen );
		EVDPara[ aTextLen ] = ' ';
		aPara += aTextLen;
		aEVDLen = *(long*)aPara;
		aPara += aEVDLen + sizeof( aEVDLen );
		long aTextLen2 = *(long*)aPara;
		aPara += sizeof( aTextLen2 );
		memcpy( EVDPara + aTextLen + 1, aPara, aTextLen2 );
		aTextLen += aTextLen2;
		aTextLen++;
	} else {
		memcpy( EVDPara, aPara, aTextLen );
	}
	EVDPara[ aTextLen ] = 0;
	if ( codePage == CP_ANSI ) {
		EVDWin2Dos( EVDPara, aTextLen );
	}
	return EVDPara;
}

short	TempDoc :: EVDTextSize( const char* aPara )
{
	char	aParaStyle = ParaStyle( aPara );
	if( aParaStyle != PS_EVD )
		return TextSize( aPara );

	aPara = ParaText( aPara );
	long	flags = *(long*)aPara;
	long	aENDTSize = ENDT_FLAGS_LEN + ENDT_CP_LEN;
	if ( flags & ENDT_HAS_BMP )
		aENDTSize += sizeof( long );
	aPara += aENDTSize;
	long	aEVDLen = *(long*)aPara;
	aPara += aEVDLen + sizeof( aEVDLen );
	long aTextLen = *(long*)aPara;
	aPara += sizeof( aTextLen );
	if ( flags & ENDT_SBS ) {
		aPara += aTextLen;
		aEVDLen = *(long*)aPara;
		aPara += aEVDLen + sizeof( aEVDLen );
		aTextLen += *(long*)aPara;
		aTextLen++;
	}
	return (short)aTextLen;
}

short	TempDoc :: EVDHeaderSize( const char* aPara )
{
	if ( ParaStyle( aPara ) != PS_EVD )
		return 0;

	aPara = ParaText( aPara );

	long	flags = *(long*)aPara;
	short	aENDTSize = ENDT_FLAGS_LEN + ENDT_CP_LEN;
	if ( flags & ENDT_HAS_BMP )
		aENDTSize += sizeof( long );
	aPara += aENDTSize;
	long	aEVDLen = *(long*)aPara;
	aENDTSize += aEVDLen + sizeof( aEVDLen );
	aPara += aEVDLen + sizeof( aEVDLen );
	aENDTSize += sizeof( long );

	if ( flags & ENDT_SBS ) {
		long aTextLen = *(long*)aPara;
		aPara += sizeof( aTextLen ) + aTextLen;
		aEVDLen = *(long*)aPara;
		aENDTSize += aEVDLen + sizeof( aEVDLen ) + sizeof( long )/*длина оставшегося текста*/;
	}

	return aENDTSize;
}

char*	TempDoc :: EVDHeader( const char* aPara )
{
	if ( ParaStyle( aPara ) != PS_EVD )
		return 0;

	char* to = EVDPara;
	aPara = ParaText( aPara );
	const char* begin = aPara;

	long	flags = *(long*)aPara;
	short	aENDTSize = ENDT_FLAGS_LEN + ENDT_CP_LEN;
	if ( flags & ENDT_HAS_BMP )
		aENDTSize += sizeof( long );
	aPara += aENDTSize;
	long	aEVDLen = *(long*)aPara;
	aENDTSize += aEVDLen + sizeof( aEVDLen );
	aPara += aEVDLen + sizeof( aEVDLen );
	aENDTSize += sizeof( long );

	memcpy( to, begin, aENDTSize );
	if ( flags & ENDT_SBS ) {
		to    += aENDTSize;
		long aTextLen = *(long*)aPara;
 		aPara += sizeof( aTextLen ) + aTextLen;
		aEVDLen = *(long*)aPara;
		aENDTSize = aEVDLen += sizeof( aEVDLen ) + sizeof( long )/*длина оставшегося текста*/;
		memcpy( to, aPara, aENDTSize );
	}

	return EVDPara;
}

DummyDoc :: DummyDoc ( Base* base, long docId )
{
	Document *doc = base->GetDoc (DocId = docId);
	paracount = doc->Stat.ParaCount;
	stat = doc->Stat;
	paras = new char* [paracount];
	for (int i = 0; i < paracount; i++) {
		const char *para = doc->GetPara (i);
		long parasize = ParaSize (para) + 3;
		paras [i] = new char [parasize];
		memcpy (paras [i], para, parasize);
	}
	delete doc;
}

DummyDoc :: ~DummyDoc ()
{
	for (int i = 0; i < paracount; i++)
		delete paras [i];
	delete [] paras;
}

const char * DummyDoc :: GetPara (long para)
{
	assert (para < paracount);
	return paras [para];
}

char*	DummyDoc :: EVDParaText( const char* aPara )
{
	char	aParaStyle = ParaStyle( aPara );
	aPara = ParaText( aPara );
	if ( aParaStyle != PS_EVD )
		return (char*) aPara;

	long	flags = *(long*)aPara;
	aPara += ENDT_FLAGS_LEN;
	short	codePage = *(short*)aPara;
	aPara += ENDT_CP_LEN;
	if ( flags & ENDT_HAS_BMP )
		aPara += sizeof( long );
	long	aEVDLen = *(long*)aPara;
	aPara += aEVDLen + sizeof( aEVDLen );
	long aTextLen = *(long*)aPara;
	aPara += sizeof( aTextLen );
	if ( flags & ENDT_SBS ) {
		memcpy( EVDPara, aPara, aTextLen );
		EVDPara[ aTextLen ] = ' ';
		aPara += aTextLen;
		aEVDLen = *(long*)aPara;
		aPara += aEVDLen + sizeof( aEVDLen );
		long aTextLen2 = *(long*)aPara;
		aPara += sizeof( aTextLen2 );
		memcpy( EVDPara + aTextLen + 1, aPara, aTextLen2 );
		aTextLen += aTextLen2;
		aTextLen++;
	} else {
		memcpy( EVDPara, aPara, aTextLen );
	}
	EVDPara[ aTextLen ] = 0;
	if ( codePage == CP_ANSI ) {
		EVDWin2Dos( EVDPara, aTextLen );
	}
	return EVDPara;
}

short	DummyDoc :: EVDTextSize( const char* aPara )
{
	char	aParaStyle = ParaStyle( aPara );
	if( aParaStyle != PS_EVD )
		return TextSize( aPara );

	aPara = ParaText( aPara );
	long	flags = *(long*)aPara;
	long	aENDTSize = ENDT_FLAGS_LEN + ENDT_CP_LEN;
	if ( flags & ENDT_HAS_BMP )
		aENDTSize += sizeof( long );
	aPara += aENDTSize;
	long	aEVDLen = *(long*)aPara;
	aPara += aEVDLen + sizeof( aEVDLen );
	long aTextLen = *(long*)aPara;
	aPara += sizeof( aTextLen );
	if ( flags & ENDT_SBS ) {
		aPara += aTextLen;
		aEVDLen = *(long*)aPara;
		aPara += aEVDLen + sizeof( aEVDLen );
		aTextLen += *(long*)aPara;
		aTextLen++;
	}
	return (short)aTextLen;
}

short	DummyDoc :: EVDHeaderSize( const char* aPara )
{
	if ( ParaStyle( aPara ) != PS_EVD )
		return 0;

	aPara = ParaText( aPara );

	long	flags = *(long*)aPara;
	short	aENDTSize = ENDT_FLAGS_LEN + ENDT_CP_LEN;
	if ( flags & ENDT_HAS_BMP )
		aENDTSize += sizeof( long );
	aPara += aENDTSize;
	long	aEVDLen = *(long*)aPara;
	aENDTSize += aEVDLen + sizeof( aEVDLen );
	aPara += aEVDLen + sizeof( aEVDLen );
	aENDTSize += sizeof( long );

	if ( flags & ENDT_SBS ) {
		long aTextLen = *(long*)aPara;
		aPara += sizeof( aTextLen ) + aTextLen;
		aEVDLen = *(long*)aPara;
		aENDTSize += aEVDLen + sizeof( aEVDLen ) + sizeof( long )/*длина оставшегося текста*/;
	}

	return aENDTSize;
}

char*	DummyDoc :: EVDHeader( const char* aPara )
{
	if ( ParaStyle( aPara ) != PS_EVD )
		return 0;

	char* to = EVDHeaderPara;
	aPara = ParaText( aPara );
	const char* begin = aPara;

	long	flags = *(long*)aPara;
	short	aENDTSize = ENDT_FLAGS_LEN + ENDT_CP_LEN;
	if ( flags & ENDT_HAS_BMP )
		aENDTSize += sizeof( long );
	aPara += aENDTSize;
	long	aEVDLen = *(long*)aPara;
	aENDTSize += aEVDLen + sizeof( aEVDLen );
	aPara += aEVDLen + sizeof( aEVDLen );
	aENDTSize += sizeof( long );

	memcpy( to, begin, aENDTSize );
	if ( flags & ENDT_SBS ) {
		to    += aENDTSize;
		long aTextLen = *(long*)aPara;
 		aPara += sizeof( aTextLen ) + aTextLen;
		aEVDLen = *(long*)aPara;
		aENDTSize = aEVDLen += sizeof( aEVDLen ) + sizeof( long )/*длина оставшегося текста*/;
		memcpy( to, aPara, aENDTSize );
	}

	return EVDHeaderPara;
}
