////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppUserProp.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppUserProp
//
// страница для работы с юзер-свойствами элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppUserProp.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/MDAGui/StCollection.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppUserProp.h"
#include "shared/GCL/str/str_op.h"

//#UC START# *4574175201B5_CUSTOM_INCLUDES*
#include <boost/lexical_cast.hpp>
//#UC END# *4574175201B5_CUSTOM_INCLUDES*


//#UC START# *4574175201B5*
#define WM_BT_CLIKED (WM_USER + 1)

/*void IppUserProp::OnBnClickedButton3() {
	StCollection st (this->get_rose_item());
	st.DoModal ();	
}*/
void IppUserProp::on_tree_item_changed (NMHDR* pNotifyStruct, LRESULT* plResult) {
	// Declare variables
	LPNMOPTIONTREE pNMOptionTree = (LPNMOPTIONTREE) pNotifyStruct;

	if (pNMOptionTree != NULL && pNMOptionTree->otiItem != NULL) {
		CString value_text;
		if (pNMOptionTree->otiItem->GetItemType () == OT_ITEM_3STATECHECKBOX) {
			WinGUI::COptionTree3StateCheckBox* check_box = dynamic_cast<WinGUI::COptionTree3StateCheckBox*> (
				pNMOptionTree->otiItem
			);
			if (check_box->get_state () == true) {
				value_text = "true";
			} else if (check_box->get_state () == false) {
				value_text = "false";
			} else {
				value_text = "undefined";
			}
		} else if (pNMOptionTree->otiItem->GetItemType () == OT_ITEM_CHECKBOX) {
			WinGUI::COptionTreeItemCheckBox* check_box = dynamic_cast<WinGUI::COptionTreeItemCheckBox*> (
				pNMOptionTree->otiItem
			);
			if (check_box->GetCheck () == TRUE) {
				value_text = "true";			
			} else {
				value_text = "false";
			}
		} else if (pNMOptionTree->otiItem->GetItemType () == OT_ITEM_COLOR) {
			WinGUI::COptionTreeItemColor* color_item = dynamic_cast<WinGUI::COptionTreeItemColor*> (
				pNMOptionTree->otiItem
			);
			COLORREF color = color_item->GetColor ();
			char color_str[64] = {};
			_ultoa (color, color_str, 10);
			value_text = color_str;
		} else if (pNMOptionTree->otiItem->GetItemType () == OT_ITEM_FILE) {
			WinGUI::COptionTreeItemFile* file = dynamic_cast<WinGUI::COptionTreeItemFile*> (pNMOptionTree->otiItem);
			value_text = file->GetPathName ();
			std::string str (value_text);
			GCL::str_replace (str, "\\", "/");
			value_text = str.c_str ();
		} else if (
			pNMOptionTree->otiItem->GetItemType () == OT_ITEM_EDIT
			|| pNMOptionTree->otiItem->GetItemType () == OT_ITEM_COMBOBOX
		) {
			value_text = pNMOptionTree->otiItem->GetAttributeText ();
			value_text.Replace ("\r\n", "\n");
		}
		IRoseItemPtr item = this->get_rose_item();

		AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);

		CString name = pNMOptionTree->otiItem->GetLabelText ();

		const AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (stereotype);
	
		if (tpl.user_properties_group.is_nil () == false) {
			AbstractDumperBase::UserPropertyMap props;
			tpl.user_properties_group->for_each (
				AbstractDumperBase::CollectUserProperty ()
				, props
			);
			AbstractDumperBase::UserPropertyMap::iterator f = props.find ((LPCTSTR)name);
			if (f != props.end ()) {			
				CString def_value = f->second.def_value.c_str ();

				if (
					value_text != def_value
				) {
					pNMOptionTree->otiItem->AddButton (_D_BT_DEFAULT);
				} else {
					pNMOptionTree->otiItem->DeleteButton (_D_BT_DEFAULT);
				}
			}
		}
	}
	//return 0;
}

LRESULT IppUserProp::on_def_prop_btn_clicked (WPARAM wParam, LPARAM lParam) {
	WinGUI::COptionTreeItem* item = reinterpret_cast<WinGUI::COptionTreeItem*> (lParam);
	if (item != 0) {
		if (wParam == _D_BT_DEFAULT) {
			this->restore_up (item);			
			return S_OK;
		}
	}
	return S_FALSE;
}


