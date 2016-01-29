#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: Logger.h,v 1.27 2006/11/07 09:55:52 vlad Exp $
 */

/***************************** INTRODUCTION **********************************

****************************   class LogType   ********************************
	
		#define logtype_t LogType

		LogType - predstavlaet class typov soobshenij. 
Kajdij typ imeet unikalnij vnutrennij identifikator, 
a tak je svoi uroven soobshenija, na osnove kotorogo soobshenija 
dannogo tipa mogut zapreshatsa ili razreshatsa.
Tip mojet imet tekstovoe ima.
Dla sozdanija novogo unikalnogo tipa, dostatochno prosto sozdat
object dannogo klassa.

	LogType ( unsigned int level, const char* name );
		- sozdaet novij unikalnij tip s zadannim urovnem i imenem

	predustanovlennie tipi soobshenij 
		lt_fatal : "FATAL ERROR", uroven 0
		lt_stop : "STOP MESSAGE", uroven 100
		lt_error : "ERROR", uroven 200
		lt_warning : "WARNING", uroven 300
		lt_info : "INFO", uroven 400
		lt_debug : "DEBUG", uroven 500
		lt_always : "ALWAYS" uroven 0

****************************   class LogDevice   ********************************
		
		LogDevice - predstavlaet class ustroistv vivoda soobshenij.
log-ustroistvo mojet imet sobstvennuju russkuyu kodirovku, 
otlichaushyusa ot obshej kodirovki vivoda programmi.
Kajdoe log-ustrojstvo svazanno so svoimi vladelcami ( objectami 
classa TypeDevices - kontejner log-ustrojstv otnosashihsa k konkretnomu 
tipu soobshenija).
	
	
	void SelfCode ( code_t );
		- ustanavlivaet kodirovku
	
	*** virtualnie metodi
	virtual void Print ( const char* str );
		- metod vipolnaushij neposredstvennij vivod soobshenija
	
	*** proizvodnie klassi
	class LogFile 
		- class ustroistva vivoda f fail

	class LogScreen
		- class ustroistva vivoda v cout

****************************   class TypeDevices   ********************************

		TypeDevices - klass predstavlaushij contejner (conteiner tipa) 
log-ustroistv svazannih s konkretnim tipom soobshenija. 
Tolko cherez takoi kontejner opredelaetsa na kakie ustrojstva
neobhodimo vivodit soobshenija zadanogo tipa.
Vivod soobshenij zadannogo tipa mojet bit zapreshen na vse 
ego ustrojastva, esli zapreshen kontejner ustrojstv etogo tipa.
Pri udalenii objecta ustroistva iz vne, contejner avtomaticheski 
opoveshaetsa ustroistvom i udalet ego iz svoego spiska!
 
	void Add ( LogDevice* );
		- dobovlaet i svazivaet ustroistvo s kontejnerom tipa

	void Del ( LogDevice* );
		- udalaet ustroistvoiz kontejnera	

	void Clear ();
		- ochishaet kontejner 

****************************   class LogPolicy   ********************************	
   
		LogPolicy - class nastroek (politik) dla vivoda vseh soobshenij.
Sodertjit vhodnyu i vihodnyu kodirovki soobshenij, 
uroven razreshennih (vivodimih) soobshenij (soobshenija tipa s urovnem bolshem zadannogo
budut zapresheni), tekstovoe ima politiki. Politika opredelaet kontejneri ustrojstv dla 
zaregistrirovannih v dannoi politike tipov soobshenij.
Kajdaja log-sessija imeet konkretnuju politiku, 
i ispolzuet ee dla dostupa k kontejneram tipov opredelennih v politike. 
Politika soderjit metod PrePrint neobhodimij dla predvaritelnoj (perd vivodom)
obrabotki soobshenija. Proizvodnie ot LogSession classi mogut pereopredilat etot metod,
dla zadanija specifichnoj predobrabotki.

	void AddLogDevice ( LogDevice* dev );
		- dobavlaet ustroistvo v kontejneri vseh zaregistrirovannih tipov

	void DelLogDevice ( LogDevice* dev );
		- udalaet ustroistvo iz kontejnerov vseh zaregistrirovannih tipov
		
	void SetLogLevel ( unsigned int level );
	void SetLogLevel ( logtype_t ltlevel = lt_debug );
		- ustanavlivaet uroven dopustimih soobshenij i update'it vse zaregistrirovannie
	
	*** virtualnie metodi
	int PrePrint ( logtype_t type, char *& str );
		- funkcija predvoritelnoi obrabotki soobshenij

****************************   class LogSession   ********************************	

		LogSession - klass opredelaushij log sessiu s konkretnoi politicoi. 
Vse klientskie soobshenija vivodatsa imenno cherez nego (ili ego proizvodbnih).
Neposredstvennoe sozdanie objectov dannogo classa mojet proishodit tolko cherez ego 
proizvodnij class Logger.
Upravlaet sobstvennoi politikoi, mojet ee izmenat i zameshat ee class. 
Predostavlaet dostup k conteineram ustroistv.
Opredelaet tip soobshenij po umolchaniu? ispolzuemij dla soobshenij bez 
javnogo zadanija ih tipa.

	void printf ( const char *fmt, ... );
		- formiruet soobshenie s tipom po umolchaniu

	void printf ( logtype_t type, const char *fmt, ... );
		- formiruet soobshenie s zadannim tipom

	LogPolicy* GetPolicy ();
		- vozvrashaet politicu

	LogPolicy* SetPolicy ( const LogPolicy& );
		- ustanavlivaet politicu, polnostiu perepisivaja sushestvyushyu.
		  Peredannaja politika copiruetsa v LogSession
	
	TypeDevices& operator () (logtype_t type);
	TypeDevices& Devices (logtype_t type);
		- vozvrashaet conteiner ispolzuemij dla zadannogo tipa
		  ili sozdaet pustoi dla novogo tipa i registriruet ego
	
	TypeDevices& operator () ();
	TypeDevices& Devices ();
		- vozvrashaet conteiner ispolzuemij po umolchaniu
	
	 void DefaultLogType ( logtype_t def );
		- ustanavlivaet tip soobshenij po umolchaniu

	*** proizvodnie klassi
	class Logger
		- copiruet vse metodi LogSession i dobovlaet vozmojnost raboti 
		  s neskolkimi sessijami

****************************   class Logger   ********************************	

		Logger - class obladaushej vsemi svoistvamo LogSession. plus vozmojnostu upravlenija 
razlichnimi log-sessijami. S ego pomoshu mojno sozdavat razlichnie imenovannie sessii
s razlichnimi politikami, dla ispolzovanija v razlichnih chastah prilojenija.


	Logger ( LogDevice* dev, code_t in, code_t out, logtype_t def );
		- opredelaet osnovnyu (sobstvennyu) sessiu s vhodnoi i vihodnoi codirovkami
		  edinstvennim log-ustroistvom dla ne zaregestrirovannih tipov, i tipom po umolchaniu
	
	Logger ( const LogPolicy& policy, logtype_t def );
		- opredelaet osnovnyu sessiu s zadannoi politikoi
		  politica copiruetsa
	
	Logger ( LogPolicy* policy, logtype_t def );
		- opredelaet osnovnyu sessiu s zadannoi politikoi
		  politica ne copiruetsa, udalaetsa avtomaticheski
		  Ispolzovat s ostarojnostu!

	LogSession* const GetSession ( const char* name );
		- vozvrashaet sozdannuy log-sessiu po imeni ili sozdaet novyu
	
	LogSession* const AddSession ( const char* name );
		- sozdaet novyu log-sessiu s zadannim imenem ili vozvrashaet sushestvyushyu
		  Politica sessii copiruetsa iz osnovnoi
		  esli ima ne zadanno to unikalnoe ima budet sgenerirovanno avtomaticheski
	
	LogSession* const AddSession ( const LogPolicy& policy, const char* name );
		- sozdaet novyu log-sessiu s zadannoi politicoi

	LogSession* const CopySession ( const char* destname, const char* srcname );
		- copiruet sesiu s odnim imenem v sessiu s drugim

	void DelSession ( const char* name );	
		- udalaet sessiu

******************************* utiliti ***********************************

  	void sinsertf ( char * str, const char* fmt, ... );
		- dobovlaet v nachalo stroki peredannyu formatirovannyu podstroku
		  peredannij bufer doljen bit dostatochnogo razmera

******************************* EXAMPLE ***********************************


// Main module
#include "Logger.h"  

	// sozdali ustroistvo vivoda na ekran
LogScreen screen;
	// sozdali osnovnyu log-sessiu s ekranom v kachestve ustroistva 
	// dla vivoda ne zarefestrirovannih soobshenij, vhodnoj i vihodnoi codirovkoi
	// sootvetstvyushej tekushej systeme, i tipom soobshenij po umolchaniu
Logger theLogger ( &screen, mpcxc_cd_cursys(), mpcxc_cd_cursys(), lt_debug );

void main ( char** argv, int argc )
{
	theLogger.printf ( "Programm %s, runs with argc = %ld\n", argv[1], argc );

	LogFile logInfo ( "c:\\info.log" );
	
	// vivodim vse soobshenija s tipom lt_info v info.log
	// (sozdaem novij kontejner dla tipa lt_info i dobovlaem v nego logInfo
	theLogger.Devices(lt_info)->Add( &logInfo );

	theLogger.printf ( lt_info, "Programm %s, runs with argc = %ld\n", argv[1], argc );

	...

// SOME OTHER MODULE

// sozdaem copiu osnovnoj sessii
LogSession* pMySession = theLogger.AddSession ( "My session" );

// sozdaem ustroistvo vivoda v fail s DOS kodirovkoi
LogFile logDebug ( "c:\\debug.log" );
logDebug.SelfCode ( cd_dos );

// sozdaem novij tip soobshenij
static logtype_t lt_mytype ( 10, "MY TYPE" );

...

// opredelaem class log-ustroijstva dla vivoda v debug-window pod MSVC
class MfcTracer : public LogScreen
{
	virtual void Print ( const char* str ) const {
		TRACE ( str );
	}
};

// opredelaem class log-politici dla specializacii pred obrabotki soobshenij
class MyPolicy : public LogPolicy
{
	LogPolicy* duplicate () const {
		return new MyPolicy (*this);
	};
public:
	MyPolicy () : LogPolicy () {};
	MyPolicy ( LogDevice* dev ) : LogPolicy ( dev ) {};
	MyPolicy ( const LogPolicy& copy ) : LogPolicy ( copy ) {};
	
	virtual int PrePrint ( logtype_t type, char *& str ) const {
		int processed = LogPolicy::PrePrint ( type, str );
		sinsertf ( str, "Session: %s, yype: %s, message :", GetName (), type.Name() );
		return processed;
	}
};

...

void some_function ()
{
	// pereopredilili class log-politici, vse nastroiki copiryutsa iz sushestvyushej
	pMySession->OverlapPolicy ( new MyPolicy () );
	// ustanovili tip soobshenij po umolchaniu
	pMySession->DefaultLogType( lt_mytype );

	// dinamicheski sozdali ustroistvo
	MfcTracer * mfcTracer = new MfcTracer ();

	pMySession->Devices ( lt_debug ).Add ( mfcTracer );
	pMySession->Devices ( lt_mytype ).Add ( mfcTracer );
	pMySession->Devices ( lt_mytype ).Add ( &logDebug );

	pMySession->printf ( "Debuging under MSVC (copy in file)\n" );
	pMySession->printf ( lt_debug, "Debuging under MSVC only\n" );
	pMySession->printf ( lt_info, "Only info.log\n" );

	// udalaem ustroistvo, vse svazannie contejneri budut osvobojdeni avtomaticheski 
	delete mfcTracer;

	pMySession->printf ( "Only debug.log file\n" );
	pMySession->printf ( lt_debug, "void device\n" );

	pMySession->Devices ( lt_info ).Add ( &logDebug );
	pMySession->printf ( lt_info, "Both log files\n" );

	MfcTracer tracer;
	pMySession->GetPolicy()->Devices ( lt_info ) = TypeDevices ( &tracer );
	pMySession->printf ( lt_info, "Debuging under MSVC only (after devices overwriting)\n" );
	
	theLogger.printf ( lt_info, "Only info.log (from MAIN logger)\n" );
}

*********************************************************************/

