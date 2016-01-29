////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/StaticNode.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::StaticNode
//
// реализация ноды дерева (двух-направленные связи родитель->ребенок; лево->право)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"
// by <<uses>> dependencies
#include "shared/GCL/data/StaticNodeStubBase.h"

//#UC START# *4501367B01C5_CUSTOM_INCLUDES*
//#UC END# *4501367B01C5_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *4501367B01C5*
#ifdef _DEBUG
bool StaticNode::s_need_print = 1;
//long StaticNode::s_id = 0;
#endif

StaticNode::StaticNode () : m_parent (0), m_last_child (0), m_prev (0) {
	//LOG_D (("StaticNode[%d]::StaticNode", this));
	//ADD_OBJECT_WATCHER
	//m_id__ = ++s_id;
}

unsigned StaticNode::get_parents_count () const {
	unsigned n = 1;
	const StaticNode* p = this;
	while (p = p->m_parent) {
		++n;
	}
	return n;
}

void StaticNode::insert_next (StaticNode* node) {  // справо от себя (next)
	node->m_prev = this;
	node->m_next = m_next;
	node->m_parent = m_parent; 
	
	// fix next
	if (m_next.ptr()) {
		m_next->m_prev = node;
	} 

	// fix self
	m_next = node;	

	// fix parent
	if (m_parent) {
		if (this == m_parent->m_last_child) {
			m_parent->m_last_child = node;
		}
		m_parent->invalidate_children_count();
	}	
}

void StaticNode::insert_prev (StaticNode* node) {  // слева от себя (prev)
	StaticNode* prev_prev = m_prev;

	node->m_next = StaticNode::_duplicate (this);
	node->m_prev = prev_prev;
	node->m_parent = m_parent;
	
	// fix self
	m_prev = node;

	// fix prev
	if (prev_prev) {
		prev_prev->m_next = node;
	} 

	// fix parent	
	if (m_parent) {
		if (this == m_parent->m_first_child.ptr()) {
			m_parent->m_first_child = node;
		}
		m_parent->invalidate_children_count();
	}	
}

// изменение (удаление/перемещение)
void StaticNode::remove_from_tree () {	
	//fix next
	if (m_next.ptr()) {
		m_next->m_prev = m_prev;
	}

	StaticNode_var tmp_next = m_next._retn();

	//fix parent
	if (m_parent) {
		m_parent->invalidate_children_count();
		if (this == m_parent->m_last_child) {
			m_parent->m_last_child = m_prev;
		}

		if (this == m_parent->m_first_child.ptr()) {
			StaticNode* tmp_parent = m_parent;
			m_parent = 0;
			tmp_parent->m_first_child = tmp_next; // may be this is last referens for me			
			return; // m_prev is 0 - no need to fix
		} else {
			m_parent = 0;
		}
	}
	
	// fix prev
	if (m_prev) {
		StaticNode* tmp_prev = m_prev;
		m_prev = 0;
		tmp_prev->m_next = tmp_next; // may be this is last referens for me
		return;
	}	
}


void StaticNode::move_to_destination (StaticNode* dest_node) {
	StaticNode::_duplicate (this);
	this->remove_from_tree();
	dest_node->insert_back_child(this);
}

void StaticNode::copy_to_destination (StaticNode* dest_node) const {	
	dest_node->insert_back_child(this->copy());
}

StaticNode* StaticNode::copy () const {
	StaticNode_var copy = this->create_data_copy();

	for (const StaticNode* n = m_first_child.ptr(); n; n = n->m_next.ptr()) {
		copy->insert_back_child(n->copy());
	}
	return copy._retn();
}

// очистить все дочерние узлы
void StaticNode::clear_children () {
	m_first_child = 0;
	m_last_child = 0;
}

// доступ к атрибутам узла
unsigned long StaticNode::level () const { //получить уровень ноды 
	unsigned long ret = 0;
	
	if (!m_parent) {
		return ret;
	} else {
		ret = 1;
	}
	
	StaticNode* parent = m_parent;
	while (parent = parent->m_parent) {
		ret++;
	}

	return ret;
}

