////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/ItemPropertySheet.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertySheet::Class>> MDProcess::MDAAddinLib::PropertyViews::ItemPropertySheet
//
// дилог редактирования/просмотра свойств элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/ItemPropertySheet.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"

//#UC START# *457417C60177_CUSTOM_INCLUDES*
//#UC END# *457417C60177_CUSTOM_INCLUDES*


//#UC START# *457417C60177*
ItemPropertySheet::PSMap ItemPropertySheet::s_ps_map;

bool ItemPropertySheet::edit_prop (IRoseElementPtr pRoseItem, RoseHelper::ExecResult& is_ok, bool auto_open_st_list, bool fill_def_value) {
	if (
		pRoseItem->IsClass(CLASS_TYPE)
		|| pRoseItem->IsClass(ATTRIBUTE_TYPE)
		|| pRoseItem->IsClass(OPERATION_TYPE)
		|| pRoseItem->IsClass(PARAMETER_TYPE)
		|| pRoseItem->IsClass("Role")
		|| pRoseItem->IsClass("Association")
		|| pRoseItem->IsClass(CATEGORY_TYPE)
		|| pRoseItem->IsClass(CLASS_DEPENDENCY_TYPE)
	) {
		IRoseItemPtr item;
		if (pRoseItem->IsClass("Association")) {
			item = RoseHelper::get_role (pRoseItem);
		} else if (pRoseItem->IsClass("Role")) {
			IRoseAssociationPtr assoc = ((IRoseRolePtr)pRoseItem)->Association;
			item = RoseHelper::get_role (assoc);
		} else {
			item = pRoseItem;
		}
		
		is_ok = ItemPropertySheet::execute(item, auto_open_st_list, fill_def_value);
		return true;
	} else if (pRoseItem->IsClass ("StateMachine")) {
		((IRoseStateMachinePtr)pRoseItem)->OpenSpecification ();
	} else if (pRoseItem->IsClass ("DependencyRelation")) {
		IRoseDependencyRelationPtr dep = pRoseItem;
		std::string mess ("Внимание, ошибочная связь к ");
		mess += dep->SupplierName;
		mess += "\n";
		mess += "удалите её.";
		::MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), mess.c_str (), "Внимание, ошибочная связь", MB_OK | MB_ICONERROR);
	} else if (pRoseItem->IsClass (ROSE_ITEM_TYPE)) {
		((IRoseItemPtr)pRoseItem)->OpenSpecification ();
	}
	return false;
}

DWORD WINAPI ShitSheetThreadFunc(LPVOID lpParam) { 
	ItemPropertySheet* shit = (ItemPropertySheet*)lpParam;
	shit->DoModal ();
    return 0; 
} 

BOOL ItemPropertySheet::DestroyWindow () {
	CPropertySheet::DestroyWindow();
	//delete this;
	return 1;
}

RoseHelper::ExecResult ItemPropertySheet::execute(IRoseItemPtr item, bool auto_open_st_list, bool fill_def_value) {
	Core::Aptr<ItemPropertySheet> prop_sheet = new ItemPropertySheet();
	prop_sheet->m_auto_open_st_list = auto_open_st_list;
	prop_sheet->m_fill_def_value = fill_def_value;
	
	prop_sheet->m_rose_item = item;

	PSMap::iterator f = s_ps_map.find(get_rose_element_uid(item));
	if (f != s_ps_map.end()) {
		f->second->BringWindowToTop();
		return RoseHelper::ER_EDIT_OK;
	} else {
		s_ps_map[get_rose_element_uid(item)] = prop_sheet.ptr();

		prop_sheet->AddPage(&prop_sheet->m_PageStd);

		AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (RoseHelper::get_gen_stereotype(item));

		if (tpl.user_properties_group.is_nil () == false) {
			prop_sheet->AddPage(&prop_sheet->m_Page1);
		}

		if (
			ACE_OS::strncmp (
				static_cast<const char*>(item->GetPropertyValue (TOOL_NAME, Base::IS_OVERRIDEN_WRAPPER))
				, "true"
				, ACE_OS::strlen ("true")
			) != 0
		) {
			//если элемент - не обертка для переопределяемого элемента - добавляем дополнительные вкладки
			if (tpl.has_get_except || tpl.has_set_except) {
				prop_sheet->AddPage(&prop_sheet->m_Page2);	
			}

			if (item->IsClass(CLASS_TYPE) || item->IsClass(CATEGORY_TYPE)) {			
				prop_sheet->AddPage(&prop_sheet->m_Page3);
			}

			if (tpl.has_derived_impl) {
				prop_sheet->AddPage(&prop_sheet->m_Page4);
			}

			if (item->IsClass(CLASS_TYPE) || item->IsClass(CATEGORY_TYPE)) {
				prop_sheet->AddPage(&prop_sheet->m_Page5);
			}

			if (tpl.main_st || item->GetContext()->IsClass (MODEL_TYPE)) {
				prop_sheet->AddPage(&prop_sheet->m_Page6);
			}

			if (RoseHelper::get_is_native_with_parent(item)) {
				prop_sheet->AddPage(&prop_sheet->m_Page7);
			}
		}
		
		std::string caption = "Property of: ";
		if (item->GetStereotype() != _bstr_t("")) {
			caption += "<<";
			caption += (const char*)item->GetStereotype();
			caption += ">>";
		}
		
		IRoseElementPtr context = RoseHelper::get_context (item);
		caption += context ? (const char*)context->GetName() : "";
		caption += "::";

		if (item->GetName() != _bstr_t ("")) {
			caption += (const char*)item->GetName();
		} else {
			caption += (const char*)item->IdentifyClass();
		}
				
		prop_sheet->SetTitle (caption.data());
		
		//DWORD dwThreadId;
		//prop_sheet->m_thread = CreateThread(NULL, 0, ShitSheetThreadFunc, prop_sheet, 0, &dwThreadId);
		if (prop_sheet->DoModal () == IDOK) {
			return prop_sheet->m_specific_result;
		} else {
			return RoseHelper::ER_CANCEL;
		}
		//return prop_sheet->m_thread != NULL;
	}
}

