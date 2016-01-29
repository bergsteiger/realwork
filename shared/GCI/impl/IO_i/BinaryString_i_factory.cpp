////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/BinaryString_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::BinaryString_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/IO_i/BinaryString_i_factory.h"
#include "shared/GCI/impl/IO_i/BinaryString_i.h"

namespace GCI {
namespace IO_i {

BinaryString_i_factory::BinaryString_i_factory () {
}

void BinaryString_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IO::BinaryStringFactoryManager::register_factory (this, priority);
}

const char* BinaryString_i_factory::key () const {
	return "BinaryString_i";
}

IO::BinaryString* BinaryString_i_factory::make (const void* buffer, size_t size) {
	BinaryString_i_var ret = new BinaryString_i (buffer, size);
	return ret._retn ();
}

} // namespace IO_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

