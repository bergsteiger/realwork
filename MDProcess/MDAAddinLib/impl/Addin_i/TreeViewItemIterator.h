////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/TreeViewItemIterator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::TreeViewItemIterator
//
// итератор по вью-дерева
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_TREEVIEWITEMITERATOR_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_TREEVIEWITEMITERATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "MDProcess/MDAAddinLib/MDAGui/ATLControls.h"


// итератор по вью-дерева
class TreeViewItemIterator {
	SET_OBJECT_COUNTER (TreeViewItemIterator)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// массив элементов дерева-вью
	typedef std::vector < ATLControls::CTreeItem > TreeItemVec;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	TreeViewItemIterator (ATLControls::CTreeItem& root, bool in_root_only);

public:
	virtual ~TreeViewItemIterator ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// следующий элемент
	virtual ATLControls::CTreeItem get_next ();

	// инициализация итератора
	virtual void init (ATLControls::CTreeItem root);

private:
	// поднимаемся на уровень вверх, от текущего положения
	virtual ATLControls::CTreeItem up_level ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ATLControls::CTreeItem m_current;

	// итерирование будет вестись только по элементам ниже m_root
	bool m_in_root_only;

	bool m_is_first;

	TreeItemVec m_parents_with_children;

	ATLControls::CTreeItem m_root;
}; // class TreeViewItemIterator



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_TREEVIEWITEMITERATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

