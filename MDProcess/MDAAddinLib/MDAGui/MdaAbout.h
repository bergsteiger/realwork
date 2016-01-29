////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/MdaAbout.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::MdaAbout
//
// About-диалог
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_MDAABOUT_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_MDAABOUT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *458E706E0066_CUSTOM_INCLUDES*
//#UC END# *458E706E0066_CUSTOM_INCLUDES*


// About-диалог
class MdaAbout : public CDialog {
	SET_OBJECT_COUNTER (MdaAbout)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_MDA_ABOUT };

public:
	MdaAbout ();

public:
	virtual ~MdaAbout ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(MdaAbout)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

//#UC START# *458E706E0066*
	CStatic m_version;
	CStatic m_build;
	CStatic m_target;
	CStatic m_server;
//#UC END# *458E706E0066*
}; // class MdaAbout



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_MDAABOUT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

