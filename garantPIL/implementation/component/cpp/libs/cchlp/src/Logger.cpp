/*
 * $Id: Logger.cpp,v 1.20 2015/03/03 12:06:59 young Exp $
 */

//////////////////////////////////////////////////////////////////////
//
// Logger.cpp: implementation of the Logger class.
//
//////////////////////////////////////////////////////////////////////

#include "osdep.h"

#include "Logger.h"
#include <stdarg.h>

logtype_t lt_fatal ( 0, "FATAL ERROR" );
logtype_t lt_stop ( 100, "STOP MESSAGE" );
logtype_t lt_error ( 200, "ERROR" );
logtype_t lt_warning ( 300, "WARNING" );
logtype_t lt_info ( 400, "INFO" );
logtype_t lt_debug ( 500, "DEBUG" );
logtype_t lt_always ( 0, "ALWAYS" );

void sinsertf ( char * str, const char* fmt, ... )
{
	char * adds = (char*) gk_malloc (LOG_MAXSIZE);
	
	va_list ap;
	va_start(ap, fmt);
		vsprintf( (char*)adds, fmt, ap);
	va_end(ap);

	memmove ( str+strlen(adds), str, strlen(str)+1 );
	memcpy ( str, adds, strlen(adds) );
	
	gk_free ( adds );
}

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

int LogType::s_nextFreeId = 0;

LogDevice :: ~LogDevice () 
{
	m_bDestruction = 1;
	for ( Point point = m_setOwners.first(); point; m_setOwners.next(point) )
		m_setOwners(point)->Del ( this );		
}

void LogDevice::Logging ( code_t out, const char* str ) {
	if ( m_bEnable ) {
		if ( m_bSelfOutCode && m_ctOut != out ) {
			char format_buff_2 [LOG_MAXSIZE];
			str = Recoding ( out, m_ctOut, format_buff_2, str );
		}
	
		Print ( str );
	}
}

void LogFile::Print ( const char* str ) const 
{
	if (m_pFile && str) fputs (str, m_pFile);
	//fflush ( m_pFile );
}

void LogScreen::Print ( const char* str ) const
{
	printf ( str );
}

LogPolicy* LogPolicy::duplicate () const
{
	LogPolicy* p = new LogPolicy (*this);
	return p; // GARANT_DBG
}	

void LogSession::printf ( const char *fmt, ... )
{		
	if ( m_pPolicy->Enable(m_ltDefault) ) {
		char format_buff_1 [LOG_MAXSIZE];
		va_list ap;
		va_start(ap, fmt);
			vsprintf( (char*)format_buff_1, fmt, ap);
		va_end(ap);
			
		char* str = (char*)format_buff_1;
		if ( m_pPolicy->PrePrint ( m_ltDefault, str ) )
			Logging ( m_ltDefault, m_pPolicy->InCode(), str );
	}
}

void LogSession::printf ( logtype_t& type, const char *fmt, ... )
{	
	if ( m_pPolicy->Enable(type) ) {
		char format_buff_1 [LOG_MAXSIZE];
		va_list ap;
		va_start(ap, fmt);
			vsprintf( (char*)format_buff_1, fmt, ap );
		va_end(ap);
	
		char* str = (char*)format_buff_1;
		if ( m_pPolicy->PrePrint ( type, str ) )
			Logging ( type, m_pPolicy->InCode(), str );
	}
}

void LogSession::printf ( logtype_t& type, code_t code, const char *fmt, ... )
{	
	if ( m_pPolicy->Enable(type) ) {
		char format_buff_1 [LOG_MAXSIZE];
		va_list ap;
		va_start(ap, fmt);
			vsprintf( (char*)format_buff_1, fmt, ap );
		va_end(ap);
	
		char* str = (char*)format_buff_1;
		if ( m_pPolicy->PrePrint ( type, str ) )
			Logging ( type, code, str );
	}
}

void LogSession::Logging ( logtype_t& type, code_t in, char* str ) 
{		
	code_t out = m_pPolicy->OutCode();

	if ( in != out ) Recoding ( in, out, str, 0 );

	m_pPolicy->GetDevices(type).Print ( out, str );
}

