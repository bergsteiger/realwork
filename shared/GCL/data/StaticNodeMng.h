////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/StaticNodeMng.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::StaticNodeMng
//
// "интерфейс" менеджера нод, умеющий создавать реальные ноды
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_STATICNODEMNG_H__
#define __SHARED_GCL_DATA_STATICNODEMNG_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"
#include "shared/GCL/data/StaticNodeStubBase.h"

namespace GCL {

// "интерфейс" менеджера нод, умеющий создавать реальные ноды
class StaticNodeMng {
// virtual void destructor
public:
	virtual ~StaticNodeMng () {};

//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// создать ноду
	virtual StaticNode* make_real_node (
		const StaticNode* parent
		, const StaticNode* prev
		, long offset
		, StaticNodeStubBase* current_stub
	) = 0;

	// функция вызывается перед удалением?
	virtual void pre_remove (const StaticNode* node, unsigned int count = 0) = 0;

}; // class StaticNodeMng

} // namespace GCL


#endif //__SHARED_GCL_DATA_STATICNODEMNG_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

