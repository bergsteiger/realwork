#include "shared/Core/fix/mpcxc.h"
#ifndef dbproc_mh_mt_srw_h
#define dbproc_mh_mt_srw_h

#include "dbproc.mh.h"

#ifdef USE_POSIX_TH
#include <pthread.h>
#else
#include <thread.h>
#include <synch.h>
#endif

class DbProcMetaMTSRWHolder : public DbProcMetaHolder
{
struct HolderBuffer
{
   int count;
   char *buf;
};
public:
     DbProcMetaMTSRWHolder(int size);
	virtual ~DbProcMetaMTSRWHolder();
	virtual int ace_os_write( const DbProcMRecord *);
	virtual const DbProcMRecord *next(const DbProcMRecord *&);
	virtual void  noteEOM();
	virtual int OK();
protected:
#ifdef USE_POSIX_TH
        pthread_cond_t c_exch;
        pthread_mutex_t mtx;
        pthread_mutexattr_t mtx_a;
#else
        cond_t c_exch;
        mutex_t mtx;
#endif
	int size;
	int somebody_waits;
	int eom;
	enum WhoWantExchange {reader, writer };
	struct HolderBuffer *h_w, *h_r;
	void exchange( WhoWantExchange, int setEOM );
};

#endif