/************************  LogType  **********************/

 LogType::LogType ( unsigned int i, const char* name ) 
	: m_level (i), m_pName(0) 
{
	m_typeId = s_nextFreeId++;
	if ( name ) m_pName = strdup ( name );
}

 LogType::LogType ( const LogType& copy ) 
	: m_typeId (copy.m_typeId), m_level(copy.m_level), m_pName(0)
{
	if ( copy.m_pName ) m_pName = strdup ( copy.m_pName );
}

 LogType::~LogType ()
{
	if ( m_pName ) free ( m_pName );
}

 LogType& LogType::operator = ( const LogType& copy )
{
	m_typeId = copy.m_typeId;
	m_level = copy.m_level;
	if ( m_pName ) free ( m_pName );
	if ( copy.m_pName ) m_pName = strdup ( copy.m_pName );
	else m_pName = 0;

	return *this;
}

 const char* LogType::Name () const
{
	return m_pName;
}

 unsigned int LogType::Level () const
{
	return m_level;
}

 int LogType::operator == (const LogType& a ) const 
{
	return m_typeId == a.m_typeId;
}

 int LogType::operator != (const LogType& a ) const 
{
	return m_typeId != a.m_typeId;
}

 int LogType::operator < (const LogType& a ) const 
{
	return m_typeId < a.m_typeId;
}

 int LogType::operator > (const LogType& a ) const 
{
	return m_typeId > a.m_typeId;
}

 int LogType::operator <= (const LogType& a ) const 
{
	return m_typeId <= a.m_typeId;
}

 int LogType::operator >= (const LogType& a ) const 
{
	return m_typeId >= a.m_typeId;
}


/************************  LogDevices  **********************/

 LogDevice::LogDevice () : m_bSelfOutCode(0), m_bEnable(1), m_bDestruction(0)
{
}

 code_t LogDevice::SelfCode () const
{
	return m_ctOut;	
}

 void LogDevice::SelfCode ( code_t selfCode ) 
{
	m_ctOut = selfCode;
	m_bSelfOutCode = 1;
}

 int LogDevice::HasSelfCode () const
{
	return m_bSelfOutCode;
}

 int LogDevice::Enable () const
{
	return m_bEnable;	
}

 void LogDevice::Enable ( int enable ) 
{
	m_bEnable = enable;
}

 void LogDevice::ReleaseOwner ( TypeDevices* owner ) 
{
	if ( !m_bDestruction ) m_setOwners.del ( owner );
}

 void LogDevice::AddOwner ( TypeDevices* owner ) 
{
	if ( owner ) m_setOwners.add ( owner );
}

 LogFile::LogFile ( FILE* file )
	: LogDevice (), m_pFile ( file ), m_bCreated (0) 
{
}

 LogFile::LogFile ( const char* name ) 
	: LogDevice (), m_bCreated (0) 
{
	FileOpen ( name );
}

 LogFile::~LogFile () 
{
	if ( m_bCreated ) {
		fclose ( m_pFile );
	}
}

 void LogFile::FileOpen ( const char* name ) 
{
	m_pFile = mpcxc_fopen ( name, "atc" );
	if ( !m_pFile ) {
		throw errno;
	} else m_bCreated = 1;
}

