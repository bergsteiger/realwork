////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/IO/IO.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::IO
//
// пакет интерфейсов ввода-вывода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "shared/GCI/IO/IOFactories.h"

namespace GCI {
namespace IO {


const char* OperationError::uid () const /*throw ()*/ {
	return "F5A55B66-C39A-4758-BE4D-844DE9E142A4";
}

const char* OperationError::what () const throw () {
	//#UC START# *443E3D76031C_WHAT_IMPL*
	return "OperationError (Во время выполнения операции copy_to один из потоков, участвовавших в операции перешёл в некорректное состояние.)";
	//#UC END# *443E3D76031C_WHAT_IMPL*
}


const char* NotImplemented::uid () const /*throw ()*/ {
	return "BA9EDABD-A788-46FF-B5C3-45E967EFEE3C";
}

const char* NotImplemented::what () const throw () {
	//#UC START# *476645080087_WHAT_IMPL*
	return "NotImplemented (функция не реализована)";
	//#UC END# *476645080087_WHAT_IMPL*
}

// factory interface wrapper for String
String* StringFactory::make (
	const char* str
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return StringFactoryManager::Singleton::instance ()->make (str);
}

String* StringFactory::create (
	const char* str
	, short code_page
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return StringFactoryManager::Singleton::instance ()->create (str, code_page);
}

String* StringFactory::take (
	char* str
	, short code_page
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return StringFactoryManager::Singleton::instance ()->take (str, code_page);
}

String* StringFactory::alloc (
	unsigned long maximum
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return StringFactoryManager::Singleton::instance ()->alloc (maximum);
}

// factory interface wrapper for Stream
Stream* StreamFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return StreamFactoryManager::Singleton::instance ()->make ();
}

Stream* StreamFactory::make (
	const char* path
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return StreamFactoryManager::Singleton::instance ()->make (path);
}

// factory interface wrapper for BinaryString
BinaryString* BinaryStringFactory::make (
	const void* buffer
	, size_t size
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return BinaryStringFactoryManager::Singleton::instance ()->make (buffer, size);
}

} // namespace IO
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

