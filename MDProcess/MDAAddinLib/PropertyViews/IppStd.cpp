////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppStd.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppStd
//
// General - страница
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppStd.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/MDAGui/TemplArgs.h"
#include "MDProcess/MDAAddinLib/MDAGui/StCollection.h"
#include "MDProcess/MDAAddinLib/PropertyViews/Contents.h"
#include "MDProcess/MDAAddinLib/MDAGui/ReportView.h"
#include "MDProcess/MDAAddinLib/PropertyViews/ItemPropertySheet.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"
#include "MDProcess/MDAAddinLib/PropertyViews/ContentView.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"
#include "MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"
#include "MDProcess/MDAAddinLib/MDAGui/DeleteQuestion.h"
#include "MDProcess/MDAModel/Parsers/Parsers.h"
#include "MDProcess/MDAModel/Parsers/ParsersFactories.h"
#include "MDProcess/MDAModel/Parsers/Parsers.h"
#include "MDProcess/MDAModel/Parsers/ParsersFactories.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"

//#UC START# *4574173603A9_CUSTOM_INCLUDES*
#include "boost/regex.hpp"
#include <boost/token_iterator.hpp>
#include <vector>
#include <map>
//#UC END# *4574173603A9_CUSTOM_INCLUDES*


//#UC START# *4574173603A9*

