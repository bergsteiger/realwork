////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/AdvancedSearch.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::AdvancedSearch
//
// диалог расширенного поиска элементов в модели, позволяет искать по элементы по имени, классу,
// стереотипу, и т.д
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/AdvancedSearch.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "shared/GCL/str/str_op.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"

//#UC START# *4573E7840177_CUSTOM_INCLUDES*
#include "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "shared/GCL/str/str_op.h"
//#UC END# *4573E7840177_CUSTOM_INCLUDES*


//#UC START# *4573E7840177*
/*namespace RoseHelper {
	RoseHelper::TemplatesSet get_available_parent_by_constr_cached (
		const AbstractDumperBase::Templates::key_type& key_child
		, const AbstractDumperBase::Templates::value_type& child
	) {
		RoseHelper::AvailableParentByConstrMap::iterator f = RoseHelper::get_available_parent_by_constr_map ().find (key_child);
		if (f == RoseHelper::get_available_parent_by_constr_map ().end ()) {
			f = RoseHelper::get_available_parent_by_constr_map ().insert (
				RoseHelper::AvailableParentByConstrMap::value_type (
					key_child
					, RoseHelper::get_available_parent_by_constr (key_child, child)
				)
			).first;
		}
		return f->second;
	}
}*/

int get_column_index(CListCtrl& list, const char* name) {
	char buf[128];
	int count = list.GetHeaderCtrl()->GetItemCount();
	LVCOLUMN info;
	info.mask = LVCF_TEXT;
	info.pszText = buf;
	info.cchTextMax = 128;
	for (int i = 0; i < count; i++) {
		list.GetColumn (i, &info);
		if (!strcmp (info.pszText, name)) {
			return i;
		}
	}
	return -1;
}

void AdvancedSearch::fill_st_list () {
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif

	m_self_st_set.clear ();
	m_content_st_set.clear ();
	m_parent_st_set.clear ();
	m_g_parent_st_set.clear ();

	m_self_st.ResetContent();
	m_parent_st.ResetContent();
	m_g_parent_st.ResetContent();
	m_content_st.ResetContent();

	m_self_st_set.insert("");
	m_parent_st_set.insert("");
	m_g_parent_st_set.insert("");
	m_content_st_set.insert("");
	
	m_up_name_1.ResetContent();
	m_up_name_2.ResetContent();
	m_up_name_3.ResetContent();
	m_up_name_4.ResetContent();
	m_up_name_1.AddString("");
	m_up_name_2.AddString("");
	m_up_name_3.AddString("");
	m_up_name_4.AddString("");
	
	for (
		AbstractDumperBase::Templates::const_iterator it = AbstractDumperBase::templates_begin ()
		; it != AbstractDumperBase::templates_end ()
		; it ++
	) {
		if (
			m_cat.GetCheck () && it->second.classtype_name == "Category"
			|| m_class.GetCheck () && it->second.classtype_name == "Class"
			|| m_op.GetCheck () && it->second.classtype_name == "Operation"
			|| m_attr.GetCheck () && it->second.classtype_name == "Attribute"
			|| m_dep.GetCheck () && it->second.classtype_name == "ClassDependency"
		) {
			/*if (m_self_st.FindString(0, it->second.stereotype_name.data()) == CB_ERR) {
				m_self_st.AddString (it->second.stereotype_name.data());							
			}*/
			m_self_st_set.insert (it->second.stereotype_name);
			this->fill_up_list (it->second);

			RoseHelper::TemplatesSet av_par = RoseHelper::get_available_parent_by_constr (it->first, *it);

			for (RoseHelper::TemplatesSet::iterator it2 = av_par.begin(); it2 != av_par.end(); it2++) {
				/*if (m_parent_st.FindString(0, (*it2)->second.stereotype_name.data()) == CB_ERR) {
					m_parent_st.AddString ((*it2)->second.stereotype_name.data());

					if (m_content_st.FindString(0, (*it2)->second.stereotype_name.data()) == CB_ERR) {
						m_content_st.AddString ((*it2)->second.stereotype_name.data());
					}
				}*/
				if (m_parent_st_set.insert ((*it2)->second.stereotype_name).second == true) {
					m_content_st_set.insert ((*it2)->second.stereotype_name);
				}

				RoseHelper::TemplatesSet av_g_par = RoseHelper::get_available_parent_by_constr ((*it2)->first, **it2);

				for (RoseHelper::TemplatesSet::iterator it3 = av_g_par.begin(); it3 != av_g_par.end(); it3++) {
					/*if (m_g_parent_st.FindString(0, (*it3)->second.stereotype_name.data()) == CB_ERR) {
						m_g_parent_st.AddString ((*it3)->second.stereotype_name.data());

						this->requrcive_fill_content_sts (**it3);
					}*/
					if (m_g_parent_st_set.insert ((*it3)->second.stereotype_name).second == true) {
						this->requrcive_fill_content_sts ((*it3)->first, **it3);
					}
				}
			}
		}
	}
	{
	//Core::GDS::StopWatch sw ("Fill combo's");
	////заполняем списки подготовленными данными
	for (
		GCL::StrSet::const_iterator it = m_parent_st_set.begin ()
		; it != m_parent_st_set.end ()
		; ++it
	) {
		m_parent_st.AddString (it->data ());
	}
	for (
		GCL::StrSet::const_iterator it = m_g_parent_st_set.begin ()
		; it != m_g_parent_st_set.end ()
		; ++it
	) {
		m_g_parent_st.AddString (it->data ());
	}
	for (
		GCL::StrSet::const_iterator it = m_content_st_set.begin ()
		; it != m_content_st_set.end ()
		; ++it
	) {
		m_content_st.AddString (it->data ());
	}
	for (
		GCL::StrSet::const_iterator it = m_self_st_set.begin ()
		; it != m_self_st_set.end ()
		; ++it
	) {
		m_self_st.AddString (it->data ());
	}
	}
}

