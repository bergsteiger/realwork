// TestBreeder32Dlg.h : header file
//

#if !defined(AFX_TESTBREEDER32DLG_H__CC89CC53_3F65_41AF_9E27_74CBD98739D0__INCLUDED_)
#define AFX_TESTBREEDER32DLG_H__CC89CC53_3F65_41AF_9E27_74CBD98739D0__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Stdbase.h"
#include "gsscreen.h"
#include "selcttreectrl.h"
#include "OtherEditCtrl.h"
#ifdef RD_AS_ETALON
	#include "TrialDlg.h"
#else
	#include "LongInt.h"
#endif
#include "PL_Proto.h"

#include "shared/Internet/impl/Inet_i/Connect_i_factory.h"
#include "shared/Internet/impl/Inet_i/Connection_i_factory.h"
#include "shared/Internet/Manage/ConnectManager.h"
#include "shared/Internet/Inet/Inet.h"

/////////////////////////////////////////////////////////////////////////////
// CTestBreeder32Dlg dialog

class GWinScreen;
class CLoginDlg;

class PDDBase : public Base
{
public:
	PDDBase(	LPPF_PARAM pKey, LPPF_PARAM pStr, LPPF_PARAM pNdt);
	PDDBase(const char *n,int m,int kc= -1, int sc= -1, int nc= -1, FILE *stf= 0);
	virtual ~PDDBase();
	int IsHDD();
	void SetScreenContext(GSScreen* pNew);
	int Backup();
	void RemovePagedFiles();
	void CopyPagedFilesByIndex (
			const char* name
			, const char* pNewBaseName
			, PagedFile** ppKey
			, PagedFile** ppStr
			, long max_paged_file_per_bytes
			, int iAsUnpacked
		);
	void openIndicesForUpdate(){
		Base::createIndices();
	}
public:
	int m_max_profiles, m_max_num;
	char *m_pUIDBFileName;
protected:
	char *textFile2,*textFile1,*textFile0;
};

typedef struct BRDR32_HDD_TAG
{
	PDDBase* pHDD;
	BaseWeight *bws;
	int			currentWeight[256+256]; // for number and weight //
	unsigned int bwcount;
#ifndef RD_AS_ETALON
	LPPL_IMPORT_COMPLECT_DATA pList;
	struct revision LastUpdate;		/* date of last update */
#endif
} BRDR32_HDD, *LPBRDR32_HDD;

#include "Scrollinfo.h"

#define LOOK_HDD_NOT_HASP -333

const int selectDefPath= -2;

class CTestBreeder32Dlg : public CDialog
{
public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
// Construction
public:
#ifdef	_GCD_CLIENT
	void	Help( const char* );
#endif

	std::string m_ini_name;
	void read_from_ini (LPCTSTR key_name, LPSTR _str, DWORD sz);
   	void write_to_ini (LPCTSTR key_name, LPCTSTR _str);
	void read_inet_settings ();
	void write_inet_settings ();

	long aCodeNew[4096+1];
	int m_AnswerCount;
	CTestBreeder32Dlg(CWnd* pParent = NULL);	// standard constructor
	LPBRDR32_HDD ppHDDs;
	GWinScreen* pGSScreen;
	char *pSelctMesgs[5], *pRegOrg, *pRegNum, *pInstalledNet;
	PDDBase *pHDD;
	CStringArray InPharmFiles;

	DWORD m_CurrHlpTopicID;
#if defined (_GCD_CLIENT) || defined (PILOT)
	UpdateRunner* pUR;
#endif

	CString testFile, m_currSourcePath, m_CurrHlpName
#if defined (_GCD_CLIENT) || defined (PILOT)
		,*pPilotBaseRoot, *pPilotBaseName, *pPilotBaseDir, *pPilotDistribPath,  *secondPilotDistribPath
#endif
		,m_OtherSelPath,txt,qqq,rrr,FileName,m_sRet, NameCIB, NameCC;
	;
	char *pHaspName,
		 *szFrmt, *szFrmtN, *szFrmtU, *szUnk;

	BOOL bOnMake, bOnRestore;
	HTREEITEM m_hPrnt,
#ifdef RD_AS_ETALON
		hTreeItem_curr,
#endif
		m_SpacePrnt;