void IppStd::fill_data (bool on_apply) {
	IRoseItemPtr item = this->get_rose_item();
	
	if (!RoseHelper::has_content (item)) {
		m_content_btn.EnableWindow (false);
	}
	
	m_guid.SetWindowText (get_rose_element_uid(item).c_str ());	

	if (item->IsClass (CLASS_DEPENDENCY_TYPE)) {
		m_name.EnableWindow (false);
		m_doc.EnableWindow (false);
		m_content_btn.EnableWindow (false);
	} else {
		m_name.EnableWindow (true);
		m_doc.EnableWindow (true);

		std::string complex_name = (const char*)item->Name;
		if (item->IsClass (ATTRIBUTE_TYPE)) {
			IRoseAttributePtr attr = item;
			m_static_name.SetWindowText (_T ("Name:"));
			complex_name += " : ";
			complex_name += (const char*)attr->Type;
			if (attr->InitValue != _bstr_t("")) {
				complex_name += " = ";
				complex_name += (const char*)attr->InitValue;
			}
		} else if (item->IsClass (OPERATION_TYPE)) {
			IRoseOperationPtr op = item;
			m_static_name.SetWindowText (_T ("Name && spec:"));
			complex_name += " (";
			IRoseParameterCollectionPtr params = op->Parameters;			
			short params_count = params->Count;
			for (short l = 1; l <= params_count; ++l) {		
				IRoseParameterPtr par = params->GetAt(l);
				complex_name += (const char*)par->Name;
				complex_name += ": ";
				complex_name += par->Type;
				if (par->InitValue != _bstr_t("")) {
					complex_name += " = ";
					complex_name += (const char*)par->InitValue;
				}
				if (l != params_count) {
					complex_name += ", ";
				}
			}
			complex_name += ")";
			if (op->ReturnType != _bstr_t("")) {
				complex_name += ": ";
				complex_name += (const char*)op->ReturnType;
			}
		} else {
			m_static_name.SetWindowText (_T ("Name:"));
		}		
		m_name.SetWindowText (complex_name.data());

		m_doc.SetWindowText ((char*)item->Documentation);
	}
	
	{
		if (item->IsClass("Role")) {
			IRoseRolePtr rol = (IRoseRolePtr)item;
			m_contents_chk.EnableWindow(true);
			if (rol->Keys->Count > 0) {
				m_contents_chk.SetCheck(true);
				m_contents_btn.EnableWindow(true);
			} else {
				m_contents_chk.SetCheck(false);
				m_contents_btn.EnableWindow(false);
			}
		} else {
			m_contents_chk.EnableWindow(false);
			m_contents_btn.EnableWindow(false);
		}
	}

	ItemPropertySheet* ps = dynamic_cast<ItemPropertySheet*> (this->GetOwner());
	{ // fill model stereotype combobox
		m_model_stereotype.ResetContent();
		
		IRoseElementPtr context = RoseHelper::get_context (item);
		Helpers::StereotypeManager_var st_mng = Helpers::StereotypeManagerFactory::make ();
		Core::Aptr<Helpers::StereotypeList> stereotypes = st_mng->make_allowable_stereotypes (item, context);
		
		for (
			Helpers::StereotypeList::const_iterator it = stereotypes->begin ()
			; it != stereotypes->end ()
			; ++it
		) {
			GCL::StrVector parts = GCL::split_string_by_sub_string (it/*->get ()*/->data(), "::");
			if (parts.size() == 2) {
				m_model_stereotype.AddString (parts[0].data());
			} else if (parts.size() == 4 && (parts[3] == OPERATION_TYPE || parts[3] == ATTRIBUTE_TYPE || parts[3] == CLASS_DEPENDENCY_TYPE)) {
				m_model_stereotype.AddString (parts[2].data());
			} else if (parts.size() == 3 && (parts[2] == OPERATION_TYPE || parts[2] == ATTRIBUTE_TYPE || parts[2] == CLASS_DEPENDENCY_TYPE)) {
				m_model_stereotype.AddString ("<default>");
			}
		}
		
		if (ps->m_auto_open_st_list && !on_apply) {			
			this->OnBnClickedButton3 ();
			CString str;
			m_model_stereotype.GetWindowText (str);
			
			std::string stereotype = (const char*)str;
			GCL::str_replace  (stereotype, "<default>", "");
			GCL::str_replace  (stereotype, " <INVALID>", "");
			
			if (item->Stereotype != _bstr_t(stereotype.data())) {
				item->Stereotype = stereotype.data();			
			}
		} else {
			std::string st = (char*)item->Stereotype;
			if (st.empty ()) {
				if (
					ps->m_fill_def_value 
					&& !on_apply
					&& m_model_stereotype.GetCount () != 0
				) {
					CString most_used_stereotype;
					m_model_stereotype.GetLBText (0, most_used_stereotype);
					st = static_cast<const char*> (most_used_stereotype);
				} else {
					st = "<default>";
				}
			}
			int index = m_model_stereotype.FindStringExact (0, st.data());
			if (index == CB_ERR) {
				st += " <INVALID>";
				index = m_model_stereotype.AddString (st.data());
			}
			if (index != CB_ERR) {
				m_model_stereotype.SetCurSel (index);
			}
		}
	}

	{// fill target stereotype combobox
		m_target_st.ResetContent();
		GCL::StrVector stereotypes = RoseHelper::get_available_target_stereotypes (item);
		if (stereotypes.size() != 0) {
			m_target_st.AddString ("");
			for (GCL::StrVector::iterator it = stereotypes.begin(); it != stereotypes.end(); it++) {
				m_target_st.AddString (it->data());
			}		
			
			std::string st = RoseHelper::get_target_stereotype(item);

			if ( st != "") {
				int index = m_target_st.FindStringExact (0, st.data());
				if (index == CB_ERR) {
					m_target_st.AddString (st.data());
				}
				if (index != CB_ERR) {
					m_target_st.SetCurSel (index);
				}
			}

			m_target_st.EnableWindow(true);
		} else {
			m_target_st.EnableWindow(false);
		}
	}
	
	AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);
	AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (stereotype);

	// setup abstraction rbs
	{		
		std::string abstr;
		if (ps->m_fill_def_value && !on_apply) {
			abstr = tpl.def_abstraction_type;
		} else {
			abstr = RoseHelper::get_abstraction_type_str (item);
		}
		
		int enable_rb_count = 0;

		if (tpl.abstraction_type & AbstractDumperBase::ATF_ABSTRACT) {
			m_abstract_rb.EnableWindow(true);
			enable_rb_count++;
			if (abstr == "abstract") {
				m_abstract_rb.SetCheck(true);
			}
		} else {
			m_abstract_rb.EnableWindow(false);
		}

		if (tpl.abstraction_type & AbstractDumperBase::ATF_REGULAR) {
			m_regular_rb.EnableWindow(true);
			enable_rb_count++;
			if (abstr == "regular") {
				m_regular_rb.SetCheck(true);
			}
		} else {
			m_regular_rb.EnableWindow(false);
		}

		if (tpl.abstraction_type & AbstractDumperBase::ATF_FINAL) {
			m_final_rb.EnableWindow(true);
			enable_rb_count++;
			if (abstr == "final") {
				m_final_rb.SetCheck(true);
			}
		} else {
			m_final_rb.EnableWindow(false);
		}
		/*
		if (tpl.abstraction_type & AbstractDumperBase::ATF_INLINE) {
			m_inline_rb.EnableWindow(true);
			enable_rb_count++;
			if (abstr == "inline") {
				m_inline_rb.SetCheck(true);
			}
		} else {
			m_inline_rb.EnableWindow(false);
		}
		*/

		if (tpl.abstraction_type & AbstractDumperBase::ATF_OPTIONAL) {
			m_optional_rb.EnableWindow(true);
			enable_rb_count++;
			if (abstr == "optional") {
				m_optional_rb.SetCheck(true);
			}
		} else {
			m_optional_rb.EnableWindow(false);
			m_optional_rb.ShowWindow (SW_HIDE);
		}

		if (enable_rb_count < 2) {
			//m_inline_rb.EnableWindow(false);
			m_final_rb.EnableWindow(false);
			m_regular_rb.EnableWindow(false);
			m_abstract_rb.EnableWindow(false);
			m_optional_rb.EnableWindow(false);
		}
	}

	// setup main flag
	{
		bool can_be_main = tpl.main_st;
		if (can_be_main) {
			bool is_main = RoseHelper::is_it_main_model_element(item);
			m_is_main.SetCheck (is_main);
			m_is_main.EnableWindow (!is_main);
		} else {
			m_is_main.EnableWindow (false);
		}
	}

	//setup visibility level
	this->GetDlgItem (IDC_VISIBILITY_LEVEL_EDIT)->ShowWindow (SW_HIDE);
	this->GetDlgItem (IDC_VISIBILITY_LEVEL_SPIN)->ShowWindow (SW_HIDE);
	this->GetDlgItem (IDC_VISIBILITY_LEVEL_STATIC)->ShowWindow (SW_HIDE);
	this->GetDlgItem (IDC_VISIBILITY_LEVEL_EDIT)->EnableWindow (FALSE);
	this->GetDlgItem (IDC_VISIBILITY_LEVEL_SPIN)->EnableWindow (FALSE);
	//Пока не используем!!!
	/*{
		bool visibility_level_settable = tpl.visibility_level_settable; 
		if (visibility_level_settable) {
			CWnd* level_edit = this->GetDlgItem (IDC_VISIBILITY_LEVEL_EDIT);
			if (level_edit) {
				m_visibility_level.SetBuddy (level_edit);
				m_visibility_level.SetRange (0, 100);
				int level = ModelPropertiesHelperFactory::get().get_visibility_level (item);
				if (level >= 0) {
					m_visibility_level.SetPos (level);
				}
			}
		} else {
			this->GetDlgItem (IDC_VISIBILITY_LEVEL_EDIT)->EnableWindow (FALSE);
			this->GetDlgItem (IDC_VISIBILITY_LEVEL_SPIN)->EnableWindow (FALSE);
		}
	}*/
	if (item->IsClass(ATTRIBUTE_TYPE) || item->IsClass("Role")) {
		m_link_type.EnableWindow(true);

		std::string lt;
		if (ps->m_fill_def_value && !on_apply) {
			lt = tpl.def_link_type;
		} else {
			lt = RoseHelper::get_link_type(item);
		}

		m_link_type.ResetContent();
		if (tpl.link_type & LTF_REF) {
			m_link_type.AddString("Reference");
		}
		if (tpl.link_type & LTF_AGR) {
			m_link_type.AddString("Agrigation");
		}
		if (tpl.link_type & LTF_LNK) {
			m_link_type.AddString("Link");
		}
				
		if (lt == "lnk") {
			m_link_type.SelectString(0,"Link");
		} else if (lt == "agr") {
			m_link_type.SelectString(0,"Agrigation");
		} else if (lt == "ref") {
			m_link_type.SelectString(0,"Reference");
		}
	} else {
		m_link_type.EnableWindow(false);
	}

	bool with_parent;
	m_is_native_btn.SetCheck (RoseHelper::get_is_native_with_parent (item, with_parent));
	if (with_parent || RoseHelper::get_is_native_with_parent (item->GetContext())) {
		m_is_native_btn.EnableWindow(false);
	}

	if (item->IsClass(CLASS_TYPE) && tpl.parameterization_type) {
		m_parameterized.EnableWindow (true);
		if (((IRoseClassPtr)item)->ClassKind->GetName () == _bstr_t ("ParameterizedClass")) {
			m_templ_args_dlg.EnableWindow (true);
			m_parameterized.SetCheck (true);
		} else {
			m_parameterized.SetCheck (false);
			m_templ_args_dlg.EnableWindow (false);
		}
	} else {
		m_parameterized.EnableWindow (false);
		m_templ_args_dlg.EnableWindow (false);
	}

	if (item->IsClass(CATEGORY_TYPE)) {
		m_global_chk.EnableWindow (true);
		if (((IRoseCategoryPtr)item)->Global) {
			m_global_chk.SetCheck(true);
		}

		m_global_locally_chk.EnableWindow (true);
		if (ModelPropertiesHelperFactory::get ().is_global_locally (item)) {
			m_global_locally_chk.SetCheck (true);
		}
	} else {
		m_global_locally_chk.EnableWindow (false);
		m_global_chk.EnableWindow (false);
	}

	{ // setup visability rb

		std::string cur_val;
		if (ps->m_fill_def_value && !on_apply) {
			cur_val = tpl.def_visability_type;
		} else {
			cur_val = RoseHelper::get_visibility_type(item);
		}

		int enable_rb_count = 0;

		if (tpl.visability_type & VTF_PUBLIC) {
			m_public_rb.EnableWindow(true);
			enable_rb_count++;
			if (cur_val == "PublicAccess") {
				m_public_rb.SetCheck(true);
			}
		} else {
			m_public_rb.EnableWindow(false);
		}

		if (tpl.visability_type & VTF_PROTECTED) {
			m_protected_rb.EnableWindow(true);
			enable_rb_count++;
			if (cur_val == "ProtectedAccess") {
				m_protected_rb.SetCheck(true);
			}
		} else {
			m_protected_rb.EnableWindow(false);
		}

		if (tpl.visability_type & VTF_PRIVATE) {
			m_private_rb.EnableWindow(true);
			enable_rb_count++;
			if (cur_val == "PrivateAccess") {
				m_private_rb.SetCheck(true);
			}
		} else {
			m_private_rb.EnableWindow(false);
		}
		
		if (tpl.visability_type & VTF_IMPL) {
			m_impl_rb.EnableWindow(true);
			enable_rb_count++;
			if (cur_val == "ImplementationAccess") {
				m_impl_rb.SetCheck(true);
			}
		} else {
			m_impl_rb.EnableWindow(false);
		}

		if (enable_rb_count < 2) {
			m_impl_rb.EnableWindow(false);
			m_private_rb.EnableWindow(false);
			m_protected_rb.EnableWindow(false);
			m_public_rb.EnableWindow(false);
			m_public_rb.SetCheck(true);
		}
	}

	bool is_wrapper = ACE_OS::strncmp (
		static_cast<const char*>(item->GetPropertyValue (TOOL_NAME, Base::IS_OVERRIDEN_WRAPPER))
		, "true"
		, ACE_OS::strlen ("true")
	) == 0;

	if (is_wrapper) {
		//запрещаем редактирование всех свойств, кроме видимости
		
		std::set<int> enabled_dlg_items;
		enabled_dlg_items.insert (IDC_RB_PUBLIC);
		enabled_dlg_items.insert (IDC_RB_PROTECTED);
		enabled_dlg_items.insert (IDC_RB_PRIVATE);
		enabled_dlg_items.insert (IDC_RB_IMPL);

		CWnd* child_wnd = this->GetWindow(GW_CHILD);
		while (child_wnd != NULL && ::IsWindow(child_wnd->m_hWnd)) {
			int id = child_wnd->GetDlgCtrlID ();

			if (enabled_dlg_items.find (id) == enabled_dlg_items.end ()) {
				child_wnd->EnableWindow (false);
			}
			child_wnd = child_wnd->GetWindow(GW_HWNDNEXT);
		}

	}
}

