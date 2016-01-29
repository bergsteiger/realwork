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

#ifndef _FStringSplayNode
#define _FStringSplayNode 1
#ifdef __GNUG__
#pragma interface
#endif
#include "FString.defs.h"

struct FStringSplayNode
{
  FStringSplayNode*   lt;
  FStringSplayNode*   rt;
  FStringSplayNode*   par;
  FString             item;
                  FStringSplayNode(FString& h, FStringSplayNode* l=0, FStringSplayNode* r=0);
                  ~FStringSplayNode();
};


inline FStringSplayNode::FStringSplayNode(FString& h, FStringSplayNode* l, FStringSplayNode* r)
:lt(l), rt(r), par(0), item(h) {}

inline FStringSplayNode::~FStringSplayNode() {}

typedef FStringSplayNode* FStringSplayNodePtr;

#endif
