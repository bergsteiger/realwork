/*
 * $Id: wordcol.cpp,v 2.10 2014/04/09 14:08:57 young Exp $
 * $Log: wordcol.cpp,v $
 * Revision 2.10  2014/04/09 14:08:57  young
 * ...
 *
 * Revision 2.9  2005/06/16 07:23:16  grigorio
 * GARANT_MSVC7: redifinition of 'for' variable inside cycle fixed
 *
 * Revision 2.8  2005/06/03 05:35:47  grigorio
 * GARANT_CROSSPLATFORM
 *
 * Revision 2.7  2005/02/11 16:03:53  vlad
 * новые флаги
 *
 * Revision 2.6  2004/10/25 07:45:31  yaroslav
 * Fix delta
 *
 * Revision 2.5  2004/08/09 10:38:57  yaroslav
 * fix warning
 *
 * Revision 2.4  2004/06/02 13:17:02  vlad
 * подготовка к дельте Г6
 *
 * Revision 2.3  2000/07/17 20:55:55  max
 * use TempDoc as source
 *
 * Revision 2.2  1999/05/02 17:06:25  max
 * Setup 4.06.2 develop state
 *
 * Revision 1.4  1998/04/02 08:47:59  max
 * Add cvs Tag in all files. Remove unnecessary file
 *
 */

#include        "wordcol.h"
#include        "ctxwords.h"

#include <cassert>
#include <algorithm>

void    WordCollection :: Add ( DummyDoc& doc )
{
	char    buf [MAX_PARA_LEN+1];

	int bEvd = doc.stat.Status & DS_EVD;

	for ( long l = 0; l < doc.paracount; l++ ) {
		const char * ptr = doc.GetPara ( l );
		const char * pTxt = bEvd? doc.EVDParaText( ptr ) : ParaText ( ptr );
		unsigned uiSize = bEvd ? doc.EVDTextSize( ptr ) : TextSize ( ptr );
		unsigned l1; // GARANT_MSVC7: GARANT_REDEFINITION (GARANT_XXX)
		int     iEmpty = 0;

		while((l1=getParaWord(buf,&pTxt,uiSize,&iEmpty))!=0){
			buf [std::min<unsigned int> ( l1, CTX_WORD_SIZE )] = '\0'; // GARANT_STL
			//Insert ( StrUpr ( buf ) );
			Insert ( buf );
		}
	}
}

void    WordCollection :: Add ( char * pBuff, int iSize )
{
	char    buf [MAX_PARA_LEN+1];

	const char * pTxt = pBuff;
	unsigned l;
    int     iEmpty = 0;

	while ( ( l = getParaWord ( buf, &pTxt, (*(unsigned*)(&iSize)), &iEmpty ) ) !=0 ) {
		buf [std::min<unsigned int> ( l, CTX_WORD_SIZE )] = '\0'; // GARANT_STL
		Insert ( buf );
	}
}