void AdvancedSearch::requrcive_fill_content_sts (
	const AbstractDumperBase::Templates::key_type& key_child
	, const AbstractDumperBase::Templates::value_type& child
) {
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	if (m_content_st_set.insert (child.second.stereotype_name).second == true) {
		RoseHelper::TemplatesSet av_par = RoseHelper::get_available_parent_by_constr (key_child, child);
		for (RoseHelper::TemplatesSet::iterator it = av_par.begin(); it != av_par.end(); it++) {
			this->requrcive_fill_content_sts ((*it)->first, **it);
		}
	}
	/*if (m_content_st.FindString(0, child.second.stereotype_name.data()) == CB_ERR) {
		m_content_st.AddString (child.second.stereotype_name.data());

		RoseHelper::TemplatesSet av_par = RoseHelper::get_available_parent_by_constr (child);
		for (RoseHelper::TemplatesSet::iterator it = av_par.begin(); it != av_par.end(); it++) {
			this->requrcive_fill_content_sts (**it);
		}
	}*/
}

void AdvancedSearch::fill_up_list (const AbstractDumperBase::Template& tpl) {
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif

	AbstractDumperBase::UserPropertyMap props;
	if (tpl.user_properties_group.is_nil () == false) {		
		tpl.user_properties_group->for_each (
			AbstractDumperBase::CollectUserProperty ()
			, props
		);
	}
	
	for (
		AbstractDumperBase::UserPropertyMap::const_iterator up_it = props.begin()
		; up_it != props.end()
		; up_it++
	) {
		if (m_up_name_1.FindString(0, up_it->first.data()) == CB_ERR) {
			m_up_name_1.AddString (up_it->first.data());
			m_up_name_2.AddString (up_it->first.data());
			m_up_name_3.AddString (up_it->first.data());
			m_up_name_4.AddString (up_it->first.data());
		}
	}	
}

void AdvancedSearch::reset_dlg() {
	m_in_name.SetCheck (true);
	m_in_doc.SetCheck (true);
	m_in_guid.SetCheck (true);
	
	m_cat.SetCheck (true);
	m_class.SetCheck (true);
	m_usecase.SetCheck (true);
	m_op.SetCheck (true);
	m_attr.SetCheck (true);
	m_dep.SetCheck (false);

	// fill by template
	{
		this->fill_st_list ();
	}

	m_up_name_1.Clear();
	m_up_name_2.Clear();
	m_up_name_3.Clear();
	m_up_name_4.Clear();

	m_up_value_1.EnableWindow(false);
	m_up_value_2.EnableWindow(false);
	m_up_value_3.EnableWindow(false);
	m_up_value_4.EnableWindow(false);

	m_public.SetCheck (true);
	m_protected.SetCheck (true);
	m_private.SetCheck (true);
	m_impl.SetCheck (true);
	m_regular.SetCheck (true);
	m_abstract.SetCheck (true);
//	m_inline.SetCheck (true);
	m_final.SetCheck (true);
	m_native.SelectString(0, "All");
	m_parameterized.SelectString(0, "All");
	
	m_result_list.DeleteAllItems();
	m_result_list.EnableWindow (false);

	m_run_spell.SetCheck (true);
}

void AdvancedSearch::OnBnClickedClear() {
	this->reset_dlg ();
}