/************************  TypeDevices  ***********************/

 TypeDevices::TypeDevices ( LogDevice* dev ) :  m_bEnable(1) 
{
	Add ( dev );
}

 TypeDevices::TypeDevices ( const TypeDevices& copy ) 
	: m_bEnable(copy.m_bEnable), m_setDevices(copy.m_setDevices) 
{
	for ( Point point = m_setDevices.first(); point; m_setDevices.next(point) )
		m_setDevices(point)->AddOwner ( this );
}

 TypeDevices::~TypeDevices () 
{
	Clear ();
}

 TypeDevices& TypeDevices::operator = ( const TypeDevices& copy ) 
{
	Clear ();
	m_setDevices = copy.m_setDevices;
	m_bEnable = copy.m_bEnable;

	for ( Point point = m_setDevices.first(); point; m_setDevices.next(point) )
		m_setDevices(point)->AddOwner ( this );

	return *this;
}

 void TypeDevices::Add ( LogDevice* dev ) 
{
	if ( dev && !m_setDevices.contains( dev ) ) {
		dev->AddOwner ( this );
		m_setDevices.add(dev);
	}
}

 void TypeDevices::Del ( LogDevice* dev ) 
{
	if ( dev && m_setDevices.contains (dev) ) {
		dev->ReleaseOwner ( this );
		m_setDevices.del( dev );
	}
}

 void TypeDevices::Clear () 
{
	for ( Point point = m_setDevices.first(); point; m_setDevices.next(point) )
		m_setDevices(point)->ReleaseOwner ( this );

	m_setDevices.clear();
}	
	
 int TypeDevices::Enable () const 
{
	return m_bEnable;
}

 void TypeDevices::Enable ( int value ) 
{
	m_bEnable = value;
}
	
 void TypeDevices::Print ( code_t out, const char* str ) 
{
	if ( Enable () )
		for ( Point point = m_setDevices.first(); point; m_setDevices.next(point) )
			m_setDevices(point)->Logging ( out, str );
}

/************************  LogPolicy  ***********************/

 LogPolicy::LogPolicy ( LogDevice* dev, code_t in, code_t out ) 
	: m_ctIn(in), m_ctOut(out), m_logLevel(lt_debug.Level()), m_pName (0), m_mapTypeDevices ( TypeDevices ( dev ) )
{
}

 LogPolicy::LogPolicy ( const TypeDevices& def, code_t in, code_t out ) 
	: m_ctIn(in), m_ctOut(out), m_logLevel(lt_debug.Level()), m_pName (0), m_mapTypeDevices ( def ) 
{
}

 LogPolicy::LogPolicy ( const LogPolicy& copy )
//	: m_ctIn(copy.m_ctIn), m_ctOut(copy.m_ctOut), m_logLevel(lt_debug.Level()), m_pName(0), m_mapTypeDevices(copy.m_mapTypeDevices) 
{
	m_ctIn = copy.m_ctIn; // GARANT_DBG
	m_ctOut = copy.m_ctOut;
	m_logLevel = lt_debug.Level();
	m_pName = 0;
	m_mapTypeDevices = copy.m_mapTypeDevices;
}

 LogPolicy& LogPolicy::operator = (const LogPolicy& copy)
{
	m_ctIn = copy.m_ctIn;
	m_ctOut = copy.m_ctOut;
	m_logLevel = copy.m_logLevel;
	m_mapTypeDevices = copy.m_mapTypeDevices;
	if ( m_pName ) {
		free ( m_pName );
		m_pName = 0;
	}
	return *this;
}

 LogPolicy::~LogPolicy ()
{
	if ( m_pName ) free ( m_pName );
}
	
 void LogPolicy::InCode ( code_t in )
{
	m_ctIn = in;
}

 code_t LogPolicy::InCode () const 
{
	return m_ctIn;
}

 void LogPolicy::OutCode ( code_t out ) 
{
	m_ctOut = out;
}

 code_t LogPolicy::OutCode () const 
{
	return m_ctOut;
}

 TypeDevices& LogPolicy::Devices ()
{
	return m_mapTypeDevices.dflt();
}

 TypeDevices& LogPolicy::Devices ( logtype_t& type ) 
{ 
	Point point = m_mapTypeDevices.seek(type);
	if ( point ) return m_mapTypeDevices.contents(point);
	else {
		(m_mapTypeDevices[type] = TypeDevices()).Enable(type.Level() <= m_logLevel);
		return m_mapTypeDevices[type];
	}
}

 TypeDevices& LogPolicy::GetDevices ( logtype_t& type ) 
{
	Point point = m_mapTypeDevices.seek(type);
	if ( point ) return m_mapTypeDevices.contents(point);
	else return m_mapTypeDevices.dflt();
}

 void LogPolicy::DelDevices ( logtype_t& type ) 
{
	m_mapTypeDevices.del(type);
}

 int LogPolicy::Enable ( logtype_t& type )
{
	return  (type.Level() <= m_logLevel) && GetDevices ( type ).Enable();
}

 void LogPolicy::Clear () 
{
	m_mapTypeDevices.clear();
}

 void LogPolicy::AddLogDevice ( LogDevice* dev ) 
{
	for ( Point point = m_mapTypeDevices.first(); point; m_mapTypeDevices.next(point) ) 
		m_mapTypeDevices.contents(point).Add ( dev );

	m_mapTypeDevices.dflt().Add ( dev );
}

 void LogPolicy::DelLogDevice ( LogDevice* dev ) 
{
	for ( Point point = m_mapTypeDevices.first(); point; m_mapTypeDevices.next(point) )
		m_mapTypeDevices.contents(point).Del ( dev );
	m_mapTypeDevices.dflt().Del ( dev );
}

 void LogPolicy::SetLogLevel ( unsigned int level )
{
	m_logLevel = level;
	for ( Point point = m_mapTypeDevices.first(); point; m_mapTypeDevices.next(point) )
		m_mapTypeDevices.contents(point).Enable(m_mapTypeDevices.key(point).Level()<=m_logLevel);
	//m_mapTypeDevices.dflt().Enable(m_mapTypeDevices.dflt().Level()<=m_logLevel);
}

 void LogPolicy::SetLogLevel ( logtype_t& ltlevel )
{
	SetLogLevel ( ltlevel.Level() );
}

 void LogPolicy::SetName ( const char* name )
{
	if ( name ) {
		if ( m_pName ) free ( m_pName );
		m_pName = strdup ( name );
	}
}

 const char* LogPolicy::GetName () const
{
	return m_pName;
}


