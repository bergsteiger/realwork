////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppBase
//
// базовый класс для страниц, отображаемых в свойствах элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppBase.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/PropertyViews/ItemPropertySheet.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"

//#UC START# *4574171C00FA_CUSTOM_INCLUDES*
//#UC END# *4574171C00FA_CUSTOM_INCLUDES*


//#UC START# *4574171C00FA*
void IppBase::do_ok (IRoseItemPtr item) {
	bool need_recolorize = false;
	try {
		if (m_ok_result = this->on_ok (need_recolorize)) {
			if (need_recolorize) {			

				IRoseClassDiagramPtr diag = RoseHelper::get_self_diagram (item);
				if (diag) {
					MDPSupport::CatLockerFacade_var diag_clf 
						= MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)diag);
					if (true == diag_clf->try_change ()) {
						RoseHelper::colorize (diag, item);
						diag_clf->do_change ();
					}
				}
			}		
			CPropertyPage::OnOK();
		} else {
		}
	} catch (_com_error& ex) {
		std::string mess ("Произошло исключение: _com_error (\n");
		mess += ex.ErrorMessage ();
		mess += ")";
		MessageBox (_T (mess.c_str ()), "Ошибка", MB_OK|MB_ICONEXCLAMATION );
	} catch (std::exception& ex) {
		std::string mess ("Произошло исключение: std::exception (\n");
		mess += ex.what ();
		mess += ")";
		MessageBox (_T (mess.c_str ()), "Ошибка", MB_OK|MB_ICONEXCLAMATION );
	} catch (...) {
		MessageBox ("Произошло не обработанное исключение", "Ошибка", MB_OK | MB_ICONEXCLAMATION );
		//RoseAbstractDumper::reset_model_tree_root ();
	}
	CPropertyPage::OnCancel ();
}

afx_msg void IppBase::OnOK() {
	class auto_locker {
	public:		
		auto_locker (IRoseElementPtr elem) 
			: m_changed (false)
		{
			m_auto_clf = MDPSupport::CatLockerFacadeFactory::make (elem);
			if (elem) {
				m_changed = m_auto_clf->try_change ();
			}
		}
		auto_locker (IRoseCategoryPtr elem) 
			: m_changed (false)
		{
			m_auto_clf = MDPSupport::CatLockerFacadeFactory::make (elem);
			if (elem) {
				m_changed = m_auto_clf->try_change ();
			}
		}
		~auto_locker () {
			if (m_changed) {
				m_auto_clf->do_change ();
			}
		}

		bool get_changed () {
			return m_changed;
		}
	private:
		MDPSupport::CatLockerFacade_var m_auto_clf;
		bool m_changed;
	};
	ItemPropertySheet* ps = dynamic_cast<ItemPropertySheet*> (this->GetOwner());

//	bool need_recolorize = false;
//	for (int i = 0; i < ps->GetPageCount(); i++) {
//		IppBase* pp = dynamic_cast<IppBase*>(ps->GetPage(i));
//		if (pp && pp->is_accessed ()) {
//			need_recolorize |= pp->on_ok ();
//		}
//	}
	IRoseItemPtr item = ps->get_rose_item();
	auto_locker clf ((IRoseElementPtr)item);
	if (false == clf.get_changed ()) {
		return;
	}

	this->do_ok (item);
}
//#UC END# *4574171C00FA*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IppBase::IppBase (UINT templ_id)
	: WinGUI::ETSLayoutPropertyPage (templ_id)
//#UC START# *4574171C00FA_CTOR_BASE_INIT*
	, m_is_accessed (false)
	, m_ok_result (true)
//#UC END# *4574171C00FA_CTOR_BASE_INIT*
{
	//#UC START# *4574171C00FA_CTOR*
	//#UC END# *4574171C00FA_CTOR*
}


IppBase::~IppBase () {
	//#UC START# *4574171C00FA_DESTR_BODY*
	//#UC END# *4574171C00FA_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(IppBase, WinGUI::ETSLayoutPropertyPage)
	//#UC START# *4574171C00FA_MESSAGE_MAP*
	//#UC END# *4574171C00FA_MESSAGE_MAP*
END_MESSAGE_MAP()

void IppBase::DoDataExchange(CDataExchange* pDX) {
	CPropertyPage::DoDataExchange(pDX);
	//#UC START# *4574171C00FA_DO_DATA_EXCHANGE*
	//#UC END# *4574171C00FA_DO_DATA_EXCHANGE*
}

BOOL IppBase::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutPropertyPage::OnInitDialog();
	try {
		//#UC START# *4574171C00FA_ON_INIT_DLG*
		m_is_accessed = true;
		//#UC END# *4574171C00FA_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"IppBase\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}


// метод проверяет можно ли редактировать элемент - если нельзя, то дизейблит все контролы
void IppBase::check_for_editable () {
	//#UC START# *468391D0005D*
	IRoseElementPtr elem = this->get_rose_item ();
	MDPSupport::CatLockerFacade_var clf = 
		MDPSupport::CatLockerFacadeFactory::make (elem);
	if (
		(
			false == clf->can_change ()
			|| (
				IsVirtualFactory::get ().execute (elem)
				&& ACE_OS::strncmp (
					static_cast<const char*> (elem->GetPropertyValue (TOOL_NAME, Base::IS_OVERRIDEN_WRAPPER))
					, "true"
					, ACE_OS::strlen ("true")
				) != 0
			)
		) && ::IsWindow (m_hWnd)
	) {
		CWnd* child_wnd = this->GetWindow(GW_CHILD);
		while (child_wnd != NULL && ::IsWindow(child_wnd->m_hWnd)) {
			child_wnd->EnableWindow (false);
			child_wnd = child_wnd->GetWindow(GW_HWNDNEXT);
		}
	}
	//#UC END# *468391D0005D*
}

// метод возвращает элемент связанный с страницей
IRoseItemPtr IppBase::get_rose_item () const {
	//#UC START# *45754B380115*
	ItemPropertySheet* ps = dynamic_cast<ItemPropertySheet*> (this->GetOwner());
	return ps->get_rose_item();
	//#UC END# *45754B380115*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

