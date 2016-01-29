////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapComImpl/MemoryPoolImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MMapComImpl::MemoryPoolImpl
// Заголовк реализации фабрик интерфеса PoolListHandler для серванта MemoryPoolImpl
//
// Реализация пула.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPCOMIMPL_MEMORYPOOLIMPL_FCTR_H__
#define __SHARED_GCI_MMAPCOMIMPL_MEMORYPOOLIMPL_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/MMapComImpl/MMapComImplFactories.h"
#include "shared/GCI/impl/MMapComImpl/MMapComImpl.h"

#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

/// Interface-factory implementation for MemoryPoolImpl
class MemoryPoolImpl_factory: virtual public ::Core::RefCountObjectBase, virtual public PoolListHandlerAbstractFactory {
public:
	MemoryPoolImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MMap::MemoryPool* get ();

};

typedef ::Core::Var<MemoryPoolImpl_factory> MemoryPoolImpl_factory_var;

} // namespace MMapComImpl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPCOMIMPL_MEMORYPOOLIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

