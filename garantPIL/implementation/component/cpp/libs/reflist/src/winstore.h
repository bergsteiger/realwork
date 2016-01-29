#ifndef __WINSTORE_H__
#define __WINSTORE_H__

#include <afxwin.h>
#include "store.h"

class CWinStore : public Store {
protected:
	CFile *m_pFile;
	int m_state;

public:
	CWinStore() { m_pFile = new CFile(); m_state = 0x8000; };
	CWinStore(const char *, int);
	~CWinStore();
	Open(const char *, int);
	Close();
	long Read(void gk_huge *, long);
	long Write(const void *, long);
	long Seek(long);
	long Trunc();
	long Tell();
	long Length();
};

#endif  // __WINSTORE_H__
