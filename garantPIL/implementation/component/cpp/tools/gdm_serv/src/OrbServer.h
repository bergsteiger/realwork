/*
 * $Id: OrbServer.h,v 1.9 2005/08/17 12:42:44 grigorio Exp $
 */

#if !defined(AFX_SERVERT1_H__FE521970_016E_11D3_BF5A_F55C1A59A517__INCLUDED_)
#define AFX_SERVERT1_H__FE521970_016E_11D3_BF5A_F55C1A59A517__INCLUDED_

#include <cstdlib>

#ifndef __CORBA_H_EXTERNAL_GUARD__
 #define __CORBA_H_EXTERNAL_GUARD__
 #include <omniORB3/CORBA.h>
#endif

#include "ServerShell.h"
#include "SplaySet.h"

class _Servant
{
	char* m_pName;
	char* m_pContext;
public:
	_Servant ( const char* name, const char* context ) {
		if ( !name || !context ) throw;
		m_pName = strdup (name);
		m_pContext = strdup (context);		
	}
	
	virtual ~_Servant () {
		if ( m_pName ) free ( m_pName );
		if ( m_pContext ) free ( m_pContext );
	}

	virtual CORBA::Object_ptr getServant () const = 0;
	virtual PortableServer::ServantBase * getServantBase () const = 0;
	inline const char* getName () {
		return m_pName;
	}
	inline const char* getContext () {
		return m_pContext;
	}
};



template <class ServerObj> 
class Servant : public _Servant
{
protected:
	ServerObj* m_servant;
public:
	Servant ( ServerObj* serv, const char* name, const char* context ) 
		: _Servant (name, context), m_servant (serv) {}
	
	virtual ~Servant () {
		if ( m_servant ) delete m_servant;		
	}

	inline virtual CORBA::Object_ptr getServant () const {
		return m_servant->_this();
	};
	
	inline virtual PortableServer::ServantBase* getServantBase () const {
		return m_servant;
	};
};

class ORBServer  
{
#ifdef _WIN32
	friend void _startCycle (void*);
	friend void _stopCycle (void*);
#elif defined (unix)
	friend void* _startCycle (void*);
	friend void* _stopCycle (void*);
#endif
public:
	enum SyncType {
		st_async,
		st_sync
	};

public:
	ORBServer( ServerShell* pShell );
	virtual void init ( int argc, char** argv );
	virtual ~ORBServer();
		
	template <class ServantObj> int attach ( ServantObj* obj, const char* name, const char* context ) 
	{	
		try {
			_Servant * p = new Servant<ServantObj> ( obj, name, context );
			m_setServant.add (p);
		} catch (...) {
			m_pShell->Message ( "Can't attach servlet with bad params", "Work Error", STMT_ERROR );
			return 0;
		}
	
		char buf [1024];
		sprintf ( buf, "Servlet %s.%s successfully attached", context, name );
		m_pShell->Message ( buf, "ORBServer Info", STMT_DEBUG );
		return 1;
	};
	virtual void stopServer () {
		stopCycle(st_async);
	};

	virtual void startServants ( SyncType sync = st_sync );
	
protected:
	void COSInit ();
	virtual CORBA::Boolean nameBinding( _Servant* pserv );
	
	virtual void ORBInit (int argc, char** argv) = 0;
	virtual void startCycleProc() = 0;
	virtual void stopCycleProc() = 0;
	virtual void startObj ( _Servant* ) = 0;

private:
	void startCycle( SyncType sync );
	void stopCycle( SyncType sync );

protected:
	ServerShell* m_pShell;
	CORBA::ORB_ptr m_pOrb;
	CosNaming::NamingContext_var m_rootContext;	
	SplaySet<_Servant*> m_setServant;
};

class BOAServer: public ORBServer 
{
public:
	BOAServer( ServerShell* pShell ) : ORBServer( pShell ) {};
	virtual ~BOAServer();
		
protected:
	virtual void startCycleProc();
	virtual void stopCycleProc();
	void ORBInit (int argc, char** argv);
	virtual void startObj ( _Servant* pserv ) {
		m_pBoa->obj_is_ready(pserv->getServant());
	};

protected:
	CORBA::BOA_ptr m_pBoa;
};

class POAServer: public ORBServer 
{
public:
	POAServer( ServerShell* pShell ) : ORBServer( pShell ) {};
	virtual ~POAServer();	
	
protected:
	virtual void startCycleProc();
	virtual void stopCycleProc();
	virtual void ORBInit (int argc, char** argv);
	virtual void startObj ( _Servant* );
protected:
	PortableServer::POA_var m_pPoa;
	PortableServer::POAManager_var m_pman;
};

#endif

