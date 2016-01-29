////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/StCollection.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::StCollection
//
// дилог выводит список доступных стереотипов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/StCollection.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"
#include "MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"

//#UC START# *4574164F0242_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "shared/GCL/str/str_op.h"
#include "StCollection.h"
//#UC END# *4574164F0242_CUSTOM_INCLUDES*


//#UC START# *4574164F0242*
void StCollection::fill_list () {
	m_st_details.DeleteAllItems ();
	unsigned i = 0;

	Helpers::StereotypeManager_var st_mng = Helpers::StereotypeManagerFactory::make ();
	Core::Aptr<Helpers::StereotypeList> stereotypes = st_mng->make_allowable_stereotypes (m_item, m_item_context);

	for (
		Helpers::StereotypeList::const_iterator it = stereotypes->begin ()
		; it != stereotypes->end ()
		; ++it
	) {
		GCL::StrVector parts = GCL::split_string_by_sub_string (it/*->get ()*/->data(), "::");
		
		AbstractDumperBase::Templates::const_iterator tp_it = AbstractDumperBase::find_template (*it);
		if (m_selected_type != "all") {
			if (m_selected_type != tp_it->second.classtype_name) {
				continue;
			}
		}

		int img_id;
		if (parts.size() == 2) { // class or categories (MySt::Class)
			std::string s = parts[0];			

			if (parts[1] == CLASS_TYPE) {
				img_id = 1;
			} else {
				img_id = 0;
			}

			if (
				!RoseHelper::is_it_available_by_type (m_item, m_item_context, tp_it->first) 
				|| !RoseHelper::is_it_available_by_constr (m_item, m_item_context, tp_it->first)
			) {
				if (!m_show_all.GetCheck()) {
					continue;
				}
				img_id += 2;				
			}			

			m_st_details.InsertItem (i, s.data());

			m_st_details.SetItem (i, 0, LVIF_IMAGE, 0, img_id, 0, 0, 0);
			//m_st_details.SetItemText (i, 1, parts[1].data());
			m_st_details.SetItemText (i, 1, tp_it->second.st_description_header/*.get ()*/.data());
			
			const AbstractDumperBase::Templates::value_type* vt = &(*tp_it);
			m_st_details.SetItemData (i, (DWORD)vt);

			++i;
		} else if (parts.size() == 4) { // like Interface::Class::factory::Operation 
			                            //   or Interface::Class::Operation::Parameter :((
						                //   or Interface::Class::Parameter::Parameter :((
			if (parts[2] == "Operation") {
				continue;
			}

			std::string s = parts[2];
			s += "::";
			s += parts[0];

			if (parts[3] == "Operation") {
				img_id = 5;
			} else if (parts[3] == "Attribute") {
				img_id = 4;
			} else {
				img_id = 6;
			}

			if (
				!RoseHelper::is_it_available_by_type (m_item, m_item_context, tp_it->first) 
				|| !RoseHelper::is_it_available_by_constr (m_item, m_item_context, tp_it->first)
			) {
				if (!m_show_all.GetCheck()) {
					continue;
				}
				img_id += 3;
			}

			m_st_details.InsertItem (i, s.data());

			m_st_details.SetItem (i, 0, LVIF_IMAGE, 0, img_id, 0, 0, 0);
			m_st_details.SetItemText (i, 1, tp_it->second.st_description_header/*.get ()*/.data());
		
			const AbstractDumperBase::Templates::value_type* vt = &(*tp_it);
			m_st_details.SetItemData (i, (DWORD)vt);

			++i;			
		} else if (parts.size() == 3) { // unstereotyped ops and attrs 
			                            //  like Interface::Class::Operation, Interface::Class::Operation
			                            //  like Interface::Class::Parameter, Interface::Class::ClassDependency
			std::string s = "<default>";
			s += "::";
			s += parts[0];

			if (parts[2] == "Operation") {
				img_id = 5;
			} else if (parts[2] == "Attribute") {
				img_id = 4;
			} else {
				img_id = 6;
			}

			if (
				!RoseHelper::is_it_available_by_type (m_item, m_item_context, tp_it->first) 
				|| !RoseHelper::is_it_available_by_constr (m_item, m_item_context, tp_it->first)
				) {
				if (!m_show_all.GetCheck()) {
					continue;
				}
				img_id += 3;
			}

			m_st_details.InsertItem (i, s.data());

			m_st_details.SetItem (i, 0, LVIF_IMAGE, 0, img_id, 0, 0, 0);
			m_st_details.SetItemText (i, 1, tp_it->second.st_description_header/*.get ()*/.data());
		
			const AbstractDumperBase::Templates::value_type* vt = &(*tp_it);
			m_st_details.SetItemData (i, (DWORD)vt);

			++i;			
		}
	}

	
	std::string st;
	if (m_item) {
		st = (char*)m_item->Stereotype;	
		if (st == "") {
			st = "<default>";
		}
	}
	
	m_st_details.SetFocus ();
	if (st != "") {
		if (!m_item->IsClass(CATEGORY_TYPE) && !m_item->IsClass(CLASS_TYPE)) {
			st += "::";
			IRoseItemPtr item_context = RoseHelper::get_context(m_item);			
			st += item_context ? (char*)item_context->Stereotype : "";
		}

		LVFINDINFO query;
		query.flags = LVFI_STRING;			
		query.psz = st.data();
		int ind = m_st_details.FindItem (&query);
		m_st_details.SetItemState (ind, LVIS_SELECTED | LVIS_FOCUSED, LVIS_SELECTED | LVIS_FOCUSED);
		m_st_details.SetSelectionMark (ind);
		m_st_details.EnsureVisible(ind, false);

		this->fill_info(ind);
	} else {
		if (m_st_details.GetItemCount () > 0) {
			m_st_details.SetItemState (0, LVIS_SELECTED | LVIS_FOCUSED, LVIS_SELECTED | LVIS_FOCUSED);
			m_st_details.EnsureVisible(0, false);
			m_st_details.SetSelectionMark (0);
			this->fill_info(0);
		}
	}
}

