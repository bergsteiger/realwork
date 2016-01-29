////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/StaticNode.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::StaticNode
//
// реализация ноды дерева (двух-направленные связи родитель->ребенок; лево->право)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_STATICNODE_H__
#define __SHARED_GCL_DATA_STATICNODE_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4501367B01C5_CUSTOM_INCLUDES*
#include "shared/Core/mng/CacheMap.h"
//#UC END# *4501367B01C5_CUSTOM_INCLUDES*

namespace GCL {

// реализация ноды дерева (двух-направленные связи родитель->ребенок; лево->право)
class StaticNode;
typedef Core::Var<StaticNode> StaticNode_var;
typedef Core::Var<const StaticNode> StaticNode_cvar;

class StaticNode :
	virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (StaticNode)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~StaticNode ();


//#UC START# *4501367B01C5*
	// exceptions
	class ConcreteClassMustImplement {
	};

public:
	static const StaticNode* shift_prev (const StaticNode*& node) {
		return node = node->m_prev;
	}

	static StaticNode* shift_prev (StaticNode*& node) {
		return node = node->m_prev;
	}

	static const StaticNode* shift_next (const StaticNode*& node) {
		return node = node->m_next.ptr();
	}

	static StaticNode* shift_next (StaticNode*& node) {
		return node = node->m_next.ptr();
	}

	static const StaticNode* shift_up (const StaticNode*& node) {
		return node = node->m_parent;
	}

	static StaticNode* shift_up (StaticNode*& node) {
		return node = node->m_parent;
	}

	struct VoidCloneFilter {
		static bool is_meet (const StaticNode*) {
			return true;
		}
	};

	template <class _StaticNodeType, class _StaticNodeFactory, class _CloneFilter>
	static _StaticNodeType* clone_tree (const _StaticNodeType* source, _StaticNodeFactory* factory, const _CloneFilter& filter) {
		Core::Var<_StaticNodeType> new_node = factory->make_copy(source);
		
		_StaticNodeType* source_ch = dynamic_cast<_StaticNodeType*>(source->m_last_child);
		while (source_ch) {
			if (filter.is_meet (source_ch)) {
				new_node->insert_front_child (clone_tree (source_ch, factory, filter));
			}
			source_ch = dynamic_cast<_StaticNodeType*>(source_ch->m_prev);
		}

		return new_node._retn();
	}

	template <class _EachFunc, class _EachArgs>
	void for_each (_EachFunc& func, _EachArgs& res) {
		func.each_func (this, res);
		
		StaticNode* ch = m_last_child;
		while (ch) {
			ch->for_each (func, res);
			ch = ch->m_prev;
		}
	}

	template <class _EachFunc, class _EachArgs>
	void for_each (_EachFunc& func, _EachArgs& res) const {
		func.each_func (this, res);
		
		StaticNode* ch = m_last_child;
		while (ch) {
			ch->for_each (func, res);
			ch = ch->m_prev;
		}
	}

protected:
	unsigned get_parents_count () const;

public:
	virtual const StaticNode* child_by_index (unsigned long index) const; // NOT CONSTRUCTOR!!!!
	virtual StaticNode* child_by_index (unsigned long index) { // NOT CONSTRUCTOR!!!!
		return const_cast<StaticNode*>(((const StaticNode*const)this)->child_by_index (index));
	}

	virtual StaticNode* create_data_copy () const {
		throw ConcreteClassMustImplement ();
	}

	virtual StaticNode* remove_me_and_siblings (unsigned long& count) {
		StaticNode_var ret = StaticNode::_duplicate(m_next.ptr());
		this->remove_from_tree ();
		count--;
		return ret._retn();
	}

	virtual long get_nodes_count_for_me () {
		return 1;
	}

	virtual long get_index_from_parent () const;

 
public:
	StaticNode ();

#ifdef _DEBUG
	static bool s_need_print;

	void print_tree() const {
		if (s_need_print) {
			StaticNode* root = const_cast<StaticNode*>(this);
			while (root->m_parent) {
				root = root->m_parent;
			}

			root->draw_node(0, 0);
			root->print_childs(0);
		}
	}

	virtual void draw_node (unsigned level, unsigned index) const {
		// empty
	};

	void print_childs (unsigned level) const {
		level++;
		unsigned index = 0;
		for (const StaticNode* n = m_first_child.ptr(); n; n = n->m_next.in ()) {
			n->draw_node(level, index++);
			n->print_childs(level);
		}
	}
#endif

	bool is_it_higher (const StaticNode* it) const {
		if (it == this || !it) {
			return false;
		}
		
		// balance levels
		unsigned my_level = this->level();
		unsigned it_level = it->level();

		const StaticNode* my_branch = this;
		const StaticNode* it_branch = it;

		long delta = my_level - it_level;
		if (delta > 0) {
			for (; delta; delta--) {
				StaticNode::shift_up (my_branch);
			}
		} else if (delta < 0) {
			for (; delta; delta++) {
				StaticNode::shift_up (it_branch);
			}
		}

		if (my_branch == it_branch) {
			return my_level - it_level > 0;
		}

		//find common parent
		while (it_branch->m_parent != my_branch->m_parent) {
			StaticNode::shift_up (my_branch);
			StaticNode::shift_up (it_branch);
		}

		//gos up from smaler adress
		if (my_branch > it_branch) {
			const StaticNode* tmp_my_branch = my_branch;
			while (tmp_my_branch) {
				StaticNode::shift_prev (tmp_my_branch);
				if (tmp_my_branch == it_branch) {
					return false;
				}
			}
			return true;
		} else {
			const StaticNode* tmp_it_branch = it_branch;
			while (tmp_it_branch) {
				StaticNode::shift_prev (tmp_it_branch);
				if (tmp_it_branch == my_branch) {
					return true;
				}
			}
			return false;
		}		
	}

