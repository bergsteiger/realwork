////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeFontSel.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> shared::WinGUI::OptionTreeControls::COptionTreeFontSel
//
// диалог выбора шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSEL_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSEL_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470AFEDC003E_CUSTOM_INCLUDES*
// Added Headers
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"

#include "shared/WinGUI/OptionTreeControls/COptionTreeFontSelColorButton.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeFontSelFontCombo.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeFontSelGlobals.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeFontSelSizeCombo.h"
//#UC END# *470AFEDC003E_CUSTOM_INCLUDES*

namespace WinGUI {

// диалог выбора шрифта
class COptionTreeFontSel : public CDialog {
	SET_OBJECT_COUNTER (COptionTreeFontSel)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_C_OPTION_TREE_FONT_SEL };

public:
	COptionTreeFontSel ();

public:
	virtual ~COptionTreeFontSel ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeFontSel)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

//#UC START# *470AFEDC003E*
// Construction
public:
	void SetControlID(UINT uID);
	void GetCharFormat(CHARFORMAT &cf);
	void GetLogFont(LOGFONT &lf);
	void SetCustomSample(CString strSample);
	DWORD GetDialogFlags();
	void SetCurFont(LOGFONT lf);
	void SetDefaultFont(LOGFONT lf);
	void SetCurFont(CHARFORMAT cfFont);
	void SetDefaultFont(CHARFORMAT cfFont);
	COLORREF GetTextColor();
	COLORREF GetDefaultTextColor();
	void SetTextColor(COLORREF crColor);
	void SetDefaultTextColor(COLORREF crColor);
	COptionTreeFontSel(DWORD dwFlags, LOGFONT lfFont, LOGFONT lfDefault, CWnd* pParent = NULL);
	COptionTreeFontSel(DWORD dwFlags, LOGFONT lfFont, CWnd* pParent = NULL);
	COptionTreeFontSel(DWORD dwFlags, CHARFORMAT cfFont, CHARFORMAT cfDefault, CWnd* pParent = NULL);
	COptionTreeFontSel(DWORD dwFlags, CHARFORMAT cfFont, CWnd* pParent = NULL);

// Dialog Data
	//{{AFX_DATA(COptionTreeFontSel)
	CStatic	m_ctlSample;
	CComboBox	m_ctlFontStyles;
	COptionTreeFontSelSizeCombo	m_ctlFontSizes;
	COptionTreeFontSelFontCombo	m_ctlFontNames;
	CButton	m_ctlUnderline;
	CButton	m_ctlStrikeout;
	CButton	m_ctlButtonDefault;
	CButton	m_ctlButtonApply;
	COptionTreeFontSelColorButton	m_ctlButtonColor;
	//}}AFX_DATA

protected:
	void GetSelectedFont(LOGFONT &lf);
	void ConvertFont(CHARFORMAT &cfFont, LOGFONT &lf);
	void ConvertFont(LOGFONT &lf, CHARFORMAT &cfFont);
	void OnSelChangeFontScript();
	BOOL ValidateControls();
	void SelectCurFont(LOGFONT lf);
	void FillSizeStyleList();
	void FillFaceNameList();
	static int CALLBACK EnumFontFamiliesCallBack(ENUMLOGFONT* lpelf, NEWTEXTMETRIC* lpntm, int nFontType, LPARAM lParam);
	static int CALLBACK EnumFontFamiliesCallBack2(ENUMLOGFONT* lpelf, NEWTEXTMETRIC* lpntm, int nFontType, LPARAM lParam);
	void OnObjectsChanged();
	void UpdateSampleFont();
	void OnEditUpdateFontNames();
	void OnEditUpdateFontSizes();
	void OnSelChangeFontNames();
	void OnSelChangeFontSizes();
	void OnSelChangeFontStyles();
	void OnEditChangeFontStyles();
	void OnStrikeout();
	void OnUnderline();


	CFont m_fSampleFont;
	DWORD m_nCurrentStyle;
	DWORD m_nActualStyle;
	DWORD m_nStyles;
	BOOL m_bStrikeOut;
	BOOL m_bUnderline;
	CString m_strFontSize;
	LOGFONT m_lfFont;
	LOGFONT m_lfDefault;
	DWORD m_dwDialogFlags;
	CString m_strCustomSample;
	UINT m_uControlID;

	// Generated message map functions
	//{{AFX_MSG(COptionTreeFontSel)
	afx_msg void OnPaint();
	afx_msg void OnButtonOK();
	afx_msg void OnButtonCancel();
	afx_msg void OnButtonDefault();
	afx_msg void OnButtonApply();
	//}}AFX_MSG
	afx_msg long OnSelChangeColor(UINT lParam, long wParam);
//#UC END# *470AFEDC003E*
}; // class COptionTreeFontSel

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEFONTSEL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

