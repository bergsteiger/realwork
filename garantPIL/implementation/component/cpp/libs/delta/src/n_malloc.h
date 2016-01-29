/*
 * $Id: n_malloc.h,v 2.5 2005/09/27 11:36:58 grigorio Exp $
 * $Log: n_malloc.h,v $
 * Revision 2.5  2005/09/27 11:36:58  grigorio
 * improve: eliminate macro __FreeBSD__, replace it with GARANT_TOOLS,
 * leave unchanged where it seems to be really necessary; clean ancient
 * temporary comments
 *
 * Revision 2.4  2002/10/23 12:00:33  vlad
 * *** empty log message ***
 *
 * Revision 2.3  2000/05/03 12:56:14  max
 * memory procedure reassigment
 *
 * Revision 2.2  1999/05/02 17:06:22  max
 * Setup 4.06.2 develop state
 *
 * Revision 1.3.4.5  1999/02/16 18:07:06  max
 * Fuck up cygwin
 *
 * Revision 1.3.4.4  1998/12/07 19:02:08  taurus
 * Sync sbrk() definition with go32 includes.
 * remove references to iostream.h
 *
 * Revision 1.3.4.3  1998/12/03 18:21:44  alik
 * make it compile with CygWin b20
 *
 * Revision 1.3.4.2  1998/09/09 16:31:48  den
 * port to native solaris cc
 * fix stupid bug in fulldiff.cc
 *
 * Revision 1.3.4.1  1998/05/18 15:47:50  max
 * Go away from RELENG_4_05
 *
 * Revision 1.4  1998/05/14 18:49:19  max
 * Use malloc_handler for stop if DPMI das't get memory
 *
 * Revision 1.3.2.2  1998/05/12 12:28:02  max
 * Some defenition for CYGWIN32
 *
 * Revision 1.3.2.1  1998/05/08 17:22:18  max
 * Disabele malinfo() structure return
 *
 * Revision 1.3  1998/04/02 08:47:50  max
 * Add cvs Tag in all files. Remove unnecessary file
 *
 */

/* ---------- To make a malloc.h, start cutting here ------------ */

