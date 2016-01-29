// Update.h : main header file for the UPDATE application
//

#if !defined(AFX_UPDATE_H__A05AC0EA_8CA9_4790_A512_6FB31A995996__INCLUDED_)
#define AFX_UPDATE_H__A05AC0EA_8CA9_4790_A512_6FB31A995996__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#if defined (_GCD_CLIENT) || defined (PILOT)
#include "garantServer/src/Business/GblPilot/Home/Client.h"
#include "garantServer/src/Services/GslSecurity/Home/Client.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Global/Core/Common/GCMSimpleComponents.h"
#if defined (_GCD_CLIENT)
#include "garantServer/src/Services/GslSessionHandlerClient/Home/Client.h"
#include "garantServer/src/Services/GslSessionHandlerClient/Home/Server.h"
#endif
#include "ace/Thread_Manager.h"
#include "ace/Synch.h"
#endif

#include "shared/GCL/os/DllLoader.h"
#include "resource.h"		// main symbols
#include "garutils.h"
#include "Collection.h"
#include "UpdateDHReader.h"

/////////////////////////////////////////////////////////////////////////////
// CUpdateApp:
// See Update.cpp for the implementation of this class
//

void    FatalError( UINT, CString aAdd = "", UINT aTitleID = IDS_ERROR, CWnd* mainwindow = 0 );
void	FatalMessage( UINT, CString aAdd = "", UINT aTitleID = IDS_ERROR );
void	FatalError( CString aMessage );
void	FatalMessage( CString aMessage );
void	OkBox( UINT aMessage, UINT aTitle = IDS_ATTENTION, UINT aIcon = IDI_BEINFO );
void	OkBox( CString aMessage, UINT aTitle = IDS_ATTENTION, UINT aIcon =  IDI_BEINFO );
BOOL	YesNoBox( UINT, UINT aTitleID = IDS_CONFIRM, UINT aIconID = IDI_BEWARNING, CString aAdd = "", CWnd* mainwindow = 0 );
BOOL	YesNoBox( UINT, CWnd* mainWindow );
void	NormalExit();
void	BadExit();

enum	DeltaStates  { DELTA_NONE, DELTA_ABSENT_SOME, DELTA_ABSENT_PREVIOUS, DELTA_SELECTED, DELTA_NOTSELECTED, DELTA_PREV_BAD };
enum	UpdateStatus { UPDATE_NONE, UPDATE_PART, UPDATE_FULL };
CString	UpdateStatus2Str( UpdateStatus aStatus );

void	LockBases( BOOL aLockShell = FALSE );
void	UnlockBases();

void	RunDownload( revision aFrom );

class	TDelta
{
public:
	TShortCollection*	Segments;
	revision			From, To;
	TStringCollection*	FileNames;
	DeltaStates			State;
	short				Version;

	TDelta( revision aFrom, revision aTo );
	~TDelta();

	BOOL	AddDelta( char* aFileName, UpdateDHReader *dhReader );
	short	CheckDelta( UpdateDHReader *dhReader );
};

class	TDeltaCollection: public TSortedCollection
{
public:
	TDeltaCollection( short aLimit, short aDelta ) : TSortedCollection( aLimit, aDelta ) {}

	TDelta* at( short item ) { return (TDelta*) TSortedCollection::at( item ); }

	virtual	void freeItem( void *item ) { delete (TDelta*) item; }

	virtual int compare( void *key1, void *key2 )
	{
		TDelta	*pDelta1 = (TDelta*)key1;
		TDelta	*pDelta2 = (TDelta*)key2;
		int	aResult  = CompRevs( &pDelta1 -> From, &pDelta2 -> From );
		if ( !aResult )aResult = CompRevs( &pDelta2 -> To, &pDelta1 -> To );
		return	aResult;
	}
};

class	TDeltaManager
{
public:
	revision			From, Today;
	revision			MinRevision;
	TDeltaCollection*	Deltas;
	short				Merged;
	TShortCollection*	Segments;
	TStringCollection*	SegmentNames;
	TStringCollection*	SegmentFiles;
	TStringCollection*	BadDeltas;
	TStringCollection*	BadDescs;
	TStringCollection*	Absents;
	CTime				StartTime, EndTime;

	TDeltaManager( revision aFrom, revision aToday, short aMerged );
	~TDeltaManager();
	
	void	AddSegment( short aSegment, char* aName, char* aFileName );
	void	AddDelta( char* aFileName, UpdateDHReader* dhReader );
	void	FreeDeltas();
	void	Check();

	void	SelectAll();
	void	UnselectAll();
	void	CalcMinRevision();

	void	Select( short aIndex );
	void	Unselect( short aIndex );
	UpdateStatus	Status();
	/*
	DeltaStates	State( short aIndex );
	*/

	char*	SegmentName( short aId );
	char*	SegmentFile( short aId );
	BOOL	ApplyDeltas();

	int	remoteType;
	int	serverType;
};

class CUpdateApp : public CWinApp
{
public:
	CUpdateApp();

	void CheckArgs();
	void ApplyPatches();
	void set_local_resource (const char* dll_name);

	void	read_from_ini (LPCTSTR key_name, LPSTR _str, DWORD sz);
	void	read_inet_settings ();
	void	send_internet_result ();
	void	internet_complete ();

#ifdef	_GCD_CLIENT
	void Help( const char* );
#endif

	std::string m_ini_name;
	std::string	pers_key, from_str, to_str;
	long	update_seconds;
	bool	b_result_send;
	bool	b_english_face;
	char*	cmdLine;

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CUpdateApp)
	public:
	virtual BOOL InitInstance();
	virtual int ExitInstance ();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CUpdateApp)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

private:
	Core::Aptr <GCL::DllLoader> m_res_loader;
};

#if defined (_GCD_CLIENT) || defined (PILOT)
class UpdateRunner : public GCM::GCMSimpleServer {
	public:
		static GslUserManager::UserManager_var um;
		static GblPilot::BaseUpdate_var bu;
		static GblPilot::FunctionMng_var m_func_manager;
		static bool logged;
		UpdateRunner();

		void process_args (const GCD::Args& args);
		void execute();
		void finalize () {
			um = GslUserManager::UserManager::_nil ();
			bu = GblPilot::BaseUpdate::_nil ();
			m_func_manager = GblPilot::FunctionMng::_nil ();
			GCM::GCMSimpleServer::finalize ();
		}
	private:
		void cancel_update (::GblPilot::UpdateCancelCode code) { 
			try { 
				bu->update_cancel (code); 
			} catch(...) {
			}
		}
	public:
		char* m_login;
		char* m_pwd;
		bool m_auto;
		bool m_nofinalmessage;
};
#endif

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_UPDATE_H__A05AC0EA_8CA9_4790_A512_6FB31A995996__INCLUDED_)
