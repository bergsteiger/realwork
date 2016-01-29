////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/Tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::Tree
//
// Шаблонный класс, позволяет создавать древовидные структуры из любых объектов и типов (включая
// примитивные)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_TREE_H__
#define __SHARED_GCL_DATA_TREE_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *450138270399_CUSTOM_INCLUDES*
#include <vector>
#include <functional>
#include <map>
#include <set>
//#UC END# *450138270399_CUSTOM_INCLUDES*

namespace GCL {

// Шаблонный класс, позволяет создавать древовидные структуры из любых объектов и типов (включая
// примитивные)
template <class T, bool is_sort = true , class Pred = std::less<T> >
class Tree {
	SET_OBJECT_COUNTER (Tree)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~Tree ();


//#UC START# *450138270399*
public:
	typedef T* Item_ptr;
	typedef std::vector<Item_ptr> Items;

	class UnknownElement : public Core::Exception {
		const char* what () const throw () {
			return "UnknownElement (исключение при обращении к элементу не пренадлежащему дереву)";
		}

		const char* uid () const /*throw ()*/ {
			return "GCL::Tree::UnknownElement";
		}
	};
	
	class AlreadyInTree : public Core::Exception {
		const char* what () const throw () {
			return "AlreadyInTree (исключение при попытки вставить элемент уже находящийся в дереве)";
		}

		const char* uid () const /*throw ()*/ {
			return "GCL::Tree::AlreadyInTree";
		}		
	};

protected:
	struct Node;

	struct NodeSort : public std::binary_function<const Node*, const Node*, bool> {
		bool operator()(const Node* const x, const Node* const y) const {
			return *x->item < *y->item;
		}
    };
	
	typedef std::vector<Node*> VectorCont;
	typedef std::set<Node*,NodeSort> SetCont;
	typedef typename Loki::Select<is_sort, SetCont, VectorCont>::Result NodeChilds;

	struct Node {
		Node* parent;
		Item_ptr item;
		NodeChilds childs;
		Node () : parent (0), item (0) {
		}		
	};
	typedef std::map<T, Node, Pred> NodeTree;

public:
	// простой итератор аналогичный stl-евскому
	// обертка над итератором от map-шаблона, возврящает только ключ аналогично итератору от set-шаблона
	class iterator {
		typename NodeTree::iterator m_it;
	public:
		iterator ( typename NodeTree::iterator it ) : m_it (it) {
		}
		void operator ++ (int) {
			m_it++;
		}
		Item_ptr operator *() {
			const T& item = (*m_it).first;
			return (Item_ptr)&item;
		}
		bool operator == (iterator it) {
			return it.m_it == m_it;
		}
		bool operator != (iterator it) {
			return it.m_it != m_it;
		}
	};

public:
	// создает дерево начиная с переданного элемента
	Tree(const T& root);
	// добавляет "соседа"
	void add_sibling (const T& to, const T& subling);
	// добавляет "ребенка"
	void add_child (const T& to, const T& child);
	// возвращает родителя
	Item_ptr parent (const T& to) const;

	bool is_child_of_parent ( const T& child, const T& parent ) const;

	// возвращает детей
	Items childs (const T& to) const;
	// возвращает всех детей (рекурсивно)
	Items all_childs (const T& to) const;
	// возвращает всех "братьев"
	Items sublings (const T& to) const;
	
	Item_ptr find (const T& key) {
		NodeTree::iterator it =  m_tree.find ( key );
		if ( it != m_tree.end() ) return (*it).second.item;
		return 0;
	}
	
	void remove (const T& key);
	// методы для удаления или перемещения элементов пока отсутствют
	
	unsigned long get_level (const T& to) const;	
	unsigned long get_child_count(const T& to) const;
	unsigned long get_all_child_count (const T& to) const;
	unsigned long get_index (const T& to) const;
	unsigned long get_through_index (const T& to) const;

	// возвращает итератор на первый элемент развернутого дерева 
	// отсортированного по возрастанию элементов
	iterator begin () {
		iterator it (m_tree.begin());
		return it;
	}
	
	// возвращает конец развернутого дерева 
	iterator end () {
		iterator it (m_tree.end());
		return it;
	}

protected:
	const Node& find_node (const T& key) const;
	Node& create_node (const T& key);
	void collect_childs (const T& to, Items& items) const;
	void collect_childs_count (const Node* to, unsigned long& count) const;

	void insert_child (Node* to, Node* node, Loki::Int2Type<true>) {
		to->childs.insert(node);
	}
	void insert_child (Node* to, Node* node, Loki::Int2Type<false>) {
		to->childs.push_back(node);
	}

	void remove_child (Node* from, Node* node, Loki::Int2Type<true>) {
		from->childs.erase(node);
	}

	void remove_child (Node* from, Node* node, Loki::Int2Type<false>) {
		from->childs.erase (std::remove (from->childs.begin (), from->childs.end (), node), from->childs.end ());
	}


private:
	NodeTree m_tree;
//#UC END# *450138270399*
}; // class Tree

} // namespace GCL

#include "shared/GCL/data/Tree.i.h"

#endif //__SHARED_GCL_DATA_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

