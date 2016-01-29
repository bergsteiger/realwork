////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppDerivedImpl_TreeNode.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::PropertyViews::IppDerivedImpl::TreeNode
//
// Представляет собой элемент данных для отображения в дереве
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppDerivedImpl.h"

class IppDerivedImpl;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// созадёт ноду
IppDerivedImpl::TreeNode::TreeNode (IRoseElementPtr elem, InheritedItem* inherited_state)
//#UC START# *49818ABB02BF_BASE_INIT*
: m_real_elem (elem)
//#UC END# *49818ABB02BF_BASE_INIT*
{
	//#UC START# *49818ABB02BF_BODY*
	if (inherited_state) {
		set_inhertied_state (inherited_state);
	}
	//#UC END# *49818ABB02BF_BODY*
}

IppDerivedImpl::TreeNode::~TreeNode () {
	//#UC START# *498189C400D7_DESTR_BODY*
	//#UC END# *498189C400D7_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает уникальный идентифкатор элемента
const std::string IppDerivedImpl::TreeNode::get_guid () const {
	//#UC START# *49818D6A005D*
	return get_rose_element_uid(m_real_elem);
	//#UC END# *49818D6A005D*
}

// возвращает имя ноды
const std::string IppDerivedImpl::TreeNode::name () const {
	//#UC START# *49818AE301C5*
	if (m_real_elem->IsClass (ROSE_ITEM_TYPE)) {
		std::string stereotype = ((IRoseItemPtr)m_real_elem)->GetStereotype ();
		if (!stereotype.empty ()) {
			return std::string ("<<")
				+ stereotype
				+ std::string (">> ")
				+ std::string (static_cast<const char*> (m_real_elem->GetName ()));
		}
	}
	return std::string (static_cast<const char*> (m_real_elem->GetName ()));
	//#UC END# *49818AE301C5*
}

// дополнительное имя (для операции - сигнатура, для классов - имя родителя, для атрибутов - имя
// типа)
const std::string IppDerivedImpl::TreeNode::subname () const {
	//#UC START# *4B17B7E4007E*
	if (m_real_elem->IsClass (ATTRIBUTE_TYPE)) {
		IRoseAttributePtr attr = m_real_elem;
		return std::string (": ") + std::string (static_cast<const char*> (attr->Type));
	} else if (m_real_elem->IsClass (OPERATION_TYPE)) {
		IRoseOperationPtr op = m_real_elem;
		IRoseParameterCollectionPtr params = op->GetParameters ();
		short params_count = params->Count;

		std::string sub_name ("(");
		for (short i = 1; i <= params_count; ++i) {
			IRoseParameterPtr param = params->GetAt (i);
			sub_name += std::string (static_cast<const char*> (param->Name));
			sub_name += ": ";
			sub_name += std::string (static_cast<const char*> (param->Type));

			if (i != params_count) {
				sub_name += ", ";
			}
		}

		sub_name += ")";
		
		std::string type (static_cast<const char*> (op->ReturnType)); 
		if (!type.empty ()) {
			sub_name += ": " + type;
		}

		return sub_name;
	} else if (m_real_elem->IsClass (CLASS_TYPE)) {
		IRoseElementPtr parent = ((IRoseClassPtr)m_real_elem)->GetContext ();
		if (parent) {
			std::string sub_name ("(from ");
			sub_name += std::string (static_cast<const char*> (parent->Name));
			sub_name += ")";
			
			return sub_name;
		}
	}

	return std::string ();
	//#UC END# *4B17B7E4007E*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const InheritedItem* IppDerivedImpl::TreeNode::get_inhertied_state () const {
	//#UC START# *4C19F33C03A8_GET_ACCESSOR*
	return m_inhertied_state.in ();
	//#UC END# *4C19F33C03A8_GET_ACCESSOR*
}

void IppDerivedImpl::TreeNode::set_inhertied_state (InheritedItem* inhertied_state) {
	//#UC START# *4C19F33C03A8_SET_ACCESSOR*
	m_inhertied_state = InheritedItem::_duplicate(inhertied_state);
	//#UC END# *4C19F33C03A8_SET_ACCESSOR*
}

IRoseElementPtr IppDerivedImpl::TreeNode::get_real_elem () const {
	//#UC START# *4C177C2C01F3_GET_ACCESSOR*
	return m_real_elem;
	//#UC END# *4C177C2C01F3_GET_ACCESSOR*
}

void IppDerivedImpl::TreeNode::set_real_elem (IRoseElementPtr real_elem) {
	//#UC START# *4C177C2C01F3_SET_ACCESSOR*
	m_real_elem = real_elem;
	//#UC END# *4C177C2C01F3_SET_ACCESSOR*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

