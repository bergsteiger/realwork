/*
 * $Id: wordcol.h,v 2.4 2014/04/09 14:08:57 young Exp $
 * $Log: wordcol.h,v $
 * Revision 2.4  2014/04/09 14:08:57  young
 * ...
 *
 * Revision 2.3  2000/07/17 20:55:55  max
 * use TempDoc as source
 *
 * Revision 2.2  1999/05/02 17:06:26  max
 * Setup 4.06.2 develop state
 *
 * Revision 1.3  1998/04/02 08:48:00  max
 * Add cvs Tag in all files. Remove unnecessary file
 *
 */

#ifndef __WORD_COL__
#define __WORD_COL__

#include "collect.h"
#include "garutils.h"
#include "tempdoc.h"
#include "gardefs.h"

class   WordCollection : public SortedCollection
{
public:
        WordCollection () : SortedCollection ( CTX_WORD_SIZE + 1, 1000 ) {}

        void    Add ( DummyDoc& );
	void	Add ( char *, int );
};

#endif
