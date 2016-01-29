////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/GeneratorSelect.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::GeneratorSelect
//
// диалог выбора генераторов позволяет выбрать какие генераторы учавствуют в генерации модели, а
// также позволяет настроить некоторые параметры генерации: "отключить/включить авто-инкремент",
// "отключить/включить запуск спец. комманд после генерации" и т.д
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_GENERATORSELECT_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_GENERATORSELECT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4574166E02FD_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "shared/WinGUI/Helpers/LayoutHelper.h"
//#UC END# *4574166E02FD_CUSTOM_INCLUDES*


// диалог выбора генераторов позволяет выбрать какие генераторы учавствуют в генерации модели, а
// также позволяет настроить некоторые параметры генерации: "отключить/включить авто-инкремент",
// "отключить/включить запуск спец. комманд после генерации" и т.д
class GeneratorSelect : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (GeneratorSelect)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_GENERATOR_SELECT };

public:
	GeneratorSelect ();

public:
	virtual ~GeneratorSelect ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(GeneratorSelect)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// кнопка выбора стратегии залочки при генерации - с данной кнопкой связана стратегия "Спрашивать"
	CButton m_ask_lock;

	// кнопка выбора стратегии залочки при генерации - с данной кнопкой связана стратегия "лочить всё"
	CButton m_lock_allways;

	// кнопка выбора стратегии залочки при генерации - с данной кнопкой связана стратегия "Не лочить"
	CButton m_no_lock;

//#UC START# *4574166E02FD*
private:
	RoseHelper::Selections m_selections;

// Construction
public:
	bool make_choice (IRoseItemPtr root);

// Dialog Data
	CButton	m_dis_auto_count;
	CButton	m_disable_post_processing;
	CButton	m_rewrite_uc;
	CButton	m_suppress_uc;	
	CTreeCtrl m_gen_tree;
	Core::Var<AbstractDumperBase::GenTreeItem> m_gen_tree_copy;

// Implementation
protected:
	void update_template ();

	// Generated message map functions
	virtual void OnOK();

protected:
	IRoseItemPtr m_root;
	typedef std::map<std::string, HTREEITEM> TreeItemsMap;
	TreeItemsMap m_tree_items_map;
//#UC END# *4574166E02FD*
}; // class GeneratorSelect



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_GENERATORSELECT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