// StCollection message handlers

static const char ENTER[3] = {13, 10, 0};

void StCollection::fill_info (int index) {	
	if (index >=0 ) {
		const AbstractDumperBase::Templates::value_type* vt = (const AbstractDumperBase::Templates::value_type*)m_st_details.GetItemData (index);
		
		if (!RoseHelper::is_it_available_by_type (m_item, m_item_context, vt->first) || !RoseHelper::is_it_available_by_constr (m_item, m_item_context, vt->first)) {
			m_ok.EnableWindow(false);
		} else {
			m_ok.EnableWindow(true);
		}

		std::string desc = vt->second.st_description_header;
		desc += ENTER;
		desc += ENTER;
		std::string description = vt->second.st_description;
		GCL::str_replace (description, "\n", ENTER);
		desc += description;

		if (vt->second.user_properties_group.is_nil () == false) {
			AbstractDumperBase::UserPropertyMap props;
			vt->second.user_properties_group->for_each (
				AbstractDumperBase::CollectUserProperty ()
				, props
			);
			if (props.size () > 0) {
				desc += ENTER;
				desc += ENTER;
				desc += "Has User Property:";
				desc += ENTER;
				for (
					AbstractDumperBase::UserPropertyMap::const_iterator it = props.begin()
					; it != props.end()
					; it++
				) {
					desc += "\t";
					desc += it->first;
					desc += " - ";
					desc += it->second.description;
					desc += ENTER;
				}
			}
		}

		if (vt->second.child_st_constraints.size() != 0) {
			desc += ENTER;
			desc += ENTER;
			if (vt->second.child_st_constarint_type == AbstractDumperBase::CSCT_EXCLUDED) {
				desc += "Can contain any stereotypes, exclude:";
			} else {
				desc += "Can contain only stereotypes:";
			}
			desc += ENTER;

			for (
				GCL::StrSet::const_iterator it = vt->second.child_st_constraints.begin ()
				; it != vt->second.child_st_constraints.end ()
				; ++it
			) {
				desc += "\t";
				desc += it->c_str ();
				desc += ENTER;
			}
		}

		{ // fill "Can be inserted in"
			//std::string can_be_inserted_in;
			desc += ENTER;
			desc += "Can be used inside:";
			desc += ENTER;

			GCL::StrVector parts = GCL::split_string_by_sub_string (vt->first/*.get ()*/.data(), "::");
			if (parts.size() > 2) {
				desc += "\t";
				desc += parts[0];
				desc += "::";
				desc += parts[1];
				desc += ENTER;
			} else {
				for (
					AbstractDumperBase::Templates::const_iterator it = AbstractDumperBase::templates_begin ()
					; it != AbstractDumperBase::templates_end ()
					; it ++
				) {
					bool can;
					GCL::StrVector it_parts = GCL::split_string_by_sub_string (it->first/*.get ()*/.data(), "::");

					if (it_parts.size() != 2) {
						continue;
					}					

					if (it->second.child_st_constraints.size() == 0) {
						can = true;
					} else {
						can = it->second.child_st_constarint_type != AbstractDumperBase::CSCT_INCLUDED;
						for (
							GCL::StrSet::const_iterator it2 = it->second.child_st_constraints.begin ()
							; it2 != it->second.child_st_constraints.end ()
							; ++it2
						) {
							GCL::StrVector constr_parts = GCL::split_string_by_sub_string (it2->data(), "::");
							if (constr_parts[1] == parts[1]) {
								if (it->second.child_st_constarint_type == AbstractDumperBase::CSCT_INCLUDED) {
									if (constr_parts[0] == "*") {
										can = true;
										break;
									} else {
										if (constr_parts[0] == parts[0]) {;
											can = true;
											break;
										}
									}
								} else {
									if (constr_parts[0] == "*") {
										can = false;
										break;
									} else {
										if (constr_parts[0] == parts[0]) {
											can = false;
											break;
										}
									}
								}
							} 
						}
					}

					if (can) {
						desc += "\t";
						desc += it_parts[0];
						desc += "::";
						desc += it_parts[1];
						desc += ENTER;
					}
				}
			}
		}

		m_description.SetWindowText (desc.data());
	} else {		
		if (!m_forsed_show_all && !m_show_all.GetCheck()) {
			m_show_all.SetCheck(true);
			this->fill_list();
			m_forsed_show_all = true;
		} else {
			m_ok.EnableWindow(false);
			m_description.SetWindowText ("INVALID STEREOTYPE");
		}
	}
}

