////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppSystem.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppSystem
//
// страница редактирвоания системных свойств (путь к рутовой папке генерации, выбор шаблона)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPSYSTEM_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPSYSTEM_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppBase.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *457417A3005D_CUSTOM_INCLUDES*
//#UC END# *457417A3005D_CUSTOM_INCLUDES*


// страница редактирвоания системных свойств (путь к рутовой папке генерации, выбор шаблона)
class IppSystem : public IppBase {
	SET_OBJECT_COUNTER (IppSystem)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_IPP_SYSTEM };

public:
	IppSystem ();

public:
	virtual ~IppSystem ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNCREATE(IppSystem)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// чек-бокс для установки прихнака незавершённости элемента
	CButton m_is_incomlete;

//#UC START# *457417A3005D*
	CEdit	m_root_dir;
	CEdit	m_templ_file;
	CButton m_chg_templ;
	CButton m_chg_root_dir;

// Overrides
public:
	virtual bool on_ok(bool& need_colorize);

// Implementation
protected:
	afx_msg void OnChangeRootDir();
	afx_msg void OnChangeTempl();
//#UC END# *457417A3005D*
}; // class IppSystem



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPSYSTEM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

