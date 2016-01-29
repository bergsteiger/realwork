#include "shared/Core/fix/mpcxc.h"
#include <fcntl.h>
#include "winstore.h"

CWinStore::CWinStore(const char *name, int mode)
{
	m_pFile = new CFile();
	Open(name, mode);
}

CWinStore::~CWinStore()
{
	Close();
	if(m_pFile) delete m_pFile;
}

int CWinStore::Open(const char *name, int mode)
{
	int openflags;

	openflags = 0;
	if(mode & ACE_OS_O_WRONLY) openflags |= CFile::modeWrite;
	else if(mode & ACE_OS_O_RDWR) openflags |= CFile::modeReadWrite;
	else openflags |= CFile::modeRead;
	if(mode & ACE_OS_O_CREAT) openflags |= CFile::modeCreate;
	if(mode & ACE_OS_O_TEXT) openflags |= CFile::typeText;
	else if(mode & ACE_OS_O_BINARY) openflags |= CFile::typeBinary;
	if(!m_pFile->Open(name, openflags)) m_state = 0x8000;
	else m_state = 1;
	return (m_state & 1);
}

int CWinStore::Close()
{
	if(m_state == 1) {
		m_pFile->Close();
		m_state = 0;
	}
	return 0;
}

long CWinStore::Read(void gk_huge *buf, long dwRead)
{
	if( m_state != 1 ) return 0L;
	if ( dwRead < 0x10000L ) m_pFile->Read(buf, (UINT)dwRead);
	else m_pFile->ReadHuge(buf, dwRead);
	return dwRead;
}

long CWinStore::Write(const void *buf, long dwWrite)
{
	if( m_state != 1 ) return 0L;
	if ( dwWrite < 0x10000L ) m_pFile->Write(buf, (UINT)dwWrite);
	else m_pFile->WriteHuge(buf, dwWrite);
	return dwWrite;
}

long CWinStore::Seek(long offs)
{
	if( m_state != 1 ) return 0L;
	return m_pFile->Seek(offs, CFile::begin);
}

long CWinStore::Trunc()
{
	long length;

	if( m_state != 1 ) return 0L;
	length = Tell();
	m_pFile->SetLength(length);
	return length;
}

long CWinStore::Tell()
{
	if( m_state != 1 ) return 0L;
	return m_pFile->Seek(0L, CFile::current);
}

long CWinStore::Length()
{
	if( m_state != 1 ) return 0L;
	return m_pFile->GetLength();
}