void AdvancedSearch::on_run() {
	m_result_list.DeleteAllItems();
	m_result_list.EnableWindow (true);
	
	try {
		RoseHelper::check_model_for_changes ();
		bool run_spell = m_run_spell.GetCheck ();

		RoseAbstractDumper::get_model_tree_root(run_spell);	
	} catch (Base::FatalError&) {
		RoseAbstractDumper::has_error (true);
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors (), true);
		if (dlg.DoModal () == IDOK) {
			return;
		}
	} catch (...) {
		RoseAbstractDumper::has_error (true);
		GenSupport::ErrorManagerFactory::get ().error (0, "Неизвестное исключение", GDS_CURRENT_FUNCTION);
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors (), true);
		if (dlg.DoModal () == IDOK) {
			return;
		}
	}

	Query q;
	this->fill_query (q);

	unsigned i = 0;

	int st_ind = get_column_index(m_result_list, "Stereotype");	
	int context_ind = get_column_index(m_result_list, "Context");
	int doc_ind = get_column_index(m_result_list, "Documentation");
	int path_ind = get_column_index(m_result_list, "Path");
	
	int up1_ind = -1;
	int up2_ind = -1;
	int up3_ind = -1;
	int up4_ind = -1;

	if (m_selected_up_view.GetCheck()) {
		m_selected_up_view.SetCheck(false);
		this->OnBnClickedCheck21();
		m_selected_up_view.SetCheck(true);
		this->OnBnClickedCheck21();

		up1_ind = get_column_index(m_result_list, m_upc_name_1.data());
		up2_ind = get_column_index(m_result_list, m_upc_name_2.data());
		up3_ind = get_column_index(m_result_list, m_upc_name_3.data());
		up4_ind = get_column_index(m_result_list, m_upc_name_4.data());
	}
	
	RoseAbstractDumper::auto_locker lck;

	if (RoseAbstractDumper::s_tree) {
		for (
			RoseElementVector::const_iterator items_it = m_items.begin ()
			; items_it != m_items.end ()
			; ++items_it
		) {

			const RoseAbstractDumper* rad_root = RoseAbstractDumper::find_in_tree (items_it->element);
			if (rad_root) {
				for (
					ObjectTreeResolver::ObjectTree::iterator it = RoseAbstractDumper::s_tree->begin()
					; it != RoseAbstractDumper::s_tree->end()
					; it++
				) {
					const ObjectTreeResolver* otr_it = **it;

					//const AbstractDumperBase* adb_it = dynamic_cast<const AbstractDumperBase*>(otr_it);
					const RoseAbstractDumper* rad_it = dynamic_cast<const RoseAbstractDumper*>(otr_it);

					if (!rad_root || rad_it->is_child_of (rad_root)) {
						if (this->is_fit_to_query(q, rad_it)) {
							std::string name (rad_it->get_name_str ());
							if (IsVirtualFactory::get ().execute (rad_it->rose_element ())) {
								name.insert (0, "(virtual) ");
							}

							this->m_result_list.InsertItem (i, name.data());
							
							int img_id = RoseHelper::get_image_index (rad_it->rose_element ());

							if (img_id != -1) {
								this->m_result_list.SetItem (i, 0, LVIF_IMAGE, 0, img_id, 0, 0, 0);
							}			
							this->m_result_list.SetItemData (i, (DWORD)rad_it);

							if (st_ind != -1) {
								this->m_result_list.SetItemText (i, st_ind, rad_it->get_stereotype_str().data());
							}
							if (doc_ind != -1) {
								this->m_result_list.SetItemText (i, doc_ind, rad_it->get_documentation_str().data());
							}
							if (context_ind != -1) {
								const AbstractDumperBase* par = rad_it->parent();
								if (par) {
									this->m_result_list.SetItemText (i, context_ind, par->get_name_str().data());
								} else {
									this->m_result_list.SetItemText (i, context_ind, "MODEL ROOT");
								}
							}
							if (path_ind != -1) {
								const AbstractDumper* par_ad = dynamic_cast<const AbstractDumper*> (rad_it->parent());
								if (par_ad) {
									this->m_result_list.SetItemText (i, path_ind, par_ad->get_full_name().data());
								} else {
									this->m_result_list.SetItemText (i, context_ind, "MODEL ROOT");
								}
							}

							if (up1_ind != -1) {
								this->m_result_list.SetItemText (i, up1_ind, rad_it->get_user_property_str (q.up_name_1).data());
							}
							if (up2_ind != -1) {
								this->m_result_list.SetItemText (i, up2_ind, rad_it->get_user_property_str (q.up_name_2).data());
							}
							if (up3_ind != -1) {
								this->m_result_list.SetItemText (i, up3_ind, rad_it->get_user_property_str (q.up_name_3).data());
							}
							if (up4_ind != -1) {
								this->m_result_list.SetItemText (i, up4_ind, rad_it->get_user_property_str (q.up_name_4).data());
							}

							i++;
						}
					}
				}
			}
		}
	}
}

void AdvancedSearch::fill_query(Query& q) {
	CString str;

	this->m_text_field.GetWindowText (str);	
	q.text = (const char*)str;
	GCL::kill_final_char (q.text, "*");

	q.in_doc = this->m_in_doc.GetCheck();
	q.in_name = this->m_in_name.GetCheck();
	q.in_guid = this->m_in_guid.GetCheck ();

	this->m_self_st.GetWindowText (str);
	q.self_st = (const char*)str;
	
	this->m_parent_st.GetWindowText (str);
	q.parent_st = (const char*)str;

	this->m_g_parent_st.GetWindowText (str);
	q.grand_parent_st = (const char*)str;

	this->m_content_st.GetWindowText (str);
	q.content_st = (const char*)str;

	q.is_cat = this->m_cat.GetCheck();
	q.is_class = this->m_class.GetCheck();
	q.is_usecase = this->m_usecase.GetCheck();
	q.is_op = this->m_op.GetCheck();
	q.is_attr = this->m_attr.GetCheck();
	q.is_dep = this->m_dep.GetCheck();

	q.is_public = this->m_public.GetCheck();
	q.is_private = this->m_private.GetCheck();
	q.is_protected = this->m_protected.GetCheck();
	q.is_impl = this->m_impl.GetCheck();
	
	q.is_regular = this->m_regular.GetCheck();
	q.is_abstract = this->m_abstract.GetCheck();
//	q.is_inline = this->m_inline.GetCheck();
	q.is_final = this->m_final.GetCheck();

	this->m_native.GetWindowText (str);
	q.is_native = (str == "All" || str == "Native");
	q.is_modeled = (str == "All" || str == "Modeled");
	
	this->m_parameterized.GetWindowText (str);
	q.is_parameterized = (str == "All" || str == "Parameterized");
	q.is_not_parameterized = (str == "All" || str == "Not parameterized");
	
	this->m_up_name_1.GetWindowText (str);
	q.up_name_1 = (const char*)str;
	this->m_up_value_1.GetWindowText (str);
	q.up_value_1 = (const char*)str;

	this->m_up_name_2.GetWindowText (str);
	q.up_name_2 = (const char*)str;
	this->m_up_value_2.GetWindowText (str);
	q.up_value_2 = (const char*)str;

	this->m_up_name_3.GetWindowText (str);
	q.up_name_3 = (const char*)str;
	this->m_up_value_3.GetWindowText (str);
	q.up_value_3 = (const char*)str;

	this->m_up_name_4.GetWindowText (str);
	q.up_name_4 = (const char*)str;
	this->m_up_value_4.GetWindowText (str);
	q.up_value_4 = (const char*)str;
}

