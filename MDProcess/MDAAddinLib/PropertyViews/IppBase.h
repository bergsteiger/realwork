////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppBase
//
// базовый класс для страниц, отображаемых в свойствах элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPBASE_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4574171C00FA_CUSTOM_INCLUDES*
//#UC END# *4574171C00FA_CUSTOM_INCLUDES*


// базовый класс для страниц, отображаемых в свойствах элемента
class IppBase : public WinGUI::ETSLayoutPropertyPage {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	IppBase (UINT templ_id);

public:
	virtual ~IppBase ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
protected:
	// метод проверяет можно ли редактировать элемент - если нельзя, то дизейблит все контролы
	virtual void check_for_editable ();

	// метод возвращает элемент связанный с страницей
	IRoseItemPtr get_rose_item () const;


//#UC START# *4574171C00FA*
public:
	bool is_accessed () const {
		return m_is_accessed;
	}
	
	void OnOK();

	static DWORD WINAPI ShitApplyThreadFunc(LPVOID lpParam) { 
		IppBase* shit = (IppBase*)lpParam;
		ACE_OS::sleep (1);
		try {
			if (::IsWindow(shit->m_hWnd)) {
				shit->SetModified(true);
			}
		} catch (...) {
		}
		return 0; 
	} 

	BOOL OnApply() {
		bool ret = CPropertyPage::OnApply();
		//DWORD dwThreadId;
		//CloseHandle( CreateThread(NULL, 0, ShitApplyThreadFunc, this, 0, &dwThreadId) );
		return m_ok_result;
	}

	virtual bool on_ok (bool& need_colorize) = 0; // result shows that we need recolorize diagrams
	
	void do_ok (IRoseItemPtr item);
protected:
	bool m_ok_result;
	bool m_is_accessed;
//#UC END# *4574171C00FA*
}; // class IppBase



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