//////////////////////////////////////////////////////////////////////
//
// Logger.h: interface for the Logger class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_LOGGER_H__CAD838E3_7805_11D3_9CBA_00AA00AD3486__INCLUDED_)
#define AFX_LOGGER_H__CAD838E3_7805_11D3_9CBA_00AA00AD3486__INCLUDED_

#include <errno.h>
#include <string.h>
#include <stdio.h>
#include "SharedData.h"
#include "SplayMap.h"
#include "SplaySet.h"
#include "recode.h"

#define LOG_MAXSIZE 4096

void sinsertf ( char * str, const char* fmt, ... );

class LogType 
{
protected:
	static int s_nextFreeId;
	int m_typeId;
	unsigned int m_level;
	char* m_pName;
public:
	LogType () { m_pName= 0; };
	LogType ( unsigned int level, const char* name = 0 );
	 LogType ( const LogType& );
	 ~LogType ();
	 LogType& operator = ( const LogType& );
	 const char* Name () const;
	 unsigned int Level () const;
	 int operator == ( const LogType& ) const;
	 int operator != ( const LogType& ) const;
	 int operator < ( const LogType& ) const;
	 int operator > ( const LogType& ) const;
	 int operator >= ( const LogType& ) const;
	 int operator <= ( const LogType& ) const;
};
#define logtype_t const LogType