unsigned long StaticNode::_load_children_count () const { //количество непосредственных детей 
	unsigned long ret = 0;

	//for (const StaticNode* cp = m_first_child.ptr ()/*m_last_child*/; cp; cp = cp->m_next.ptr ()/*m_prev*/) {
	for (const StaticNode* cp = m_last_child; cp; cp = cp->m_prev) {
		const StaticNodeStubBase* snsb = dynamic_cast<const StaticNodeStubBase*>(cp);
		if (snsb) {
			long stub_count = snsb->stub_count();
			ret += abs(stub_count);
			if (stub_count != 1 && snsb->has_pair()) {
				ret++;
				cp = cp->m_prev;
			}
		} else {
			ret++;
		}
	}

	return ret;
}

const StaticNode* StaticNode::child_by_index (unsigned long index) const {
	for (const StaticNode* cp = m_first_child.ptr(); cp; cp = cp->m_next.ptr()) {
		if (!index) {
			return StaticNode::_duplicate (cp);
		}

		const StaticNodeStubBase* snsb = dynamic_cast<const StaticNodeStubBase*>(cp);
		if (snsb) {
			long stub_count = snsb->stub_count();
			GDS_ASSERT (stub_count >= -1); //ses: incredible!!! algorithm error

			unsigned long ind = abs(stub_count);

			if (index < ind) {
				if (!index) {
					return StaticNode::_duplicate (cp);
				}
				return snsb->get_at (index);
			} else {
				index -= ind;
				if (!index) {
					return cp->m_next._sretn ();
				}
			}

			if (ind != 1 && snsb->has_pair()) {
				index--;
				cp = cp->m_next.in ();
			}
		} else {
			index--;
		}
	}
	
	return 0;
}

void StaticNode::invalidate_children_count () const {
	ChildrenMapSingleton::instance ()->invalidate (this);
}

unsigned long StaticNode::parent_level (const StaticNode* node) const {
	unsigned long ret = 0;
	const StaticNode* parent = this;

	while (parent = parent->m_parent) {
		ret++;
		if (parent == node) {
			return ret;
		}
	}
	return 0;
}

long StaticNode::get_index_from_parent () const {
	long count = 1;
	StaticNode* p = this->m_prev;

	long i;
	bool negative_stub = false;
	for (; p; p = p->m_prev) {
		i = p->get_nodes_count_for_me ();
		if (negative_stub) {
			if (i > 1) {
				i = 1;
			}
			negative_stub = false;
		}
		if (i < 0) {
			negative_stub = true;
			i = -i;
		}
		count += i;
	}

	return count;
}

/*unsigned long NodeBase::index () const {
	unsigned long ret = 0;
	const StaticNode* node = this;
		
	for (const StaticNode* cp = m_prev; cp; cp = cp->m_prev) {		
			
		StaticNodeStubBase* snsb = dynamic_cast<StaticNodeStubBase*>(cp);

		if (snsb) {
			long sc = snsb->stub_count();
			if (sc < 0) {
				ret += -sc;
			} else {
				ret++;
			}
		} else {
			ret++;			
		}
	}

	return ret;
}*/

bool StaticNode::is_first_child_of_child_of_root () const {
	//is_first_child
	if (this->m_prev) {
		return false;
	}

	//is_child_of_child_of_root
	StaticNode* parent = this->m_parent;
	if (!parent) {
		return false;
	}
	StaticNode* maybe_root = parent->m_parent;
	if (!maybe_root) {
		return false;
	}

	return !maybe_root->m_parent;
}
//#UC END# *4501367B01C5*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StaticNode::~StaticNode () {
	//#UC START# *4501367B01C5_DESTR_BODY*
	//LOG_D (("StaticNode[%d]::~StaticNode", this));
	StaticNode* n = m_first_child.ptr();
	if (n) {
		while (n && n->ref_count() == 1) {
			n = n->m_next.ptr();
		}
		if (!n) {
			n = m_last_child;
		}

		for (; n; n = n->m_prev) {
			n->m_next = 0;
		}

		// reqursive occures!  why???
	}

	ChildrenMapSingleton::instance ()->invalidate(this);
	//REMOVE_OBJECT_WATCHER
	//#UC END# *4501367B01C5_DESTR_BODY*
}


} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