void IppStd::OnBnClickedButton4() {
	IRoseClassPtr cls = this->get_rose_item();
	TemplArgs dlg (cls);
	dlg.DoModal ();
	if (cls->ClassKind->Name != _bstr_t("ParameterizedClass")) {
		m_parameterized.SetCheck(false);
		m_templ_args_dlg.EnableWindow (false);
	}
}


void IppStd::OnBnClickedCheck2()
{
	// TODO: Add your control notification handler code here
	if (m_parameterized.GetCheck ()) {
		m_templ_args_dlg.EnableWindow (true);
		this->OnBnClickedButton4();
	} else {
		m_templ_args_dlg.EnableWindow (false);
	}
}

struct ParamData {
	ParamData (
		const std::string& _name
		, const std::string& _type
		, const std::string& _init_value
	) : name (_name), type (_type), init_value (_init_value)
	{
	}

	bool operator == (const ParamData& src) const {
		return this->name == src.name
			&& this->type == src.type
			&& this->init_value == src.init_value;
	}
	std::string name;
	std::string type;
	std::string init_value;
};
typedef std::vector<ParamData> Params;

bool AttributeDataEqual (const Parsers::AttributeData& x, const Parsers::AttributeData& y) {
	return x.name == y.name
			&& x.type == y.type
			&& x.init_value == y.init_value;
}