/* 
  A version of malloc/free/realloc written by Doug Lea and released to the 
  public domain.  Send questions/comments/complaints/performance data
  to dl@cs.oswego.edu

* preliminary VERSION 2.6.2q Mon Jan  8 10:28:33 1996  Doug Lea  (dl at gee)
  
   Note: There may be an updated version of this malloc obtainable at
           ftp://g.oswego.edu/pub/misc/malloc.c
         Check before installing!

* Synopsis of public routines

  (Much fuller descriptions are contained in the program documentation below.)

  malloc(size_t n);
     Return a pointer to a newly allocated chunk of at least n bytes, or null
     if no space is available.
  free(Void_t* p);
     Release the chunk of memory pointed to by p, or no effect if p is null.
  realloc(Void_t* p, size_t n);
     Return a pointer to a chunk of size n that contains the same data
     as does chunk p up to the minimum of (n, p's size) bytes, or null
     if no space is available. The returned pointer may or may not be
     the same as p. If p is null, equivalent to malloc.  Unless the
     #define REALLOC_ZERO_BYTES_FREES below is set, realloc with a
     size argument of zero (re)allocates a minimum-sized chunk.
  memalign(size_t alignment, size_t n);
     Return a pointer to a newly allocated chunk of n bytes, aligned
     in accord with the alignment argument, which must be a power of
     two.
  valloc(size_t n);
     Equivalent to memalign(pagesize, n), where pagesize is the page
     size of the system (or as near to this as can be figured out from
     all the includes/defines below.)
  calloc(size_t unit, size_t quantity);
     Returns a pointer to quantity * unit bytes, with all locations
     set to zero.
  cfree(Void_t* p);
     Equivalent to free(p).
  malloc_trim(size_t pad);
     Release all but pad bytes of freed top-most memory back 
     to the system. Return 1 if successful, else 0.
  malloc_usable_size(Void_t* p);
     Report the number usable allocated bytes associated with allocated
     chunk p. This may or may not report more bytes than were requested,
     due to alignment and minimum size constraints.
  malloc_stats();
     Prints brief summary statistics on stderr.
  mallinfo()
     Returns (by copy) a struct containing various summary statistics.
  mallopt(int parameter_number, int parameter_value)
     Changes one of the tunable parameters described below. Returns
     1 if successful in changing the parameter, else 0.

* Vital statistics:

  Alignment:                            8-byte

       8 byte alignment is currently hardwired into the design.  This
       seems to suffice for all current machines and C compilers.

  Assumed pointer representation:       4 bytes
  Assumed size_t  representation:       4 bytes
  Minimum overhead per allocated chunk: 4 bytes

       Each malloced chunk has a hidden overhead of 4 bytes holding size
       and status information.  

  Minimum allocated size:              16 bytes (12 bytes usable, 4 overhead)

       When a chunk is freed, 12 additional bytes are needed; 4 for a
       trailing size field and 8 bytes for free list pointers. Thus,
       the minimum allocatable size is 16 bytes, of which 12 bytes are
       usable. Even a request for zero bytes (i.e., malloc(0)) returns 
       a pointer to something of the minimum allocatable size.  

  Maximum allocated size:      2147483640 (2^31 - 8) bytes

       It is assumed that (possibly signed) 32 bit values suffice to
       represent chunk sizes. `Possibly signed' is due to the fact
       that `size_t' may be defined on a system as either a signed or
       an unsigned type. To be conservative, values that would appear
       as negative numbers are avoided.  The maximum size chunk is
       2^31 - 8 bytes.  Requests for negative sizes (when size_t is
       signed) or those greater than (2^31 - 8) bytes will return a
       minimum-sized chunk.

  Maximum overhead wastage per allocated chunk: normally 15 bytes

       Alignnment demands, plus the minimum allocatable size restriction
       make the normal worst-case wastage 15 bytes (i.e., up to 15
       more bytes will be allocated than were requested in malloc), with 
       two exceptions:
         1. Because requests for zero bytes allocate non-zero space,
            the worst case wastage for a request of zero bytes is 24 bytes.
         2. For requests >= mmap_threshold that are serviced via
            mmap(), the worst case wastage is 8 bytes plus the remainder
            from a system page (the minimal mmap unit); typically 4096 bytes.


* Synopsis of compile-time options:

    People have reported using previous versions of this malloc on all
    versions of Unix, sometimes by tweaking some of the defines
    below. It has been tested most extensively on Solaris and
    Linux. People have also reported adapting this malloc for use in
    stand-alone embedded systems.

    The implementation is in straight, hand-tuned ANSI C.  Among other
    consequences, it uses a lot of macros.  Because of this, to be at
    all usable, this code should be compiled using an optimizing compiler
    (for example gcc -O2) that can simplify expressions and control
    paths.

  __STD_C                  (default: derived from C compiler defines)
     Nonzero if using ANSI-standard C compiler, a C++ compiler, or
     a C compiler sufficiently close to ANSI to get away with it.
  DEBUG                    (default: NOT defined)
     Define to enable debugging. Adds fairly extensive assertion-based 
     checking to help track down memory errors, but noticeably slows down
     execution.
  REALLOC_ZERO_BYTES_FREES (default: NOT defined) 
     Define this if you think that realloc(p, 0) should be equivalent
     to free(p). Otherwise, since malloc returns a unique pointer for
     malloc(0), so does realloc(p, 0).
  HAVE_MEMCPY               (default: defined)
     Define if you are not otherwise using ANSI STD C, but still 
     have memcpy and memset in your C library and want to use them.
     Otherwise, simple internal versions are supplied.
  HAVE_MMAP                 (default: defined as 1)
     Define to non-zero to optionally make malloc() use mmap() to
     allocate very large blocks.  
  malloc_getpagesize        (default: derived from system #includes)
     Either a constant or routine call returning the system page size.
  HAVE_USR_INCLUDE_MALLOC_H (default: NOT defined) 
     Optionally define if you are on a system with a /usr/include/malloc.h
     that declares struct mallinfo. It is not at all necessary to
     define this even if you do, but will ensure consistency.
  INTERNAL_LINUX_C_LIB      (default: NOT defined)
     Defined only when compiled as part of Linux libc.
     Also note that there is some odd internal name-magling via defines
     (for example, internally, `malloc' is named `mALLOc') needed
     when compiling in this case. These look funny but don't otherwise
     affect anything.
  MORECORE                  (default: sbrk)
     The name of the routine to call to obtain more memory from the system.
  MORECORE_FAILURE          (default: -1)
     The value returned upon failure of MORECORE.
  DEFAULT_TRIM_THRESHOLD
  DEFAULT_TOP_PAD       
  DEFAULT_MMAP_THRESHOLD
  DEFAULT_MMAP_MAX      
     Default values of tunable parameters (described in detail below)
     controlling interaction with host system routines (sbrk, mmap, etc).
     These values may also be changed dynamically via mallopt(). The
     preset defaults are those that give best performance for typical
     programs/systems.


*/

