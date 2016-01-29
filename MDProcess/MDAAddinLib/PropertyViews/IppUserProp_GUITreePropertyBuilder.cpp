////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppUserProp_GUITreePropertyBuilder.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::PropertyViews::IppUserProp::GUITreePropertyBuilder
//
// класс для построение дерева контролов для отображения свойств элмента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppUserProp.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

class IppUserProp;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
// prop - контэйнер дерева контролов
IppUserProp::GUITreePropertyBuilder::GUITreePropertyBuilder (IppUserProp& prop)
//#UC START# *46FC9FC7035B_BASE_INIT*
: m_prop (&prop)
//#UC END# *46FC9FC7035B_BASE_INIT*
{
	//#UC START# *46FC9FC7035B_BODY*
	//#UC END# *46FC9FC7035B_BODY*
}

IppUserProp::GUITreePropertyBuilder::~GUITreePropertyBuilder () {
	//#UC START# *46FC8D2A02AF_DESTR_BODY*
	//#UC END# *46FC8D2A02AF_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// метод для построения дерева контролов по дереву групп свойств (root)
void IppUserProp::GUITreePropertyBuilder::build (const AbstractDumperBase::PropertyGroupTreeItem* root) {
	//#UC START# *46FC9D960196*	
	
	WinGUI::COptionTree& option_tree = m_prop->get_properties_tree ();
	WinGUI::COptionTreeItem* gui_root = NULL;
	this->fill_group (
		option_tree
		, gui_root
		, root
	);
	//GCL::StaticNodeIterator tree_iter (const_cast<AbstractDumperBase::PropertyGroupTreeItem*> (root));
	//for (
	//	AbstractDumperBase::PropertyGroupTreeItem_var group = dynamic_cast<AbstractDumperBase::PropertyGroupTreeItem*> (tree_iter.get_next ())
	//	; !group.is_nil ()
	//	; group = dynamic_cast<AbstractDumperBase::PropertyGroupTreeItem*> (tree_iter.get_next ())
	//) {
		/*unsigned long level = group->level ();
		std::string text (level + 1, '-');
		text += ">";
		text += group->get_name ();
		LOG_D ((text.c_str ()));
		
		const AbstractDumperBase::UserPropertyMap& props = group->get_properties ();
		AbstractDumperBase::UserPropertyMap::const_iterator it;	
		for (
			it = props.begin()
			; it != props.end()
			; ++it
		) {
			LOG_D ((it->first.c_str ()));
		}*/

		//COptionTreeItem* root = option_tree.InsertItem (new COptionTreeItem());
		//root->SetLabelText(group->get_name ().c_str ());
		//this->fill_properties (group->get_properties (), *root);

		//IppUserProp::OptionTreeItemMap::iterator group_item; //группа, в которую будут добавляться свойства
		//AbstractDumperBase::PropertyGroupTreeItem_var parent 
		//	= dynamic_cast<AbstractDumperBase::PropertyGroupTreeItem*> (group->parent ());
		//
		//if (parent.is_nil ()) {
		//	//значит group - эту рут дерева
		//	unsigned long level = group->level ();
		//	group_item = m_roots.find (level);
		//	if (group_item == m_roots.end ()) {
		//		group_item = m_roots.insert (
		//			IppUserProp::OptionTreeItemMap::value_type (
		//				level
		//				, option_tree.InsertItem (new COptionTreeItem())
		//			)
		//		).first;
		//		GDS_ASSERT(group_item->second);
		//		group_item->second->SetLabelText(group->get_name ().c_str ());
		//	}
		//} else {
		//	unsigned long parent_level = parent->level ();
		//	IppUserProp::OptionTreeItemMap::iterator parent_root
		//		= m_roots.find (parent_level);
		//	if (parent_root == m_roots.end ()) {
		//		parent_root = m_roots.insert (
		//			IppUserProp::OptionTreeItemMap::value_type (
		//				parent_level
		//				, option_tree.InsertItem (new COptionTreeItem())
		//			)
		//		).first;
		//		GDS_ASSERT(parent_root->second);
		//		parent_root->second->SetLabelText(parent->get_name ().c_str ());			
		//	}
		//	
		//	group_item = m_roots.insert (
		//		IppUserProp::OptionTreeItemMap::value_type (
		//			parent_level
		//			, option_tree.InsertItem (new COptionTreeItem(), parent_root->second)
		//		)
		//	).first;
		//	GDS_ASSERT(group_item->second);
		//	group_item->second->SetLabelText(group->get_name ().c_str ());
		//}
		//GDS_ASSERT(group_item != m_roots.end () && group_item->second);		
		//this->fill_properties (group->get_properties (), *group_item->second);
	//}	
	//#UC END# *46FC9D960196*
}

// заполняет дерево группами
void IppUserProp::GUITreePropertyBuilder::fill_group (
	WinGUI::COptionTree& option_tree
	, WinGUI::COptionTreeItem*& node
	, const AbstractDumperBase::PropertyGroupTreeItem* group
) {
	//#UC START# *47008D1F0196*
	GDS_ASSERT (group);
	if (node == 0) {
		node = option_tree.InsertItem (new WinGUI::COptionTreeItem());
		node->SetLabelText(group->get_name ().c_str ());	
		this->fill_properties (group->get_properties (), *node);
		fill_group (option_tree, node, group);
	} else {
		Core::Var<const AbstractDumperBase::PropertyGroupTreeItem> child 
			= dynamic_cast<const AbstractDumperBase::PropertyGroupTreeItem*>(group->first_child());
		
		while (!child.is_nil()) {
			WinGUI::COptionTreeItem* ht_child = option_tree.InsertItem (new WinGUI::COptionTreeItem(), node);
			ht_child->SetLabelText(child->get_name ().c_str ());
			
			this->fill_properties (child->get_properties (), *ht_child);

			if (child->has_children()) {
				fill_group (option_tree, ht_child, child.in());
			}
			child = dynamic_cast<const AbstractDumperBase::PropertyGroupTreeItem*>(child->next());
		}
	}
	//#UC END# *47008D1F0196*
}

// метод заполняет группу контролами для конкретных свойств
void IppUserProp::GUITreePropertyBuilder::fill_properties (
	const AbstractDumperBase::UserPropertyMap& props
	, WinGUI::COptionTreeItem& group
) {
	//#UC START# *46FC8DB70186*
	IRoseItemPtr item = m_prop->get_rose_item();
	AbstractDumperBase::UserPropertyMap::const_iterator it;	
	for (
		it = props.begin()
		; it != props.end()
		; ++it
	) {
		std::string prop_name = it->first;
		std::string val = (char*) item->GetPropertyValue (Base::USER_PROPERTY_TOOL, prop_name.data());
		if (val.empty ()) {
			val = it->second.def_value;				
		}
		std::string description = it->second.description;
		AbstractDumperBase::UserPropertyMap::const_iterator f = it;	
		
		WinGUI::COptionTree& tree = m_prop->get_properties_tree ();
		if (f->second.type == AbstractDumperBase::UPT_LIST) {
			WinGUI::COptionTreeItemComboBox* item 
				= (WinGUI::COptionTreeItemComboBox*)tree.InsertItem (
					new WinGUI::COptionTreeItemComboBox (), &group
				);
			GDS_ASSERT(item);
			item->SetLabelText (prop_name.c_str ());
			item->SetInfoText (description.c_str ());

			if (item->CreateComboItem (0) == TRUE) {
				for (
					GCL::StrVector::const_iterator it = f->second.value_list.begin()
					; it != f->second.value_list.end()
					; it++
				) {							
					item->AddString (it->c_str());
				}
				item->SelectString (-1, val.c_str ());					
			}				
			if (val != f->second.def_value) {
				item->AddButton(_D_BT_DEFAULT);
			}
			m_prop->add_property (item);
		} else if (f->second.type == AbstractDumperBase::UPT_TRIBOOL) {
			WinGUI::COptionTree3StateCheckBox* item = (WinGUI::COptionTree3StateCheckBox*)tree.InsertItem (
				new WinGUI::COptionTree3StateCheckBox (), &group
			);
			GDS_ASSERT(item);
			item->SetLabelText (prop_name.c_str ());
			item->SetInfoText (description.c_str ());
			
			if (item->CreateCheckBoxItem(false, OT_CHECKBOX_SHOWCHECK | OT_CHECKBOX_SHOWTEXT) == true) {
				item->SetCheckText(_T("true"), _T("false"));
				item->set_undefined_str ("undefined");
				if (val == "true") {
					item->set_state (true);
				} else if (val == "false") {
					item->set_state (false);
				} else {
					item->set_state (boost::indeterminate);
				}
			}				
			if (val != f->second.def_value) {
				item->AddButton(_D_BT_DEFAULT);
			}
			m_prop->add_property (item);				
		} else if (f->second.type == AbstractDumperBase::UPT_BOOL) {
			WinGUI::COptionTreeItemCheckBox* item = (WinGUI::COptionTreeItemCheckBox*)tree.InsertItem (
				new WinGUI::COptionTreeItemCheckBox (), &group
			);
			GDS_ASSERT(item);
			item->SetLabelText (prop_name.c_str ());
			item->SetInfoText (description.c_str ());
			
			if (item->CreateCheckBoxItem(false, OT_CHECKBOX_SHOWCHECK | OT_CHECKBOX_SHOWTEXT) == TRUE) {
				item->SetCheckText(_T("true"), _T("false"));
				if (val == "true") {
					item->SetCheck (true);
				} else {
					item->SetCheck (false);
				}
			}				
			if (val != f->second.def_value) {
				item->AddButton(_D_BT_DEFAULT);
			}
			m_prop->add_property (item);				
		} else if (f->second.type == AbstractDumperBase::UPT_COLOR) {
			WinGUI::COptionTreeItemColor* item = (WinGUI::COptionTreeItemColor*)tree.InsertItem (
				new WinGUI::COptionTreeItemColor (), &group
			);
			GDS_ASSERT(item);
			item->SetLabelText (prop_name.c_str ());
			item->SetInfoText (description.c_str ());
							
			COLORREF color = OT_COLOR_NO_SELECTION;
			COLORREF def_colors = RGB(0, 0, 0);
			try {
				if (val.empty () == false) {
					color = boost::lexical_cast<COLORREF> (val);
				}
				if (f->second.def_value.empty () == false) {
					def_colors =  boost::lexical_cast<COLORREF> (f->second.def_value);
				}
			} catch (std::exception&) {						
			}			
			if (item->CreateColorItem(NULL, color, def_colors) == TRUE) {
			}
			
			if (val != f->second.def_value) {
				item->AddButton(_D_BT_DEFAULT);
			}
			m_prop->add_property (item);	
		} else if (f->second.type == AbstractDumperBase::UPT_FILE) {			
			WinGUI::COptionTreeItemFile* item = new WinGUI::COptionTreeItemFile();
			item = (WinGUI::COptionTreeItemFile*)tree.InsertItem(
				item, &group
			);
			GDS_ASSERT(item);
			item->SetLabelText (prop_name.c_str ());
			item->SetInfoText (description.c_str ());
			if (
				item->CreateFileItem (
					_T("")
					, _T("")
					, _T("All files|*.*|")
					, OT_FILE_OPENDIALOG | OT_FILE_SHOWFULLPATH | OT_FILE_NOFIND
					, OFN_OVERWRITEPROMPT
				) == TRUE
			) {
				item->SetFileName (val.c_str ());
			}
			if (val != f->second.def_value) {
				item->AddButton(_D_BT_DEFAULT);
			}
			m_prop->add_property (item);
		} else if (f->second.type == AbstractDumperBase::UPT_STRING || f->second.type == AbstractDumperBase::UPT_TEXT) {
			WinGUI::COptionTreeItemEdit* item = (WinGUI::COptionTreeItemEdit*)tree.InsertItem (
				new WinGUI::COptionTreeItemEdit (), &group
			);
			GDS_ASSERT(item);
			item->SetLabelText (prop_name.c_str ());
			item->SetInfoText (description.c_str ());
			//item->SetDrawMultiline (TRUE);
			
			if (item->CreateEditItem(f->second.type == AbstractDumperBase::UPT_TEXT ? OT_EDIT_MULTILINE : 0, 0) == TRUE) {
				std::string new_line_replaced = val;
				const char replacer[] = {ROSE_NEWLINE_REPLACEMENT, '\0'};
				GCL::str_replace (new_line_replaced, replacer, "\r\n");
				item->SetEditText (new_line_replaced.c_str ());
			} else {
				LOG_E (("%s - CreateEditItem failed, GDS_CURRENT_FUNCTION"));
			}
			if (val != f->second.def_value) {
				item->AddButton(_D_BT_DEFAULT);
			}
			m_prop->add_property (item);
		} else {
			GDS_ASSERT_MSG(false, ("Unknown property type, name: %s, type: %d", prop_name.c_str (), f->second.type));
		}
	}
	//#UC END# *46FC8DB70186*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