bool AdvancedSearch::is_fit_to_query(const Query& q, const RoseAbstractDumper* rad) {
	const AbstractDumperBase* adb = static_cast<const AbstractDumperBase*> (rad);
	IRoseElementPtr rad_elem = rad->rose_element();
	if (rad_elem->IsClass (PARAMETER_TYPE)) {
		return false;
	}

	std::string st = adb->get_stereotype_str();
	if (q.self_st != "") {
		if (q.self_st != "<default>" ? q.self_st != st : q.self_st != "") {
			return false;
		}
	}

	if (q.parent_st != "") {
		const AbstractDumperBase* par = adb->parent();
		if (!par || (q.parent_st != "<default>" ? q.parent_st != par->get_stereotype_str() : q.parent_st != "")) {
			return false;
		}
	}

	if (q.grand_parent_st != "") {
		const AbstractDumperBase* par = adb->parent();
		
		if (!par) {
			return false;
		}
		
		const AbstractDumperBase* g_par = par->parent();
		
		if (!g_par || (q.grand_parent_st != "<default>" ? q.grand_parent_st != g_par->get_stereotype_str() : q.grand_parent_st != "")) {
			return false;
		}
	}

	std::string cls_type = adb->get_model_class_str();
	if (!q.is_cat && cls_type == CATEGORY_TYPE) {
		return false;
	}

	if (!q.is_class && (cls_type == CLASS_TYPE && st != "UseCase")) {
		return false;
	}

	if (!q.is_usecase && (cls_type == CLASS_TYPE && st == "UseCase")) {
		return false;
	}

	if (!q.is_op && cls_type == OPERATION_TYPE) {
		return false;
	}

	if (!q.is_attr && cls_type == ATTRIBUTE_TYPE) {
		return false;
	}

	if (!q.is_dep && cls_type == "Dependency") {
		return false;
	}

	ObjectTreeResolver::VisibilityType vt = rad->get_visibility_type();
	if (!q.is_public &&  vt == ObjectTreeResolver::VT_PUBLIC) {
		return false;
	}

	if (!q.is_protected && vt == ObjectTreeResolver::VT_PROTECTED) {
		return false;
	}

	if (!q.is_private && vt == ObjectTreeResolver::VT_PRIVATE) {
		return false;
	}

	if (!q.is_impl && vt == ObjectTreeResolver::VT_IMPL) {
		return false;
	}

	std::string at = adb->get_abstract_str();
	if (!q.is_regular && at == "regular") {
		return false;
	}

	if (!q.is_abstract && at == "abstract") {
		return false;
	}

	if (!q.is_final && at == "final") {
		return false;
	}

	if (!q.is_inline && at == "inline") {
		return false;
	}

	bool b;
	bool native = rad->is_native(b) || st == "UMLPrimitive" || st == "UMLModule";
	if (!q.is_native && native) {
		return false;
	}

	if (!q.is_modeled && !native) {
		return false;
	}

	if (!q.is_parameterized) {		
		if (rad_elem->IsClass (CLASS_TYPE)) {
			IRoseClassPtr cls = rad_elem;
			if (cls->ClassKind->GetName() == _bstr_t ("ParameterizedClass")) {
				return false;
			}
		}
	}

	if (!q.is_not_parameterized) {
		if (rad_elem->IsClass (CLASS_TYPE)) {
			IRoseClassPtr cls = rad_elem;
			if (cls->ClassKind->GetName() != _bstr_t ("ParameterizedClass")) {
				return false;
			}
		} else {
			return false;
		}
	}

	if (q.text != "") {
		bool res = false;

		if (q.in_name) {
			res = (GCL::find_sub_string_nocase (rad_elem->Name, q.text.data()) != 0);
		}

		if (!res && q.in_doc && rad_elem->IsClass (ROSE_ITEM_TYPE)) {
			IRoseItemPtr item = rad_elem;
			res |= (GCL::find_sub_string_nocase (item->Documentation, q.text.data()) != 0);
		}

		if (!res && q.in_guid) {
			res |= (GCL::find_sub_string_nocase (get_rose_element_uid (rad_elem).c_str (), q.text.data()) != 0);
		}
		if (!res) {
			return false;
		}
	}

	if (q.content_st != "") {
		const AbstractDumperBase* par = adb->parent();
		bool ok = false;
		while (par != 0 && ok != true) {
			if (q.parent_st != "<default>" ? q.parent_st == par->get_stereotype_str() : q.parent_st == "") {
				ok = true;
			}
			par = par->parent ();
		}
		if (!ok) {
			return false;
		}
	}
	
	if (q.up_name_1 != "") {
		if (q.up_value_1 != "") {
			if (adb->get_user_property_str(q.up_name_1) != q.up_value_1) {
				return false;
			}
		} else {
			if (adb->get_user_property_str(q.up_name_1) == "") {
				return false;
			}
		}
	}

	if (q.up_name_2 != "") {
		if (q.up_value_2 != "") {
			if (adb->get_user_property_str(q.up_name_2) != q.up_value_2) {
				return false;
			}
		} else {
			if (adb->get_user_property_str(q.up_name_2) == "") {
				return false;
			}
		}
	}

	if (q.up_name_3 != "") {
		if (q.up_value_3 != "") {
			if (adb->get_user_property_str(q.up_name_3) != q.up_value_3) {
				return false;
			}
		} else {
			if (adb->get_user_property_str(q.up_name_3) == "") {
				return false;
			}
		}
	}

	if (q.up_name_4 != "") {
		if (q.up_value_4 != "") {
			if (adb->get_user_property_str(q.up_name_4) != q.up_value_4) {
				return false;
			}
		} else {
			if (adb->get_user_property_str(q.up_name_4) == "") {
				return false;
			}
		}
	}

	return true;
}

