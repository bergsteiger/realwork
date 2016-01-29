////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/Facade/Factory.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Morpho::Facade::Factory
//
// Фабрика
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_FACADE_FACTORY_H__
#define __SHARED_MORPHO_FACADE_FACTORY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/Def/Def.h"

namespace Morpho {

// Фабрика
class Factory {
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// фабрика
	static Def::INormalizer* make (Def::ICache* cache);

	// фабрика
	static Def::ICache* make ();

	// фабрика
	static Def::INormalizer* make (Def::ICache* cache, Def::IMorphoAdapter* adapter);

	// фабрика
	static Def::ICache* make_for_txt (const std::string& path);

}; // class Factory

} // namespace Morpho


#endif //__SHARED_MORPHO_FACADE_FACTORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

