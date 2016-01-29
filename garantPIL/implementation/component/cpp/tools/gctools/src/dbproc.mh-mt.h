#include "shared/Core/fix/mpcxc.h"
#ifndef dbproc_mh_mt_h
#define dbproc_mh_mt_h

#include "dbproc.mh.h"

#ifdef USE_POSIX_TH
#include <pthread.h>
#else
#include <thread.h>
#include <synch.h>
#endif

class DbProcMetaMTHolder : public DbProcMetaHolder
{
public:
     DbProcMetaMTHolder(int size, int over );
	virtual ~DbProcMetaMTHolder();
	virtual int ace_os_write( const DbProcMRecord *);
	virtual const DbProcMRecord *next(const DbProcMRecord *&);
	virtual void  noteEOM();
	virtual int OK();
protected:
#ifdef USE_POSIX_TH
        pthread_cond_t c_want_read;
        pthread_cond_t c_want_write;
        pthread_mutex_t mtx;
        pthread_mutexattr_t mtx_a;
#else
        cond_t c_want_read;
        cond_t c_want_write;
        mutex_t mtx;
#endif
	int size, over, count;
	int i_buf, o_buf;
	int want_read, want_write;
	int eom;
	char *buf;
};

#endif


