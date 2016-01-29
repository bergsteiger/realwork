// TestBreeder32.h : main header file for the TESTBREEDER32 application
//

#if !defined(AFX_TESTBREEDER32_H__724E187D_6E50_4556_81A4_B8E22EB2E22D__INCLUDED_)
#define AFX_TESTBREEDER32_H__724E187D_6E50_4556_81A4_B8E22EB2E22D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#if defined (_GCD_CLIENT) || defined (PILOT)
#include "garantServer/src/Business/GblPilot/Home/Client.h"
#include "garantServer/src/Services/GslHeartbeatManager/Home/Client.h"
#include "garantServer/src/Services/GslSecurity/Home/Client.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#if defined (_GCD_CLIENT)
#include "garantServer/src/Global/Core/Common/GCMSimpleComponents.h"
#include "garantServer/src/Services/GslSessionHandlerClient/Home/Client.h"
#include "garantServer/src/Services/GslSessionHandlerClient/Home/Server.h"
#endif
#include <ace/Thread_Manager.h>
#include <ace/Synch.h>
#endif

#include "shared/GCL/os/DllLoader.h"
#include "resource.h"		// main symbols

#define WM_ON_OPEN      (WM_USER + 1968)
#define WM_ON_INSTALL   (WM_USER + 1969)

/////////////////////////////////////////////////////////////////////////////

enum ResourceLang { rl_Rus, rl_Eng };

/////////////////////////////////////////////////////////////////////////////
// CTestBreeder32App:
// See TestBreeder32.cpp for the implementation of this class
//

class CTestBreeder32App : public CWinApp {
public:
	CTestBreeder32App();

	bool AskFileName;

	void set_local_resource (const char* dll_name);

	inline ResourceLang get_rc_lang () const { return m_rc_lang; }

	HINSTANCE handle2GLink;
	WORD (__stdcall *imp_HaspGetMediaId)(PDWORD MediaID);
	WORD (__stdcall *imp_HaspAddTry)(WORD CIB_number);
	WORD (__stdcall *imp_HaspAddSuccess)(WORD CIB_number);
#ifndef RD_AS_ETALON
	WORD (__stdcall *imp_HaspComplectState)(WORD wNumber, PWORD pSuccessCount, PWORD pTryCount);
#endif

	CString	log_file_prefix;
	char	module_file_name [256];
	bool	global_success;

	void	Log (char*, bool only_in_crypt = false);
	void	TimeLog (char*);
	void	ErrorLog (char*);
	void	RenameLog (bool);

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTestBreeder32App)
	public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CTestBreeder32App)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

private:
	ResourceLang m_rc_lang;

	Core::Aptr <GCL::DllLoader> m_res_loader;
};

static CTestBreeder32App* get_app () {
	return (static_cast <CTestBreeder32App*>(AfxGetApp ()));
}

#if defined (_GCD_CLIENT) || defined (PILOT)
class UpdateRunner : public GCM::GCMSimpleServer {
		public:
			GblPilot::VersionType version_type;
			bool b_exit_requested;
			CString PilotBaseRoot, PilotBaseName, PilotBaseDir;
			CString PilotDistribPath;
			GslUserManager::UserManager_var um;
			GblPilot::BaseUpdate_var bu;
			GblPilot::FunctionMng_var function_mng;
			GblPilotDef::VersionInfo version_info;
			short updateType;
			UpdateRunner();
			void execute();
			void terminate_exit ();
			void logout_current ();
			bool m_logged;
			CString secondPilotDistribPath;
	};
#endif
/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TESTBREEDER32_H__724E187D_6E50_4556_81A4_B8E22EB2E22D__INCLUDED_)
