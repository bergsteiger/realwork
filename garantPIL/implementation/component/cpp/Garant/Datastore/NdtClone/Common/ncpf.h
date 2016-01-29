#ifndef _PILOT_ncpagedfile_h
#define _PILOT_ncpagedfile_h

#include "pagefile.h"


namespace NdtClone {

//##ModelId=3BFE7DE90167
struct pageinfo {
	//##ModelId=3BFE7DEB01C4
	long page;
	//##ModelId=3BFE7DEB01D0
	NdtClone::pageinfo *last, *first;
	//##ModelId=3BFE7DEB01E1
	char *buf;
	//##ModelId=3BFE7DEB01EB
	char m;
	//##ModelId=3BFE7DEB01F5
	char st;
};

//##ModelId=3BFE7DE90170
typedef struct pageinfo * ppageinfo;

//##ModelId=3BFE7DE900E4
class	NCPagedFile : public PagedFile
{
  public:
	//##ModelId=3BFE7DEA028A
	NCPagedFile(const char *n, int m, int npages, unsigned t /*=4*/, long database_version);
	//##ModelId=3BFE7DEA029E
	virtual ~NCPagedFile ();

	//##ModelId=3BFE7DEA02A0
	int	GetPage ( long page, void * buf );
	//##ModelId=3BFE7DEA02A8
	int	PutPage ( long page, void * buf );
	//##ModelId=3BFE7DEA02B2
	void Create  ( short, bool bLockPath= false );
	//##ModelId=3BFE7DEA02B4
	int setThresh(int t ){
		int tmp = threshold;
		threshold = t;
		return tmp;
	};

	//##ModelId=3BFE7DEA02C6
	void flushpages();

  protected:
	//##ModelId=3BFE7DEA02BC
  	void initCache();
	//##ModelId=3BFE7DEA02BD
	void printCacheStat(FILE *);
	//##ModelId=3BFE7DEA023A
  	int cpn;
	//##ModelId=3BFE7DEA023B
	int cpcount;
	//##ModelId=3BFE7DEA023C
	unsigned threshold;
	//##ModelId=3BFE7DEA02C7
	void deletePage(long);
	//##ModelId=3BFE7DEA02D0
	struct pageinfo * getInfoByN(long);
	//##ModelId=3BFE7DEA02D2
	struct pageinfo * allocInfoByN(long);
	//##ModelId=3BFE7DEA0245
	struct pageinfo *cont;
	//##ModelId=3BFE7DEA024E
	unsigned size;
	//##ModelId=3BFE7DEA0250
	struct pageinfo *lu, *fu;
	//##ModelId=3BFE7DEA0262
	unsigned long ratt, watt;
	//##ModelId=3BFE7DEA026C
	unsigned long rhit, whit;
	//##ModelId=3BFE7DEA0277
	unsigned long fwh, frh;
	//##ModelId=3BFE7DEA0281
	unsigned long pageouts;
};
} // namespace NdtClone

#endif

