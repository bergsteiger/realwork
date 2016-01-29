////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/StaticNodeIterator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::StaticNodeIterator
//
// итератор по дереву
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/StaticNodeIterator.h"

namespace GCL {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// root - нода с которой начнется поиск
StaticNodeIterator::StaticNodeIterator (StaticNode* root)
//#UC START# *45C70C01004E_BASE_INIT*
//#UC END# *45C70C01004E_BASE_INIT*
{
	//#UC START# *45C70C01004E_BODY*
	this->init (root);
	//#UC END# *45C70C01004E_BODY*
}

StaticNodeIterator::~StaticNodeIterator () {
	//#UC START# *45C70B45008C_DESTR_BODY*
	//#UC END# *45C70B45008C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// получение следующего элемента дерева
StaticNode* StaticNodeIterator::get_next () {
	//#UC START# *45C70BA40000*
	if (m_is_first) {
		m_is_first = false;
		return m_current._sretn ();		
	} else {		
		GCL::StaticNode_var node_out;
		GCL::StaticNode* out_node;
		if (m_current->has_children ()) {
			node_out = m_current->first_child ();
		} else {
			node_out = m_current->next ();
			if (node_out.in () == 0)
			{
				GCL::StaticNode_var parent;
				parent = m_current->parent ();
				if (parent.in () != 0) {
					GCL::StaticNode_var up_node_out;
					up_node_out = up_level ();
					node_out = up_node_out._sretn ();
				}
			}
		}
		//m_parent = m_current;
		m_current = node_out;
		out_node = m_current._sretn ();
		return out_node;
	}
	//#UC END# *45C70BA40000*
}

// инициализация итератора
void StaticNodeIterator::init (StaticNode* root) {
	//#UC START# *45D473430242*
	m_current = GCL::StaticNode::_duplicate (root);
	m_is_first = true;
	//#UC END# *45D473430242*
}

// возвращение на уровень вверх
StaticNode* StaticNodeIterator::up_level () {
	//#UC START# *45C70BCC01F4*
	GCL::StaticNode* out_node;
	GCL::StaticNode_var parent;
	parent = m_current->parent ();

	if (parent.in () != 0) {
		GCL::StaticNode_var next_node;
		next_node = parent->next ();
		if (next_node.in () == 0){
			m_current = parent;
			out_node = up_level ();
		} else {
			out_node = next_node._sretn ();
		}
	} else {
		out_node = 0;
	}
	return out_node;
	//#UC END# *45C70BCC01F4*
}

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