bool IppStd::on_ok (bool& need_colorize) {
	need_colorize = false;
	IRoseItemPtr item = this->get_rose_item();
	
	/*IRoseDiagramCollectionPtr diags = RoseHelper::get_all_diagrams (item);
	short count = diags->Count;
	LOG_W(("Used in %d diags", count));
	for (short i = 1; i <= count; ++i) {
		std::string name = RoseHelper::get_full_name (diags->GetAt (i));
		LOG_W (("Used in diag: %s", name.c_str ()));
	}*/
	CString str;
	
	{
		m_name.GetWindowText (str);
		std::string pure_name;

		if (item->IsClass (ATTRIBUTE_TYPE)) {
			try {				
				Core::Aptr<Parsers::AttributeData> attr_data = Parsers::AttributeParserFactory::get ().parse (static_cast<const char*> (str));
				
				IRoseAttributePtr attr = item;
				if (attr_data->type != std::string (attr->Type)) {
					attr->Type = attr_data->type.data ();
					RoseTreeState::instance ()->set_changed (true);
				}

				if (attr_data->init_value != std::string (attr->InitValue)) {
					attr->InitValue = attr_data->init_value.data ();
				}

				pure_name = attr_data->name;
			} catch (Parsers::ParseError& ex) {
				MessageBox (ex.what (), "ERROR", MB_OK|MB_ICONEXCLAMATION);
				return false;
			}
		} else if (item->IsClass (OPERATION_TYPE)) {
			try {
				Core::Aptr<Parsers::OperationData> op_data = Parsers::OperationParserFactory::get ().parse (static_cast<const char*> (str));
				pure_name = op_data->name;

				Parsers::AttributeDataVector old_params;
				
				IRoseOperationPtr op = item;
				IRoseParameterCollectionPtr op_params = op->Parameters;
				short params_count = op_params->Count;
				for (short i = 1; i <= params_count; ++i) {
					IRoseParameterPtr param = op_params->GetAt(i);
					Parsers::AttributeData param_data;
					param_data.name = GCL::trim_ws((const char*)param->Name);
					param_data.type = GCL::trim_ws((const char*)param->Type);
					param_data.init_value = GCL::trim_ws((const char*)param->InitValue);

					old_params.push_back (param_data);
				}

				const Parsers::AttributeDataVector& params = op_data->parameters;
				if (
					params.size () != old_params.size ()
					|| std::equal (params.begin (), params.end (), old_params.begin (), AttributeDataEqual) == false
				) {
					op->RemoveAllParameters ();

					for (Parsers::AttributeDataVector::const_iterator it = params.begin(); it != params.end(); it++) {
						op->AddParameter (
							it->name.data()
							, it->type.data()
							, it->init_value.data ()
							, op->Parameters->Count
						);
					}					
					RoseTreeState::instance ()->set_changed (true);
				}
				_bstr_t ret_type = op_data->return_type.data ();
				if (ret_type != op->ReturnType) {
					op->ReturnType = ret_type;
					RoseTreeState::instance ()->set_changed (true);
				}
			} catch (Parsers::ParseError& ex) {
				MessageBox (ex.what (), "ERROR", MB_OK|MB_ICONEXCLAMATION);
				return false;
			}					
		} else {
			pure_name = GCL::trim_ws ((LPCTSTR)str);
		}

		if (item->Name != _bstr_t(pure_name.data())) {
			try {
				//RoseHelper::check_name (item, pure_name);
				if (item->IsClass (CATEGORY_TYPE)) {
					 pure_name = GCL::replace_char (pure_name, 'я', 'Я');
				}
				item->Name = pure_name.data ();
			} catch (RoseHelper::BadName& ex) {
				std::string err_mess = "Duplicated items names (";
				err_mess += ex.what ();
				err_mess += ") - correct it first";
				MessageBox (err_mess.data(), "ERROR", MB_OK|MB_ICONEXCLAMATION);
				return false;
			} catch (...) {
				MessageBox ("Duplicated items names - correct it first", "ERROR", MB_OK|MB_ICONEXCLAMATION);
				return false;
			}			
		}
	}

	m_doc.GetWindowText (str);
	item->Documentation = (LPCTSTR)str;

	m_model_stereotype.GetWindowText (str);
	std::string stereotype = (const char*)str;
	GCL::str_replace  (stereotype, "<default>", "");
	GCL::str_replace  (stereotype, " <INVALID>", "");
	
	if (item->Stereotype != _bstr_t(stereotype.data())) {
		item->Stereotype = stereotype.data();
		need_colorize = true;
		RoseTreeState::instance ()->set_changed (true);
	}

	AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (RoseHelper::get_gen_stereotype(item));

	{ // abstraction type
		std::string abstr;

		if (m_abstract_rb.GetCheck()) {
			abstr = "abstract";
			if (!(tpl.abstraction_type & AbstractDumperBase::ATF_ABSTRACT)) {
				abstr = tpl.def_abstraction_type;
			}
		} else if (m_regular_rb.GetCheck()) {
			abstr = "regular";
			if (!(tpl.abstraction_type & AbstractDumperBase::ATF_REGULAR)) {
				abstr = tpl.def_abstraction_type;
			}
		} else if (m_final_rb.GetCheck()) {
			abstr = "final";
			if (!(tpl.abstraction_type & AbstractDumperBase::ATF_FINAL)) {
				abstr = tpl.def_abstraction_type;
			}
		} else if (m_optional_rb.GetCheck()) {
			abstr = "optional";
			if (!(tpl.abstraction_type & AbstractDumperBase::ATF_OPTIONAL)) {
				abstr = tpl.def_abstraction_type;
			}
		}/* else if (m_inline_rb.GetCheck()) {
			abstr = "inline";
			if (!(tpl.abstraction_type & ATF_INLINE)) {
				abstr = tpl.def_abstraction_type;
			}
		} */else {
			//assert (0);
			abstr = tpl.def_abstraction_type;
		}

		if (RoseHelper::override_property(item, TOOL_NAME, Base::ABSTRACTION_TYPE, abstr.data())) {
			need_colorize = true;
			RoseTreeState::instance ()->set_changed (true);
		}

		if (item->IsClass(CLASS_TYPE)) {
			((IRoseClassPtr)item)->Abstract = (abstr == "abstract");
		}
	}

	if (item->IsClass(OPERATION_TYPE) || item->IsClass(ATTRIBUTE_TYPE) || item->IsClass("Role")) {	
		m_target_st.GetWindowText (str);

		GCL::StrVector t_stereotypes = RoseHelper::get_available_target_stereotypes (item);
		std::string t_stereotype = str;

		if (std::find (t_stereotypes.begin(), t_stereotypes.end(), t_stereotype) == t_stereotypes.end()) {
			t_stereotype = "";
		}
		
		if (RoseHelper::set_target_stereotype (item, t_stereotype)) {
			need_colorize = true;
			//RoseTreeState::instance ()->set_changed (true);
		}
	}

	if (item->IsClass(ATTRIBUTE_TYPE) || item->IsClass("Role")) {
		m_link_type.GetWindowText (str);
		
		std::string lt;
		if (str == "Link") {
			lt = "lnk";
			if (!(tpl.link_type & LTF_LNK)) {
				lt = tpl.def_link_type;
			}
		} else if (str == "Agrigation") {
			lt = "agr";
			if (!(tpl.link_type & LTF_AGR)) {
				lt = tpl.def_link_type;
			}
		} else if (str == "Reference") {
			lt = "ref";
			if (!(tpl.link_type & LTF_REF)) {
				lt = tpl.def_link_type;
			}
		}
		if (RoseHelper::set_link_type(item, lt)) {
			need_colorize = true;
			//RoseTreeState::instance ()->set_changed (true);
		}
	}

	if (item->IsClass(CATEGORY_TYPE)) {
		((IRoseCategoryPtr)item)->Global = m_global_chk.GetCheck();
		ModelPropertiesHelperFactory::get ().set_global_locally (
			item
			, m_global_locally_chk.GetCheck () == TRUE && m_global_chk.GetCheck () == FALSE ? true : false
		);
	}

	if (!m_is_native_btn.EnableWindow(true)) {
		if (RoseHelper::set_is_native (item, m_is_native_btn.GetCheck())) {
			if (m_is_native_btn.GetCheck()) {
				//если элемент был не native, а стал native - нужно информацию
				//о сгенерённых артефактах перенести на родителя
				IRoseElementPtr non_native_parent = RoseHelper::get_context (item);
				bool is_parent_native = RoseHelper::get_is_native(non_native_parent);
				while (non_native_parent && is_parent_native) {
					non_native_parent = RoseHelper::get_context (non_native_parent);
					is_parent_native = RoseHelper::get_is_native(non_native_parent);
				};
				if (non_native_parent) {
					MDPSupport::CatLockerFacade_var clf = 
						MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)non_native_parent);
					if (clf->try_change ()) {
						RoseHelper::move_generated_source_to_parent (
							item
							, non_native_parent
						);
						clf->do_change ();
					} else {
						std::string message ("Не удалось записать информацию о сгенерённых артефактах в элемент:");
						message += RoseHelper::get_full_name (non_native_parent);
						GenSupport::LogManagerFactory::get ().log_error (message.c_str ());
					}
				}

			}
			need_colorize = true;
			//RoseTreeState::instance ()->set_changed (true);
		}
	}

	RoseHelper::set_parameterized (item, m_parameterized.GetCheck() && tpl.parameterization_type);
		
	if (m_is_main.GetCheck () && tpl.main_st) {
		RoseHelper::set_new_main_model_element(item);
	}

	//Пока не используем
	/*if (tpl.visibility_level_settable) {
		int newLevel = m_visibility_level.GetPos ();
		if (ModelPropertiesHelperFactory::get().get_visibility_level (item) != newLevel) {
			ModelPropertiesHelperFactory::get ().set_visibility_level (item, newLevel);
			RoseTreeState::instance ()->set_changed (true);
		}
	}*/

	{ // setup visability rb
		std::string vt;

		if (m_public_rb.GetCheck()) {
			vt = "PublicAccess";
			if (!(tpl.visability_type & VTF_PUBLIC)) {
				vt = tpl.def_visability_type;
			}
		} else if (m_protected_rb.GetCheck()) {
			vt = "ProtectedAccess";
			if (!(tpl.visability_type & VTF_PROTECTED)) {
				vt = tpl.def_visability_type;
			}
		} else if (m_private_rb.GetCheck()) {
			vt = "PrivateAccess";
			if (!(tpl.visability_type & VTF_PRIVATE)) {
				vt = tpl.def_visability_type;
			}
		} else if (m_impl_rb.GetCheck()) {
			vt = "ImplementationAccess";
			if (!(tpl.visability_type & VTF_IMPL)) {
				vt = tpl.def_visability_type;
			}
		} else {
			assert (0);
			vt = tpl.def_visability_type;
		}

		if (RoseHelper::get_visibility_type(item) != vt) {			
			RoseHelper::set_visibility_type (item, vt);
			need_colorize = true;
			RoseTreeState::instance ()->set_changed (true);
		}
	}

	if (!m_contents_chk.GetCheck() && item->IsClass("Role")) {
		IRoseRolePtr rol = (IRoseRolePtr)item;
		while (rol->Keys->Count) {
			rol->DeleteKey (rol->Keys->GetAt(1));
		}
	}

	//нужно обновить закэшированные значения на дампере
	RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (item);
	if (rad) {
		rad->update_cached_attrs ();
	}

	this->fill_data(true);
	return true;
}