bool IppUserProp::on_ok (bool& need_colorize) {
	IRoseItemPtr item = this->get_rose_item();

	need_colorize = false;

	// save properties to model
	for (std::vector<Property>::iterator it = m_properties_list.begin(); it != m_properties_list.end(); it++) {			
		CString name_text = it->item->GetLabelText ();		
		CString value_text = it->item->GetAttributeText ();

		if (it->item->GetItemType () == OT_ITEM_3STATECHECKBOX) {
			WinGUI::COptionTree3StateCheckBox* check_box = dynamic_cast<WinGUI::COptionTree3StateCheckBox*> (
				it->item
			);
			if (check_box->get_state() == true) {
				value_text = "true";
			} else if (check_box->get_state() == false) {
				value_text = "false";
			} else {
				value_text = "undefined";
			}
		} else if (it->item->GetItemType () == OT_ITEM_CHECKBOX) {
			WinGUI::COptionTreeItemCheckBox* check_box = dynamic_cast<WinGUI::COptionTreeItemCheckBox*> (
				it->item
			);
			if (check_box->GetCheck() == TRUE) {
				value_text = "true";
			} else {
				value_text = "false";
			}
		} else if (it->item->GetItemType () == OT_ITEM_COLOR) {
			WinGUI::COptionTreeItemColor* color_item = dynamic_cast<WinGUI::COptionTreeItemColor*> (
				it->item
			);
			COLORREF color = color_item->GetColor ();
			if (color != OT_COLOR_NO_SELECTION) {
				char color_str[64] = {};
				_ultoa (color, color_str, 10);
				value_text = color_str;
			}
		} else if (it->item->GetItemType () == OT_ITEM_FILE) {
			value_text = it->item->GetAttributeText ();
			std::string str (value_text);
			value_text = GCL::str_replace (str, "\\", "/").c_str ();
		} else if (
			it->item->GetItemType () == OT_ITEM_EDIT
			|| it->item->GetItemType () == OT_ITEM_COMBOBOX
		) {
			value_text = it->item->GetAttributeText ();
			const char replacer[] = {ROSE_NEWLINE_REPLACEMENT, '\0'};
			value_text.Replace ("\r\n", replacer);
		} else {
			GDS_ASSERT_MSG (false, ("Unknown property type: %d", it->item->GetItemType ()));
		}

		need_colorize |= RoseHelper::override_property(item, Base::USER_PROPERTY_TOOL, (LPCTSTR)name_text, (LPCTSTR)value_text);
		if (need_colorize) {
			AbstractDumperBase::s_need_run_spell = true;
		}
	}
	return true;
}

void IppUserProp::restore_up (WinGUI::COptionTreeItem* prop_item) {
	GDS_ASSERT(prop_item)

	IRoseItemPtr item = this->get_rose_item();

	AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);

	CString name = prop_item->GetLabelText ();
	const AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (stereotype);
	
	if (tpl.user_properties_group.is_nil () == false) {
		AbstractDumperBase::UserPropertyMap props;
		tpl.user_properties_group->for_each (
			AbstractDumperBase::CollectUserProperty ()
			, props
		);
		AbstractDumperBase::UserPropertyMap::iterator f = props.find ((LPCTSTR)name);		
		if (f != props.end ()) {
			if (f->second.type == AbstractDumperBase::UPT_LIST) {
				WinGUI::COptionTreeItemComboBox* combo = dynamic_cast<WinGUI::COptionTreeItemComboBox*> (
					prop_item
				);
				int index = combo->FindStringExact (0, f->second.def_value.data());
				if (index != CB_ERR) {
					combo->SetCurSel (index);
				}
			} else if (f->second.type == AbstractDumperBase::UPT_TRIBOOL) {
				WinGUI::COptionTree3StateCheckBox* check = dynamic_cast<WinGUI::COptionTree3StateCheckBox*> (
					prop_item
				);
				if (f->second.def_value == "true") {
					check->set_state (true);
				} else if (f->second.def_value == "false") {
					check->set_state (false);
				} else {
					check->set_state (boost::indeterminate);
				}
			} else if (f->second.type == AbstractDumperBase::UPT_BOOL) {
				WinGUI::COptionTreeItemCheckBox* check = dynamic_cast<WinGUI::COptionTreeItemCheckBox*> (
					prop_item
				);
				if (f->second.def_value == "true") {
					check->SetCheck (true);
				} else {
					check->SetCheck (false);
				}
			} else if (f->second.type == AbstractDumperBase::UPT_COLOR) {
				WinGUI::COptionTreeItemColor* color_item = dynamic_cast<WinGUI::COptionTreeItemColor*> (
					prop_item
				);
				COLORREF def_colors = OT_COLOR_NO_SELECTION;
				try {
					if (f->second.def_value.empty () == false) {
						def_colors =  boost::lexical_cast<COLORREF> (f->second.def_value);
					}
				} catch (std::exception&) {						
				}
				color_item->SetColor (def_colors);
			} else if (f->second.type == AbstractDumperBase::UPT_STRING || f->second.type == AbstractDumperBase::UPT_TEXT) {
				WinGUI::COptionTreeItemEdit* edit = dynamic_cast<WinGUI::COptionTreeItemEdit*> (
					prop_item
				);

				std::string def_value = f->second.def_value;
				GCL::str_replace (def_value, "\n", "\r\n");
				edit->SetEditText (def_value.data());
			} else if (f->second.type == AbstractDumperBase::UPT_FILE) {
				//COptionTreeItemFileSimple* file = dynamic_cast<COptionTreeItemFileSimple*> (prop_item);
				WinGUI::COptionTreeItemFile* file = dynamic_cast<WinGUI::COptionTreeItemFile*> (
					prop_item
				);
				file->SetFileName (f->second.def_value.data());		
			}
			prop_item->DeleteButton (_D_BT_DEFAULT);
			m_properties.RefreshItem (prop_item);
		}
	}
}
//#UC END# *4574175201B5*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IppUserProp::IppUserProp ()
	: IppBase (IppUserProp::IDD)
