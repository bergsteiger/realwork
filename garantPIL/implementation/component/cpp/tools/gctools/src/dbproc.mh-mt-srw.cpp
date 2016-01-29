#include "shared/Core/fix/mpcxc.h"
#ifndef _REENTRANT
#define _REENTRANT
#endif


#include "dbproc.mh-mt-srw.h"
#include <cstdlib>
#include <cstring>
#include <cstdio>

#define USE_COND_VARS
// #undef  USE_COND_VARS

#ifdef USE_POSIX_TH
        #define TH_LOCK(a) pthread_mutex_lock(a)
        #define TH_UNLOCK(a) pthread_mutex_unlock(a)
        #define TH_COND_WAIT(a,b) pthread_cond_wait((a),(b))
        #define TH_COND_SIGNAL(a) pthread_cond_signal(a)
#else
        #define TH_LOCK(a) mutex_lock(a)
        #define TH_UNLOCK(a) mutex_unlock(a)
        #define TH_COND_WAIT(a,b) cond_wait((a),(b))
        #define TH_COND_SIGNAL(a) cond_signal(a)
#endif



DbProcMetaMTSRWHolder :: DbProcMetaMTSRWHolder(int s) :
  size(s),
  somebody_waits(0),
  eom(0)
{
  if( size <= 0 ){
    size =1024*1024; 
  }
  h_w = (struct HolderBuffer *)calloc(1,sizeof(struct HolderBuffer));
  h_w -> buf = (char*)malloc(size);
  h_r = (struct HolderBuffer *)calloc(1,sizeof(struct HolderBuffer));
  h_r -> buf = (char*)malloc(size);

#ifdef USE_POSIX_TH
  pthread_cond_init(&c_exch, 0);
  pthread_mutexattr_init(&mtx_a);
  pthread_mutexattr_setpshared(&mtx_a, PTHREAD_PROCESS_PRIVATE);
  pthread_mutex_init(&mtx, &mtx_a);
#else
  cond_init(&c_exch,USYNC_THREAD,0);
  mutex_init(&mtx,USYNC_THREAD,0);
#endif
}

void DbProcMetaMTSRWHolder :: exchange(WhoWantExchange w, int setEOM)
{
  TH_LOCK(&mtx);
  if( !eom || w == writer || somebody_waits ){
    if( setEOM ) eom = 1;
    if( somebody_waits ){
	 struct HolderBuffer *tmp = h_w;
	 h_w = h_r;
	 h_r = tmp;
	 h_w -> count = 0;
	 TH_COND_SIGNAL(&c_exch);
	 TH_UNLOCK(&mtx);
	 fprintf(stderr, "%d - go\n", w );
	 fflush(stderr);
    }else{
	 somebody_waits = 1;
	 fprintf(stderr, "%d - park\n", w );
	 fflush(stderr);
	 TH_COND_WAIT(&c_exch,&mtx);
	 somebody_waits = 0;
	 TH_UNLOCK(&mtx);
	 fprintf(stderr, "%d - go\n", w );
	 fflush(stderr);
    }
   }else{
    // I am reader and eom set
    struct HolderBuffer *tmp = h_w;
    h_w = h_r;
    h_r = tmp;
    h_w -> count = 0;
    TH_UNLOCK(&mtx);
  }
}
void DbProcMetaMTSRWHolder :: noteEOM()
  /*
    Note - here may be only writer
    once me is writer => I can't currently wait in exchange()
    so, no deadlock possible
   */
{
  exchange(writer, 1);
}
int DbProcMetaMTSRWHolder :: ace_os_write( const DbProcMRecord *r)
{
restart:
	if( size >= h_w->count + r->recSize ){
	   memcpy(h_w->buf+h_w->count, r, r->recSize );
	   h_w->count += r->recSize;
	}else{
	   exchange(writer,0);
	   goto restart;
	}
     return 0;
}

const DbProcMRecord * DbProcMetaMTSRWHolder :: next(const DbProcMRecord *&r)
{
restart:
	if( !r ){ 
	  r = (DbProcMRecord*) h_r->buf;
	}else{
	  r = (DbProcMRecord*)(char *)r + r->recSize;
	}
	int used = (char*)r - h_r->buf;
	if( h_r -> count <= used ){
	   exchange(reader,0);
	   if( !h_r -> count && eom ){
		r= 0;
	   }else{
		r = 0;
		goto restart;
	   }
	}
     return r;
}


DbProcMetaMTSRWHolder :: ~DbProcMetaMTSRWHolder()
{
  if( h_r ) free( h_r );
  if( h_w ) free( h_w );

#ifdef USE_POSIX_TH
  pthread_cond_destroy(&c_exch);
  pthread_mutex_destroy(&mtx);
#else
  cond_destroy(&c_exch);
  mutex_destroy(&mtx);
#endif
}

int DbProcMetaMTSRWHolder :: OK()
{
  return h_r && h_w;
}