/************************  LogSession  ***********************/

 LogSession::LogSession() : m_pPolicy(0)
{
}

 LogSession::LogSession( const LogPolicy& policy, const char* name, logtype_t def )
	: m_pPolicy(policy.duplicate()), m_ltDefault(def) 
{
	m_pPolicy->SetName ( name );
}

 void LogSession::Init( const LogPolicy& policy, const char* name, logtype_t def )	
{
	m_pPolicy = new LogPolicy(policy); // GARANT_DBG
	m_ltDefault = def;
	m_pPolicy->SetName ( name );
}

 LogSession::LogSession( LogPolicy* policy, const char* name, logtype_t def )
	: m_pPolicy(policy), m_ltDefault(def) 
{
	m_pPolicy->SetName ( name );
}

 void LogSession::Init( LogPolicy* policy, const char* name, logtype_t def )	
{
	m_pPolicy = policy;
	m_ltDefault = def;
	m_pPolicy->SetName ( name );
}


 LogSession::LogSession( const LogSession& copy ) 
	: m_pPolicy(copy.m_pPolicy->duplicate()), m_ltDefault(copy.m_ltDefault) 
{
	m_pPolicy->SetName ( copy.m_pPolicy->GetName() );
}

 LogSession& LogSession::operator = (const LogSession& copy) 
{
	delete m_pPolicy;
	m_pPolicy = copy.m_pPolicy->duplicate();
	m_ltDefault = copy.m_ltDefault;
	
	m_pPolicy->SetName ( copy.m_pPolicy->GetName() );

	return *this;
}

 LogSession::~LogSession() 
{	
	delete m_pPolicy;
}	

 LogPolicy* LogSession::GetPolicy () 
{
	return m_pPolicy;
}

 LogPolicy* LogSession::SetPolicy ( LogPolicy* policy )
{
	policy->SetName ( m_pPolicy->GetName() );
	delete m_pPolicy;
	
	return m_pPolicy = policy;
}

 LogPolicy* LogSession::SetPolicy ( const LogPolicy& policy )
{	
	return SetPolicy ( policy.duplicate() );
}

 LogPolicy* LogSession::OverlapPolicy ( LogPolicy* policy )
{
	*policy = *m_pPolicy;
	policy->SetName ( m_pPolicy->GetName() );

	delete m_pPolicy;
	return m_pPolicy = policy;
}

 LogPolicy* LogSession::OverlapPolicy ( const LogPolicy& policy )
{
	return OverlapPolicy ( policy.duplicate() );
}

 TypeDevices& LogSession::operator () (logtype_t& type) 
{
	return Devices(type);
}

 TypeDevices& LogSession::operator () () 
{
	return Devices();
}

 TypeDevices& LogSession::Devices (logtype_t& type) 
{
	return m_pPolicy->Devices(type);
}

 TypeDevices& LogSession::Devices () 
{
	return m_pPolicy->Devices();
}

 logtype_t LogSession::DefaultLogType () const
{
	return m_ltDefault;
}

 void LogSession::DefaultLogType ( logtype_t& def ) 
{
	m_ltDefault = def;
}

