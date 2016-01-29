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

#ifndef _u_int32_tSplayNode
#define _u_int32_tSplayNode 1
#ifdef __GNUG__
#pragma interface
#endif
#include "u_int32_t.defs.h"

struct u_int32_tSplayNode
{
  u_int32_tSplayNode*   lt;
  u_int32_tSplayNode*   rt;
  u_int32_tSplayNode*   par;
  u_int32_t             item;
                  u_int32_tSplayNode(u_int32_t  h, u_int32_tSplayNode* l=0, u_int32_tSplayNode* r=0);
                  ~u_int32_tSplayNode();
};


inline u_int32_tSplayNode::u_int32_tSplayNode(u_int32_t  h, u_int32_tSplayNode* l, u_int32_tSplayNode* r)
:lt(l), rt(r), par(0), item(h) {}

inline u_int32_tSplayNode::~u_int32_tSplayNode() {}

typedef u_int32_tSplayNode* u_int32_tSplayNodePtr;

#endif
