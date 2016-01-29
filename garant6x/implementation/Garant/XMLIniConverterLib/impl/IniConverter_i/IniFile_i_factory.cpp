////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniFile_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::IniFile_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniFile_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniFile_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

IniFile_i_factory::IniFile_i_factory () {
}

void IniFile_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IniConverter::IniFileFactoryManager::register_factory (this, priority);
}

const char* IniFile_i_factory::key () const {
	return "IniFile_i";
}

IniConverter::IniFile* IniFile_i_factory::make (const char* filename) {
	IniFile_i_var ret = new IniFile_i (filename);
	return ret._retn ();
}

} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