/************************  Logger  ***********************/
 Logger::Logger () : m_mapSessions ( 0 )
{
}

 Logger::Logger ( LogDevice* dev, code_t in, code_t out, logtype_t def )
	:LogSession ( LogPolicy ( TypeDevices ( dev ), in, out ), "MAIN LOGGER", def ), m_mapSessions ( 0 )
{
}

 void Logger::Init ( LogDevice* dev, code_t in, code_t out, logtype_t def )
{
	LogPolicy lp(TypeDevices ( dev ), in, out);
	LogSession::Init ( lp, "MAIN LOGGER", def ); // GARANT_DBG
	LogDevice* tmp = dev; // GARANT_DBG
}

 Logger::Logger ( const LogPolicy& policy, logtype_t def )
	: LogSession ( policy, "MAIN LOGGER", def ), m_mapSessions ( 0 )
{
}

 void Logger::Init ( const LogPolicy& policy, logtype_t def )
{
	LogSession::Init ( policy, "MAIN LOGGER", def );
}

 Logger::Logger ( LogPolicy* policy, logtype_t def )
	:LogSession ( policy, "MAIN LOGGER", def ), m_mapSessions ( 0 )
{
}

 void Logger::Init ( LogPolicy* policy, logtype_t def )
{
	LogSession::Init ( policy, "MAIN LOGGER", def );
}

 Logger::~Logger ()
{
	for ( Point point=m_mapSessions.first(); point; m_mapSessions.next(point) ) {
		delete m_mapSessions.contents(point);
	}
}

 LogSession* const Logger::AddSession ( const char* name ) 
{
	return AddSession ( *m_pPolicy, name );
}

 LogSession* const Logger::AddSession ( const LogPolicy& policy, const char* name ) 
{	
	char buf[256];	
	if ( !name ) {
		long same;
		long l = 0;
		do {
			sprintf ( buf, "Auto-created session #%ld", l++ );
			SString key (buf);			
			same = m_mapSessions.contains ( key );
		} while ( same );
		name = buf;
	}
	
	SString fname ( name );
	LogSession * newlog = m_mapSessions[fname];

	if ( !newlog )
		newlog = m_mapSessions[fname] = new LogSession ( policy, name, m_ltDefault );
	
	return newlog;
}

 LogSession* const Logger::CopySession ( const char* destname, const char* srcname )
{
	LogSession * srclog = 0;
	if ( srcname ) {		
		SString fsrcname ( srcname );		
		srclog = m_mapSessions [fsrcname];
		if ( srclog ) 
			srclog = AddSession ( *(srclog->m_pPolicy), destname );
	}
	return srclog;
}

 void Logger::DelSession ( const char* name ) 
{
	if ( name ) {
		SString fname ( name );
		Point point = m_mapSessions.seek ( fname );		
		if ( point ) {			
			delete m_mapSessions.contents ( point );
			m_mapSessions.del ( point );
		}
	}
}

 LogSession* const Logger::GetSession ( const char* name ) 
{
	LogSession * session = 0;
	if ( name ) {
		SString fname ( name );		
		if ( m_mapSessions.contains ( fname ) )
			session = m_mapSessions [fname];
		else 
			session = AddSession ( name );
	}	
	return session;
}

void	LogSession::flush ( logtype_t& type )
{	
	if ( m_pPolicy->Enable(type) ) {
		m_pPolicy->GetDevices(type).flush ();
	}
}

void	TypeDevices::flush() 
{
	for ( Point point = m_setDevices.first(); point; m_setDevices.next(point) )
		m_setDevices(point)->flush ();
}

void	LogDevice::flush()
{
}

void	LogFile::flush () 
{
	if (m_pFile)
		fflush ( m_pFile );
}
