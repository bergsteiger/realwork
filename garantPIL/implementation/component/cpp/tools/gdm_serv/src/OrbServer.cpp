/*
 * $Id: OrbServer.cpp,v 1.13 2005/08/17 12:42:44 grigorio Exp $
 *
 */

#ifdef _WIN32
 #include <process.h>
#elif defined (unix)
 #include <thread.h>
 #include <unistd.h>
#endif
#include <cstdio>

#include "OrbServer.h"

// Request Waiting Cycle thread fork function
#ifdef _WIN32
 void _startCycle (void* pMess)
#elif defined (unix)
 void* _startCycle (void* pMess)
#endif
{
	ORBServer * pServer = (ORBServer*) pMess;

	try {
		pServer->startCycle (ORBServer::st_sync);
	} catch (...) {		
		pServer->m_pShell->Message ( "Exception is caught while Server is running", 
			"ORB Error", STMT_ERROR );
	}
#if defined (unix)
	return 0;
#endif	
}

#ifdef _WIN32
 void _stopCycle (void* pMess)
 {
	 Sleep ( 2 * 1000 );
#elif defined (unix)
 void* _stopCycle (void* pMess)
 {
	 sleep ( 2 );
#endif	
	((ORBServer*)pMess)->stopCycle (ORBServer::st_sync);

#if defined (unix)
	return 0;
#endif	
}

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

ORBServer::ORBServer ( ServerShell* pShell )
{
	m_pShell = pShell;
}

//void ORBServer::init ( CORBA::ULong incSec, CORBA::ULong outSec )
void ORBServer::init ( int argc, char** argv ) 
{
	ORBInit ( argc, argv );
	COSInit();
}

ORBServer::~ORBServer()
{
	m_pOrb->destroy();
	m_pShell->Message ( "ORB destroed", "ORBServer Info", STMT_DEBUG  );

	for ( Point p = m_setServant.first(); p; m_setServant.next(p) ) {
		delete m_setServant(p);
	}
	m_pShell->Message ( "All objs destroed", "ORBServer Info", STMT_DEBUG );	
}

void ORBServer::COSInit ()
{
	try {
		// Obtain a reference to the root context of the Name service:
		CORBA::Object_var initServ;
		initServ = m_pOrb->resolve_initial_references("NameService");

		// Narrow the object returned by resolve_initial_references()
		// to a CosNaming::NamingContext object:
		m_rootContext = CosNaming::NamingContext::_narrow(initServ);
		if (CORBA::is_nil(m_rootContext)) {
			m_pShell->Message ( "Failed to narrow naming context", "COSN error", STMT_ERROR );
			throw;
		}
	} catch(CORBA::ORB::InvalidName& ex) {
		m_pShell->Message ( "Service required is invalid [does not exist]", "COSN error", STMT_ERROR );
		throw ex;
	} catch(CORBA::NO_RESOURCES& ex) {
		m_pShell->Message ( "Service required is invalid [does not exist]", "COSN error", STMT_ERROR );
		throw ex;
	}
	
	m_pShell->Message ( "NameService successfully resolved", "ORBServer Info", STMT_DEBUG );
}

CORBA::Boolean ORBServer::nameBinding( _Servant* pserv )
{
	try {
		// Bind a context called "test" to the root context:
		CosNaming::Name contextName;
		contextName.length(1);
		contextName[0].id   = (const char*) pserv->getContext();
		contextName[0].kind = (const char*) "Context";

		CosNaming::NamingContext_var context;
		try {
			// Bind the context to root, and assign context to it:
  			context = m_rootContext->bind_new_context(contextName);
		}
		catch(CosNaming::NamingContext::AlreadyBound& ex) {
			// If the context already exists, this exception will be raised.
			// In this case, just resolve the name and assign context
			// to the object returned:
			CORBA::Object_var tmpobj;
			tmpobj = m_rootContext->resolve(contextName);
			context = CosNaming::NamingContext::_narrow(tmpobj);
			if (CORBA::is_nil(context)) {
				m_pShell->Message ( "Failed to narrow naming context", "COSN error", STMT_ERROR );
				return 0;
			}
		} 

		CosNaming::Name objectName;
		objectName.length(1);
		objectName[0].id   = (const char*) pserv->getName();
		objectName[0].kind = (const char*) "Object";

		try {
			context->bind( objectName, pserv->getServant() );
		}
		catch(CosNaming::NamingContext::AlreadyBound& ex) {
			context->rebind( objectName, pserv->getServant() );
			m_pShell->Message ( "Object rebinded", "COSN info", STMT_WARNING );
		}
	} catch (CORBA::COMM_FAILURE& ex) {
		m_pShell->Message ( "Caught system exception COMM_FAILURE, unable to contact the naming service",
			"COSN error", STMT_ERROR );
		return 0;
	} catch (...) {
		m_pShell->Message ( "Caught a system exception while using the naming service", 
			"COSN error", STMT_ERROR );
		return 0;
	}
	return 1;
}

void ORBServer::stopCycle ( SyncType sync )
{
	if ( sync == st_sync ) {
		stopCycleProc ();
		m_pShell->Message ( "Request Waiting Cycle successfully ended and unlock the thread", 
			"Srver info", STMT_DEBUG );
	} else {
#ifdef _WIN32
		if ( _beginthread ( _stopCycle, 4, this ) == -1 ) {
#elif defined (unix)
		pthread_t tid;
		thr_create(0, 0, _stopCycle, this, 0, &tid);
		if ( tid == 0 ) {
#else
		#error "Don't know how to create thread"	
#endif
			m_pShell->Message ( "Can't fork a Request Waiting Cycle shutdown thread", 
				"Server error", STMT_ERROR );
		} else {
			m_pShell->Message ( "Request Waiting Cycle shutdown in progress",
				"Srver info", STMT_DEBUG );
		}
	}
}

void ORBServer::startCycle( SyncType sync )
{	
	if ( sync == st_sync) {
		m_pShell->Message ( "Request Waiting Cycle successfully started and lock the thread", 
			"Srver info", STMT_DEBUG );
		startCycleProc ();
		m_pShell->Message ( "Request Waiting Cycle successfully ended and unlock the thread", 
			"Srver info", STMT_DEBUG );		
	} else {
#ifdef _WIN32
		if ( _beginthread ( _startCycle, 4, this ) == -1 ) {
#elif defined (unix)
		pthread_t tid;
		thr_create(0, 0, _startCycle, this, 0, &tid);
		if ( tid == 0 ) {
#else
 		#error "Don't know how to create thread"	
#endif
			m_pShell->Message ( "Can't fork a Request Waiting Cycle thread", 
				"Server error", STMT_ERROR );
		} else {
			m_pShell->Message ( "Request Waiting Cycle successfully started in thread",
				"Srver info", STMT_DEBUG );
		}
	}
}

void ORBServer::startServants( SyncType sync )
{
	for ( Point p = m_setServant.first(); p; m_setServant.next(p) ) {
		try {
			startObj ( m_setServant(p) );
		} catch (...) {
			m_pShell->Message ( "Can't starts objs", "ORB Error", STMT_ERROR );
			return;
		}

		try {
			nameBinding ( m_setServant(p) );
		} catch (...) {
			m_pShell->Message ( "Can't bind objs to COS Naming", "COSN Error", STMT_ERROR );
			return;
		}

		{
			char buf [1024];
			sprintf ( buf, "Servlet %s.%s started", 
				m_setServant(p)->getContext(), m_setServant(p)->getName() );
			m_pShell->Message ( buf, "ORBServer Info", STMT_DEBUG );
		}
	}
	startCycle ( sync );
}

void BOAServer::startCycleProc()
{
	m_pBoa->impl_is_ready ();
}

void BOAServer::stopCycleProc()
{
	m_pBoa->impl_shutdown ();
}

void BOAServer::ORBInit( int argc, char** argv )
{	
	try {
		m_pOrb = CORBA::ORB_init ( argc, argv, "omniORB3" );
	} catch (...) {
		m_pShell->Message ( "Can't initialize ORB", "ORB Error", STMT_ERROR );
		m_pOrb = 0;
		throw;
	}
	if ( m_pOrb ) try {
		m_pBoa = m_pOrb->BOA_init ( argc, argv, "omniORB2_BOA" );
	} catch (...) {
		m_pShell->Message ( "Can't initialize BOA", "ORB Error", STMT_ERROR );
		m_pBoa = 0;
		throw;
	}
	m_pShell->Message ( "ORB successfully initialize", "ORBServer Info", STMT_DEBUG );
}

BOAServer::~BOAServer()
{
	for ( Point p = m_setServant.first(); p; m_setServant.next(p) ) {
		m_pBoa->dispose ( m_setServant(p)->getServant() );
	}
	m_pShell->Message ( "All objs disposed", "ORBServer Info", STMT_DEBUG );
	
	m_pBoa->destroy();
}

POAServer::~POAServer()
{
}

void POAServer::ORBInit( int argc, char** argv )
{		
	try {
		m_pOrb = CORBA::ORB_init ( argc, argv, "omniORB3" );
	} catch (...) {
		m_pShell->Message ( "Can't initialize ORB", "ORB Error", STMT_ERROR );
		m_pOrb = 0;
		throw;
	}
	if ( m_pOrb ) try {
		CORBA::Object_var obj = m_pOrb->resolve_initial_references("RootPOA");
		m_pPoa = PortableServer::POA::_narrow(obj);		
	} catch (...) {
		m_pShell->Message ( "Can't initialize POA", "ORB Error", STMT_ERROR );
		m_pPoa = 0;
		throw;
	}
	m_pShell->Message ( "ORB successfully initialize", "ORBServer Info", STMT_DEBUG );
}

void POAServer::startCycleProc()
{
	m_pman = m_pPoa->the_POAManager();
	m_pman->activate();
	m_pOrb->run();	
}

void POAServer::stopCycleProc()
{

}

void POAServer::startObj ( _Servant* pserv ) 
{
	
	/*PortableServer::ObjectId_var myechoid = */
	m_pPoa->activate_object(pserv->getServantBase());
};