	WORD IsNextRnd();


	UINT m_uTimerID;
	int isLookFlpp(), IsFlppInsert(), IsKeyFlpp(int process= 0),
		timeOn10sec, m_TrialQ, getOldPathBase, m_baseIndx, m_SelectNext, iHASPFind
#ifdef INC_OLD_FAST_CPY
		, not_Cache
#endif
		;
	void	Bind(CString *),
			LockTargetedBase(),
			SetItemTextAsUnknwn(HTREEITEM, char* pName= NULL),
			OnPasswordForm();

	void BeepWarning()
	{
		Beep(1000, 200);
		Sleep(100);
		Beep(1000, 200);
	}

	void BeepOk()
	{
		Beep(1000, 500);
	}

	void ProcessFlppError(CString name);
	int initFirst, installed, retVal, m_keyDiskProcess, m_currBaseSz;
	char 
#ifdef SEL_OUT_PATH
	SelectedPath[MAX_PATH+MAX_PATH]
#else
	*SelectedPath
#endif
	, *pLogin;
	WORD m_hasp_ret, m_hasp_number;

#ifndef RD_AS_ETALON
	DWORD m_DefaultRD_Hash;
	LPPL_IMPORT_CIB_DATA pCurrCIBs;
	long
#else
	WORD
#endif
	aCode, realACode;
	std::string str_password;

	CLoginDlg *m_pLoginDlg;
	BOOL	m_restoreINI;

	void HideControl(CWnd *);
	void ShowControl(CWnd *);
	void restoreBase();

	int IsDistribHASP_Ok(PDWORD pdwMediaID);
	void TestedHaspOnHDD(	char *pBff, PDWORD pdwMediaID, PWORD pret,
							int indx, char *LoginReplicator1,
							LPPL_IMPORT_COMPLECT_DATA *ppList);

// Dialog Data
	//{{AFX_DATA(CTestBreeder32Dlg)
	enum { IDD = IDD_TESTBREEDER32};
	CStatic	m_MsgDealer;
	CScrollinfo	m_DealerInfo;
	CButton	m_BttnExit;
	CButton	m_BttnSettings;
#ifndef RD_AS_ETALON
	CTreeCtrl	m_EditCtrl;
#else
	COtherEditCtrl	m_EditCtrl;
#endif
	CString	m_AnswerStr;
	CButton m_CopyPassword;
	CButton	m_BttnNext;
	CButton	m_BttnBrws;
	CSelctTreeCtrl	m_CIBsTree;
	CStatic	m_ProcessMsg;
	CProgressCtrl	m_Progress;
	CStatic	m_Msg0;
	CStatic	m_Msg1;
	CStatic	m_Msg2;
	int     m_iColor;
	CButton	m_Radio3;
	CButton	m_Radio4;
	CStatic	m_Static_01;
	CStatic	m_Static_02;
	CStatic	m_Static_03;
	CStatic	m_Static_73;
	CStatic	m_Msg70;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTestBreeder32Dlg)
	public:
	virtual BOOL DestroyWindow();
	virtual BOOL OnCmdMsg(UINT nID, int nCode, void* pExtra, AFX_CMDHANDLERINFO* pHandlerInfo);
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

	BaseInfo *pRBI;
	long RBIcount;

	CImageList m_ImageList;
	bool check_version_All();

public:
	bool	internet_answer;
	bool	internet_was_checked;
	void setInstallThread(HANDLE hNew);
	int ShowQuestionBrowse();

	unsigned long install_status;
	void	send_internet_result ();

// Implementation
protected:
	int MakeTreeNodes(	LPPL_IMPORT_COMPLECT_DATA, HTREEITEM*, int*, BaseInfo *,
						WORD,
#ifdef RD_AS_ETALON
						BOOL*,
#endif
						BOOL*);

#ifndef RD_AS_ETALON
	char *pXXX;
	int OkCount, DistribHASP_Ok, isFree;
	BYTE bff[LOGIN_SIZE_PER_BYTES+1];
	long lVIP_flag, lOnFloppy;
#else
	LPPL_IMPORT_COMPLECT_DATA pList;