/* Preliminaries */

#ifdef N_MALLOC

#ifndef __N_MALLOC_H__
#define __N_MALLOC_H__ 1

#ifndef __STD_C
#ifdef __STDC__
#define __STD_C     1
#else
#if __cplusplus
#define __STD_C     1
#else
#define __STD_C     0
#endif /*__cplusplus*/
#endif /*__STDC__*/
#endif /*__STD_C*/

#ifndef Void_t
#if __STD_C
#define Void_t      void
#else
#define Void_t      char
#endif
#endif /*Void_t*/

#if __STD_C
#include <stddef.h>   /* for size_t */
#else
#include <sys/types.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>    /* needed for malloc_stats */


/*
  Compile-time options
*/


/*
    Debugging:

    Because freed chunks may be overwritten with link fields, this
    malloc will often die when freed memory is overwritten by user
    programs.  This can be very effective (albeit in an annoying way)
    in helping track down dangling pointers.

    If you compile with -DDEBUG, a number of assertion checks are
    enabled that will catch more memory errors. You probably won't be
    able to make much sense of the actual assertion errors, but they
    should help you locate incorrectly overwritten memory.  The
    checking is fairly extensive, and will slow down execution
    noticeably. Calling malloc_stats or mallinfo with DEBUG set will
    attempt to check every non-mmapped allocated and free chunk in the
    course of computing the summmaries. (By nature, mmapped regions
    cannot be checked very much automatically.)

    Setting DEBUG may also be helpful if you are trying to modify 
    this code. The assertions in the check routines spell out in more 
    detail the assumptions and invariants underlying the algorithms.

*/

/*#if DEBUG */
#include "assert.h"
/*
#else
#define assert(x) ((void)0)
#endif
*/


/*
  REALLOC_ZERO_BYTES_FREES should be set if a call to
  realloc with zero bytes should be the same as a call to free.
  Some people think it should. Otherwise, since this malloc
  returns a unique pointer for malloc(0), so does realloc(p, 0). 
*/


/*   #define REALLOC_ZERO_BYTES_FREES */


/*
  HAVE_MEMCPY should be defined if you are not otherwise using
  ANSI STD C, but still have memcpy and memset in your C library
  and want to use them in calloc and realloc. Otherwise simple
  macro versions are defined here.
*/

#define HAVE_MEMCPY 

#if __STD_C || defined(HAVE_MEMCPY)

void* memset(void*, int, size_t);
void* memcpy(void*, const void*, size_t);

#define MALLOC_ZERO(charp, nbytes)  memset(charp, 0, nbytes)
#define MALLOC_COPY(dest,src,nbytes) memcpy((dest), (src), (nbytes))

#else

/* We only invoke with multiples of size_t units, with size_t alignment */

#define MALLOC_ZERO(charp, nbytes)                                            \
{                                                                             \
  size_t* mzp = (size_t*)(charp);                                             \
  size_t mzn = (nbytes) / sizeof(size_t);                                     \
  while (mzn-- > 0) *mzp++ = 0;                                               \
} 

#define MALLOC_COPY(dest,src,nbytes)                                          \
{                                                                             \
  size_t* mcsrc = (size_t*) src;                                              \
  size_t* mcdst = (size_t*) dest;                                             \
  long mcn = (nbytes) / sizeof(size_t);                                       \
  while (mcn-- > 0) *mcdst++ = *mcsrc++;                                      \
}

#endif

/*
  Define HAVE_MMAP to optionally make malloc() use mmap() to
  allocate very large blocks.  These will be returned to the
  operating system immediately after a free().
*/

#ifndef HAVE_MMAP
#define HAVE_MMAP 0
#endif

#if HAVE_MMAP

#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

#if !defined(MAP_ANONYMOUS) && defined(MAP_ANON)
#define MAP_ANONYMOUS MAP_ANON
#endif

#endif /* HAVE_MMAP */

