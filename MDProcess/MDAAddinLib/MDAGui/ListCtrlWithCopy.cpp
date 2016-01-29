////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/ListCtrlWithCopy.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> MDProcess::MDAAddinLib::MDAGui::ListCtrlWithCopy
//
// список с поддержкой копирования
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/ListCtrlWithCopy.h"
// by <<uses>> dependencies
#include "shared/GCL/str/str_op.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/WinGUI/Helpers/ClipboardHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ListCtrlWithCopy::~ListCtrlWithCopy () {
	//#UC START# *4AD86888019C_DESTR_BODY*
	//#UC END# *4AD86888019C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(ListCtrlWithCopy, CListCtrl)
	//#UC START# *4AD86888019C_MESSAGE_MAP*
	//ON_WM_KEYDOWN ()
	ON_COMMAND(ID_EDIT_COPY, on_copy)
    ON_UPDATE_COMMAND_UI(ID_EDIT_COPY, on_update_copy)
	{ WM_KEYDOWN, 0, 0, 0, AfxSig_vwww, \
		(AFX_PMSG)(AFX_PMSGW) \
		(static_cast< void (AFX_MSG_CALL CWnd::*)(UINT, UINT, UINT) > ( &ThisClass::on_key_down)) },
	//#UC END# *4AD86888019C_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(ListCtrlWithCopy, CListCtrl)



// реализация копирования в буфер выделенного текста
void ListCtrlWithCopy::on_copy () {
	//#UC START# *4AD868BF00EC*
	GCL::StrVector texts;
	POSITION pos = this->GetFirstSelectedItemPosition();
	if (pos != NULL) {
		while (pos) {
			int selected_item = this->GetNextSelectedItem(pos);
			CString item_text = this->GetItemText (selected_item, 0);
			texts.push_back (static_cast<const char*> (item_text));
		}

		std::string clipboard_data = GCL::join (texts, "\r\n");
		WinGUI::ClipboardHelper::copy_text_to_clipboard (clipboard_data);
	} else {
		WinGUI::ClipboardHelper::copy_text_to_clipboard ("");
	}
	//#UC END# *4AD868BF00EC*
}

void ListCtrlWithCopy::on_key_down (unsigned int key, unsigned int rep_cnt, unsigned int flags) {
	//#UC START# *4AD868DC00B6*
    if (
		(GetKeyState(VK_CONTROL) & 0x8000) 
		&& (key == 'C' || key == 'С')
	) {
		this->on_copy ();
    }
	//#UC END# *4AD868DC00B6*
}

// поддержка операции копирования в буфер
void ListCtrlWithCopy::on_update_copy (CCmdUI* cmd) {
	//#UC START# *4AD868B603E2*
	POSITION pos = this->GetFirstSelectedItemPosition();
	cmd->Enable(pos != NULL);
	//#UC END# *4AD868B603E2*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