#define LTL_FATAL 0 
#define LTL_STOP 100 
#define LTL_ERROR 200 
#define LTL_WARNING 300
#define LTL_INFO 400 
#define LTL_DEBUG 500
#define LTL_ALWAYS 0 

extern logtype_t lt_fatal;
extern logtype_t lt_stop;
extern logtype_t lt_error;
extern logtype_t lt_warning;
extern logtype_t lt_info;
extern logtype_t lt_debug;
extern logtype_t lt_always;

class TypeDevices;
class LogDevice
{
protected:
	int     m_bSelfOutCode;
	code_t  m_ctOut;
	int     m_bEnable;

public :
	LogDevice ();
	virtual ~LogDevice ();		

	// vozvrashaet sobstvennyu kodirovku
	 code_t SelfCode () const;
	// ustanavlivaet kodirovku
	 void SelfCode ( code_t );
	// opredelaet ustanovlenna li kodirovka
	 int HasSelfCode () const;
	 int Enable () const;
	 void Enable ( int enable );
     virtual void flush();	

protected:
	// metod vipolnaushij neposredstvennij vivod soobshenija
	virtual void Print ( const char* str ) const = 0;
	void Logging ( code_t out, const char* str );

private :
	SplaySet<TypeDevices*> m_setOwners;
	int     m_bDestruction;	

