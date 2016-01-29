////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeIterator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i.h"

//#UC START# *45F7BD35005D_CUSTOM_INCLUDES*
//#UC END# *45F7BD35005D_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F7BD35005D*
//#UC END# *45F7BD35005D*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NodeIterator_i::NodeIterator_i (DefaultNodeBase* from_node, FlagMask with_flag)
//#UC START# *4625D990000F_BASE_INIT*
: m_cur_node (Core::IObject::_duplicate(from_node)), m_with_flags (with_flag)
//#UC END# *4625D990000F_BASE_INIT*
{
	//#UC START# *4625D990000F_BODY*
	m_root = m_cur_node->is_root () ? 0 : m_cur_node.ptr ();
	//#UC END# *4625D990000F_BODY*
}

NodeIterator_i::~NodeIterator_i () {
	//#UC START# *45F7BD35005D_DESTR_BODY*
	//#UC END# *45F7BD35005D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

GCL::StaticNode* NodeIterator_i::get_base_next () const {
	//#UC START# *45FFB5C40128*
	if (!m_cur_node.is_nil ()) {
		m_cur_node = m_cur_node->next_with_flag (m_with_flags);

		if (m_root) {
			if (!m_root->is_my_child(m_cur_node.in())) {
				m_cur_node = 0;
			}
		}
	}

	return m_cur_node._sretn ();	
	//#UC END# *45FFB5C40128*
}

GTree::CompactSelectorList* NodeIterator_i::make_compact_selectors () const {
	//#UC START# *45FFB5FE0261*
	std::vector<GTree::CompactSelector> selector_list;
	
	// оболочка подает root дерева в операци, использующие этот метод
	// алгоритм обходит все дерево, независимо от параметра конструктора 'from'
	GDS_ASSERT (m_cur_node->is_root ());
	
	std::vector<const GCL::StaticNode*> root_list;
	root_list.push_back (m_cur_node.in ());
	
	while (!root_list.empty ()) {
		std::vector<const GCL::StaticNode*> next;
		for (size_t i = 0; i < root_list.size (); ++i) {
			
			GTree::CompactSelector selector;
			selector.count = 0;
			selector.from.parent_pointer = dynamic_cast<const DefaultNodeBase*>(root_list[i])->get_server_pointer ();
			selector.from.child_index = 0;
			selector.include_subtree = false;
			
			Core::Var <const GCL::StaticNode> first_child = root_list[i]->first_child ();
			long j = 0;
			for (const GCL::StaticNode* child = first_child.ptr (); child; GCL::StaticNode::shift_next (child)) {
				
				const FlagNodeBase* flag_node = dynamic_cast<const FlagNodeBase*> (child);
				const DefaultNodeBase* node = dynamic_cast <const DefaultNodeBase*> (child);
				
				if (node && flag_node->has_flag (FM_OPEN)) {                      // элементы с установленным флагом 'OPEN'
					next.push_back (child);                                         // запоминаем для последующей обработки
				}
				
				if (!flag_node->has_flag (m_with_flags)) {                        // искомый флаг не установлен,
					CSH::try_close_selector (selector, selector_list);              // пробуем закрыть сформированный селектор

					if (!node) {                                                    // учет заглушки: надо передвинуть индекс 'j'
						long stub_count = CSH::get_stub_count (const_cast<GCL::StaticNode*> (child));                // соответственно кол-ву элементов
                                                                          // представляемых заглушкой;
						if (stub_count > 1) {
							GCL::StaticNode::shift_next (child);                             // переход на связанную отрицательную заглушку
						}
						
						j += stub_count;
					} else {
						++j;
					}	
					continue;                                                       // и переходим к следующему узлу
				}
				
				if (!selector.count) {                                            // узел подходит =>
					CSH::open_selector (selector, j);                               // открываем селектор (если надо)
				}
				
				if (node) {                                                       // считаем кол-во подряд идущих 
					selector.count++;                                               // подходящих узлов
					++j;
				} else {                                                          // подходящая заглушка:
					if (flag_node->has_flag (FM_OPEN)) {                            // с флагом 'FM_OPEN' => 
						CSH::try_close_selector (selector, selector_list);            // выбираем все поддерево 
						CSH::open_selector (selector, j);                             // отдельным селектором
					}

					long stub_count = CSH::get_stub_count (const_cast<GCL::StaticNode*> (child));
					selector.count += stub_count;

					if (flag_node->has_flag (FM_OPEN)) {
						selector.include_subtree = true;
						CSH::close_selector (selector, selector_list);
					}
					
					if (stub_count > 1) {
						GCL::StaticNode::shift_next (child);                               // переход на связанную отрицательную заглушку
					}
					
					j += stub_count;
				}
			}
			CSH::try_close_selector (selector, selector_list);
		}
		next.swap (root_list);
	}

	GTree::CompactSelector* buf = GTree::CompactSelectorList::allocbuf (selector_list.size ());
	memcpy (buf, &*(selector_list.begin ()), selector_list.size () * sizeof (GTree::CompactSelector));
	return new GTree::CompactSelectorList (selector_list.size (), selector_list.size (), buf, 1);
	//#UC END# *45FFB5FE0261*
}

GTree::SelectorList* NodeIterator_i::make_selectors () const {
	//#UC START# *45FFB5E70399*
	std::vector<GTree::NodeSelector> sels;
	NodeBase_cvar next;
	do {
		GTree::NodeSelector sel;

		next = this->get_next ();
		if (next.ptr()) {
			sel.child_pointer = dynamic_cast<const DefaultNodeBase*>(next.ptr ())->get_server_pointer ();

			NodeBase_cvar parent;
			parent = next->get_parent ();
			if (parent.ptr()) {
				sel.parent_pointer = dynamic_cast<const DefaultNodeBase*>(parent.ptr ())->get_server_pointer ();
			} else {
				sel.parent_pointer = GTree::ROOT_PARENT_POINT;
			}

			sels.push_back(sel);
		}
	} while (next.ptr());

	GTree::NodeSelector* buf = GTree::SelectorList::allocbuf (sels.size ());
	memcpy (buf, &*(sels.begin ()), sels.size () * sizeof (GTree::NodeSelector));
	return new GTree::SelectorList (sels.size (), sels.size (), buf, 1);
	//#UC END# *45FFB5E70399*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NodeIterator
const NodeBase* NodeIterator_i::get_next () const {
	//#UC START# *45FFB3E000FA_45F7BD35005D_GET*
	if (!m_cur_node.is_nil ()) {
		m_cur_node = m_cur_node->next_with_flag (m_with_flags);

		if (m_root) {
			if (!m_root->is_my_child(m_cur_node.in())) {
				m_cur_node = 0;
			}
		}
	}

	if (dynamic_cast<FlagNodeStub*> (m_cur_node.ptr ())) {
		m_cur_node = FlagNodeBase::_duplicate(
			dynamic_cast<FlagNodeBase*> (
				dynamic_cast<FlagNodeStub*> (m_cur_node.ptr ())->transform_to_real_node ()
			)
		);
	}

	return dynamic_cast<NodeBase*> (m_cur_node._sretn ());
	// fuck the current NON-TIE template :(((
	//if (!next) {
	//	m_cur_node.release ();
	//	return dynamic_cast<NodeDelegate*> (m_cur_node._sretn());
	//}
	//#UC END# *45FFB3E000FA_45F7BD35005D_GET*
}

NodeBase* NodeIterator_i::get_next () {
	return const_cast<NodeBase*>(((const NodeIterator_i*)this)->get_next ());
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