void AdvancedSearch::on_cancel() {
	this->OnCancel ();
}

void AdvancedSearch::OnLvnItemActivateList1(NMHDR *pNMHDR, LRESULT *pResult) {
	LPNMITEMACTIVATE pNMIA = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	
	RoseAbstractDumper* rad = reinterpret_cast<RoseAbstractDumper*> (this->m_result_list.GetItemData(pNMIA->iItem));
	
	// cut-and-paste from ItemPropertyPage
	if (rad) {			
		IRoseItemPtr item_to_select = RoseHelper::get_nearest_container (rad->rose_element());
		IRoseDiagramPtr diag = RoseHelper::get_self_diagram (rad->rose_element());

		if (diag != 0) {
			IRoseItemViewPtr iview = diag->GetViewFrom(item_to_select);
			diag->Activate();
			iview->SetSelected(true);
			diag->CenterDiagramToView(iview);
		} else {
			MessageBox("No diagrams availble");
		}
	}

	RoseHelper::ExecResult is_ok = Commands::CmdManagerFactory::get ().properties (rad->rose_element(), false, true);
		
	if (is_ok == RoseHelper::ER_DELETE) {
		m_result_list.DeleteItem (pNMIA->iItem);
	}

	*pResult = 0;
}

// st
void AdvancedSearch::OnBnClickedCheck9() {
	if (this->m_st_view.GetCheck()) {
		int indx = m_result_list.GetHeaderCtrl()->GetItemCount();
		m_result_list.InsertColumn (indx, "Stereotype", LVCFMT_LEFT, 80 );
		for (long l = 0; l < m_result_list.GetItemCount(); l++) {
			RoseAbstractDumper* rad = reinterpret_cast<RoseAbstractDumper*> (this->m_result_list.GetItemData(l));
			this->m_result_list.SetItemText (l, indx, rad->get_stereotype_str().data());
		}
	} else {
		int ind = get_column_index(m_result_list, "Stereotype");
		if (ind != -1) {
			m_result_list.DeleteColumn (ind);
		}
	}
}

// path
void AdvancedSearch::OnBnClickedCheck10() {
	if (this->m_path_view.GetCheck()) {
		int indx = m_result_list.GetHeaderCtrl()->GetItemCount();
		m_result_list.InsertColumn (indx, "Path", LVCFMT_LEFT, 350 );
		for (long l = 0; l < m_result_list.GetItemCount(); l++) {
			RoseAbstractDumper* rad = reinterpret_cast<RoseAbstractDumper*> (this->m_result_list.GetItemData(l));
			AbstractDumperBase* adb = dynamic_cast<AbstractDumperBase*> (rad);
			if (rad) {
				const AbstractDumper* par_ad = dynamic_cast<const AbstractDumper*> (adb->parent());
				if (par_ad) {
					this->m_result_list.SetItemText (l, indx, par_ad->get_full_name().data());
				} else {
					this->m_result_list.SetItemText (l, indx, "MODEL ROOT");
				}
			}
		}
	} else {
		int ind = get_column_index(m_result_list, "Path");
		if (ind != -1) {
			m_result_list.DeleteColumn (ind);
		}
	}
}

// contex
void AdvancedSearch::OnBnClickedCheck11() {
	if (this->m_context_view.GetCheck()) {
		int indx = m_result_list.GetHeaderCtrl()->GetItemCount();
		m_result_list.InsertColumn (indx, "Context", LVCFMT_LEFT, 170 );
		for (long l = 0; l < m_result_list.GetItemCount(); l++) {
			RoseAbstractDumper* rad = reinterpret_cast<RoseAbstractDumper*> (this->m_result_list.GetItemData(l));
			AbstractDumperBase* adb = dynamic_cast<AbstractDumperBase*> (rad);
			if (adb) {
				const AbstractDumperBase* par = adb->parent();
				if (par) {
					this->m_result_list.SetItemText (l, indx, (std::string ("<<") + par->get_stereotype_str() + ">> " + par->get_name_str()).data());
				} else {
					this->m_result_list.SetItemText (l, indx, "MODEL ROOT");
				}
			}
		}
	} else {		
		int ind = get_column_index(m_result_list, "Context");
		if (ind != -1) {
			m_result_list.DeleteColumn (ind);
		}
	}
	
}

