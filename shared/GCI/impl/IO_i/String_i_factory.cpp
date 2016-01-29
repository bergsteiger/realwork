////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/String_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::String_i
//
// Реализация интерфейса строки.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/IO_i/String_i_factory.h"
#include "shared/GCI/impl/IO_i/String_i.h"

namespace GCI {
namespace IO_i {

String_i_factory::String_i_factory () {
}

void String_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IO::StringFactoryManager::register_factory (this, priority);
}

const char* String_i_factory::key () const {
	return "String_i";
}

IO::String* String_i_factory::make (const char* str) {
	String_i_var ret = new String_i (str);
	return ret._retn ();
}

IO::String* String_i_factory::create (const char* str, short code_page) {
	String_i_var ret = new String_i (str, code_page);
	return ret._retn ();
}

IO::String* String_i_factory::take (char* str, short code_page) {
	String_i_var ret = new String_i (str, code_page);
	return ret._retn ();
}

IO::String* String_i_factory::alloc (unsigned long maximum) {
	String_i_var ret = new String_i (maximum);
	return ret._retn ();
}

} // namespace IO_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