void IppStd::OnBnClickedStdNative() {
	ItemPropertySheet* ps = dynamic_cast<ItemPropertySheet*> (this->GetOwner());
	if (m_is_native_btn.GetCheck()) {
		ps->AddPage (const_cast<IppNative*> (&ps->get_native_page ()));
	} else {
		ps->RemovePage (const_cast<IppNative*> (&ps->get_native_page ()));
	}
}

void IppStd::OnEnSetfocusName() {
	this->SetModified (true);
}

void IppStd::OnBnClickedButton3() {
	StCollection st (this->get_rose_item());

	st.DoModal ();

	std::string res = st.get_result();
	if (res != "") {
		GCL::StrVector parts = GCL::split_string_by_sub_string (res.data(), "::");
		if (parts.size() == 2) {
			int index = m_model_stereotype.FindStringExact (0, parts[0].data());
			if (index != CB_ERR) {
				m_model_stereotype.SetCurSel (index);
			}
		} else if (parts.size() >= 3) {
			if (parts[2] == "Operation" || parts[2] == "Attribute" || parts[2] == "ClassDependency") {
				//m_model_stereotype.SelectString (0, "");
				m_model_stereotype.SetCurSel (0);
			} else {
				int index = m_model_stereotype.FindStringExact (0, parts[2].data());
				if (index != CB_ERR) {
					m_model_stereotype.SetCurSel (index);
				}
			}
		}
	}
}