/*
  Access to system page size. To the extent possible, this malloc
  manages memory from the system in page-size units.
  
  The following mechanics for getpagesize were adapted from 
  bsd/gnu getpagesize.h 
*/

#ifndef malloc_getpagesize
#if defined(BSD) || defined(DGUX) || defined(HAVE_GETPAGESIZE)
   extern size_t getpagesize();
#  define malloc_getpagesize getpagesize()
#else
#  include <sys/param.h>
#  ifdef EXEC_PAGESIZE
#    define malloc_getpagesize EXEC_PAGESIZE
#  else
#    ifdef NBPG
#      ifndef CLSIZE
#        define malloc_getpagesize NBPG
#      else
#        define malloc_getpagesize (NBPG * CLSIZE)
#      endif
#    else 
#      ifdef NBPC
#        define malloc_getpagesize NBPC
#      else
#        ifdef PAGESIZE
#          define malloc_getpagesize PAGESIZE
#        else
#          define malloc_getpagesize (4096) /* just guess */
#        endif
#      endif
#    endif 
#  endif
#endif 
#endif

/*

  This version of malloc supports the standard SVID/XPG mallinfo
  routine that returns a struct containing the same kind of
  information you can get from malloc_stats. It should work on
  any SVID/XPG compliant system that has a /usr/include/malloc.h
  defining struct mallinfo. (If you'd like to install such a thing
  yourself, cut out the preliminary declarations as described above
  and below and save them in a malloc.h file. But there's no
  compelling reason to bother to do this.)

  The main declaration needed is the mallinfo struct that is returned
  (by-copy) by mallinfo().  The SVID/XPG malloinfo struct contains a
  bunch of fields, most of which are not even meaningful in this
  version of malloc. Some of these fields are are instead filled by
  mallinfo() with other numbers that might possibly be of interest.

  HAVE_USR_INCLUDE_MALLOC_H should be set if you have a
  /usr/include/malloc.h file that includes a declaration of struct
  mallinfo.  If so, it is included; else an SVID2/XPG2 compliant
  version is declared below.  These must be precisely the same for
  mallinfo() to work.

*/

/* #define HAVE_USR_INCLUDE_MALLOC_H */

#if HAVE_USR_INCLUDE_MALLOC_H
//#include "/usr/include/malloc.h"
#else

/* SVID2/XPG mallinfo structure */

struct mallinfo {
  int arena;    /* total space allocated from system */
  int ordblks;  /* number of non-inuse chunks */
  int smblks;   /* unused -- always zero */
  int hblks;    /* number of mmapped regions */
  int hblkhd;   /* total space in mmapped regions */
  int usmblks;  /* unused -- always zero */
  int fsmblks;  /* unused -- always zero */
  int uordblks; /* total allocated space */
  int fordblks; /* total non-inuse space */
  int keepcost; /* top-most, releasable (via malloc_trim) space */
};	

/* SVID2/XPG mallopt options */

#define M_MXFAST  1    /* UNUSED in this malloc */
#define M_NLBLKS  2    /* UNUSED in this malloc */
#define M_GRAIN   3    /* UNUSED in this malloc */
#define M_KEEP    4    /* UNUSED in this malloc */

#endif

/* mallopt options that actually do something */

#define M_TRIM_THRESHOLD    -1
#define M_TOP_PAD           -2
#define M_MMAP_THRESHOLD    -3
#define M_MMAP_MAX          -4



#ifndef DEFAULT_TRIM_THRESHOLD
#define DEFAULT_TRIM_THRESHOLD (1024 * 1024)
#endif

