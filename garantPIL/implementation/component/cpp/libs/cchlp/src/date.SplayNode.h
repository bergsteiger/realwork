// This may look like C code, but it is really -*- C++ -*-
/* 
Copyright (C) 1988, 1982 Free Software Foundation
    written by Doug Lea (dl@rocky.oswego.edu)

This file is part of the GNU C++ Library.  This library is free
software; you can redistribute it and/or modify it under the terms of
the GNU Library General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your
option) any later version.  This library is distributed in the hope
that it will be useful, but WITHOUT ANY WARRANTY; without even the
implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU Library General Public License for more details.
You should have received a copy of the GNU Library General Public
License along with this library; if not, write to the Free Software
Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

#ifndef _dateSplayNode
#define _dateSplayNode 1
#ifdef __GNUG__
#pragma interface
#endif
#include "date.defs.h"

struct dateSplayNode
{
  dateSplayNode*   lt;
  dateSplayNode*   rt;
  dateSplayNode*   par;
  date             item;
                  dateSplayNode(date& h, dateSplayNode* l=0, dateSplayNode* r=0);
                  ~dateSplayNode();
};


inline dateSplayNode::dateSplayNode(date& h, dateSplayNode* l, dateSplayNode* r)
:lt(l), rt(r), par(0), item(h) {}

inline dateSplayNode::~dateSplayNode() {}

typedef dateSplayNode* dateSplayNodePtr;

#endif
