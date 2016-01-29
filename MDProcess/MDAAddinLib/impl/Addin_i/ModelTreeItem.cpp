////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/ModelTreeItem.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::ModelTreeItem
//
// дерево с данными для браузера модели
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/ModelTreeItem.h"
// by <<uses>> dependencies
#include "shared/GCL/data/StaticNodeIterator.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *45C704E301A5_CUSTOM_INCLUDES*
//#UC END# *45C704E301A5_CUSTOM_INCLUDES*


//#UC START# *45C704E301A5*
//#UC END# *45C704E301A5*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// функция копирования элемента
ModelTreeItem* ModelTreeItem::make_copy (const ModelTreeItem* source) {
	//#UC START# *45C708660109*
	ModelTreeItem_var ret = new ModelTreeItem (source->get_item ());
	return ret._retn();
	//#UC END# *45C708660109*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ModelTreeItem::ModelTreeItem (IRoseElementPtr elem)
//#UC START# *45C706F3002E_BASE_INIT*
	: m_item_name ("")
	, m_item_uid ("")
	, m_item_stereotype ("")
//#UC END# *45C706F3002E_BASE_INIT*
{
	//#UC START# *45C706F3002E_BODY*
	this->init (elem);	
	//LOG_D (("Item was added: %s (%s)", m_item_name.c_str (), (const char*)elem->IdentifyClass ()));
	short count = 0;
	if (elem->IsClass (CATEGORY_TYPE)) {
		IRoseCategoryPtr cat = elem;
		IRoseCategoryCollectionPtr cats = cat->GetCategories ();
		if (cats) {
			count = cats->Count;
			for (short i = 1; i <= count; i++) {
				ModelTreeItem* new_item = new ModelTreeItem (cats->GetAt(i));
				this->insert_back_child (new_item);
			}
		}
				
		IRoseClassCollectionPtr clss = cat->GetClasses ();
		if (clss) {
			count = clss->Count;
			for (short i = 1; i <= count; i++) {
				ModelTreeItem* new_item = new ModelTreeItem (clss->GetAt(i));
				this->insert_back_child (new_item);
			}
		}

		IRoseCategoryDependencyCollectionPtr dps = cat->GetCategoryDependencies ();
		if (dps) {
			count = dps->Count;
			for (short i = 1; i <= count; i++) {
				ModelTreeItem* new_item = new ModelTreeItem (dps->GetAt(i));
				this->insert_back_child (new_item);
			}
		}

		IRoseClassDiagramCollectionPtr cls_diags = cat->ClassDiagrams;
		if (cls_diags != 0) {
			count = cls_diags->Count;
			for (short i = 1; i <= count; i++) {
				IRoseClassDiagramPtr cls_diag = cls_diags->GetAt(i);
				ModelTreeItem* new_item = new ModelTreeItem (cls_diag);

				std::string linked_uid = cls_diag->GetPropertyValue (
					TOOL_NAME, RoseHelper::CLASS_DIAG_LINK_PROPERTY
				);
				ModelTreeItem_var linked_elem;

				if (!linked_uid.empty ()) {
					//диаграмма с кем-то связана, пытаемся найти этот элемент
					GCL::StaticNodeIterator iter (this);
					for (
						ModelTreeItem_var found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
						; !found_node.is_nil ()
						; found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
					) {		
						if (found_node->get_item_uid () == linked_uid) {
							linked_elem = found_node;
							break;
						}
					}
					
					if (linked_elem.is_nil ()) {
						//элемент не нашли, значит просто добавляяем диаграмму в папку
						//и удаляем информацию о связанном элементе
						
						this->insert_back_child (new_item);
					} else {
						linked_elem->insert_back_child (new_item);
					}
				} else {
					//диаграмма ни с кем не связанна - добавляем её в папку
					this->insert_back_child (new_item);
				}							
			}
		}

		IRoseScenarioDiagramCollectionPtr scen_diags = cat->ScenarioDiagrams;
		if (scen_diags != 0) {
			count = scen_diags->Count;
			for (short i = 1; i <= count; i++) {
				IRoseScenarioDiagramPtr sc_diag = scen_diags->GetAt(i);
				ModelTreeItem* new_item = new ModelTreeItem (sc_diag);
				
				std::string use_case_uid = sc_diag->GetPropertyValue (TOOL_NAME, "UseCase");
				ModelTreeItem_var use_case;
				if (use_case_uid == "") {
					GCL::StaticNodeIterator iter (const_cast<ModelTreeItem*> (this));
					for (
						ModelTreeItem_var found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
						; !found_node.is_nil ()
						; found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
					) {	
						IRoseClassPtr cls = found_node->get_item ();
						if (
							cls != 0
							&& cls->Stereotype == _bstr_t ("UseCase")
							&& found_node->get_item ()->Name == sc_diag->Name
						) {
							use_case = found_node;
							break;
						}
					}
				} else {
				
					GCL::StaticNodeIterator iter (this);
					for (
						ModelTreeItem_var found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
						; !found_node.is_nil ()
						; found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
					) {		
						if (found_node->get_item_uid () == use_case_uid) {
							use_case = found_node;
							break;
						}
					}					
				}
				if (use_case.is_nil ()) {
					this->insert_back_child (new_item);
				} else {
					if (use_case->get_item_uid () != use_case_uid) {
					}
					use_case->insert_back_child (new_item);
				}
			}
		}
		IRoseStateMachineOwnerPtr state_machine_owner = cat->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				ModelTreeItem* new_item = new ModelTreeItem (st_machines->GetAt (i));
				this->insert_back_child (new_item);				
			}
		}		
	} else if (elem->IsClass (CLASS_TYPE)) {
		IRoseClassPtr cls = elem;
		IRoseClassCollectionPtr classes = cls->GetNestedClasses();
		count = classes->Count;
		for (short i = 1; i <= count; i++) {
			ModelTreeItem* new_item = new ModelTreeItem (classes->GetAt(i));
			this->insert_back_child (new_item);		
		}

		IRoseAttributeCollectionPtr attrs = cls->Attributes;
		count = attrs->Count;
		for (short i = 1; i <= count; i++) {		
			ModelTreeItem* new_item = new ModelTreeItem (attrs->GetAt(i));
			this->insert_back_child (new_item);
		}

		IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
		count = rl_attrs->Count;
		for (short i = 1; i <= count; i++) {
			IRoseRolePtr rl_attr = rl_attrs->GetAt(i);
			if (rl_attr->Navigable) {
				ModelTreeItem* new_item = new ModelTreeItem (rl_attr);
				this->insert_back_child (new_item);
			}
		}

		IRoseOperationCollectionPtr ops = cls->Operations;
		count = ops->Count;
		for (short i = 1; i <= count; i++) {
			ModelTreeItem* new_item = new ModelTreeItem (ops->GetAt(i));
			this->insert_back_child (new_item);
		}

		IRoseParameterCollectionPtr pars = cls->Parameters;
		count = pars->Count;
		for (short i = 1; i <= count; i++) {
			ModelTreeItem* new_item = new ModelTreeItem (pars->GetAt(i));
			this->insert_back_child (new_item);
		}

		IRoseClassDependencyCollectionPtr deps = cls->GetClassDependencies();
		count = deps->Count;
		for (short i = 1; i <= count; i++) {
			ModelTreeItem* new_item = new ModelTreeItem (deps->GetAt(i));
			this->insert_back_child (new_item);
		}

		IRoseStateMachineOwnerPtr state_machine_owner = cls->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				ModelTreeItem* new_item = new ModelTreeItem (st_machines->GetAt (i));
				this->insert_back_child (new_item);				
			}
		}
	} else if (elem->IsClass (ATTRIBUTE_TYPE)) {
		
	} else if (elem->IsClass ("Role"))  {		
		IRoseAttributeCollectionPtr atrs = ((IRoseRolePtr)elem)->GetKeys ();
		count = atrs->Count;
		for (short i = 1; i <= count; i++) {
			ModelTreeItem* new_item = new ModelTreeItem (atrs->GetAt(i));
			this->insert_back_child (new_item);
		}
	} else if (elem->IsClass ("Association"))  {
		IRoseRolePtr item = RoseHelper::get_role (elem);
		this->init (item);

		IRoseAttributeCollectionPtr atrs = item->GetKeys ();
		count = atrs->Count;
		for (short i = 1; i <= count; i++) {
			ModelTreeItem* new_item = new ModelTreeItem (atrs->GetAt(i));
			this->insert_back_child (new_item);
		}
	} else if (elem->IsClass (OPERATION_TYPE)) {
		IRoseOperationPtr op = elem;
		IRoseParameterCollectionPtr pars = op->GetParameters ();
		count = pars->Count;
		for (short i = 1; i <= count; i++) {
			ModelTreeItem* new_item = new ModelTreeItem (pars->GetAt(i));
			this->insert_back_child (new_item);
		}		
		IRoseStateMachineOwnerPtr state_machine_owner = op->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				ModelTreeItem* new_item = new ModelTreeItem (st_machines->GetAt (i));
				this->insert_back_child (new_item);				
			}
		}
	} else if (elem->IsClass ("StateMachine")) {
		IRoseStateMachinePtr st_machine = elem;
		IRoseStateDiagramCollectionPtr state_diags = st_machine->GetDiagrams ();
		short state_diags_count = state_diags->Count;
		for (short j = 1; j <= state_diags_count; ++j) {
			ModelTreeItem* new_item = new ModelTreeItem (state_diags->GetAt(j));
			this->insert_back_child (new_item);
		}

		IRoseStateCollectionPtr states = st_machine->States;
		short states_count = states->Count;
		for (short i = 1; i <=  states_count; ++i) {
			ModelTreeItem* new_item = new ModelTreeItem (states->GetAt(i));
			this->insert_back_child (new_item);
		}
	} else if (elem->IsClass ("StateDiagram")) {
	} else if (elem->IsClass ("State")) {
		IRoseStatePtr state = elem;
		IRoseTransitionCollectionPtr transitions = state->GetTransitions ();
		short transitions_count = transitions->Count;
		for (short i = 1; i <= transitions_count; ++i) {
			ModelTreeItem* new_item = new ModelTreeItem (transitions->GetAt (i));
			this->insert_back_child (new_item);
		}
		
		IRoseStateMachineCollectionPtr state_machines = state->GetStateMachines ();
		short state_machines_count = state_machines->Count;
		for (short i = 1; i <= state_machines_count; ++i) {
			ModelTreeItem* new_item = new ModelTreeItem (state_machines->GetAt (i));
			this->insert_back_child (new_item);
		}
		/*IRoseStateCollectionPtr states = state->GetSubStates ();
		short states_count = states->Count;
		for (short i = 1; i <= states_count; ++i) {
			ModelTreeItem* new_item = new ModelTreeItem (states->GetAt (i));
			this->insert_back_child (new_item);
		}*/
	} else if (elem->IsClass ("Transition")) {
		
	} else if (elem->IsClass (PARAMETER_TYPE)) {		

	} else if (elem->IsClass (CLASS_DEPENDENCY_TYPE)) {
		
	} else if (elem->IsClass ("CategoryDependency")) {
		
	} else if (elem->IsClass ("ScenarioDiagram")) {
	} else if (elem->IsClass ("ClassDiagram")) {

	} else {		
		LOG_E (("Unknown element: %s, class: %s", m_item_name.c_str (), (const char*)elem->IdentifyClass ()));
	}
	//#UC END# *45C706F3002E_BODY*
}

