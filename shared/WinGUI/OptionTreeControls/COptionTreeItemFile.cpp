////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemFile.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemFile
//
// ������� ������ �����, ����� ��� ����������� � ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemFile.h"
// by <<uses>> dependencies
#include "shared/GCL/str/str_op.h"

//#UC START# *470B034A0232_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470B034A0232_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B034A0232*
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

COptionTreeItemFile::COptionTreeItemFile()
{
	// Initialize variables
	m_dwOptions = NULL;
	m_lDefaultHeight = 0;
	m_dwDlgFlags = NULL;
	m_strDefExt = _T("");
	m_strFilter = _T("");
	m_lDefaultHeight = 0;
	m_strDlgTitle = _T("Select Folder");
	m_strBufferText = "";
	// Set item type
	SetItemType(OT_ITEM_FILE);
}

void COptionTreeItemFile::DrawAttribute(CDC *pDC, const RECT &rcRect)
{
	// Declare variables
	COLORREF crOld;
	int nOldBack;
	CRect rcText, rcClient;
	HGDIOBJ hOld;
	COLORREF crOldBack;

	// Make sure options aren't NULL
	if (m_otOption == NULL)
	{
		return;
	}

	// Get window rect
	rcClient = rcRect;

	// Select font
	hOld = pDC->SelectObject(m_otOption->GetNormalFont());
	
	// Set text color
	if (IsReadOnly() == TRUE || m_otOption->IsWindowEnabled() == FALSE)
	{
		crOld = pDC->SetTextColor(GetSysColor(COLOR_GRAYTEXT));
	}
	else
	{
		crOld = pDC->SetTextColor(GetTextColor());
	}

	// Set background mode
	nOldBack = pDC->SetBkMode(TRANSPARENT);

	// Set background color
	crOldBack = pDC->SetBkColor(GetBackgroundColor());	

	// Draw text
	// Get text rectangle
	rcText.left  = rcRect.left + 1;
	rcText.right = rcRect.right;
	rcText.top = rcRect.top + 1;
	rcText.bottom = rcRect.bottom;

	update_buffer ();
	// Draw text
	pDC->DrawText(m_strBufferText, rcText, DT_VCENTER);
	pDC->DrawText(m_strBufferText, rcText, DT_VCENTER | DT_CALCRECT);
	
	// Restore GDI ojects
	pDC->SetTextColor(crOld);
	pDC->SetBkMode(nOldBack);
	pDC->SelectObject(hOld);
	pDC->SetBkColor(crOldBack);
}

void COptionTreeItemFile::OnCommit()
{
}

void COptionTreeItemFile::OnRefresh()
{
}

void COptionTreeItemFile::OnMove()
{
}

void COptionTreeItemFile::OnActivate()
{
	// Declare variables
	CFont *pFont;
	LOGFONT lf;
	BOOL bMultiline = FALSE;
	int m_nNumItems = 0;
	POSITION psPos;
	CString strFile;
// GARANT {
	bool commit = false;
// } GARANT

	// Get file
	if (m_strFileNames.GetSize() == 0)
	{
		strFile = _T("");
	}
	else
	{
		strFile = m_strFileNames.GetAt(0);
	}

	// Select folder
	if (GetOption(OT_FILE_SELECTDIALOG) == TRUE)
	{
		if (m_dlgFile.SelectFolder(m_strDlgTitle, strFile, m_dwDlgFlags, m_otOption) == IDOK)
		{
			bMultiline = TRUE;

			// -- Get file names
			m_strFileNames.RemoveAll();
			m_strFileNames.Add(m_dlgFile.GetSelectedFolder());

			// -- Number of items
			m_nNumItems = 1;
// GARANT {
			commit = true;
// } GARANT
		}
	}
	// Normal
	else
	{
		m_dlgFile.SetDialog(GetOption(OT_FILE_OPENDIALOG), m_strDefExt, strFile, m_dwDlgFlags, m_strFilter, m_otOption);
		if (m_dlgFile.DoModal() == IDOK)
		{
			bMultiline = TRUE;

			// -- Get file names
			m_strFileNames.RemoveAll();
			psPos = m_dlgFile.GetStartPosition();

			while (psPos != NULL)
			{
				m_strFileNames.Add(m_dlgFile.GetNextPathName(psPos));

				m_nNumItems++;
			}
// GARANT {
			commit = true;
// } GARANT
		}
    
	}

	// Change height
	if (bMultiline == TRUE)
	{
		// -- Get font
		pFont = m_otOption->GetNormalFont();
		pFont->GetLogFont(&lf);

		if ((abs(lf.lfHeight) + 3) * m_nNumItems > m_lDefaultHeight)
		{
			SetItemHeight((abs(lf.lfHeight) + 3) * m_nNumItems + ATTRIB_OFFSET);
			SetDrawMultiline(TRUE);
		}
		else
		{
			SetItemHeight(m_lDefaultHeight);
			SetDrawMultiline(FALSE);
		}
	}

	// Update items
	if (m_otOption != NULL)
	{
		m_otOption->UpdatedItems();
	}

// GARANT {
	if (commit) {
		CommitChanges();
	}
// } GARANT
}