	bool is_my_child (const StaticNode* child) {
		for (const StaticNode* c = m_last_child; c; c = c->m_prev) {
			if (c == child) {
				return true;
			}
		}
		return false;
	}

	/* [Tree DEBUG Start]
	bool is_my_child_ex (const StaticNode* child, std::vector<const StaticNode*>& vec) {
		for (const StaticNode* y = m_last_child; y; y = y->m_prev) {
			int x = 0;
		}

		for (const StaticNode* c = m_last_child; c; c = c->m_prev) {
			vec.push_back (c);
			if (c == child) {
				return true;
			}
		}
		return false;
	}
	*/ 
	// [Tree DEBUG End]

	virtual bool is_equal (const StaticNode* e) const {
		return e == this;
	}
	
	// доступ к структуре
	const StaticNode* root () const {
		const StaticNode* node = this;
		while (node->m_parent) {
			node = node->m_parent;
		}
		return StaticNode::_duplicate(node);
	}
	
	StaticNode* root () {
		StaticNode* node = this;
		while (node->m_parent) {
			node = node->m_parent;
		}
		return StaticNode::_duplicate(node);
	}

	const StaticNode* parent () const {
		return StaticNode::_duplicate (m_parent);
	}

	StaticNode* parent () {
		return StaticNode::_duplicate (m_parent);
	}

	virtual const StaticNode* next () const {
		return m_next._sretn();
	}

	virtual StaticNode* next () {
		return m_next._sretn();
	}

	virtual StaticNode* prev () {
		return StaticNode::_duplicate (m_prev);
	}

	virtual const StaticNode* prev () const {
		return StaticNode::_duplicate (m_prev);
	}

	bool is_prev (const StaticNode* prev) const {
		return prev ? m_prev == prev : false;
	}

	const StaticNode* first_child () const {
		return m_first_child._sretn();
	}

	StaticNode* first_child () {
		return m_first_child._sretn();
	}

	StaticNode* last_child () {
		return StaticNode::_duplicate (m_last_child);
	}

	const StaticNode* last_child () const {
		return StaticNode::_duplicate (m_last_child);
	}

	bool is_last () const {
		return m_next.ptr() == 0;
	}

	// Первый элемент.
	bool is_first () const {
		return m_prev == 0;
	}

	// Есть ли дочерние элементы.
	bool has_children () const {
		return m_last_child != 0;
	}

	/*bool has_sub_child () const {
		for (StaticNode* cp = m_last_child; cp; cp = cp->_prev()) {
			if (cp->m_last_child) {
				return true;
			}
		}
		return false;
	}*/

	bool is_root() const {
		return m_parent == 0;
	}

	// создание структуры
	void insert_back_child (StaticNode* node) {  // в конец списка детей
		if (this->m_last_child != 0) {
			m_last_child->insert_next(node);
		} else {
			this->insert_front_child(node);
		}
	}

	void parent_is_dead () {
		m_parent = 0;
	}

	void insert_front_child (StaticNode* node) {  // в начало списка детей
		if (m_first_child.ptr()) {
			m_first_child->insert_prev(node);
		} else {
			m_first_child = node;
			m_last_child = node;			
			node->m_parent = this;
			this->invalidate_children_count();
		}
	}
	void insert_next (StaticNode* node);  // справо от себя
	void insert_prev (StaticNode* node);  // слево от себя

	// изменение (удаление/перемещение)
	void remove_from_tree ();
	void move_to_destination (StaticNode* dest_node); // work inside one tree
	void copy_to_destination (StaticNode* dest_node) const; // recursive, work inside one tree

	// make node copy
	StaticNode* copy () const;
	// очистить все дочерние узлы
	void clear_children ();

	// доступ к атрибутам узла
	virtual unsigned long level () const; //получить уровень ноды 
	
	unsigned long children_count () const { //количество непосредственных детей 
		return m_last_child ? ChildrenMapSingleton::instance ()->get_value (this) : 0;
	}

	unsigned long parent_level (const StaticNode* node) const; // уровень вложенности в node, 0 если node не является предком
		
	virtual bool operator == (const StaticNode& c) const {
		return this == &c;
	}
	virtual bool operator != (const StaticNode& c) const {
		return this != &c;
	}
	virtual bool operator < (const StaticNode& c) const {
		return this < &c;
	}

	virtual void invalidate_children_count () const;

protected:
	virtual unsigned long _load_children_count() const;

protected:
	friend class StaticNodeStubBase; // GARANT_FRIEND

	struct ChildrenCountLoader {
		static unsigned long load_value (const StaticNode* node) {
			return node->_load_children_count();
		}
	};

public:
	typedef Core::CacheMap<const StaticNode*, unsigned long, ChildrenCountLoader> ChildrenMap;
	typedef ACE_Singleton <StaticNode::ChildrenMap, ACE_SYNCH_RECURSIVE_MUTEX> ChildrenMapSingleton;
	
protected:
	StaticNode* m_parent;
	StaticNode_var m_next;
	StaticNode* m_prev;
	StaticNode_var m_first_child;
	StaticNode* m_last_child;

#ifdef _DEBUG
	//static long s_id;
	//long m_id__;
public:
	//void _dump (FILE* to_dump) const {
	//	fprintf (to_dump, "StaticNode [%d] id:[%d]", this, m_id__);
	//}
#endif

public:
	bool is_first_child_of_child_of_root () const;
//#UC END# *4501367B01C5*
}; // class StaticNode

} // namespace GCL


#endif //__SHARED_GCL_DATA_STATICNODE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