//#UC END# *457417C60177*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ItemPropertySheet::ItemPropertySheet ()
	: WinGUI::ETSLayoutPropertySheet ("")
//#UC START# *457417C60177_CTOR_BASE_INIT*
//#UC END# *457417C60177_CTOR_BASE_INIT*
{
	//#UC START# *457417C60177_CTOR*
	m_specific_result = RoseHelper::ER_EDIT_OK;
	m_thread = 0;
	m_auto_open_st_list = false;
	m_fill_def_value = false;
	//#UC END# *457417C60177_CTOR*
}


ItemPropertySheet::~ItemPropertySheet () {
	//#UC START# *457417C60177_DESTR_BODY*
	if (m_rose_item) {
		s_ps_map.erase(get_rose_element_uid(m_rose_item));
	}
	if (m_thread) {
		CloseHandle (m_thread);
	}
	//#UC END# *457417C60177_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(ItemPropertySheet, WinGUI::ETSLayoutPropertySheet)
	ON_WM_CREATE()
	//#UC START# *457417C60177_MESSAGE_MAP*
	//#UC END# *457417C60177_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(ItemPropertySheet, CPropertySheet)

void ItemPropertySheet::DoDataExchange(CDataExchange* pDX) {
	CPropertySheet::DoDataExchange(pDX);
	//#UC START# *457417C60177_DO_DATA_EXCHANGE*
	//#UC END# *457417C60177_DO_DATA_EXCHANGE*
}

BOOL ItemPropertySheet::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutPropertySheet::OnInitDialog();
	try {
		//#UC START# *457417C60177_ON_INIT_DLG*
		if (m_rose_item) {
			MDPSupport::CatLockerFacade_var clf = 
				MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)m_rose_item);

			CString caption;
			this->GetWindowText (caption);
			
			bool is_virtual = (
				IsVirtualFactory::get ().execute (m_rose_item)
				&& ACE_OS::strncmp (
					static_cast<const char*> (m_rose_item->GetPropertyValue (TOOL_NAME, Base::IS_OVERRIDEN_WRAPPER))
					, "true"
					, ACE_OS::strlen ("true")
				) != 0
			);

			if (false == clf->can_change () || is_virtual) {
				caption += " (read-only)";
				CWnd* button_wnd = GetDlgItem (IDOK);
				button_wnd->EnableWindow (false);

				button_wnd = GetDlgItem (ID_APPLY_NOW);
				button_wnd->EnableWindow (false);
			}

			if (is_virtual) {
				caption.Insert (0, "(virtual) ");
			}
			this->SetTitle (caption);
		}
		//#UC END# *457417C60177_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"ItemPropertySheet\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int ItemPropertySheet::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutPropertySheet::OnCreate (create_struct);
}

void ItemPropertySheet::init_constraint () {
	//#UC START# *457417C60177_CUSTOM_CONTROLS_CONSTRAINT*
	//#UC END# *457417C60177_CUSTOM_CONTROLS_CONSTRAINT*
}


// возвращает страницу "Native Paths"
const IppNative& ItemPropertySheet::get_native_page () const {
	//#UC START# *47C40DE20396*
	return m_Page7;
	//#UC END# *47C40DE20396*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

RoseHelper::ExecResult ItemPropertySheet::get_specific_result () const {
	//#UC START# *4575862E01A2_GET_ACCESSOR*
	return m_specific_result;
	//#UC END# *4575862E01A2_GET_ACCESSOR*
}

void ItemPropertySheet::set_specific_result (RoseHelper::ExecResult specific_result) {
	//#UC START# *4575862E01A2_SET_ACCESSOR*
	m_specific_result = specific_result;
	//#UC END# *4575862E01A2_SET_ACCESSOR*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

