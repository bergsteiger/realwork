////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppApplGen.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppApplGen
//
// страница для выбора разрешенных генераторв для элемента, т.е тех генераторв, которыми можно
// генерить данный элемент
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPAPPLGEN_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPAPPLGEN_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppBase.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4574179402BF_CUSTOM_INCLUDES*
//#UC END# *4574179402BF_CUSTOM_INCLUDES*


// страница для выбора разрешенных генераторв для элемента, т.е тех генераторв, которыми можно
// генерить данный элемент
class IppApplGen : public IppBase {
	SET_OBJECT_COUNTER (IppApplGen)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_IPP_APPL_GEN };

public:
	IppApplGen ();

public:
	virtual ~IppApplGen ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNCREATE(IppApplGen)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// множество выбранных генераторов
	RoseHelper::Selections m_selections;

//#UC START# *4574179402BF*
public:
	virtual bool on_ok(bool& need_colorize);

protected:
	void load_gen_tree (bool use_global);
	
public:
	CTreeCtrl m_gen_tree;
	//CButton m_global_rb;
	//CButton m_project_rb;
	Core::Var<AbstractDumperBase::GenTreeItem> m_gen_tree_copy;

	afx_msg void OnBnClickedGlobalRb();
	afx_msg void OnBnClickedProjectRb();

//#UC END# *4574179402BF*
}; // class IppApplGen



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPAPPLGEN_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

