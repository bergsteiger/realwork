////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/Tree.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::Tree
//
// Шаблонный класс, позволяет создавать древовидные структуры из любых объектов и типов (включая
// примитивные)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"

//#UC START# *450138270399_CUSTOM_INCLUDES*
//#UC END# *450138270399_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *450138270399*
template <class T, bool is_sort, class Pred>
Tree<T,is_sort,Pred>::Tree( const T& root) {
	create_node (root);
}

template <class T, bool is_sort, class Pred>
void Tree<T,is_sort,Pred>::add_sibling ( const T& to, const T& subling ) {
	if ( !to ) return add_child (to, subling);
	else return add_child (parent(to), subling);		
}

template <class T, bool is_sort, class Pred>
void Tree<T,is_sort,Pred>::add_child ( const T& to, const T& child ) {
	const Node& parent_node = find_node (to);
	//hask const
	Node* no_const_parent_node = const_cast<Node*>(&parent_node);
	Node& node = create_node (child);
	node.parent = no_const_parent_node;
	insert_child (no_const_parent_node, &node, Loki::Int2Type<is_sort>());
}

template <class T, bool is_sort, class Pred>
typename Tree<T,is_sort,Pred>::Item_ptr Tree<T,is_sort,Pred>::parent ( const T& to ) const {
	const Node& node = find_node(to);
	if (!node.parent) return 0;
	else return node.parent->item;
}

template <class T, bool is_sort, class Pred>
bool Tree<T,is_sort,Pred>::is_child_of_parent ( const T& child, const T& parent ) const {
	const Node* node = &find_node(child);
	
	if (!node) {
		return false;
	}

	while (node->parent) {
		if (*(node->parent->item) == parent) {
			return true;
		}
		node = node->parent;
	}
	return false;
}

template <class T, bool is_sort, class Pred>
typename Tree<T,is_sort,Pred>::Items Tree<T,is_sort,Pred>::childs ( const T& to ) const {
	const Node& node = find_node(to);
	Items ch;
	for (NodeChilds::const_iterator it = node.childs.begin(); it != node.childs.end(); it++) {
		ch.push_back ((*it)->item);
	}
	return ch;
}

template <class T, bool is_sort, class Pred>
typename Tree<T,is_sort,Pred>::Items Tree<T,is_sort,Pred>::all_childs ( const T& to ) const {
	Items ch;
	this->collect_childs (to, ch);	
	return ch;
}

template <class T, bool is_sort, class Pred>
void Tree<T,is_sort,Pred>::collect_childs ( const T& to, Items& items ) const {
	const Node& node = find_node(to);
	for (NodeChilds::const_iterator it = node.childs.begin(); it != node.childs.end(); it++) {
		items.push_back ((*it)->item);
		this->collect_childs (*(*it)->item, items);
	}
}

template <class T, bool is_sort, class Pred>
typename Tree<T,is_sort,Pred>::Items Tree<T,is_sort,Pred>::sublings ( const T& to ) const {
	Item_ptr p = parent(to);
	if (p) {
		const Node& node = find_node(*p);
		Items ch;
		for (NodeChilds::const_iterator it = node.childs.begin(); it != node.childs.end(); it++) {
			if ( (*(*it)->item) != to ) ch.push_back ((*it)->item);
		}
		return ch;
	} else return Items();
};


template <class T, bool is_sort, class Pred>
const typename Tree<T,is_sort,Pred>::Node& Tree<T,is_sort,Pred>::find_node ( const T& key ) const {
	NodeTree::const_iterator it =  m_tree.find ( key );
	if ( it != m_tree.end() ) return (*it).second;
	else throw UnknownElement ();
}

template <class T, bool is_sort, class Pred>
typename Tree<T,is_sort,Pred>::Node& Tree<T,is_sort,Pred>::create_node ( const T& key ) {
	NodeTree::iterator it =  m_tree.find ( key );
	if ( it != m_tree.end() ) {
		throw AlreadyInTree();
	}
	
	it = m_tree.insert (NodeTree::value_type (key, Node())).first;

	it->second.item = (Item_ptr)&it->first;
	return it->second;

	/*Node& node = m_tree[key];
	
	it =  m_tree.find ( key );
	const T& item = (*it).first;
	node.item = (Item_ptr)&item;
	return node;*/
}

template <class T, bool is_sort, class Pred>
unsigned long Tree<T,is_sort,Pred>::get_level(const T& to) const {
	unsigned long ret = 0;

	const Node& node = find_node(to);
	const Node* parent = &node;

	while (parent = parent->parent) {
		ret++;
	}

	return ret;
}

template <class T, bool is_sort, class Pred>
unsigned long Tree<T,is_sort,Pred>::get_child_count(const T& to) const {
	const Node& node = find_node(to);
	return node.childs.size();
}

template <class T, bool is_sort, class Pred>
void Tree<T,is_sort,Pred>::collect_childs_count (const Node* to, unsigned long& count) const {
	count++;
	for (NodeChilds::const_iterator it = to->childs.begin(); it != to->childs.end(); it++) {
		this->collect_childs_count(*it, count);
	}
}

template <class T, bool is_sort, class Pred>
unsigned long Tree<T,is_sort,Pred>::get_all_child_count(const T& to) const {
	unsigned long ret = 0;
	const Node& node = find_node(to);
	this->collect_childs_count(&node, ret);
	ret--;
	
	return ret;
}

template <class T, bool is_sort, class Pred>
unsigned long Tree<T,is_sort,Pred>::get_index(const T& to) const {
	unsigned long ret = 0;
	const Node& node = find_node(to);
	
	if (!node.parent) return 0;
	for (
		NodeChilds::iterator it = node.parent->childs.begin()
		; it != node.parent->childs.end() && *it != &node
		; it++
	) {	
		ret++;
	}
	
	return ret;
}

template <class T, bool is_sort, class Pred>
unsigned long Tree<T,is_sort,Pred>::get_through_index(const T& to) const {
	unsigned long ret = 0;
	const Node& node = find_node(to);

	if (!node.parent) return 0;
	
	for (
		NodeChilds::iterator it = node.parent->childs.begin()
		; it != node.parent->childs.end() && *it != &node
		; it++
	) {	
		this->collect_childs_count(*it, ret);
	}
	
	return ret;
}
template <class T, bool is_sort, class Pred>
void Tree<T,is_sort,Pred>::remove (const T& key) {
	NodeTree::iterator it =  m_tree.find (key);
	if (it != m_tree.end ()) {
		Node& node = (*it).second;
		if (node.parent) {
			remove_child (node.parent, &node, Loki::Int2Type<is_sort> ());
		}
		m_tree.erase (it);
	}
}
//#UC END# *450138270399*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <class T, bool is_sort, class Pred>
Tree<T, is_sort, Pred>::~Tree () {
	//#UC START# *450138270399_DESTR_BODY*
	//#UC END# *450138270399_DESTR_BODY**cpp*
}


} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

