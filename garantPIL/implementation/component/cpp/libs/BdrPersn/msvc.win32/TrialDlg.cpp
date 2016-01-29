// TrialDlg.cpp : implementation file
//

#include "stdafx.h"
#include "recode.h"
#include "TestBreeder32.h"
#include "TrialDlg.h"

#include "TestBreeder32Dlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// TrialDlg dialog

TrialDlg::TrialDlg(CWnd* pParent /*=NULL*/)
	: CDialog(TrialDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(TrialDlg)
	m_iTrialType = 0;
	m_retVal = _T("14");
	//}}AFX_DATA_INIT

	m_prevCustomVl= atoi(m_retVal);
}


void TrialDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(TrialDlg)
	DDX_Control(pDX, IDC_STATIC_AD1, m_Add1);
	DDX_Control(pDX, IDC_STATIC_AD0, m_Add0);
	DDX_Control(pDX, IDC_EDIT_ANSWER, m_EditCtrl);
	DDX_Control(pDX, ID_NEXT, m_BttnNext);
	DDX_Control(pDX, ID_HELP, m_BttnHlp);
	DDX_Radio(pDX, IDC_RADIO1, m_iTrialType);
	DDX_Text(pDX, IDC_EDIT_ANSWER, m_retVal);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(TrialDlg, CDialog)
	//{{AFX_MSG_MAP(TrialDlg)
	ON_BN_CLICKED(ID_NEXT, OnNext)
	ON_EN_CHANGE(IDC_EDIT_ANSWER, OnChangeEditAnswer)
	ON_BN_CLICKED(IDC_RADIO1, OnChangeEditAnswer)
	ON_BN_CLICKED(IDC_RADIO6, OnChangeEditAnswer)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// TrialDlg message handlers

BOOL TrialDlg::OnCmdMsg(UINT nID, int nCode, void* pExtra, AFX_CMDHANDLERINFO* pHandlerInfo) 
{
	if(nID == ID_HELP){
		::WinHelp(m_hWnd, ((CTestBreeder32Dlg*)GetParent())->m_CurrHlpName, HELP_CONTEXT, 90);
		return FALSE;
	}else if(nID == IDCANCEL){
		CString titl, emsg;

		titl.LoadString(IDS_EXIT_TITLE);
		emsg.LoadString(IDS_EXIT_MSG);

		if(MessageBox(emsg, titl, MB_ICONQUESTION | MB_YESNO | MB_DEFBUTTON2) != IDYES){
			return FALSE;
		}else{
			((CDialog*)GetParent())->EndDialog(-1);
			EndDialog(-1);
		}
	}
	return CDialog::OnCmdMsg(nID, nCode, pExtra, pHandlerInfo);
}

void TrialDlg::OnNext() 
{
	EndDialog(IDOK);
}

void TrialDlg::OnChangeEditAnswer() 
{
	UpdateData();

	if(m_iTrialType == 1){
		m_EditCtrl.ShowWindow(SW_SHOWNORMAL);
		m_Add1.ShowWindow(SW_SHOWNORMAL);
		m_Add0.ShowWindow(SW_SHOWNORMAL);
		int m_CustomVl= atoi(m_retVal);
		if(m_CustomVl < 1 || m_CustomVl > 30)
			m_BttnNext.EnableWindow(FALSE);
		else
			m_BttnNext.EnableWindow();
		return;
	}else{
		m_retVal= "7";
		m_EditCtrl.ShowWindow(SW_HIDE);
		m_Add1.ShowWindow(SW_HIDE);
		m_Add0.ShowWindow(SW_HIDE);
	}
	m_BttnNext.EnableWindow();
}

BOOL TrialDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_EditCtrl.ShowWindow(SW_HIDE);
	m_Add1.ShowWindow(SW_HIDE);
	m_Add0.ShowWindow(SW_HIDE);

	SetDefID(ID_NEXT);
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
