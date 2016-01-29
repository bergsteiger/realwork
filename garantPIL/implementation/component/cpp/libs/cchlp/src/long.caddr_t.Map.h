// This may look like C code, but it is really -*- C++ -*-
/* 
Copyright (C) 1988 Free Software Foundation
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


#ifndef _longcaddr_tMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _longcaddr_tMap_h 1

#include "osdep.h"

//#ifdef NEED_CADDR_T
//	typedef char * caddr_t;
//#endif

#include <sys/types.h>

#include "Pix.h"
#include "long.defs.h"

class longcaddr_tMap
{
protected:
  unsigned int                   count;
  caddr_t                   def;

public:
                        longcaddr_tMap(caddr_t  dflt);
  inline virtual              ~longcaddr_tMap();

  int                   length() const; // current number of items
  int                   empty() const;

  virtual int           contains(long  key);      // is key mapped?

  virtual void          clear();                 // delete all items

  virtual caddr_t&          operator [] (long  key) = 0; // access contents by key

  virtual void          del(long  key) = 0;       // delete entry

  virtual Pix           first() = 0;             // Pix of first item or 0
  virtual void          next(Pix& i) = 0;        // advance to next or 0
  virtual long&          key(Pix i) = 0;          // access key at i
  virtual caddr_t&          contents(Pix i) = 0;     // access contents at i

  virtual int           owns(Pix i);             // is i a valid Pix  ?
  virtual Pix           seek(long  key);          // Pix of key

  caddr_t&                  dflt();                  // access default val

  void                  error(const char* msg);
  virtual int           OK() = 0;                // rep invariant
};


inline longcaddr_tMap::~longcaddr_tMap() {}

inline int longcaddr_tMap::length() const
{
  return count;
}

inline int longcaddr_tMap::empty() const
{
  return count == 0;
}

inline caddr_t& longcaddr_tMap::dflt()
{
  return def;
}

inline longcaddr_tMap::longcaddr_tMap(caddr_t  dflt) :def(dflt)
{
  count = 0;
}

#endif
