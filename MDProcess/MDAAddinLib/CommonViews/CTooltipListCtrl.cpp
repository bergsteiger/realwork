////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/CommonViews/CTooltipListCtrl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> MDProcess::MDAAddinLib::CommonViews::CTooltipListCtrl
//
// контрол-список с поддержкой всплывающих подсказок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/CommonViews/CTooltipListCtrl.h"

//#UC START# *45F982BB0128_CUSTOM_INCLUDES*
#include "shared/GCL/math/unbounded_ops.h"

//#UC END# *45F982BB0128_CUSTOM_INCLUDES*


//#UC START# *45F982BB0128*
void CTooltipListCtrl::PreSubclassWindow()  {
	EnableToolTips( );

	CListCtrl::PreSubclassWindow();
}

int CTooltipListCtrl::OnToolHitTest( CPoint point, TOOLINFO* pTI ) const {	
	int n_item = this->get_item_on_cursor ();
	if (n_item != -1) {
		CRect rcItem;
		GetItemRect (n_item, rcItem, LVIR_BOUNDS );

		pTI->hwnd = m_hWnd;
		pTI->uId = ( UINT )( n_item + 1 );
		pTI->lpszText = LPSTR_TEXTCALLBACK;

		pTI->rect = rcItem;

		return pTI->uId;
	}
	return -1;
}

BOOL CTooltipListCtrl::OnToolTipText( UINT id, NMHDR * pNMHDR, LRESULT * pResult ) {
	// need to handle both ANSI and UNICODE versions of the message
	TOOLTIPTEXTA* pTTTA = (TOOLTIPTEXTA*)pNMHDR;
	TOOLTIPTEXTW* pTTTW = (TOOLTIPTEXTW*)pNMHDR;
	CString sTipText;
	UINT nID = pNMHDR->idFrom;

	if( nID == 0 )	  	// Notification in NT from automatically
		return FALSE;   	// created tooltip

	
	//int nRow = nID - 1;
	int n_item = this->get_item_on_cursor ();
	if (n_item == -1) {
		return FALSE;
	}
	::SendMessage (pNMHDR->hwndFrom, TTM_SETMAXTIPWIDTH, 0, this->m_tool_tip_max_width);
	const std::string tip = this->get_item_tip (n_item);
/*
#ifndef _UNICODE
	if (pNMHDR->code == TTN_NEEDTEXTA)
		lstrcpyn(pTTTA->szText, tip.c_str (), sizeof (pTTTA->szText));
		lstrcpyn(pTTTA->szText, tip.c_str (), sizeof (pTTTA->szText));
	else
		_mbstowcsz(pTTTW->szText, tip.c_str (), sizeof (pTTTA->szText));
#else
	if (pNMHDR->code == TTN_NEEDTEXTA)
		_wcstombsz(pTTTA->lpszText, tip.c_str (), sizeof (pTTTA->szText));
	else
		lstrcpyn(pTTTW->lpszText, tip.c_str (), sizeof (pTTTA->szText));
#endif
*/	    
	if (pNMHDR->code == TTN_NEEDTEXTA) {
		lstrcpyn(pTTTA->lpszText, tip.c_str (), tip.length ());
	} else {
		WCHAR tip_text[1024] = {0};
		::MultiByteToWideChar( CP_ACP, 0, tip.c_str (), -1, tip_text, sizeof(tip_text)/sizeof(tip_text[0]));
		pTTTW->lpszText = tip_text;
	}
	
	*pResult = 0;
	return TRUE;    // message was handled
}

