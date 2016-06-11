/*=============================================================================
  This file is dual licensed under the MIT and the University of Illinois Open
  Source Licenses. See LICENSE.TXT for details.

  This file implements the a small heap for allocation of exception
  in the situation where malloc fails.
  http://www.codesourcery.com/public/cxx-abi/abi-eh.html (section 2.4.2)

  A small, simple heap manager based (loosely) on
  the startup heap manager from FreeBSD, optimized for space.

  Manages a fixed-size memory pool, supports malloc and free only.
  No support for realloc.

  Allocates chunks in multiples of four bytes, with a four byte header
  for each chunk. The overhead of each chunk is kept low by keeping pointers
  as two byte offsets within the heap, rather than (4 or 8 byte) pointers.

  Cross-platform implementation
=============================================================================*/
#include <stdlib.h>

#include "fallback_malloc.hpp"
#ifdef MUTEX_SUPPORTED
#include "guard.hpp"
#include "mutex.hpp"
#endif

namespace __cxx_runtime { namespace detail
{
  namespace
  {
    #define HEAP_SIZE 512
    char heap [ HEAP_SIZE ];

    typedef unsigned short heap_offset;
    typedef unsigned short heap_size;

    struct heap_node
    {
      heap_offset next_node;  // offset into heap
      heap_size   len;        // size in units of "sizeof(heap_node)"
    };

    static const heap_node *list_end
      = (heap_node*) (&heap[HEAP_SIZE]);   // one past the end of the heap
    static heap_node *freelist = 0;

    heap_node* node_from_offset(const heap_offset offset) throw()
    {
      return (heap_node*) (heap + (offset * sizeof (heap_node)));
    }

    heap_offset offset_from_node(const heap_node* ptr) throw()
    {
      return heap_offset((((char*) ptr)-heap) / sizeof(heap_node));
    }

    void init_heap() throw()
    {
      freelist = (heap_node*) heap;
      freelist->next_node = offset_from_node(list_end);
      freelist->len = HEAP_SIZE / sizeof (heap_node);
    }

    //  How big a chunk we allocate
    size_t alloc_size(size_t len) throw()
    {
      return (len + sizeof(heap_node) - 1) / sizeof(heap_node) + 1;
    }

    //  Return the start of the next block
    heap_node *after(heap_node *p) throw()
    {
      return p + p->len;
    }

#ifdef MUTEX_SUPPORTED
    static mutex heap_mutex;
#endif
  }

  bool is_fallback_ptr(void* ptr) throw()
  {
    return ptr >= heap && ptr < (heap + HEAP_SIZE);
  }

  void* fallback_malloc(size_t len) throw()
  {
    heap_node *p, *prev;
    const size_t nelems = alloc_size(len);
#ifdef MUTEX_SUPPORTED
    guard<mutex> g(heap_mutex);
#endif

    if (0 == freelist)
      init_heap ();

    // Walk the free list, looking for a "big enough" chunk
    for (
      p = freelist, prev = 0;
      p && p != list_end;
      prev = p, p = node_from_offset(p->next_node))
    {
      if (p->len > nelems)
      {  //  chunk is larger, shorten, and return the tail
        heap_node *q;

        p->len -= heap_size(nelems);
        q = p + p->len;
        q->next_node = 0;
        q->len = heap_size(nelems);
        return (void*) (q + 1);
      }

      if (p->len == nelems)
      { // exact size match
        if (prev == 0)
            freelist = node_from_offset(p->next_node);
        else
            prev->next_node = p->next_node;
        p->next_node = 0;
          return (void*) (p + 1);
      }
    }
    return 0; // couldn't find a spot big enough
  }

  void fallback_free (void *ptr) throw()
  {
    struct heap_node *cp = ((struct heap_node *) ptr) - 1; // retrieve the chunk
    struct heap_node *p, *prev;

#ifdef MUTEX_SUPPORTED
    guard<mutex> g(heap_mutex);
#endif

    for (
      p = freelist, prev = 0;
      p && p != list_end;
      prev = p, p = node_from_offset(p->next_node))
    {
      if (after(p) == cp)
      {
        p->len += cp->len;  // make the free heap_node larger
        return;
      }
      else if (after( cp ) == p)
      { // there's a free heap_node right after

        cp->len += p->len;
        if ( prev == 0 )
        {
          freelist = cp;
          cp->next_node = p->next_node;
        }
        else
        {
          prev->next_node = offset_from_node(cp);
        }
        return;
      }
    }

    //  Nothing to merge with, add it to the start of the free list
    cp->next_node = offset_from_node(freelist);
    freelist = cp;
  }
}}

