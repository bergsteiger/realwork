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
#if !defined(CXXRUNTIME_DETAIL_FALLBACK_MALLOC_HPP)
#define CXXRUNTIME_DETAIL_FALLBACK_MALLOC_HPP

namespace __cxx_runtime { namespace detail
{
  bool is_fallback_ptr(void* ptr) throw();
  void* fallback_malloc(size_t len) throw();
  void fallback_free(void* ptr) throw();
}}

#endif