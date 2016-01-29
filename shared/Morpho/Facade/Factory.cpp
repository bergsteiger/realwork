////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/Facade/Factory.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Morpho::Facade::Factory
//
// Фабрика
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/Facade/Factory.h"
// by <<uses>> dependencies
#include "shared/Morpho/impl/Impl/Normalizer_i.h"
#include "shared/Morpho/impl/Impl/Cache_i.h"
#include "shared/Morpho/impl/Impl/CacheTxt_i.h"

namespace Morpho {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// фабрика
Def::INormalizer* Factory::make (Def::ICache* cache) {
	//#UC START# *5150897A0099*
	return new Impl::Normalizer_i (cache, 0);
	//#UC END# *5150897A0099*
}

// фабрика
Def::ICache* Factory::make () {
	//#UC START# *5151E23302B8*
	return new Impl::Cache_i ();
	//#UC END# *5151E23302B8*
}

// фабрика
Def::INormalizer* Factory::make (Def::ICache* cache, Def::IMorphoAdapter* adapter) {
	//#UC START# *51B710720234*
	return new Impl::Normalizer_i (cache, adapter);
	//#UC END# *51B710720234*
}

// фабрика
Def::ICache* Factory::make_for_txt (const std::string& path) {
	//#UC START# *52DFE23501C0*
	return new Impl::CacheTxt_i (path);
	//#UC END# *52DFE23501C0*
}

} // namespace Morpho

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