	friend class TypeDevices; // GARANT_FRIEND

	 void ReleaseOwner ( TypeDevices* );
	 void AddOwner ( TypeDevices* );
};

class LogFile : public LogDevice
{
protected:
	FILE* m_pFile;
	int   m_bCreated;

public:
	LogFile ( FILE* file );
	LogFile ( const char* name );
	virtual ~LogFile ();
	virtual void flush();

protected:
	virtual void Print ( const char* str ) const;
	void FileOpen ( const char* name );
};

class LogScreen : public LogDevice
{
protected:
	virtual void Print ( const char* str ) const;
};

class TypeDevices 
{
	int m_bEnable;		
	SplaySet<LogDevice*> m_setDevices;

public:
	TypeDevices ( LogDevice* dev = 0 );
	TypeDevices ( const TypeDevices& );
	virtual ~TypeDevices ();
	 TypeDevices& operator = ( const TypeDevices& copy );

	// dobovlaet i svazivaet ustroistvo s kontejnerom tipa
	 void Add ( LogDevice* ); 
	// dobovlaet i osvobojdaet ustroistvo
	 void Del ( LogDevice* );
	// ochishaet kontejner 
	 void Clear ();
	// vozvrashaet sostojanie razreshen/zapreshen
	 int Enable () const;
	// ustanavlivaet sostojanie razreshen/zapreshen
	 void Enable ( int value );
	// iniciiruet pechat na vseh log-ustrojstvah.
	// peredaetsa soobshenie i ego ishodnaja kodirovka
	void Print ( code_t out, const char* str );
	void flush();
};

