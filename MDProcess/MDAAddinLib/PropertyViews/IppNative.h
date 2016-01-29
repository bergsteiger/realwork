////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppNative.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppNative
//
// страница для редакртирования native путей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPNATIVE_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPNATIVE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppBase.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *457417BB0232_CUSTOM_INCLUDES*
//#UC END# *457417BB0232_CUSTOM_INCLUDES*


// страница для редакртирования native путей
class IppNative : public IppBase {
	SET_OBJECT_COUNTER (IppNative)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_IPP_NATIVE };

public:
	IppNative ();

public:
	virtual ~IppNative ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNCREATE(IppNative)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// нэйтив пути
	WinGUI::COptionTree m_native_paths;

//#UC START# *457417BB0232*
public:
	virtual bool on_ok(bool& need_colorize);
	
	struct Property {
		WinGUI::COptionTreeItemEdit* item;		
		std::string gen_id;
		Property (WinGUI::COptionTreeItemEdit* n, const std::string& id) 
			: item(n) 
			, gen_id (id)
		{
		}
		bool operator == (const Property& eq) {
			return item == eq.item;
		}
		Property& operator = (const Property& eq) {
			item = eq.item;					
			return *this;
		}
	};
	typedef std::vector<Property> Properties;
	Properties m_properties_list;

private:
	friend struct InsertInDlg;
//#UC END# *457417BB0232*
}; // class IppNative



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPNATIVE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

