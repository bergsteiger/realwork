#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: dbproc.mf.h,v 1.8 2012/08/02 11:09:38 yaroslav Exp $
 */

#ifndef dbproc_mf_h
#define dbproc_mf_h

#include "dbproc.mh.h"
#include <stdio.h>

#ifdef WITH_DBL_THREAD
        #include "../../../tools/gctools/src/MyPipe.h"
	#define YFILE THREAD_CNTX
	#define yread(aaa, xxx, yyy, zzz) read_my_pipe(zzz, (char*)aaa, xxx*yyy)
	#define ywrite(aaa, xxx, yyy, zzz) write_my_pipe(zzz, (char*)aaa, xxx*yyy)
#else
	#define YFILE FILE
	#define yread(aaa, xxx, yyy, zzz) fread(aaa, xxx, yyy, zzz)
	#define ywrite(aaa, xxx, yyy, zzz) fwrite(aaa, xxx, yyy, zzz)
#endif

struct z_stream_s;
#define RDBFSZ 8192

class DbProcMetaFile : public DbProcMetaHolder
{
  public:
#pragma pack(1)
  	struct DbProcMFHeader {
		char signature[4];
		u_int32_t version;
		u_int32_t dataOffset;
		u_int32_t nRecords;
		u_int32_t pack  ;
		char reserved[108];
	};

#pragma pack()

	DbProcMetaFile( int fd, int bWrite, int pack=0, int vb=1 );
	DbProcMetaFile( const char *nm, int bWrite, int pack=0, int vb=1 );
	virtual ~DbProcMetaFile();
	virtual int write( const DbProcMRecord *);
	virtual const DbProcMRecord *next(const DbProcMRecord *&);
	virtual int OK();
	virtual void noteEOM();
	char *rdbuf;
	size_t rdbsz;
protected:
	u_int32_t recCount;
	YFILE *fl;
	int status;
	int verbose;
	z_stream_s *c_stream;
	char *compr_buf;
	int wmode;
	int packed;
	int st_pos;
	char statusbuf[80];
	int lastP;
	u_int32_t c_rec_no;
	void initWrite(int fd, int pk, int needDup);
	void initRead(int fd, int needDup);
	int m_DeActualCount;
private:
	DbProcMRecord *r;
	int tmpLast;
	u_int32_t action;
	u_int32_t recSize;
};
#endif