class LogSession;
class LogPolicy {
protected:
	code_t m_ctIn;
	code_t m_ctOut;
	unsigned int m_logLevel;
	char * m_pName;
	SplayMap<logtype_t,TypeDevices> m_mapTypeDevices;

public:
	// zadaet vhodnyu i vihodnyu kodirovki (po umolchaniu kodirovka sootvetstvyushaja 
	// tekushei sisteme), zadaet conteiner ustroistv po umolchaniu (vozvrashaemij dla ne 
	// zaregestrirovannogo tipa) s edinstvennim ustroistvom.
	LogPolicy ( LogDevice* dev = 0, code_t in = cd_win, code_t out = mpcxc_cd_cursys() );
	// zadaet vhodnyu i vihodnyu kodirovki, zadaet conteiner ustroistv po umolchaniu
	LogPolicy ( const TypeDevices& def, code_t in = cd_win, code_t out = mpcxc_cd_cursys() );
	LogPolicy ( const LogPolicy& );	
	LogPolicy& operator = (const LogPolicy& );
	virtual ~LogPolicy ();

	// ustanavlivaet vhodnyu codirovku
	 void InCode ( code_t );
	// vozvrashaet vhodnyu codirovku
	 code_t InCode () const;
	// ustanavlivaet vihodnyu codirovku
	 void OutCode ( code_t );
	// vozvrashaet vihodnyu codirovku
	 code_t OutCode () const;
	// vozvrashaet default'nij conteiner ustroistv (dla ne zaregestrirovannogo tipa) 
	 TypeDevices& Devices ();
	// vozvrashaet conteiner ustroistv dla dannogo tipa, ili sozdaet pustoj
	 TypeDevices& Devices ( logtype_t& );
	// vozvrashaet sushestvyushij ili defoltnij
	 TypeDevices& GetDevices ( logtype_t& type );
	// void Devices ( logtype_t type, const LogDevice* device);
	// udalaet sushestvyushij contejner
	 void DelDevices ( logtype_t& type );
	// ochishaet vse contejneri
	 int Enable ( logtype_t& type );
	 void Clear ();
	//dobavlaet ustroistvo v kontejneri vseh zaregistrirovannih tipov
	 void AddLogDevice ( LogDevice* dev );
	//udalaet ustroistvo v kontejneri vseh zaregistrirovannih tipov
	 void DelLogDevice ( LogDevice* dev );
	//ustanavlivaet uroven dopustimih soobshenij i update'it vse zaregistrirovannie
	 void SetLogLevel ( unsigned int level );
	 void SetLogLevel ( logtype_t& ltlevel );
	 const char* GetName () const;

protected :
	friend class LogSession; // GARANT_GCC
	// funkcija predvoritelnoi obrabotki soobshenij
	virtual int PrePrint ( logtype_t& type, char *& str )
	{
		return 1;
	}
	 void SetName ( const char* name );
private:
	// funkcija sozdanija obekta klassa LogPolicy ili ego proizvodnih
	// neobhodimo pereopredelat dla vseh proizvodnih classov
	virtual LogPolicy* duplicate () const;
};

/************************ Logging classes *********************/

class Logger;
class LogSession
{
protected:
	LogPolicy* m_pPolicy;
	LogType m_ltDefault;

public:
	LogSession( const LogSession& copy );
	virtual ~LogSession();

