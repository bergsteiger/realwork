////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/GardocGetterImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::GardocGetterImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/GardocGetterImpl_factory.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/GardocGetterImpl.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

GardocGetterImpl_factory::GardocGetterImpl_factory () {
}

void GardocGetterImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Gardocs::GardocGetterFactoryManager::register_factory (this, priority);
}

const char* GardocGetterImpl_factory::key () const {
	return "GardocGetterImpl";
}

Gardocs::GardocGetter* GardocGetterImpl_factory::get () {
	GardocGetterImpl_var ret = new GardocGetterImpl ();
	return ret._retn ();
}

} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