// doc
void AdvancedSearch::OnBnClickedCheck8() {
	if (this->m_doc_view.GetCheck()) {
		int indx = m_result_list.GetHeaderCtrl()->GetItemCount();
		m_result_list.InsertColumn (indx, "Documentation", LVCFMT_LEFT, 450 );
		for (long l = 0; l < m_result_list.GetItemCount(); l++) {
			RoseAbstractDumper* rad = reinterpret_cast<RoseAbstractDumper*> (this->m_result_list.GetItemData(l));
			AbstractDumperBase* adb = dynamic_cast<AbstractDumperBase*> (rad);
			if (adb) {
				this->m_result_list.SetItemText (l, indx, adb->get_documentation_str().data());
			}
		}
	} else {
		int ind = get_column_index(m_result_list, "Documentation");
		if (ind != -1) {
			m_result_list.DeleteColumn (ind);
		}
	}
}

// selected up
void AdvancedSearch::OnBnClickedCheck21() {	
	if (this->m_selected_up_view.GetCheck()) {
		int indx = m_result_list.GetHeaderCtrl()->GetItemCount();

		CString value;
		CString name_1;
		CString name_2;
		CString name_3;
		CString name_4;
		int indx_1 = -1;
		int indx_2 = -1;
		int indx_3 = -1;
		int indx_4 = -1;

		m_upc_name_1 = "";
		m_upc_name_2 = "";
		m_upc_name_3 = "";
		m_upc_name_4 = "";
		
		this->m_up_name_1.GetWindowText (name_1);
		this->m_up_value_1.GetWindowText (value);
		if (name_1 != "" && value == "") {
			indx_1 = indx++;
			m_upc_name_1 = std::string ("{") + (const char*)name_1 + "}";
			m_result_list.InsertColumn (indx_1, m_upc_name_1.data(), LVCFMT_LEFT, 100 );
		}
		

		this->m_up_name_2.GetWindowText (name_2);
		this->m_up_value_2.GetWindowText (value);
		if (name_2 != "" && value == "") {
			indx_2 = indx++;
			m_upc_name_2 = std::string ("{") + (const char*)name_2 + "}";
			m_result_list.InsertColumn (indx_2, m_upc_name_2.data(), LVCFMT_LEFT, 100 );
		}

		this->m_up_name_3.GetWindowText (name_3);
		this->m_up_value_3.GetWindowText (value);
		if (name_3 != "" && value == "") {
			indx_3 = indx++;
			m_upc_name_3 = std::string ("{") + (const char*)name_3 + "}";
			m_result_list.InsertColumn (indx_3, m_upc_name_3.data(), LVCFMT_LEFT, 100 );
		}

		this->m_up_name_4.GetWindowText (name_4);
		this->m_up_value_4.GetWindowText (value);
		if (name_4 != "" && value == "") {
			indx_4 = indx++;
			m_upc_name_4 = std::string ("{") + (const char*)name_4 + "}";
			m_result_list.InsertColumn (indx_4, m_upc_name_4.data(), LVCFMT_LEFT, 100 );
		}

		for (long l = 0; l < m_result_list.GetItemCount(); l++) {
			RoseAbstractDumper* rad = reinterpret_cast<RoseAbstractDumper*> (this->m_result_list.GetItemData(l));
			AbstractDumperBase* adb = dynamic_cast<AbstractDumperBase*> (rad);
			if (adb) {			
				if (indx_1 != -1) {
					this->m_result_list.SetItemText (l, indx_1, adb->get_user_property_str ((const char*)name_1).data());
				}
				if (indx_2 != -1) {
					this->m_result_list.SetItemText (l, indx_2, adb->get_user_property_str ((const char*)name_2).data());
				}
				if (indx_3 != -1) {
					this->m_result_list.SetItemText (l, indx_3, adb->get_user_property_str ((const char*)name_3).data());
				}
				if (indx_4 != -1) {
					this->m_result_list.SetItemText (l, indx_4, adb->get_user_property_str ((const char*)name_4).data());
				}
			}
		}
	} else {
		CString name;
		int ind;
		
		ind = get_column_index(m_result_list, m_upc_name_1.data());
		if (ind != -1) {
			m_result_list.DeleteColumn (ind);
			m_upc_name_1 = "";
		}

		ind = get_column_index(m_result_list, m_upc_name_2.data());
		if (ind != -1) {
			m_result_list.DeleteColumn (ind);
			m_upc_name_2 = "";
		}

		ind = get_column_index(m_result_list, m_upc_name_3.data());
		if (ind != -1) {
			m_result_list.DeleteColumn (ind);
			m_upc_name_3 = "";
		}

		ind = get_column_index(m_result_list, m_upc_name_4.data());
		if (ind != -1) {
			m_result_list.DeleteColumn (ind);
			m_upc_name_4 = "";
		}
	}
}

