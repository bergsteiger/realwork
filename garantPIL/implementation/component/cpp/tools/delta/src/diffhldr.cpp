#include "shared/Core/fix/mpcxc.h"
/*
 * $Header: /cvs/garantPIL/implementation/component/cpp/tools/delta/src/diffhldr.cpp,v 2.18 2014/07/09 10:24:11 yaroslav Exp $
 * $Id: diffhldr.cpp,v 2.18 2014/07/09 10:24:11 yaroslav Exp $
 */

#include <cstdio>
#include <sys/types.h>
#include <fcntl.h>
#include <cstring>
#include <sys/stat.h>
#include "indices.h"
#include "diffhldr.h"

#ifdef MIN_MEM_CONTEXT
	#include "ncpf.h"
#endif


#ifndef MIN_MEM_CONTEXT
#endif

extern "C" {
extern int CreatedBigStream;
}

const char DiffHolder :: m_idx1_Name[5]= "idx1";
const char DiffHolder :: m_idx2_Name[5]= "idx2";

DiffHolder :: DiffHolder(const char *filesName, int bRDWR, int& created)
{
	CreatedBigStream= 1;
	char buf[1024];
	sprintf(buf,"%s.k", filesName);

#ifdef MIN_MEM_CONTEXT
	kf = new NCPagedFile(buf, ACE_OS_O_RDWR, 200, 4);
	sprintf(buf,"%s.s", filesName);
	sf = new NCPagedFile(buf, ACE_OS_O_RDWR, 200, 4);

	if (bRDWR && (!kf->Exist() || !sf->Exist()) ){
		created = 1;
		kf->Create(2048);
		sf->Create(4096);
		strF = new StreamFile(sf);
		strF->Create();
		idx1 = new LongIndex(kf, m_idx1_Name, strF);
		idx1->Create(4,1,1);
		idx2 = new LongIndex(kf, m_idx2_Name, strF);
		idx2->Create(4,1,1);
	}else{
		created = 0;
		strF = new StreamFile(sf);
		idx1 = new LongIndex(kf, m_idx1_Name, strF);
		idx2 = new LongIndex(kf, m_idx2_Name, strF);
	}
#else
	std::pair <NdtClone::PagedFile*, NdtClone::StreamFile*> base (
		m_base.open (std::string(buf), std::string(filesName) + ".s", bRDWR)
	);
	idx1 = new LongIndex(base.first, m_idx1_Name, base.second);
	if (idx1->Root == -1){
		idx1->Create(4,12,1);
		idx2 = new LongIndex(base.first, m_idx2_Name, base.second);
		idx2->Create(4,12,1);
		idx1->streams->StartTransaction();
	}else{
		idx2 = new LongIndex(base.first, m_idx2_Name, base.second);
	}
#endif
}

DiffHolder :: ~DiffHolder()	
{
#ifndef MIN_MEM_CONTEXT
	if(idx1->file->m_mode) idx1->streams->EndTransaction();
#endif
	if( idx2) delete idx2;
	if( idx1) delete idx1;
#ifdef MIN_MEM_CONTEXT
	if( strF) delete strF;
	if(  kf )  delete kf;
#endif
}




