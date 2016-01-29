////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTree3StateCheckBox.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTree3StateCheckBox
//
// чек-бокс с тремя состояниями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREE3STATECHECKBOX_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREE3STATECHECKBOX_H__

#include "shared/Core/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "shared/WinGUI/OptionTreeControls/COptionTreeCheckButton.h"
#include "afxwin.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470CC30A002E_CUSTOM_INCLUDES*
//#UC END# *470CC30A002E_CUSTOM_INCLUDES*

namespace WinGUI {

// чек-бокс с тремя состояниями
class COptionTree3StateCheckBox : public COptionTreeCheckButton {
	SET_OBJECT_COUNTER (COptionTree3StateCheckBox)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// конструктор
	COptionTree3StateCheckBox ();

public:
	virtual ~COptionTree3StateCheckBox ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTree3StateCheckBox)

public:
	// уничтожение контрола
	virtual void CleanDestroyWindow ();

	// создаёт элемент
	virtual bool CreateCheckBoxItem (boost::tribool state, unsigned long options);

	// отрисовка данных контрола
	virtual void DrawAttribute (CDC* dc, const RECT& rc);

	// реакция контрола на активацию
	virtual void OnActivate ();

	// реакция контрола на изменение
	virtual void OnCommit ();

	// реакция контрола на снятие выделения
	virtual void OnDeSelect ();

	// реакция контрола на движение мыши
	virtual void OnMove ();

	// реакция контрола на обновление
	virtual void OnRefresh ();

	// реакция контрола на выделение
	virtual void OnSelect ();

	// реакция контрола на отображение/скрытие
	virtual void OnShow (BOOL bShow);

	// возвращает состояние
	virtual boost::tribool get_state () const;

	// возвращает стостояние в виде строки
	virtual const std::string get_state_str () const;

	// установка состояния
	// \state - состояние (true, false, undefined)
	// \commit - нужео ли коммитеть изменения
	virtual void set_state (boost::tribool state);

	// устанавливает текст для неопределённого значения
	virtual void set_undefined_str (const std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// фокус в контроле или нет
	bool m_focus;

	// состояние
	boost::tribool m_state;

	// текст для неопределённого состояние чек-бокса
	std::string m_undefined_str;

//#UC START# *470CC30A002E*
protected:
	//{{AFX_MSG(COptionTree3StateCheckBox)
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg void OnPaint();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	//}}AFX_MSG
private:
	CRect m_rcCheck;
//#UC END# *470CC30A002E*
}; // class COptionTree3StateCheckBox

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREE3STATECHECKBOX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