ModelTreeItem::~ModelTreeItem () {
	//#UC START# *45C704E301A5_DESTR_BODY*
	//#UC END# *45C704E301A5_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возврщает true если жлемент может быть перемещён в parent, иначе - false
bool ModelTreeItem::can_move_to (const ModelTreeItem* parent) const {
	//#UC START# *462746C40242*
	bool res = true;
	const IRoseElementPtr& item = this->get_item ();
	const IRoseElementPtr& parent_el = parent->get_item ();
	if (item->IsClass ("ScenarioDiagram")) {
		if (parent_el->IsClass (CATEGORY_TYPE)) {
			res = true;
		} else if (parent_el->IsClass (CLASS_TYPE)) {
			IRoseClassPtr cls = parent_el;
			res = (cls->Stereotype == _bstr_t ("UseCase"));
		} else {
			res = false;
		}
	} else if (
		item->IsClass ("ClassDiagram")
		|| item->IsClass ("State")
		|| item->IsClass ("StateMachine")
		|| item->IsClass ("Transition")
		|| item->IsClass ("StateDiagram")
		|| item->IsClass ("CategoryDependency")
		|| item->IsClass (CLASS_DEPENDENCY_TYPE)
		|| parent_el->IsClass ("ClassDiagram")
		|| parent_el->IsClass ("ScenarioDiagram")
		|| parent_el->IsClass ("StateDiagram")
		|| parent_el->IsClass ("StateMachine")
		|| parent_el->IsClass ("State")
		|| parent_el->IsClass ("Transition")
	) {
		res = false;
	} else if (
		!parent_el->IsClass (CLASS_TYPE)
		&& (
			item->IsClass (OPERATION_TYPE)
			|| item->IsClass (ATTRIBUTE_TYPE)
		)		
	) {
		res = false;
	} else if (
		!parent_el->IsClass (CLASS_TYPE)
		&& !parent_el->IsClass (CATEGORY_TYPE)
		&& item->IsClass (CLASS_TYPE)
	) {
		res = false;
	} else if (
		!parent_el->IsClass (CATEGORY_TYPE)
		&& item->IsClass (CATEGORY_TYPE)
	) {
		res = false;
	}
	return res;
	//#UC END# *462746C40242*
}

// инициализация ноды дерева
void ModelTreeItem::init (IRoseElementPtr elem) {
	//#UC START# *45C71A0A008C*
	m_item = elem;
	IRoseDiagramPtr diag = elem;
	IRoseItemPtr item = elem;
	
	m_item_name.clear ();
	m_item_stereotype.clear ();

	if (item) {				
		if (item->Stereotype != _bstr_t ("")) {
			m_item_stereotype = item->Stereotype;			
		}
	}				
	m_item_name += elem->GetName ();
	m_item_uid = get_rose_element_uid(elem);
	
	if (elem->IsClass (CLASS_DEPENDENCY_TYPE)) {
		IRoseClassDependencyPtr cls_dep = elem;
		std::string supplier_name = cls_dep->GetSupplierName ();
		m_item_name += " ";
		m_item_name += supplier_name;
		if (!cls_dep->HasSupplier ()) {
			m_item_name += "?";
		}
	} else if (elem->IsClass ("CategoryDependency")) {
		IRoseCategoryDependencyPtr cat_dep = elem;
		std::string supplier_name = cat_dep->GetSupplierName ();
		m_item_name += " ";
		m_item_name += supplier_name;
		if (!cat_dep->HasSupplier ()) {
			m_item_name += "?";
		}
	} else if (elem->IsClass ("Role")) {
		if (elem->Name == _bstr_t ("")) {
			m_item_name += "->";
			m_item_name += (const char*)((IRoseRolePtr)elem)->GetSupplierName ();
		}
	} else if (elem->IsClass ("Transition")) {
			IRoseTransitionPtr transition = elem;
			IRoseEventPtr rose_event = transition->GetTriggerEvent();
			if (rose_event) {
				m_item_name += (const char*)rose_event->Name;
			}
			IRoseActionPtr trigger_action = transition->GetTriggerAction ();
			if (trigger_action) {
				m_item_name += "/";
				m_item_name += (const char*)trigger_action->Name;
			}
	}
	//#UC END# *45C71A0A008C*
}

// return true if element moved successfully, other - false
bool ModelTreeItem::move_to (ModelTreeItem* parent) {
	//#UC START# *4627485A0167*	
	this->move_to_destination (parent);	
	return true;
	//#UC END# *4627485A0167*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

IRoseElementPtr ModelTreeItem::get_item () const {
	//#UC START# *45C7066203C8_GET_ACCESSOR*
	return m_item;
	//#UC END# *45C7066203C8_GET_ACCESSOR*
}

void ModelTreeItem::set_item (IRoseElementPtr item) {
	//#UC START# *45C7066203C8_SET_ACCESSOR*
	m_item = item;
	//#UC END# *45C7066203C8_SET_ACCESSOR*
}

const std::string& ModelTreeItem::get_item_name () const {
	//#UC START# *45C7054E000F_GET_ACCESSOR*
	return m_item_name;
	//#UC END# *45C7054E000F_GET_ACCESSOR*
}

void ModelTreeItem::set_item_name (const std::string& item_name) {
	//#UC START# *45C7054E000F_SET_ACCESSOR*
	m_item_name = item_name;
	//#UC END# *45C7054E000F_SET_ACCESSOR*
}

const std::string& ModelTreeItem::get_item_stereotype () const {
	//#UC START# *469B1F360222_GET_ACCESSOR*
	return m_item_stereotype;
	//#UC END# *469B1F360222_GET_ACCESSOR*
}

void ModelTreeItem::set_item_stereotype (const std::string& item_stereotype) {
	//#UC START# *469B1F360222_SET_ACCESSOR*
	m_item_stereotype = item_stereotype;
	//#UC END# *469B1F360222_SET_ACCESSOR*
}

const std::string& ModelTreeItem::get_item_uid () const {
	//#UC START# *45C706420222_GET_ACCESSOR*
	return m_item_uid;
	//#UC END# *45C706420222_GET_ACCESSOR*
}

void ModelTreeItem::set_item_uid (const std::string& item_uid) {
	//#UC START# *45C706420222_SET_ACCESSOR*
	m_item_uid = item_uid;
	//#UC END# *45C706420222_SET_ACCESSOR*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