/*
    M_TRIM_THRESHOLD is the maximum amount of unused top-most memory 
      to keep before releasing via malloc_trim in free().

      Automatic trimming is mainly useful in long-lived programs.
      Because trimming via sbrk can be slow on some systems, and can
      sometimes be wasteful (in cases where programs immediately
      afterward allocate more large chunks) the value should be high
      enough so that your overall system performance would improve by
      releasing.  

      The trim threshold and the mmap control parameters (see below)
      can be traded off with one another. Trimming and mmapping are
      two different ways of releasing unused memory back to the
      system. Between these two, it is often possible to keep
      system-level demands of a long-lived program down to a bare
      minimum. For example, in one test suite of sessions measuring
      the XF86 X server on Linux, using a trim threshold of 128K and a
      mmap threshold of 192K led to near-minimal long term resource
      consumption.  

      If you are using this malloc in a long-lived program, it should
      pay to experiment with these values.  As a rough guide, you
      might set to a value close to the average size of a process
      (program) running on your system.  Releasing this much memory
      would allow such a process to run in memory.  Generally, it's
      worth it to tune for trimming rather tham memory mapping when a
      program undergoes phases where several large chunks are
      allocated and released in ways that can reuse each other's
      storage, perhaps mixed with phases where there are no such
      chunks at all.  And in well-behaved long-lived programs,
      controlling release of large blocks via trimming versus mapping
      is usually faster.

      However, in most programs, these parameters serve mainly as
      protection against the system-level effects of carrying around
      massive amounts of unneeded memory. Since frequent calls to
      sbrk, mmap, and munmap otherwise degrade performance, the default
      parameters are set to relatively high values that serve only as
      safeguards.

      The default trim value is high enough to cause trimming only in
      fairly extreme (by current memory consumption standards) cases.
      It must be greater than page size to have any useful effect.  To
      disable trimming completely, you can set to (unsigned long)(-1);


*/


#ifndef DEFAULT_TOP_PAD
#define DEFAULT_TOP_PAD        (0)
#endif

/*
    M_TOP_PAD is the amount of extra `padding' space to allocate or 
      retain whenever sbrk is called. It is used in two ways internally:

      * When sbrk is called to extend the top of the arena to satisfy
        a new malloc request, this much padding is added to the sbrk
        request.

      * When malloc_trim is called automatically from free(),
        it is used as the `pad' argument.

      In both cases, the actual amount of padding is rounded 
      so that the end of the arena is always a system page boundary.

      The main reason for using padding is to avoid calling sbrk so
      often. Having even a small pad greatly reduces the likelihood
      that nearly every malloc request during program start-up (or
      after trimming) will invoke sbrk, which needlessly wastes
      time. 

      Automatic rounding-up to page-size units is normally sufficient
      to avoid measurable overhead, so the default is 0.  However, in
      systems where sbrk is relatively slow, it can pay to increase
      this value, at the expense of carrying around more memory than 
      the program needs.

*/


#ifndef DEFAULT_MMAP_THRESHOLD
#define DEFAULT_MMAP_THRESHOLD (128 * 1024)
#endif

/*

    M_MMAP_THRESHOLD is the request size threshold for using mmap() 
      to service a request. Requests of at least this size that cannot 
      be allocated using already-existing space will be serviced via mmap.  
      (If enough normal freed space already exists it is used instead.)

      Using mmap segregates relatively large chunks of memory so that
      they can be individually obtained and released from the host
      system. A request serviced through mmap is never reused by any
      other request (at least not directly; the system may just so
      happen to remap successive requests to the same locations).

      Segregating space in this way has the benefit that mmapped space
      can ALWAYS be individually released back to the system, which
      helps keep the system level memory demands of a long-lived
      program low. Mapped memory can never become `locked' between
      other chunks, as can happen with normally allocated chunks, which
      menas that even trimming via malloc_trim would not release them.

      However, it has the disadvantages that:

         1. The space cannot be reclaimed, consolidated, and then
            used to service later requests, as happens with normal chunks. 
         2. It can lead to more wastage because of mmap page alignment
            requirements
         3. It causes malloc performance to be more dependent on host
            system memory management support routines which may vary in
            implementation quality and may impose arbitrary
            limitations. Generally, servicing a request via normal
            malloc steps is faster than going through a system's mmap.

      All together, these considerations should lead you to use mmap
      only for relatively large requests.  


*/



#ifndef DEFAULT_MMAP_MAX
#if HAVE_MMAP
#define DEFAULT_MMAP_MAX       (8)
#else
#define DEFAULT_MMAP_MAX       (0)
#endif
#endif

/*
    M_MMAP_MAX is the maximum number of requests to simultaneously 
      service using mmap. This parameter exists because:

         1. Some systems have a limited number of internal tables for
            use by mmap.
         2. In most systems, overreliance on mmap can degrade overall
            performance.
         3. If a program allocates many large regions, it is probably
            better off using normal sbrk-based allocation routines that
            can reclaim and reallocate normal heap memory. Using a
            small value allows transition into this mode after the
            first few allocations.

      Setting to 0 disables all use of mmap.  If HAVE_MMAP is not set,
      the default value is 0, and attempts to set it to non-zero values
      in mallopt will fail.
*/



