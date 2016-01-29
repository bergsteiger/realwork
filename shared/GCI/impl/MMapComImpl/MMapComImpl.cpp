////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapComImpl/MMapComImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> shared::GCI::MMapComImpl
//
// платформонезависимая часть реализации MMAP
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include <typeinfo>
#include "shared/GCI/impl/MMapComImpl/MMapComImpl.h"
#include "shared/GCI/impl/MMapComImpl/MMapComImplFactories.h"

#if defined(WIN32)

namespace GCI {
namespace MMapComImpl {

// factory interface wrapper for PoolListHandler
PoolListHandler& PoolListHandlerFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	try {
		return dynamic_cast<PoolListHandler&> (MMap::MemoryPoolFactory::get ());
	} catch (std::bad_cast&) {
		throw Core::Root::NoActiveFactory ("GCI::MMapComImpl::PoolListHandlerFactory");
	}

}



} //namespace MMapComImpl
} // namespace GCI

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