#endif
	CString m_DefaultRD_Login;
	HICON m_hIcon;
	int iFnd, nRetCode;
	char sTr[2048];
	int m_select, m_VerType, isTrial;

	WORD m_HardwareID;
	int	LoggingStatus;

	void deleteHDDs();

	HANDLE hTickThread, hTickThread0;

	HANDLE hInstllThread;

	DWORD	m_ThreadID;
	char tmp_valuies1[1024];
	void TerminateBreederThread();

	CToolTipCtrl m_tooltip;

	// Generated message map functions
	//{{AFX_MSG(CTestBreeder32Dlg)
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnChangeEditAnswer();
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnSelchangedTree1(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnNext();
	afx_msg LRESULT OnFileOpen(WPARAM wParam, LPARAM lParam);  // user message
	afx_msg LRESULT OnTryInstall(WPARAM wParam, LPARAM lParam);  // user message
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnBrowse();
	afx_msg void OnCopyPassword();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

class CInetAccessSettingsDlg : public CDialog {
// Construction
public:
	CInetAccessSettingsDlg (CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CInetAccessSettingsDlg)
	enum { IDD = IDD_INTERNET_ACCESS_SETTINGS };
	CButton m_rbOpenTypeDirect;
	CButton m_rbOpenTypeProxy;
	CButton m_rbOpenTypePreconfig;

	CButton m_cbProxyAuthentication;

	CEdit m_edtProxyAddress;
	CEdit m_edtProxyPort;
	CEdit m_edtProxyLogin;
	CEdit m_edtProxyPassword;
	//}}AFX_DATA

// Overrides
	//{{AFX_VIRTUAL(CInetAccessSettingsDlg)
	protected:
	virtual void DoDataExchange (CDataExchange* pDX); // DDX/DDV support
	virtual void OnOK ();
	virtual void OnCancel ();
	//}}AFX_VIRTUAL


// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CInetAccessSettingsDlg)
	virtual BOOL OnInitDialog ();
	afx_msg void OnRbTypeDirect ();
	afx_msg void OnRbTypeProxy ();
	afx_msg void OnRbTypePreconfig ();
	afx_msg void OnCbProxyAuthentication ();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP ()

private:
	void SetProxyGroupState (BOOL bState);
	void SetProxyAuthGroupState (BOOL bState);
	void SetProxyParamGroupState (BOOL bState);

private:
	DWORD m_open_type;
	DWORD m_open_query_flags;

	CString m_proxy_address;
	CString m_proxy_port;
	CString m_proxy_login;
	CString m_proxy_password;

	BOOL m_is_proxy_authentication;

public:
	void set_settings (Internet::InternetAccessInfo& info);
	void get_settings (Internet::InternetAccessInfo& info);
};

class GWinScreen : public GSScreen
{
// Construction
public:
	GWinScreen(CWnd* pParent= NULL);	// standard constructor
	CWnd* m_pParent;
protected:
	virtual void ShowMessage(const char *, int sub=0);
	int	percents;
	int	value;
	time_t start_time;
	bool IsNotFreeSpace(LONGLONG*);
public:
	virtual int ShowQuestionYesOrNo(const char *, int RetryAbort= 0);
	int Init(const char *title);
	virtual int SetProgress(int value);
};

// CBRCDialog dialog

class CBRCDialog : public CDialog
{
public:
	CString m_importText;
	CBRCDialog(CWnd* pParent = NULL);   // standard constructor
	virtual ~CBRCDialog();

// Dialog Data
	//{{AFX_DATA(CBRCDialog)
	enum { IDD = IDD_DIALOG_BRC };
	CStatic	m_Msg;
	CButton	m_BttnB;
	CButton	m_BttnR;
	CButton	m_BttnC;
	//}}AFX_DATA

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	// Generated message map functions
	//{{AFX_MSG(CBRCDialog)
	virtual BOOL OnInitDialog();
	afx_msg void OnCancel();
	afx_msg void OnRetry();
	afx_msg void OnBrowse();
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TESTBREEDER32DLG_H__CC89CC53_3F65_41AF_9E27_74CBD98739D0__INCLUDED_)
