// ServerShell.h: interface for the ServerShell class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SERVERSHELL_H__9EAA17C2_0221_11D3_BF5A_D2F3C2DC4597__INCLUDED_)
#define AFX_SERVERSHELL_H__9EAA17C2_0221_11D3_BF5A_D2F3C2DC4597__INCLUDED_

#define STMT_INFO		1
#define STMT_ERROR		2
#define STMT_WARNING	3
#define STMT_DEBUG		4


class ServerShell  
{
public:
	ServerShell() {};
	virtual ~ServerShell() {};
	virtual void Message ( const char* pMess, const char* pTitle, long lType ) = 0;
};

#endif