void COptionTreeItemFile::CleanDestroyWindow()
{

}

void COptionTreeItemFile::OnDeSelect()
{
}

void COptionTreeItemFile::OnSelect()
{
}



BOOL COptionTreeItemFile::GetDialogFlag(DWORD dwOption)
{
	// Return option
	return (m_dwDlgFlags & dwOption) ? TRUE : FALSE;
}

void COptionTreeItemFile::SetDialogFlag(DWORD dwOption, BOOL bSet)
{
	// Set option
	if (bSet == TRUE)
	{
		m_dwDlgFlags |= dwOption;
	}
	else
	{
		m_dwDlgFlags &= ~dwOption;
	}	
}

BOOL COptionTreeItemFile::CreateFileItem(CString strFile, CString strDefExt, CString strFilter, DWORD dwOptions, DWORD dwDlgFlags)
{

	// Make sure options is not NULL
	if (m_otOption == NULL)
	{
		return FALSE;
	}

	// Save options
	m_dwOptions = dwOptions;

	// Save dialog flags
	m_dwDlgFlags = dwDlgFlags;

	// Save file
	m_strFileNames.Add(strFile);

	// Save default extention
	m_strDefExt = strDefExt;

	// Save filter
	m_strFilter = strFilter;

	// Get default height
	m_lDefaultHeight = GetHeight();

	return TRUE;
}

// GARANT {
void COptionTreeItemFile::SetFileName (const CString& file) {
	m_strFileNames.RemoveAll();
	AddFileName (file);
}
// } GARANT

void COptionTreeItemFile::AddFileName(CString strFile) {
	std::string str_file (strFile);
	GCL::str_replace (str_file, "/", "\\");
	m_strFileNames.Add (str_file.c_str ());
}

void COptionTreeItemFile::SetDialogFlags(DWORD dwFlags)
{
	m_dwDlgFlags = dwFlags;
}

DWORD COptionTreeItemFile::GetDialogFlags()
{
	return m_dwDlgFlags;
}

void COptionTreeItemFile::SertDefaultExtention(CString strExt)
{
	m_strDefExt = strExt;
}

CString COptionTreeItemFile::GetDefaultExtention()
{
	return m_strDefExt;
}

void COptionTreeItemFile::SetFilter(CString strFilter)
{
	m_strFilter = strFilter;
}

CString COptionTreeItemFile::GetFilter()
{
	return m_strFilter;
}

void COptionTreeItemFile::SetDialogTitle(CString strTitle)
{
	m_strDlgTitle = strTitle;
}

CString COptionTreeItemFile::GetDialogTitle()
{
	return m_strDlgTitle;
}

CString COptionTreeItemFile::GetFileExtention(CString strFile)
{
	// Declare variables
	TCHAR szExt[MAX_PATH];

	// Split path into components
	_tsplitpath(strFile, NULL, NULL, NULL, szExt);

	//memmove(szExt, szExt + 1,strlen(szExt) - 1);
	//szExt[strlen(szExt) - 1] = '\0';

	return szExt;
}

CString COptionTreeItemFile::GetFileName (CString strFile) {
	// Declare variables
	TCHAR szName[MAX_PATH];

	// Split path into components
	_tsplitpath(strFile, NULL, NULL, szName, NULL);

	//memmove(szName, szName + 1,strlen(szName) - 1);
	//szName[strlen(szName) - 1] = '\0';

	return szName;
}

CString COptionTreeItemFile::GetFileDirectory(CString strFile)
{
	// Declare variables
	TCHAR szDrive[MAX_PATH];
	TCHAR szDir[MAX_PATH];

	// Split path into components
	_tsplitpath(strFile, szDrive, szDir, NULL, NULL);
	::lstrcat(szDrive, szDir);

	return szDrive;
}

CString COptionTreeItemFile::GetFileDrive(CString strFile)
{
	// Declare variables
	TCHAR szDrive[MAX_PATH];

	// Split path into components
	_tsplitpath(strFile, szDrive, NULL, NULL, NULL);

	return szDrive;
}

POSITION COptionTreeItemFile::GetStartPosition()
{
	return m_dlgFile.GetStartPosition();
}

CString COptionTreeItemFile::GetNextPathName(POSITION &pos)
{
	return m_dlgFile.GetNextPathName(pos);
}

CString COptionTreeItemFile::GetPathName()
{
	return m_dlgFile.GetPathName();
}

CString COptionTreeItemFile::GetFileName()
{
	return m_dlgFile.GetFileName();
}

CString COptionTreeItemFile::GetFileTitle()
{
	return m_dlgFile.GetFileTitle();
}

CString COptionTreeItemFile::GetFileExt()
{
	return m_dlgFile.GetFileExt();
}

CString COptionTreeItemFile::GetFileDir()
{
	return m_dlgFile.GetFileDir();
}

CString COptionTreeItemFile::GetFileDrive()
{
	return m_dlgFile.GetFileDrive();
}

CString COptionTreeItemFile::GetSelectedFolder()
{
	return m_dlgFile.GetSelectedFolder();
}

