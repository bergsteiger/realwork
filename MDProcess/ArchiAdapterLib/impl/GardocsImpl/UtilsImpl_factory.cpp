////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/UtilsImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::UtilsImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/UtilsImpl_factory.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/UtilsImpl.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

UtilsImpl_factory::UtilsImpl_factory () {
}

void UtilsImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Gardocs::UtilsFactoryManager::register_factory (this, priority);
}

const char* UtilsImpl_factory::key () const {
	return "UtilsImpl";
}

Gardocs::Utils* UtilsImpl_factory::get () {
	UtilsImpl_var ret = new UtilsImpl ();
	return ret._retn ();
}

} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