/* 

  Special defines for linux libc

  Except when compiled using these special defines for Linux libc
  using weak aliases, this malloc is NOT designed to work in
  multithreaded applications.  No semaphores or other concurrency
  control are provided to ensure that multiple malloc or free calls
  don't run at the same time, which could be disasterous. A single
  semaphore could be used across malloc, realloc, and free (which is
  essentially the effect of the linux weak alias approach). It would
  be hard to obtain finer granularity.

*/


#ifdef INTERNAL_LINUX_C_LIB

#if __STD_C

Void_t * __default_morecore_init (ptrdiff_t);
Void_t *(*__morecore)(ptrdiff_t) = __default_morecore_init;

#else

Void_t * __default_morecore_init ();
Void_t *(*__morecore)() = __default_morecore_init;

#endif

#define MORECORE (*__morecore)
#define MORECORE_FAILURE 0

#else /* INTERNAL_LINUX_C_LIB */

#if __STD_C
#if defined(__CYGWIN32__)
extern Void_t*     sbrk(unsigned int);
#elif defined(__GO32__)
extern Void_t*     sbrk(int);
#elif defined (__FreeBSD__) // GARANT_FREEBSD
//extern char*     sbrk(ptrdiff_t);
#else
extern Void_t*     sbrk(ptrdiff_t);
#endif
#else
extern Void_t*     sbrk();
#endif

#ifndef MORECORE
#define MORECORE sbrk
#endif

#ifndef MORECORE_FAILURE
#define MORECORE_FAILURE -1
#endif

#endif /* INTERNAL_LINUX_C_LIB */

#if defined(INTERNAL_LINUX_C_LIB) && defined(__ELF__)

#define cALLOc		__libc_calloc
#define fREe		__libc_free
#define mALLOc		__libc_malloc
#define mEMALIGn	__libc_memalign
#define rEALLOc		__libc_realloc
#define vALLOc		__libc_valloc
#define mALLINFo	__libc_mallinfo
#define mALLOPt		__libc_mallopt

#pragma weak calloc = __libc_calloc
#pragma weak free = __libc_free
#pragma weak cfree = __libc_free
#pragma weak malloc = __libc_malloc
#pragma weak memalign = __libc_memalign
#pragma weak realloc = __libc_realloc
#pragma weak valloc = __libc_valloc
#pragma weak mallinfo = __libc_mallinfo
#pragma weak mallopt = __libc_mallopt

#else

#define cALLOc		calloc
#define fREe		free
#define mALLOc		malloc
#define mEMALIGn	memalign
#define rEALLOc		realloc
#define vALLOc		valloc
#define mALLINFo	mallinfo
#define P_mALLINFo	p_mallinfo
#define mALLOPt		mallopt

#endif

/* Public routines */

#if __STD_C    

Void_t* mALLOc(size_t);
void    fREe(Void_t*);
Void_t* rEALLOc(Void_t*, size_t);
Void_t* mEMALIGn(size_t, size_t);
Void_t* vALLOc(size_t);
Void_t* cALLOc(size_t, size_t);
#ifdef __CYGWIN32__
	void    cfree(Void_t*,Void_t*);
#else
	void    cfree(Void_t*);
#endif
int     malloc_trim(size_t);
size_t  malloc_usable_size(Void_t*);
void    malloc_stats();
int     mALLOPt(int, int);
struct mallinfo mALLINFo(void); 
//int mALLINFo(void);
struct mallinfo* P_mALLINFo(void);
#else
Void_t* mALLOc();
void    fREe();
Void_t* rEALLOc();
Void_t* mEMALIGn();
Void_t* vALLOc();
Void_t* cALLOc();
void    cfree();
int     malloc_trim();
size_t  malloc_usable_size();
void    malloc_stats();
int     mALLOPt();
struct mallinfo mALLINFo();
struct mallinfo* P_mALLINFo();
#endif

/*
**	Part Added by MAX for malloc handler
*/
typedef void (*zmh)(void);
zmh Z_set_malloc_handler(zmh p);
zmh Z_reset_malloc_handler();

#ifdef __cplusplus
};  /* end of extern "C" */
#endif

/* ---------- To make a malloc.h, end cutting here ------------ */

#endif
#endif