	// formiruet soobshenie s tipom po umolchaniu
	void printf ( const char *fmt, ... );
	// formiruet soobshenie s zadannim tipom
	void printf ( logtype_t& type, const char *fmt, ... );
	// formiruet soobshenie s zadannim tipom v zadannoj codirovke
	void printf ( logtype_t& type, code_t code, const char *fmt, ... );
	// vozvrashaet politicu
	 LogPolicy* GetPolicy ();
	// ustanavlivaet politicu, polnostiu perepisivaja sushestvyushyu
	// peredannaja politika copiruetsa v LogSession
	 LogPolicy* SetPolicy ( const LogPolicy& );
	// analogichno, no politika ne copiruetsa!
	// peredannaja politika udalaetsa avtomaticheski pri ustanovke novoi ili
	// pri udalenii LogPolicy.
	// Dannij metod nujno ispolzovat s ostarojnostu!
	 LogPolicy* SetPolicy ( LogPolicy* );
	// Ispolzuetsa dla izmenenija classa sushestvyushej politiki
	 LogPolicy* OverlapPolicy ( const LogPolicy& );
	// analogichno OverlapPolicy ( const LogPolicy& ) s ogranichenijami
	// SetPolicy ( LogPolicy* )
	 LogPolicy* OverlapPolicy ( LogPolicy* );
	// vozvrashaet conteiner ispolzuemij dla zadannogo tipa
	// ili sozdaet pustoj
	 TypeDevices& operator () (logtype_t& type);
	 TypeDevices& Devices (logtype_t& type);
	// vozvrashaet conteiner ispolzuemij po umolchaniu
	 TypeDevices& operator () ();
	 TypeDevices& Devices ();
	// vozvrashaet tip soobshenij po umolchaniu
	 logtype_t DefaultLogType () const;
	// ustanavlivaet tip soobshenij po umolchaniu
	 void DefaultLogType ( logtype_t& def );

     void flush ( logtype_t& type );

protected:
	friend class Logger; // GARANT_GCC

	LogSession ();
	LogSession( const LogPolicy& policy, const char* name, logtype_t def );
	LogSession( LogPolicy* policy, const char* name, logtype_t def );
	virtual void Init( const LogPolicy& policy, const char* name, logtype_t def );
	virtual void Init( LogPolicy* policy, const char* name, logtype_t def );	
	LogSession& operator = (const LogSession& copy);

	void Logging ( logtype_t& type, code_t in, char* str );
};

class Logger : public LogSession
{
	SplayMap<SString, LogSession*> m_mapSessions;

public:
	// pustoj constructor, dla objavlenija globalnih peremennih! Trebuet vizova odnogo iz Init
	Logger ();
	// opredelaet osnovnyu /(sobstvennyu) sessiu s vhodnoi i vihodnoi codirovkami
	// edinstvennim log-ustroistvom dla ne zaregestrirovannih tipov, i tipom po umolchaniu
	Logger ( LogDevice* dev, code_t in = cd_win, code_t out = mpcxc_cd_cursys(), logtype_t def = lt_debug );
	virtual void Init ( LogDevice* dev, code_t in = cd_win, code_t out = mpcxc_cd_cursys(), logtype_t def = lt_debug );
	// opredelaet osnovnyu sessiu s zadannoi politikoi
	// politica copiruetsa
	Logger ( const LogPolicy& policy, logtype_t def = lt_debug );
	virtual void Init ( const LogPolicy& policy, logtype_t def = lt_debug );
	// opredelaet osnovnyu sessiu s zadannoi politikoi
	// politica ne copiruetsa, udalaetsa avtomaticheski
	// Ispolzovat s ostarojnostu!
	Logger ( LogPolicy* policy, logtype_t def = lt_debug );
	virtual void Init ( LogPolicy* policy, logtype_t def = lt_debug );
	~Logger ();

	// vozvrashaet sozdannuy log-sessiu po imeni ili sozdaet novyu
	 LogSession* const GetSession ( const char* name );
	// sozdaet novyu log-sessiu s zadannim imenem ili vozvrashaet sushestvyushyu
	// Politica sessii copiruetsa iz osnovnoi
	// esli ima ne zadanno to unikalnoe ima budet sgenerirovanno avtomaticheski
	 LogSession* const AddSession ( const char* name = 0 );
	// sozdaet novyu log-sessiu s zadannoi politicoi	
	 LogSession* const AddSession ( const LogPolicy& policy, const char* name = 0 );
	// copiruet sesiu s odnim imenem v sessiu s drugim
	 LogSession* const CopySession ( const char* destname, const char* srcname );
	// udalaet sessiu
	 void DelSession ( const char* name );	
};

//////////////////////////////////////////////////////////////
//
// inline method implimentation - blk.Logger
//
//////////////////////////////////////////////////////////////

#endif // !defined(AFX_LOGGER_H__CAD838E3_7805_11D3_9CBA_00AA00AD3486__INCLUDED_)
