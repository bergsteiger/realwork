#include "shared/Core/fix/mpcxc.h"
#ifndef _REENTRANT
#define _REENTRANT
#endif


#include "dbproc.mh-mt.h"
#include <cstdlib>
#include <cstring>

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



DbProcMetaMTHolder :: DbProcMetaMTHolder(int s, int o) :
  size(s),
  over(o),
  count(0),
  i_buf(0),
  o_buf(0),
  want_read(0),
  want_write(0),
  eom(0),
  buf(0)
{
  if( size <= 0 ){
    size =1024*1024*4; 
  }
  if( over <= 0 ){
     over = 1024*64;
  } 
  buf=(char *) malloc( size+over);

#ifdef USE_POSIX_TH
  pthread_cond_init(&c_want_read, 0);
  pthread_cond_init(&c_want_write, 0);
  pthread_mutexattr_init(&mtx_a);
  pthread_mutexattr_setpshared(&mtx_a, PTHREAD_PROCESS_PRIVATE);
  pthread_mutex_init(&mtx, &mtx_a);
#else
  cond_init(&c_want_read,USYNC_THREAD,0);
  cond_init(&c_want_write,USYNC_THREAD,0);
  mutex_init(&mtx,USYNC_THREAD,0);
#endif

}

void DbProcMetaMTHolder :: noteEOM()
{
   eom = 1;
}

int DbProcMetaMTHolder :: ace_os_write( const DbProcMRecord *r)
{
restart0:
	TH_LOCK(&mtx);
restart:
	if( size >= count + r->recSize ){
		if( i_buf < o_buf ){
			// real free space is the diff
			if( o_buf - i_buf >= r->recSize ){
				memcpy(buf+i_buf, r, r->recSize );
				count += r->recSize;
				i_buf += r->recSize;
				if( i_buf >= size ) i_buf = 0;
			}else{
				want_write = 1;
				#ifdef USE_COND_VARS
					TH_COND_WAIT(&c_want_write,&mtx);
					want_write =0;
					goto restart;
				#else
					TH_UNLOCK(&mtx);
					while(want_write);
					goto restart0;
				#endif
			}
		}else{
			memcpy(buf+i_buf, r, r->recSize );
			count += r->recSize;
			i_buf += r->recSize;
			if( i_buf >= size ) i_buf = 0;
		}
	}else if( count < size && i_buf > o_buf ) { // try to put it at overlap
		memcpy(buf+i_buf, r, r->recSize );
		count += r->recSize;
		i_buf = 0;
	}else{
		want_write = 1;
		#ifdef USE_COND_VARS
			TH_COND_WAIT(&c_want_write,&mtx);
			want_write =0;
			goto restart;
		#else
			TH_UNLOCK(&mtx);
			while(want_write);
			goto restart0;
		#endif
	}
	if( want_read ){
		#ifdef USE_COND_VARS
			TH_COND_SIGNAL(&c_want_read);
		#else
			want_read = 0;
		#endif
	}
	TH_UNLOCK(&mtx);
     return 0;
}

const DbProcMRecord * DbProcMetaMTHolder :: next(const DbProcMRecord *&r)
{
    TH_LOCK(&mtx);

	if( r ){
		//free previous buffer
		o_buf += r->recSize;
		count -= r->recSize;
		if( o_buf >= size ) o_buf = 0;
	}
restart:
	if( count ){
		r = (DbProcMRecord*) (buf+o_buf);
	}else{
	  if( !eom ){
		want_read = 1;
		#ifdef USE_COND_VARS
			TH_COND_WAIT(&c_want_read,&mtx);
			want_read = 0;
			goto restart;
		#else
			TH_UNLOCK(&mtx);
			while(want_read);
    		TH_LOCK(&mtx);
			goto restart;
		#endif
	  }else{
	    r = 0;
	  }
	}
	if( want_write ){
		#ifdef USE_COND_VARS
			TH_COND_SIGNAL(&c_want_write);
		#else
			want_write =0;
		#endif
	}
    TH_UNLOCK(&mtx);
    return r;
}


DbProcMetaMTHolder :: ~DbProcMetaMTHolder()
{
  if( buf ) free(buf);
#ifdef USE_POSIX_TH
  pthread_cond_destroy(&c_want_read);
  pthread_cond_destroy(&c_want_write);
  pthread_mutex_destroy(&mtx);
#else
  cond_destroy(&c_want_read);
  cond_destroy(&c_want_write);
  mutex_destroy(&mtx);
#endif

}

int DbProcMetaMTHolder :: OK()
{
  return 1;
}




