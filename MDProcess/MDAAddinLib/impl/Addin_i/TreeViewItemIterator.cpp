////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/TreeViewItemIterator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::TreeViewItemIterator
//
// итератор по вью-дерева
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/TreeViewItemIterator.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TreeViewItemIterator::TreeViewItemIterator (ATLControls::CTreeItem& root, bool in_root_only)
//#UC START# *45D4631C006D_BASE_INIT*
//#UC END# *45D4631C006D_BASE_INIT*
{
	//#UC START# *45D4631C006D_BODY*	
	m_in_root_only = in_root_only;
	this->init (root);
	//#UC END# *45D4631C006D_BODY*
}

TreeViewItemIterator::~TreeViewItemIterator () {
	//#UC START# *45D462C100BB_DESTR_BODY*
	//#UC END# *45D462C100BB_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// следующий элемент
ATLControls::CTreeItem TreeViewItemIterator::get_next () {
	//#UC START# *45D46350034B*
	if (m_is_first) {
		m_is_first = false;
		return m_current;		
	} else {		
		ATLControls::CTreeItem node_out;
		ATLControls::CTreeItem out_node;
		
		if (m_in_root_only) {
			if (m_current == m_root) {
				node_out = m_current.GetChild ();
			} else {
				if (m_current.HasChildren ()) {
					m_parents_with_children.push_back (m_current);
				}
				node_out = m_current.GetNextSibling ();			
				if (node_out.IsNull ()) {
					if (!m_parents_with_children.empty ()) {
						node_out = m_parents_with_children.front ().GetChild ();
						 //удаляем первый элемент из списка
						m_parents_with_children.erase (m_parents_with_children.begin ());
					}
				}
			}
		} else {
			if (m_current.HasChildren ()) {
				m_parents_with_children.push_back (m_current);
				node_out = m_current.GetNextSibling ();
			} else {			
				node_out = m_current.GetNextSibling ();			
				if (node_out.IsNull ()) {
					if (!m_parents_with_children.empty ()) {
						node_out = m_parents_with_children.front ().GetChild ();
						 //удаляем первый элемент из списка
						m_parents_with_children.erase (m_parents_with_children.begin ());
					}
				}
			}
		}
		m_current = node_out;
		out_node = m_current;
		return out_node;
	}
	//#UC END# *45D46350034B*
}

// инициализация итератора
void TreeViewItemIterator::init (ATLControls::CTreeItem root) {
	//#UC START# *45D473320167*
	m_current = root;
	m_root = root;
	m_is_first = true;
	//#UC END# *45D473320167*
}

// поднимаемся на уровень вверх, от текущего положения
ATLControls::CTreeItem TreeViewItemIterator::up_level () {
	//#UC START# *45D4635C0251*
	ATLControls::CTreeItem out_node;
	ATLControls::CTreeItem parent;
	parent = m_current.GetParent ();

	if (!parent.IsNull ()) {
		ATLControls::CTreeItem next_node;
		next_node = parent.GetNextSibling ();
		if (next_node.IsNull ()){
			m_current = parent;
			out_node = up_level ();
		} else {
			out_node = next_node;
		}
	} else {
		out_node = ATLControls::CTreeItem ();
	}
	return out_node;
	//#UC END# *45D4635C0251*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

