////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MorphoAdapter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MorphoAdapter_i
//
// Реализация интерфейса MorphoAdapter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/LibHome.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MorphoAdapter_i.h"
// by <<uses>> dependencies
#include "shared/Morpho/Def/Def.h"

namespace MorphoAdapterLib {
namespace Impl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MorphoAdapter_i::MorphoAdapter_i ()
//#UC START# *4EA00450012E_4EA004A6000C_4EA18B6502D2_BASE_INIT*
//#UC END# *4EA00450012E_4EA004A6000C_4EA18B6502D2_BASE_INIT*
{
	//#UC START# *4EA00450012E_4EA004A6000C_4EA18B6502D2_BODY*
	//#UC END# *4EA00450012E_4EA004A6000C_4EA18B6502D2_BODY*
}

MorphoAdapter_i::~MorphoAdapter_i () {
	//#UC START# *4EA18B6502D2_DESTR_BODY*
	//#UC END# *4EA18B6502D2_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MorphoAdapter
// нормализация
size_t MorphoAdapter_i::normalize (const char* word, char* out) {
	//#UC START# *4EA17BED0282_4EA18B6502D2*
	//Morpho::Def::INormalizer* obj = Morpho::Def::ICachedNormalizerFactory::instance ().get_ptr ();
	//return obj->lemmatize (word, out);
	return 0;
	//#UC END# *4EA17BED0282_4EA18B6502D2*
}
} // namespace Impl
} // namespace MorphoAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

