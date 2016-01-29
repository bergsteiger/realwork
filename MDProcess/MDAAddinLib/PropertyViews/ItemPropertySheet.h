////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/ItemPropertySheet.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<PropertySheet::Class>> MDProcess::MDAAddinLib::PropertyViews::ItemPropertySheet
//
// дилог редактирования/просмотра свойств элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_ITEMPROPERTYSHEET_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_ITEMPROPERTYSHEET_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppStd.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppUserProp.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppException.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppUses.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppDerivedImpl.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppApplGen.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppSystem.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppNative.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *457417C60177_CUSTOM_INCLUDES*
//#UC END# *457417C60177_CUSTOM_INCLUDES*


// дилог редактирования/просмотра свойств элемента
class ItemPropertySheet : public WinGUI::ETSLayoutPropertySheet {
	SET_OBJECT_COUNTER (ItemPropertySheet)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	ItemPropertySheet ();

public:
	virtual ~ItemPropertySheet ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(ItemPropertySheet)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
public:
	// возвращает страницу "Native Paths"
	virtual const IppNative& get_native_page () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IppUserProp m_Page1;

	IppException m_Page2;

	IppUses m_Page3;

	IppDerivedImpl m_Page4;

	IppApplGen m_Page5;

	IppSystem m_Page6;

	IppNative m_Page7;

	IppStd m_PageStd;

	RoseHelper::ExecResult m_specific_result;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	RoseHelper::ExecResult get_specific_result () const;

	void set_specific_result (RoseHelper::ExecResult specific_result);

//#UC START# *457417C60177*
public:
	static bool edit_prop (IRoseElementPtr pRoseItem, RoseHelper::ExecResult& is_ok, bool auto_open_st_list, bool fill_def_value);
	static RoseHelper::ExecResult execute (IRoseItemPtr item, bool auto_open_st_list, bool fill_def_value);

public:
	typedef std::map<std::string, ItemPropertySheet*> PSMap;
	static PSMap s_ps_map;

// Attributes
public:
	bool m_auto_open_st_list;
	bool m_fill_def_value;

// Overrides
public:		
	virtual BOOL DestroyWindow();

// Implementation
public:
	IRoseItemPtr& get_rose_item() {
		return m_rose_item;
	}

protected:
	IRoseItemPtr m_rose_item;
	HANDLE m_thread;
//#UC END# *457417C60177*
}; // class ItemPropertySheet



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_ITEMPROPERTYSHEET_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