//#UC START# *4574175201B5_CTOR_BASE_INIT*
//#UC END# *4574175201B5_CTOR_BASE_INIT*
{
	//#UC START# *4574175201B5_CTOR*
	//#UC END# *4574175201B5_CTOR*
}


IppUserProp::~IppUserProp () {
	//#UC START# *4574175201B5_DESTR_BODY*
	//#UC END# *4574175201B5_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(IppUserProp, IppBase)
	ON_WM_CREATE()
	//#UC START# *4574175201B5_MESSAGE_MAP*
	ON_WM_SIZE()
	ON_MESSAGE(WM_BT_CLIKED, on_def_prop_btn_clicked)
	ON_NOTIFY(OT_NOTIFY_ITEMCHANGED, IDC_STATIC, on_tree_item_changed)
	//#UC END# *4574175201B5_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNCREATE(IppUserProp, CPropertyPage)

void IppUserProp::DoDataExchange(CDataExchange* pDX) {
	CPropertyPage::DoDataExchange(pDX);
	//#UC START# *4574175201B5_DO_DATA_EXCHANGE*	
	//#UC END# *4574175201B5_DO_DATA_EXCHANGE*
}

BOOL IppUserProp::OnInitDialog () {
	BOOL ret = IppBase::OnInitDialog();
	try {
		//#UC START# *4574175201B5_ON_INIT_DLG*
		IRoseItemPtr item = this->get_rose_item();
		
		CRect rcClient;
		GetClientRect(rcClient);
		rcClient.top += 46;
		rcClient.bottom -= 23;
		
		// Setup the window style
		DWORD dwStyle, dwOptions;
		dwStyle = WS_VISIBLE;
		
		// Setup the tree options 
		// OT_OPTIONS_SHOWINFOWINDOW
		dwOptions = OT_OPTIONS_SHADEEXPANDCOLUMN | OT_OPTIONS_SHADEROOTITEMS | OT_OPTIONS_SHOWINFOWINDOW;
		
		// Create tree options
		if (m_properties.Create (dwStyle, rcClient, this, dwOptions, IDC_STATIC) == FALSE) {
			TRACE0("Failed to create options control.\r\n");
			return FALSE;
		}
		m_properties.DeleteAllItems ();
		m_properties_list.clear ();

		// Want to be notified
		m_properties.SetNotify(TRUE, this, WM_BT_CLIKED, false);
		m_properties.SetAutoSizeColumn(false);
		m_properties.SetAttributeOffset(4);
		m_properties.LockAll();
		
		/*WinGUI::COptionTreeItem* root = m_properties.InsertItem(new WinGUI::COptionTreeItem());
		root->SetLabelText(_T("User properties"));
		root->InsertItem(new WinGUI::COptionTreeEditItem());*/
		
		AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);		
		const AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (stereotype);
	
		if (tpl.user_properties_group.is_nil () == false) {
			GUITreePropertyBuilder builder (*(const_cast<IppUserProp*> (this)));
			builder.build (tpl.user_properties_group.in ());			
		}
			
		m_properties.UnLockAll();
		m_properties.ExpandAllItems();
		this->check_for_editable ();
		//#UC END# *4574175201B5_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"IppUserProp\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int IppUserProp::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return IppBase::OnCreate (create_struct);
}

void IppUserProp::init_constraint () {
	//#UC START# *4574175201B5_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot(VERTICAL) << item (&m_properties, GREEDY);
	//#UC END# *4574175201B5_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

