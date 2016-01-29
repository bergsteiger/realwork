////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeInfo.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeInfo
//
// поле информации о дереве контролов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeInfo.h"

//#UC START# *470B002D00FA_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470B002D00FA_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B002D00FA*
/////////////////////////////////////////////////////////////////////////////
// COptionTreeInfo

COptionTreeInfo::COptionTreeInfo()
{
	// Initialize variables
	m_otOption = NULL;
}

void COptionTreeInfo::SetOptionsOwner(COptionTree *otOption)
{
	// Save pointer
	m_otOption = otOption;
}
/*
BOOL COptionTreeInfo::OnEraseBkgnd(CDC* pDC) 
{
	// Ha, Ha
	return FALSE;
}
*/
void  COptionTreeInfo::SetText(COptionTreeItem* pItem,const bool label)
{
  if(::IsWindow(this->GetSafeHwnd()) == TRUE && pItem != NULL)
  {
    CString sText("");
    if(label == true)
      this->SetWindowText(pItem->GetLabelText());
    else
      this->SetWindowText(pItem->GetInfoText());
    /*
    this->SetWindowText(sText);
    this->Invalidate();
    this->UpdateWindow();
    */
  }
}
//#UC END# *470B002D00FA*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeInfo::~COptionTreeInfo () {
	//#UC START# *470B002D00FA_DESTR_BODY*
	//#UC END# *470B002D00FA_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeInfo, CEdit)
	//#UC START# *470B002D00FA_MESSAGE_MAP*
	//#UC END# *470B002D00FA_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeInfo, CEdit)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

