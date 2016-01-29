/*
//
// module:  m0rexlib.c
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: m0rexlib.c,v 1.1 2008/02/07 09:54:19 lulin Exp $
//
*/
#ifndef   _m0REXLIB_C
#define   _m0REXLIB_C
#define   _m0REXMINIVERSION

# include <malloc.h>

# define  STDC_HEADERS
# define  REGEX_MALLOC
# define  HAVE_STRING_H


# include "regex.h"
# include "regex.c"


# include "m0rexlib.h"
# include "m0rexlib.prv.c"
# include "m0rexlib.pub.c"


#endif
