/*
 * $Id: dbproc.m-reader.h,v 2.12 2012/06/15 03:38:37 yaroslav Exp $
 */
#ifndef _dbproc_m_reader_h
#define _dbproc_m_reader_h

#include "../../../libs/gc/src/dbproc.h"
#include "../../../libs/gc/src/dbproc.mf.h"

class DbProcMetaHolder;

class DbProcessorMReader : public DbProcessor {
  protected:
	DbProcMetaHolder *mh;
	int status;
  public:
  	DbProcessorMReader(DbProcMetaHolder *);
	virtual ~DbProcessorMReader();
	virtual void run();
	virtual int OK();
};
#endif


