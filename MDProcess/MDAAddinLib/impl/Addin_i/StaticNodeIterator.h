////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/StaticNodeIterator.h"
// C++ header files (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::StaticNodeIterator
//
// итератор по дереву
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_STATICNODEITERATOR_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_STATICNODEITERATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"


// итератор по дереву
class StaticNodeIterator :
	virtual public Core::UnsortedLessBase
{
	SET_OBJECT_COUNTER (StaticNodeIterator)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// root - нода с которой начнется поиск
	explicit StaticNodeIterator (GCL::StaticNode* root);

public:
	virtual ~StaticNodeIterator ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// получение следующего элемента дерева
	virtual GCL::StaticNode* get_next ();

	// инициализация итератора
	virtual void init (GCL::StaticNode* root);

private:
	// возвращение на уровень вверх
	virtual GCL::StaticNode* up_level ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// текущая нода, на которую указывает итератор
	GCL::StaticNode_var m_current;

	// флаг показывает первый ли раз спросили get_next
	bool m_is_first;
}; // class StaticNodeIterator



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_STATICNODEITERATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