void IppStd::OnBnClickedContent()
{
	Contents  dlg (this->get_rose_item());
	dlg.DoModal();
}

void IppStd::OnBnClickedContentsChk() {
	if (m_contents_chk.GetCheck()) {
		m_contents_btn.EnableWindow(true);
		this->OnBnClickedContent();
	} else {
		m_contents_btn.EnableWindow(false);
	}
}

void IppStd::OnStnClickedStaticName2()
{
	// TODO: Add your control notification handler code here
}

void IppStd::OnBnClickedButton5() {
	RoseHelper::browse_item (this->get_rose_item());
}

void IppStd::OnBnClickedButton2() {
	if (MessageBox ("Are you shure to delete this item from model?", 0, MB_ICONEXCLAMATION | MB_YESNO) == IDYES) {				
		ItemPropertySheet* ps = dynamic_cast<ItemPropertySheet*> (this->GetOwner());
		IRoseElementPtr elem = ps->get_rose_item();	
		DeleteQuestion question (elem);
		if (question.DoModal () == IDOK) {
			ItemPropertySheet::s_ps_map.erase(get_rose_element_uid(elem));
			Commands::CmdManagerFactory::get ().remove (elem);
		}

		ps->get_rose_item() = 0;
		elem = 0;

		ps->set_specific_result(RoseHelper::ER_DELETE);
		ps->EndDialog (IDOK);
	}
}

