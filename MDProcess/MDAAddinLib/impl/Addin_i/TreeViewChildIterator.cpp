////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/TreeViewChildIterator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::TreeViewChildIterator
//
// итератор по вью-дерева
// итерирование происходит от рута и повсем его детям
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/TreeViewChildIterator.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TreeViewChildIterator::TreeViewChildIterator (ATLControls::CTreeItem& root)
//#UC START# *45D471F801B5_BASE_INIT*
//#UC END# *45D471F801B5_BASE_INIT*
{
	//#UC START# *45D471F801B5_BODY*
	this->init (root);
	//#UC END# *45D471F801B5_BODY*
}

TreeViewChildIterator::~TreeViewChildIterator () {
	//#UC START# *45D471830280_DESTR_BODY*
	//#UC END# *45D471830280_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// следующий элемент
ATLControls::CTreeItem TreeViewChildIterator::get_next () {
	//#UC START# *45D472340109*
	if (m_is_first) {
		m_is_first = false;
		return m_current;		
	} else {		
		ATLControls::CTreeItem node_out;
		ATLControls::CTreeItem out_node;
		if (m_current.HasChildren ()) {
			node_out = m_current.GetChild ();
		} else if (m_root != m_current) {
			node_out = m_current.GetNextSibling ();
			if (node_out.IsNull ()) {
				ATLControls::CTreeItem parent = m_current.GetParent ();
				if (!parent.IsNull ()) {
					ATLControls::CTreeItem up_node_out = up_level ();
					node_out = up_node_out;
				}
			}
		}
		//m_parent = m_current;
		m_current = node_out;
		out_node = m_current;
		return out_node;
	}
	//#UC END# *45D472340109*
}

// инициализация итератора
void TreeViewChildIterator::init (ATLControls::CTreeItem root) {
	//#UC START# *45D472E9006D*
	m_current = root;
	m_root = root;
	m_is_first = true;
	//#UC END# *45D472E9006D*
}

// поднимаемся на уровень вверх, от текущего положения
ATLControls::CTreeItem TreeViewChildIterator::up_level () {
	//#UC START# *45D4726C0119*
	ATLControls::CTreeItem out_node;
	ATLControls::CTreeItem parent;
	parent = m_current.GetParent ();

	if (!parent.IsNull () && parent != m_root) {
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
	//#UC END# *45D4726C0119*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