void CTooltipListCtrl::OnGetdispinfo(NMHDR* pNMHDR, LRESULT* pResult) {
	LV_DISPINFO* pDispInfo = (LV_DISPINFO*)pNMHDR;

	if ( pDispInfo->item.iItem != -1 )	{
		if ( pDispInfo->item.mask & LVIF_TEXT )	{
			CString sText = GetItemText (pDispInfo->item.iItem, 0);
			strcpy( pDispInfo->item.pszText, sText );
		}
	}

	*pResult = 0;
}
//#UC END# *45F982BB0128*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CTooltipListCtrl::CTooltipListCtrl () : m_tool_tip_max_width (100), m_is_multicolumn (false)
//#UC START# *45F98AE803A9_BASE_INIT*
, CListCtrl ()
//#UC END# *45F98AE803A9_BASE_INIT*
{
	//#UC START# *45F98AE803A9_BODY*
	EnableToolTips ();
	//#UC END# *45F98AE803A9_BODY*
}

CTooltipListCtrl::~CTooltipListCtrl () {
	//#UC START# *45F982BB0128_DESTR_BODY*
	//#UC END# *45F982BB0128_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(CTooltipListCtrl, CListCtrl)
	//#UC START# *45F982BB0128_MESSAGE_MAP*
	ON_NOTIFY_REFLECT(LVN_GETDISPINFO, OnGetdispinfo)
	ON_NOTIFY_EX_RANGE(TTN_NEEDTEXTW, 0, 0xFFFF, OnToolTipText)
	ON_NOTIFY_EX_RANGE(TTN_NEEDTEXTA, 0, 0xFFFF, OnToolTipText)
	//#UC END# *45F982BB0128_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(CTooltipListCtrl, CListCtrl)



// Добавляет элемент с текстом = text в список
void CTooltipListCtrl::add_item (const std::string& text) {
	//#UC START# *45F989220109*
	int count = this->GetItemCount ();
	this->InsertItem (count, text.c_str ());
	this->set_item_tip (count, text);
	this->calculate_column_width (true);
	//#UC END# *45F989220109*
}

// определяет ширину колонки, для того чтобы определить нжно показывать горизонтальный скроллер или
// нет
void CTooltipListCtrl::calculate_column_width (bool after_add) {
	//#UC START# *45F98B3F031C*
	int count = this->GetItemCount ();
	int max_width = 0;
	for (int i = 0; i < count; ++i) {
		CString text = this->GetItemText (i, 0);
		int text_width = this->GetStringWidth(text);
		if (text_width > max_width) {
			max_width = text_width;
		}
	}	
	int column_width = this->GetColumnWidth (0);
	CRect rect;
	this->GetWindowRect (&rect);
	if (after_add) {
		this->SetColumnWidth (
			0
			, GCL_MAX (
				max_width + 15
				, column_width
				, rect.Width () - 15
			)
		);
	} else {
		this->SetColumnWidth (
			0
			, GCL_MAX (
				max_width + 15
				, rect.Width () - 15
			)
		);
	}
	//#UC END# *45F98B3F031C*
}

// удалаяет все элементы в списке
void CTooltipListCtrl::delete_all_items () {
	//#UC START# *45FE64E600DA*
	this->DeleteAllItems ();
	this->calculate_column_width (false);
	m_item_to_tip.clear ();
	//#UC END# *45FE64E600DA*
}

// удаляет элемент из списка, row - позиция элемента в списке
void CTooltipListCtrl::delete_item (unsigned long row) {
	//#UC START# *45F989790271*
	this->DeleteItem (row);
	if (row != 0) {
		m_item_to_tip[row-1] = m_item_to_tip[row];
		m_item_to_tip.erase (row);
	} else {
		m_item_to_tip[row] = m_item_to_tip[row+1];
		m_item_to_tip.erase (row+1);
	}	
	this->calculate_column_width (false);
	//#UC END# *45F989790271*
}

// возвращает номер жлемента в списке над которым находится курсор мыши
int CTooltipListCtrl::get_item_on_cursor () const {
	//#UC START# *45FA3C34001F*
	int n_item = -1;
	int count = this->GetItemCount ();
	POINT pt;
	GetCursorPos (&pt);
	for (int i = 0; i <= count; ++i) {
		CRect rect;
		this->GetItemRect (i, &rect, LVIR_LABEL);
		this->ClientToScreen (&rect);
		if (rect.PtInRect (pt)) {
			n_item = i;
			break;
		}
	}
	return n_item;
	//#UC END# *45FA3C34001F*
}

// возвращает текст-подсказку, связанную с элементом
const std::string CTooltipListCtrl::get_item_tip (unsigned long row) const {
	//#UC START# *45F985620251*
	std::string res;
	ItemToTextMap::const_iterator it = m_item_to_tip.find (row);	
	if (it != m_item_to_tip.end ()) {
		res = it->second;
	}
	//разбиваем строку на строки по n символов	
	GCL::StrVector splited = GCL::split_string_format (res.c_str (), this->m_tool_tip_max_width);
	res.erase ();
	for (
		GCL::StrVector::const_iterator it = splited.begin ()
		; it != splited.end ()
		; ++it
	) {
		res += *it;
		GCL::StrVector::const_iterator temp = it;
		if (++temp != splited.end ()) {
			res += "\r\n";
		}
	}	
	return res;
	//#UC END# *45F985620251*
}

// возвращает позицию выделеного элемента
int CTooltipListCtrl::get_selected_item () const {
	//#UC START# *45FE64F7006D*
	POSITION pos = this->GetFirstSelectedItemPosition();
	int n_item = -1;
	if (pos == NULL) {
	   TRACE0("No items were selected!\n");
	} else {
		n_item = this->GetNextSelectedItem(pos);
	}
	return n_item;
	//#UC END# *45FE64F7006D*
}

// возвращает множество индексов выделенных элементов
CTooltipListCtrl::SelectedItems* CTooltipListCtrl::get_selected_items () const {
	//#UC START# *464AB5C70251*	
	POSITION pos = this->GetFirstSelectedItemPosition();
	if (pos == NULL) {
		return 0;
	} else {
		CTooltipListCtrl::SelectedItems* items = new CTooltipListCtrl::SelectedItems ();
		while (pos) {
		  int index = this->GetNextSelectedItem (pos);
		  items->insert (index);		 
		}
		return items;
	}
	//#UC END# *464AB5C70251*
}

// перемещает выбранный в списке элементы в другой спсик
void CTooltipListCtrl::move_selected_items (CTooltipListCtrl& dest) {
	//#UC START# *45F9959B033C*
	POSITION pos = this->GetFirstSelectedItemPosition();
	if (pos == NULL)
	   TRACE0("No items were selected!\n");
	else {
		int nItem = this->GetNextSelectedItem(pos);
		CString item = this->GetItemText (nItem, 0);
		TRACE1("Item %d was selected!\n", nItem);
		// you could do your own processing on nItem here
		this->delete_item (nItem);
		std::string text = item;
		dest.add_item (text);
		this->move_selected_items (dest);	   
	}	
	//#UC END# *45F9959B033C*
}

// устанавливает текст-подсказку, связанную с элементом
unsigned long CTooltipListCtrl::set_item_tip (unsigned long row, const std::string& text) {
	//#UC START# *45F9861203A9*
	if ((int)row < GetItemCount()) {
		m_item_to_tip[row] = text;
		return row;
	}

	return -1;
	//#UC END# *45F9861203A9*
}

// устанавливает флаг, что список многоколочный
// (пока не работает)
void CTooltipListCtrl::set_multicolumn (bool is_multi) {
	//#UC START# *45F98A9D008C*
	m_is_multicolumn = is_multi;
	//#UC END# *45F98A9D008C*
}

// устанавливает максимальную ширину окна всплывающей подсказки
void CTooltipListCtrl::set_tooltip_max_width (unsigned long width) {
	//#UC START# *45FE62180222*
	this->m_tool_tip_max_width = width;
	//#UC END# *45FE62180222*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