void IppStd::OnBnClickedButton6() {
	ItemPropertySheet* ps = dynamic_cast<ItemPropertySheet*> (this->GetOwner());

	m_post_command = PCMD_CONTENT;
	m_post_command_item = ps->get_rose_item();

    ps->EndDialog (IDOK);
}

//#UC END# *4574173603A9*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IppStd::IppStd ()
	: IppBase (IppStd::IDD)
//#UC START# *4574173603A9_CTOR_BASE_INIT*
//#UC END# *4574173603A9_CTOR_BASE_INIT*
{
	//#UC START# *4574173603A9_CTOR*
	m_post_command = PCMD_NONE;
	//#UC END# *4574173603A9_CTOR*
}


IppStd::~IppStd () {
	//#UC START# *4574173603A9_DESTR_BODY*
	if (m_post_command == PCMD_CONTENT) {
		/*AbstractDumperBase::ReportsTreeItem content_rep ("Content");
		content_rep.query ("[{%PU=%MU}true]");
		content_rep.set_view ("Child name", "%SN", 140);
		content_rep.set_view ("Child stereotype", "%SS", 100);
		content_rep.set_view ("Child documentation", "%SD", 300);
		
		RoseHelper::check_model_for_changes ();
		ReportView dlg (m_post_command_item, &content_rep);
		
		dlg.DoModal ();*/
		ContentView dlg (m_post_command_item);
		dlg.DoModal ();
	}
	//#UC END# *4574173603A9_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(IppStd, IppBase)
	ON_WM_CREATE()
	//#UC START# *4574173603A9_MESSAGE_MAP*	
	ON_BN_CLICKED(IDC_BUTTON3, OnBnClickedButton3)
	ON_BN_CLICKED(IDC_BUTTON4, OnBnClickedButton4)
	ON_BN_CLICKED(IDC_CHECK2, OnBnClickedCheck2)
	ON_BN_CLICKED(IDC_CONTENT, OnBnClickedContent)
	ON_BN_CLICKED(IDC_CONTENTS_CHK, OnBnClickedContentsChk)
	ON_BN_CLICKED(IDC_STD_NATIVE, OnBnClickedStdNative)	
	ON_BN_CLICKED(IDC_BUTTON5, OnBnClickedButton5)
	ON_BN_CLICKED(IDC_BUTTON2, OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON6, OnBnClickedButton6)
	//#UC END# *4574173603A9_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNCREATE(IppStd, CPropertyPage)

void IppStd::DoDataExchange(CDataExchange* pDX) {
	CPropertyPage::DoDataExchange(pDX);
	//#UC START# *4574173603A9_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_MODEL_ST_COMBO, m_model_stereotype);
	DDX_Control(pDX, IDC_NAME, m_name);
	DDX_Control(pDX, IDC_DOC, m_doc);
	DDX_Control(pDX, IDC_STD_PROP_LINK_TYPE, m_link_type);
	DDX_Control(pDX, IDC_TARGET_ST, m_target_st);
	DDX_Control(pDX, IDC_STD_NATIVE, m_is_native_btn);
	DDX_Control(pDX, IDC_CHECK2, m_parameterized);
	DDX_Control(pDX, IDC_BUTTON4, m_templ_args_dlg);
	DDX_Control(pDX, IDC_CHECK3, m_global_chk);
	DDX_Control(pDX, IDC_GLOBAL_LOCALLY, m_global_locally_chk);	
	DDX_Control(pDX, IDC_CHECK4, m_is_main);
	DDX_Control(pDX, IDC_RB_PUBLIC, m_public_rb);
	DDX_Control(pDX, IDC_RB_PROTECTED, m_protected_rb);
	DDX_Control(pDX, IDC_RB_PRIVATE, m_private_rb);
	DDX_Control(pDX, IDC_RB_IMPL, m_impl_rb);
	DDX_Control(pDX, IDC_RB_ABSTRACT, m_abstract_rb);
	DDX_Control(pDX, IDC_RB_REGULAR, m_regular_rb);
	DDX_Control(pDX, IDC_RB_FINAL, m_final_rb);
	DDX_Control(pDX, IDC_RB_OPTIONAL, m_optional_rb);
	DDX_Control(pDX, IDC_CONTENTS_CHK, m_contents_chk);
	DDX_Control(pDX, IDC_CONTENT, m_contents_btn);
	DDX_Control(pDX, IDC_STATIC_NAME, m_static_name);
	DDX_Control(pDX, IDC_BUTTON6, m_content_btn);
	DDX_Control(pDX, IDC_GUID, m_guid);
	
	//Пока не используем!!!
	/*DDX_Control(pDX, IDC_VISIBILITY_LEVEL_SPIN, m_visibility_level);*/
	//#UC END# *4574173603A9_DO_DATA_EXCHANGE*
}

BOOL IppStd::OnInitDialog () {
	BOOL ret = IppBase::OnInitDialog();
	try {
		//#UC START# *4574173603A9_ON_INIT_DLG*
		this->fill_data(false);
		this->UpdateData(false);
		this->check_for_editable ();		

		m_content_btn.EnableWindow (true);
		//#UC END# *4574173603A9_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"IppStd\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int IppStd::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return IppBase::OnCreate (create_struct);
}

void IppStd::init_constraint () {
	//#UC START# *4574173603A9_CUSTOM_CONTROLS_CONSTRAINT*
	CPane check_pane = pane(VERTICAL, ABSOLUTE_HORZ | ALIGN_TOP)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_CHECK4, NORESIZE)
			<< item (IDC_CHECK3, NORESIZE)
			<< item (IDC_STD_NATIVE, NORESIZE)
		)
		<< item (IDC_GLOBAL_LOCALLY, NORESIZE | ALIGN_TOP)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT | ALIGN_TOP)
			<< item (IDC_CHECK2, NORESIZE | ALIGN_TOP)
			<< itemGrowing (HORIZONTAL)
			<< item (IDC_BUTTON4, NORESIZE | ALIGN_TOP | ALIGN_RIGHT))
		<< (pane (HORIZONTAL, ABSOLUTE_VERT | ALIGN_TOP)
			<< item (IDC_CONTENTS_CHK, NORESIZE | ALIGN_TOP)
			<< itemGrowing (HORIZONTAL)
			<< item (IDC_CONTENT, NORESIZE | ALIGN_TOP | ALIGN_RIGHT)
		)		
		//Пока не используем
		/*<< (pane (HORIZONTAL, ABSOLUTE_VERT | ALIGN_TOP)
				<< item (IDC_VISIBILITY_LEVEL_STATIC, NORESIZE | ALIGN_VCENTER)
				<< itemGrowing (HORIZONTAL)
				<< item (IDC_VISIBILITY_LEVEL_EDIT, NORESIZE)				
				<< item (IDC_VISIBILITY_LEVEL_SPIN, NORESIZE | ALIGN_RIGHT)
			)
		*/<< itemGrowing (VERTICAL);
	//CPane group_pane = paneCtrl( IDC_STATIC7, VERTICAL, NORESIZE, WinGUI::nDefaultBorder, 10, 10)
	//	<< check_pane;
	
	CPane edit_pane = pane (VERTICAL, GREEDY, 14)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_STATIC_NAME, NORESIZE)
			<< item (IDC_NAME, ABSOLUTE_VERT)
		)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_BUTTON3, NORESIZE)
			<< item (IDC_STATIC1, NORESIZE)
			<< item (IDC_MODEL_ST_COMBO, ABSOLUTE_VERT)
			<< itemGrowing (HORIZONTAL)
			<< item (IDC_GUID_STATIC, NORESIZE)
			<< item (IDC_GUID, ABSOLUTE_VERT)
		)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_STATIC2, NORESIZE)
			<< item (IDC_TARGET_ST, ABSOLUTE_VERT)
			<< itemGrowing (HORIZONTAL)
			<< item (IDC_STATIC3, NORESIZE)
			<< item (IDC_STD_PROP_LINK_TYPE, ABSOLUTE_VERT)
		) 
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_STATIC4, NORESIZE)
			<< item (IDC_RB_PUBLIC, NORESIZE)
