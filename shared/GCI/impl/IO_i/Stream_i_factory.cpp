////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/Stream_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::Stream_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/IO_i/Stream_i_factory.h"
#include "shared/GCI/impl/IO_i/Stream_i.h"

namespace GCI {
namespace IO_i {

Stream_i_factory::Stream_i_factory () {
}

void Stream_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IO::StreamFactoryManager::register_factory (this, priority);
}

const char* Stream_i_factory::key () const {
	return "Stream_i";
}

IO::Stream* Stream_i_factory::make () {
	Stream_i_var ret = new Stream_i ();
	return ret._retn ();
}

IO::Stream* Stream_i_factory::make (const char* path) {
	Stream_i_var ret = new Stream_i (path);
	return ret._retn ();
}

} // namespace IO_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