void StCollection::OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	int selection = m_st_details.GetSelectionMark();
	if (selection >= 0) {
		this->fill_info (selection);
	}
}

void StCollection::OnBnClickedCheck1()
{
	this->fill_list ();
}

void StCollection::OnBnClickedOk() {
	int selection = m_st_details.GetSelectionMark();
	if (selection >= 0) {
		const AbstractDumperBase::Templates::value_type* vt = (const AbstractDumperBase::Templates::value_type*)m_st_details.GetItemData (selection);
		m_result = vt->first;

		OnOK();
	}
}

void StCollection::OnHdnItemdblclickList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMHEADER phdr = reinterpret_cast<LPNMHEADER>(pNMHDR);
	this->OnBnClickedOk ();
	*pResult = 0;
}

void StCollection::OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	this->OnBnClickedOk ();
	*pResult = 0;
}

void StCollection::OnBnClickedAllRb() {
	if (m_selected_type != "all") {
		m_selected_type = "all";
		this->fill_list();
	}
}

void StCollection::OnBnClickedCatRb() {
	if (m_selected_type != "Category") {
		m_selected_type = "Category";
		this->fill_list();
	}
}

void StCollection::OnBnClickedClassRb() {
	if (m_selected_type != "Class") {
		m_selected_type = "Class";
		this->fill_list();
	}
}

void StCollection::OnBnClickedAttrRb() {
	if (m_selected_type != "Attribute") {
		m_selected_type = "Attribute";
		this->fill_list();
	}
}