//			<< itemGrowing (HORIZONTAL)
			<< item (IDC_RB_PROTECTED, NORESIZE)
//			<< itemGrowing (HORIZONTAL)
			<< item (IDC_RB_PRIVATE, NORESIZE)
//			<< itemGrowing (HORIZONTAL)
			<< item (IDC_RB_IMPL, NORESIZE)
		) 
//		<< itemGrowing (VERTICAL)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_STATIC5, NORESIZE)
			<< item (IDC_RB_REGULAR, NORESIZE)
//			<< itemGrowing (HORIZONTAL)
			<< item (IDC_RB_ABSTRACT, NORESIZE)
//			<< itemGrowing (HORIZONTAL)
			<< item (IDC_RB_FINAL, NORESIZE)
			<< item (IDC_RB_OPTIONAL, NORESIZE)
//			<< itemGrowing (HORIZONTAL)			
		);

	CPane buttons_pane = pane(VERTICAL, ABSOLUTE_HORZ)
		<< item (IDC_CONTENT_BTN, NORESIZE)
		<< item (IDC_BUTTON5, NORESIZE)
		<< item (IDC_BUTTON2, NORESIZE)		
		<< itemGrowing (VERTICAL);
	
	CPane actions_group_pane = paneCtrl( IDC_STATIC8, VERTICAL, GREEDY | ALIGN_FILL, WinGUI::nDefaultBorder, 10, 10)
		<< buttons_pane;

	CreateRoot (VERTICAL)
		<< (pane (VERTICAL)
			<< (pane (HORIZONTAL, ABSOLUTE_VERT)
				<< edit_pane				
				<< check_pane
			)
		) << (pane (HORIZONTAL)
			<< (pane (VERTICAL)
				<< item (IDC_STATIC6, NORESIZE)
				<< actions_group_pane
			)
			<< item (IDC_DOC, GREEDY)
		);
	//#UC END# *4574173603A9_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