CString COptionTreeItemFile::GetAttributeText() {
	update_buffer ();

	return m_strBufferText;
}

void COptionTreeItemFile::update_buffer () {
	CString strText = _T("");
	CString strTemp;

	// -- Full path
	if (GetOption(OT_FILE_SHOWFULLPATH) == TRUE)
	{
		for (int i = 0; i < m_strFileNames.GetSize(); i++)
		{
			// -- -- Get file
			strTemp = m_strFileNames.GetAt(i);

			// -- -- Add newline
			if ((i+1) != m_strFileNames.GetSize())
			{
				strTemp += _T("\n");
			}

			// -- -- Add to text
			strText += strTemp;
		}
	}
	// -- Filename
	else if (GetOption(OT_FILE_SHOWFILENAME) == TRUE)
	{
		CFileFind fFind;
		for (int i = 0; i < m_strFileNames.GetSize(); i++)
		{
			if (GetOption(OT_FILE_NOFIND) == FALSE) {
				// -- -- Find file information
				if (fFind.FindFile(m_strFileNames.GetAt(i)) == FALSE)
				{
					continue;
				}
				fFind.FindNextFile();

				// -- -- Get file
				strTemp = fFind.GetFileName();
			} else {
				CString str = m_strFileNames.GetAt(i);
				CString name = GetFileName (str);
				CString ext = GetFileExtention (str);
				TCHAR path_buffer[_MAX_PATH];
				_tmakepath (path_buffer, NULL, NULL, name, ext); 

				strTemp = path_buffer;
			}

			// -- -- Add newline
			if ((i+1) != m_strFileNames.GetSize())
			{
				strTemp += _T("\n");
			}

			// -- -- Add to text
			strText += strTemp;
		}
	}
	// -- File title
	else if (GetOption(OT_FILE_SHOWFILETITLE) == TRUE)
	{
		CFileFind fFind;
		for (int i = 0; i < m_strFileNames.GetSize(); i++)
		{
			if (GetOption(OT_FILE_NOFIND) == FALSE) {
				// -- -- Find file informaton
				if (fFind.FindFile(m_strFileNames.GetAt(i)) == FALSE)
				{
					continue;
				}
				fFind.FindNextFile();

				// -- -- Get file
				strTemp = fFind.GetFileTitle();

			} else {
				strTemp = GetFileName (m_strFileNames.GetAt(i));
			}
			// -- -- Add newline
			if ((i+1) != m_strFileNames.GetSize())
			{
				strTemp += _T("\n");
			}

			// -- -- Add to text
			strText += strTemp;
		}
	}
	// -- File extention
	else if (GetOption(OT_FILE_SHOWFILEEXT) == TRUE)
	{
		CFileFind fFind;
		for (int i = 0; i < m_strFileNames.GetSize(); i++)
		{
			if (GetOption(OT_FILE_NOFIND) == FALSE) {
				// -- -- Find file informaton
				if (fFind.FindFile(m_strFileNames.GetAt(i)) == FALSE)
				{
					continue;
				}
				fFind.FindNextFile();

				// -- -- Get file
				strTemp = GetFileExtention(fFind.GetFileName());
			} else {
				strTemp = GetFileExtention (m_strFileNames.GetAt(i));
			}

			// -- -- Add newline
			if ((i+1) != m_strFileNames.GetSize())
			{
				strTemp += _T("\n");
			}

			// -- -- Add to text
			strText += strTemp;
		}
	}
	// -- File directory
	else if (GetOption(OT_FILE_SHOWFILEDIR) == TRUE)
	{
		for (int i = 0; i < m_strFileNames.GetSize(); i++)
		{
			// -- -- Get file
			strTemp = GetFileDirectory(m_strFileNames.GetAt(i));

			// -- -- Add newline
			if ((i+1) != m_strFileNames.GetSize())
			{
				strTemp += _T("\n");
			}

			// -- -- Add to text
			strText += strTemp;
		}
	}
	// -- File drive
	else if (GetOption(OT_FILE_SHOWFILEDRIVE) == TRUE)
	{
		for (int i = 0; i < m_strFileNames.GetSize(); i++)
		{
			// -- -- Get file
			strTemp = GetFileDrive(m_strFileNames.GetAt(i));

			// -- -- Add newline
			if ((i+1) != m_strFileNames.GetSize())
			{
				strTemp += _T("\n");
			}

			// -- -- Add to text
			strText += strTemp;
		}
	}

	// Makse sure we have a aselection
	if (m_strFileNames.GetSize() == 0 || strText == _T(""))
	{
		strText = OT_FILE_NOSELECTION;
	}

	std::string tmp_text (strText);
	strText = GCL::str_replace (tmp_text, "\\", "/").c_str ();

	m_strBufferText = strText;
}
//#UC END# *470B034A0232*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeItemFile::~COptionTreeItemFile () {
	//#UC START# *470B034A0232_DESTR_BODY*
	//#UC END# *470B034A0232_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeItemFile, CWnd)
	//#UC START# *470B034A0232_MESSAGE_MAP*
	//#UC END# *470B034A0232_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeItemFile, CWnd)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