void StCollection::OnBnClickedOpRb() {
	if (m_selected_type != "Operation") {
		m_selected_type = "Operation";
		this->fill_list();
	}	
}
//#UC END# *4574164F0242*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StCollection::StCollection (
	IRoseItemPtr item
	, IRoseItemPtr item_context
) :
	WinGUI::ETSLayoutDialog (StCollection::IDD)
//#UC START# *458E8D670018_BASE_INIT*
	, m_item (item)
	, m_item_context (item_context)
	, m_forsed_show_all (true)
	, m_selected_type ("all")
//#UC END# *458E8D670018_BASE_INIT*
{
	//#UC START# *458E8D670018_BODY*
	if ((m_item != 0 ) && (m_item_context == 0)) {
		m_item_context = RoseHelper::get_context (item);
	}
	//#UC END# *458E8D670018_BODY*
}

StCollection::~StCollection () {
	//#UC START# *4574164F0242_DESTR_BODY*
	//#UC END# *4574164F0242_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(StCollection, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *4574164F0242_MESSAGE_MAP*
	ON_NOTIFY(NM_CLICK, IDC_LIST1, OnNMClickList1)
	ON_BN_CLICKED(IDC_CHECK1, OnBnClickedCheck1)
	ON_BN_CLICKED(IDOK, OnBnClickedOk)
	ON_NOTIFY(HDN_ITEMDBLCLICK, 0, OnHdnItemdblclickList1)
	ON_NOTIFY(NM_DBLCLK, IDC_LIST1, OnNMDblclkList1)
	ON_BN_CLICKED(IDC_ALL_RB, OnBnClickedAllRb)
	ON_BN_CLICKED(IDC_CAT_RB, OnBnClickedCatRb)
	ON_BN_CLICKED(IDC_CLASS_RB, OnBnClickedClassRb)
	ON_BN_CLICKED(IDC_ATTR_RB, OnBnClickedAttrRb)
	ON_BN_CLICKED(IDC_OP_RB, OnBnClickedOpRb)
	//#UC END# *4574164F0242_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(StCollection, CDialog)

void StCollection::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *4574164F0242_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_LIST1, m_st_details);
	DDX_Control(pDX, IDC_EDIT1, m_description);
	DDX_Control(pDX, IDC_CHECK1, m_show_all);
	DDX_Control(pDX, IDOK, m_ok);
	DDX_Control(pDX, IDC_ALL_RB, m_all_rb);
	DDX_Control(pDX, IDC_CAT_RB, m_cat_rb);
	DDX_Control(pDX, IDC_CLASS_RB, m_class_rb);
	DDX_Control(pDX, IDC_ATTR_RB, m_attr_rb);
	DDX_Control(pDX, IDC_OP_RB, m_op_rb);
	//#UC END# *4574164F0242_DO_DATA_EXCHANGE*
}

