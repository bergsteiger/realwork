#ifndef _ncpagedfile_h
#define _ncpagedfile_h

#include "pagefile.h"

#include <cstdio>

struct pageinfo {
	long page;
	pageinfo *last, *first;
	char *buf;
	char m;
	char st;
};

typedef struct pageinfo * ppageinfo;

#if (defined(_WINDOWS) && !defined(__CYGWIN32__)) || defined(__MSDOS__)
    #define DEFAULT_KEY_CACHE 50
    #define DEFAULT_STR_CACHE 20
    #define DEFAULT_NDT_CACHE 100
#else
    #define DEFAULT_KEY_CACHE 1000
    #define DEFAULT_STR_CACHE 1000
    #define DEFAULT_NDT_CACHE 500
#endif

class	NCPagedFile : public PagedFile
{
  public:
	NCPagedFile(LPPF_PARAM pAttrs);
	virtual void ROinitCntxt()
	{
	}
	NCPagedFile(const char *n, int m, int npages, unsigned t=4 );
	virtual ~NCPagedFile ();

	int	GetPage ( int page, void * buf );
	int	PutPage ( int page, void * buf );
	virtual void Create (short, bool bLockPath = false);
	int setThresh(int t) {
		int tmp = threshold;
		threshold = t;
		return tmp;
	};

	int Update(int);

	void *m_buffer;
	long m_first;
	int m_count;
	virtual void flushpages(int pcount= -1);
	virtual	void DelPage ( int page ){
		if ( FreePage == -1l )
			FreePage = page;

		void  * buf = AllocBuf ();
		if ( buf == 0 )
			return;

		if ( lastFreePage != -1l )
		{
			* (int *) buf = page;
			PutPage ( lastFreePage, buf );
		}
		* (int *) buf = -1l;

		PutPage ( page, buf );
		FreeBuf ( buf );

		lastFreePage = page;
		Flags   |= PF_MODIFIED;
	}
  protected:
  	void initCache();
	void printCacheStat(FILE *);
	int cpcount;
	unsigned threshold;
	void deletePage(long);
	struct pageinfo * getInfoByN(long);
	struct pageinfo * allocInfoByN(long);
	struct pageinfo *cont;
	unsigned size;
	struct pageinfo *lu, *fu;
	unsigned long ratt, watt;
	unsigned long rhit, whit;
	unsigned long fwh, frh;
	unsigned long pageouts;

  public:
	virtual int Delete(int Remove= 0);
};

#endif