void AdvancedSearch::OnBnClickedCat() {
	this->fill_st_list ();
}

void AdvancedSearch::OnBnClickedClass() {
	this->fill_st_list ();
}

void AdvancedSearch::OnBnClickedOp() {
	this->fill_st_list ();
}

void AdvancedSearch::OnBnClickedAttr() {
	this->fill_st_list ();
}

void AdvancedSearch::OnBnClickedDep() {
	this->fill_st_list ();
}

void AdvancedSearch::OnBnClickedCheck12() {
	this->fill_st_list ();
}

void AdvancedSearch::OnCbnSelchangeCombo2() {
	m_up_value_1.EnableWindow(m_up_name_1.GetCurSel() > 0);
}

void AdvancedSearch::OnCbnSelchangeCombo5() {
	m_up_value_2.EnableWindow(m_up_name_2.GetCurSel() > 0);
}

void AdvancedSearch::OnCbnSelchangeCombo6() {
	m_up_value_3.EnableWindow(m_up_name_3.GetCurSel() > 0);
}

void AdvancedSearch::OnCbnSelchangeCombo7() {
	m_up_value_4.EnableWindow(m_up_name_4.GetCurSel() > 0);
}

void AdvancedSearch::OnBnClickedButEdit() {
	int selection = m_result_list.GetSelectionMark();
	if (selection >= 0) {
		RoseAbstractDumper* rad = reinterpret_cast<RoseAbstractDumper*> (this->m_result_list.GetItemData(selection));

		RoseHelper::ExecResult is_ok = Commands::CmdManagerFactory::get ().properties (rad->rose_element(), false, true);

		if (is_ok == RoseHelper::ER_DELETE) {
			m_result_list.DeleteItem (selection);
		}
	}	
}

void AdvancedSearch::OnBnClickedButBrowse() {
	int selection = m_result_list.GetSelectionMark();
	if (selection >= 0) {
		RoseAbstractDumper* rad = reinterpret_cast<RoseAbstractDumper*> (this->m_result_list.GetItemData(selection));

		// cut-and-paste from ItemPropertyPage
		if (rad) {			
			IRoseItemPtr item_to_select = RoseHelper::get_nearest_container (rad->rose_element());
			IRoseDiagramPtr diag = RoseHelper::get_self_diagram (rad->rose_element());

			if (diag != 0) {
				IRoseItemViewPtr iview = diag->GetViewFrom(item_to_select);
				diag->Activate();
				iview->SetSelected(true);
				diag->CenterDiagramToView(iview);
			} else {
				MessageBox("No diagrams availble");
			}
		}
	}
}

void AdvancedSearch::OnBnClickedButBrowseClose() {
	this->OnBnClickedButBrowse();
	this->OnOK ();
}
//#UC END# *4573E7840177*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AdvancedSearch::AdvancedSearch (const RoseElementVector& items) : CDialog (AdvancedSearch::IDD)
//#UC START# *458E8F2D01FD_BASE_INIT*
, m_items (items)
//#UC END# *458E8F2D01FD_BASE_INIT*
{
	//#UC START# *458E8F2D01FD_BODY*
	//#UC END# *458E8F2D01FD_BODY*
}

