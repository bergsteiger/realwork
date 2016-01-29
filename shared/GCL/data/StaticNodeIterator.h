////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/StaticNodeIterator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::StaticNodeIterator
//
// итератор по дереву
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_STATICNODEITERATOR_H__
#define __SHARED_GCL_DATA_STATICNODEITERATOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"

namespace GCL {

// итератор по дереву
class StaticNodeIterator {
	SET_OBJECT_COUNTER (StaticNodeIterator)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// root - нода с которой начнется поиск
	explicit StaticNodeIterator (StaticNode* root);

public:
	virtual ~StaticNodeIterator ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// получение следующего элемента дерева
	virtual StaticNode* get_next ();

	// инициализация итератора
	virtual void init (StaticNode* root);

private:
	// возвращение на уровень вверх
	virtual StaticNode* up_level ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// текущая нода, на которую указывает итератор
	StaticNode_var m_current;

	// флаг показывает первый ли раз спросили get_next
	bool m_is_first;
}; // class StaticNodeIterator

} // namespace GCL


#endif //__SHARED_GCL_DATA_STATICNODEITERATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