BOOL StCollection::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *4574164F0242_ON_INIT_DLG*	
		m_il = new CImageList ();
		m_il->Create (IDB_BITMAP1, 22, 2, 16);
		m_st_details.SetImageList (m_il.in(), LVSIL_SMALL);

		m_st_details.InsertColumn (0, "Stereotype", LVCFMT_LEFT, 150 );
		//	m_st_details.InsertColumn (1, "Type", LVCFMT_LEFT, 100 );
		m_st_details.InsertColumn (1, "Quick description", LVCFMT_LEFT, 450 );		

		if (m_item != 0) {
			if (m_item->IsClass(CATEGORY_TYPE)) {
				m_cat_rb.SetCheck(true);
				m_all_rb.EnableWindow(false);
				m_class_rb.EnableWindow(false);
				m_attr_rb.EnableWindow(false);
				m_op_rb.EnableWindow(false);
			} else if (m_item->IsClass(CLASS_TYPE)) {
				m_class_rb.SetCheck(true);
				m_all_rb.EnableWindow(false);
				m_cat_rb.EnableWindow(false);
				m_attr_rb.EnableWindow(false);
				m_op_rb.EnableWindow(false);
			} else if (m_item->IsClass(ATTRIBUTE_TYPE) || m_item->IsClass("Role")) {
				m_attr_rb.SetCheck(true);
				m_all_rb.EnableWindow(false);
				m_cat_rb.EnableWindow(false);
				m_class_rb.EnableWindow(false);
				m_op_rb.EnableWindow(false);
			} else if (m_item->IsClass(OPERATION_TYPE)) {
				m_op_rb.SetCheck(true);
				m_all_rb.EnableWindow(false);
				m_cat_rb.EnableWindow(false);
				m_attr_rb.EnableWindow(false);
				m_class_rb.EnableWindow(false);
			} else {
				m_all_rb.SetCheck(true);
				m_op_rb.EnableWindow(false);
				m_cat_rb.EnableWindow(false);
				m_attr_rb.EnableWindow(false);
				m_class_rb.EnableWindow(false);
			}
		} else {
			if (m_selected_type == "Category") {
				m_cat_rb.SetCheck (true);
			} else if (m_selected_type == "Class") {
				m_class_rb.SetCheck (true);
			} else if (m_selected_type == "Attribute") {
				m_attr_rb.SetCheck (true);
			} else if (m_selected_type == "Operation") {
				m_op_rb.SetCheck (true);
			} else {
				m_all_rb.SetCheck (true);
			}
			if (m_item_context != 0) {
				if (m_item_context->IsClass(CATEGORY_TYPE)) {
					m_attr_rb.EnableWindow(false);
					m_op_rb.EnableWindow(false);
				} else if (m_item_context->IsClass(CLASS_TYPE)) {
					m_cat_rb.EnableWindow(false);
				} else if (m_item_context->IsClass(ATTRIBUTE_TYPE) || m_item->IsClass("Role")) {
					m_attr_rb.EnableWindow(false);
					m_op_rb.EnableWindow(false);
					m_cat_rb.EnableWindow(false);
					m_class_rb.EnableWindow(false);
				} else if (m_item_context->IsClass(OPERATION_TYPE)) {
					m_attr_rb.EnableWindow(false);
					m_op_rb.EnableWindow(false);
					m_cat_rb.EnableWindow(false);
					m_class_rb.EnableWindow(false);
				} else {
					m_attr_rb.EnableWindow(false);
					m_op_rb.EnableWindow(false);
					m_cat_rb.EnableWindow(false);
					m_class_rb.EnableWindow(false);
				}
			}
		}

		this->fill_list ();
		//#UC END# *4574164F0242_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"StCollection\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int StCollection::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void StCollection::init_constraint () {
	//#UC START# *4574164F0242_CUSTOM_CONTROLS_CONSTRAINT*
	const int distance = 2;
	CPane radioPane = pane(HORIZONTAL)
		<< item(IDC_ST_LABEL, NORESIZE)
		<< itemFixed (HORIZONTAL, distance*2)
		<< item( IDC_ALL_RB, NORESIZE)
		<< itemFixed (HORIZONTAL, distance)
		<< item( IDC_CAT_RB, NORESIZE)
		<< itemFixed (HORIZONTAL, distance)
		<< item( IDC_CLASS_RB, NORESIZE)
		<< itemFixed (HORIZONTAL, distance)
		<< item( IDC_ATTR_RB, NORESIZE)
		<< itemFixed (HORIZONTAL, distance)
		<< item( IDC_OP_RB, NORESIZE)
		<< itemGrowing (HORIZONTAL)
		<< item( IDC_CHECK1, NORESIZE | ALIGN_RIGHT)		
		;

	
	CreateRoot(VERTICAL)
		<< radioPane
		<< itemFixed (VERTICAL, 2)
		<< item (IDC_LIST1, GREEDY )
		<< item (IDC_DESC_LABEL, NORESIZE)
		<< item (IDC_EDIT1, GREEDY)
		<< itemFixed (VERTICAL, 2)
		<<	(pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< itemGrowing (HORIZONTAL)
				<< item( IDOK, NORESIZE )
				<< item( IDCANCEL, NORESIZE )
		);	
	//#UC END# *4574164F0242_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