AdvancedSearch::~AdvancedSearch () {
	//#UC START# *4573E7840177_DESTR_BODY*
	//#UC END# *4573E7840177_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(AdvancedSearch, CDialog)
	//#UC START# *4573E7840177_MESSAGE_MAP*
	ON_BN_CLICKED(IDC_BUTTON2, on_run)
	ON_BN_CLICKED(IDC_BUTTON3, on_cancel)
	ON_NOTIFY(LVN_ITEMACTIVATE, IDC_LIST1, OnLvnItemActivateList1)
	ON_BN_CLICKED(IDC_CHECK9, OnBnClickedCheck9)
	ON_BN_CLICKED(IDC_CHECK10, OnBnClickedCheck10)
	ON_BN_CLICKED(IDC_CHECK11, OnBnClickedCheck11)
	ON_BN_CLICKED(IDC_CHECK8, OnBnClickedCheck8)
	ON_BN_CLICKED(IDC_CAT, OnBnClickedCat)
	ON_BN_CLICKED(IDC_CLASS, OnBnClickedClass)
	ON_BN_CLICKED(IDC_OP, OnBnClickedOp)
	ON_BN_CLICKED(IDC_ATTR, OnBnClickedAttr)
	ON_BN_CLICKED(IDC_DEP, OnBnClickedDep)
	ON_BN_CLICKED(IDC_CHECK21, OnBnClickedCheck21)
	ON_BN_CLICKED(IDC_CHECK12, OnBnClickedCheck12)
	ON_BN_CLICKED(IDC_CLEAR, OnBnClickedClear)
	ON_CBN_SELCHANGE(IDC_COMBO2, OnCbnSelchangeCombo2)
	ON_CBN_SELCHANGE(IDC_COMBO5, OnCbnSelchangeCombo5)
	ON_CBN_SELCHANGE(IDC_COMBO6, OnCbnSelchangeCombo6)
	ON_CBN_SELCHANGE(IDC_COMBO7, OnCbnSelchangeCombo7)
	ON_BN_CLICKED(IDC_BUT_EDIT, OnBnClickedButEdit)
	ON_BN_CLICKED(IDC_BUT_BROWSE, OnBnClickedButBrowse)
	ON_BN_CLICKED(IDC_BUT_BROWSE_CLOSE, OnBnClickedButBrowseClose)
	//#UC END# *4573E7840177_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(AdvancedSearch, CDialog)

void AdvancedSearch::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *4573E7840177_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_TEXT_FIELD, m_text_field);
	DDX_Control(pDX, IDC_CHECK1, m_in_name);
	DDX_Control(pDX, IDC_CHECK2, m_in_doc);
	DDX_Control(pDX, IDC_SEARCH_IN_GUID, m_in_guid);
	DDX_Control(pDX, IDC_CAT, m_cat);
	DDX_Control(pDX, IDC_CLASS, m_class);
	DDX_Control(pDX, IDC_OP, m_op);
	DDX_Control(pDX, IDC_ATTR, m_attr);
	DDX_Control(pDX, IDC_COMBO1, m_self_st);
	DDX_Control(pDX, IDC_COMBO3, m_parent_st);
	DDX_Control(pDX, IDC_COMBO4, m_g_parent_st);
	DDX_Control(pDX, IDC_COMBO2, m_up_name_1);
	DDX_Control(pDX, IDC_COMBO5, m_up_name_2);
	DDX_Control(pDX, IDC_COMBO6, m_up_name_3);
	DDX_Control(pDX, IDC_COMBO7, m_up_name_4);
	DDX_Control(pDX, IDC_EDIT3, m_up_value_1);
	DDX_Control(pDX, IDC_EDIT4, m_up_value_2);
	DDX_Control(pDX, IDC_EDIT5, m_up_value_3);
	DDX_Control(pDX, IDC_EDIT6, m_up_value_4);
	DDX_Control(pDX, IDC_LIST1, m_result_list);
	DDX_Control(pDX, IDC_DEP, m_dep);
	DDX_Control(pDX, IDC_CHECK9, m_st_view);
	DDX_Control(pDX, IDC_CHECK10, m_path_view);
	DDX_Control(pDX, IDC_CHECK8, m_doc_view);
	DDX_Control(pDX, IDC_CHECK11, m_context_view);
	DDX_Control(pDX, IDC_CHECK21, m_selected_up_view);
	DDX_Control(pDX, IDC_COMBO8, m_content_st);
	DDX_Control(pDX, IDC_CHECK12, m_usecase);
	DDX_Control(pDX, IDC_CHECK13, m_public);
	DDX_Control(pDX, IDC_CHECK14, m_protected);
	DDX_Control(pDX, IDC_CHECK15, m_private);
	DDX_Control(pDX, IDC_CHECK16, m_impl);
	DDX_Control(pDX, IDC_CHECK17, m_regular);
	DDX_Control(pDX, IDC_CHECK18, m_abstract);
//	DDX_Control(pDX, IDC_CHECK19, m_inline);
	DDX_Control(pDX, IDC_CHECK20, m_final);
	DDX_Control(pDX, IDC_COMBO9, m_native);
	DDX_Control(pDX, IDC_COMBO10, m_parameterized);
	DDX_Control(pDX, IDC_RUN_SPELL, m_run_spell);
	//#UC END# *4573E7840177_DO_DATA_EXCHANGE*
}

BOOL AdvancedSearch::OnInitDialog () {
	BOOL ret = CDialog::OnInitDialog();
	try {
		//#UC START# *4573E7840177_ON_INIT_DLG*
	#ifndef GDS_NLOG_DEBUG
		Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);				
	#endif

		m_self_st_set.clear ();
		m_parent_st_set.clear ();
		m_g_parent_st_set.clear ();
		m_content_st_set.clear ();

		std::string mess = "Advanced search";
		if (!m_items.empty ()) {
			GCL::StrVector items_names;

			mess += " (in: ";

			for (RoseElementVector::const_iterator it = m_items.begin (); it != m_items.end (); ++it) {
				IRoseItemPtr item = it->element;
				std::string component;
				if (item && item->GetContext () != 0 && !item->GetContext ()->IsClass(MODEL_TYPE)) {
					component = ((const char*)item->GetContext()->GetName());
					component += "::";
				}
				component += (const char*)item->GetName();				
				items_names.push_back (component);
			}
			mess += GCL::join (items_names, ", ");
			mess += ")";
			
		}		
		mess += ":";
		this->SetWindowText (mess.data());

		m_native.AddString("All");
		m_native.AddString("Native");
		m_native.AddString("Modeled");

		m_parameterized.AddString("All");
		m_parameterized.AddString("Parameterized");
		m_parameterized.AddString("Not parameterized");

		m_il = new CImageList ();
		m_il->Create (RoseHelper::get_rose_image_list ());
		m_result_list.SetImageList (m_il.in (), LVSIL_SMALL);
		
		m_result_list.InsertColumn (0, "Element name", LVCFMT_LEFT, 150 );
		m_result_list.InsertColumn (1, "Documentation", LVCFMT_LEFT, 450 );
		
		m_doc_view.SetCheck (true);
		m_selected_up_view.SetCheck (true);

		this->reset_dlg ();
		
		m_constructed = true;
		//#UC END# *4573E7840177_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"AdvancedSearch\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

