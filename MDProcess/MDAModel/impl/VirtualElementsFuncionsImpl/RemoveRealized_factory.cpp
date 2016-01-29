////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveRealized_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveRealized
//
// %S%f_remove_realized(<УИД элемента>) - функция удаления связи реализации между текущим элементом
// и элементом, заданным УИД'ом. Если не удалось найти элемент с заданным УИД'ом или с этим
// элементом нет связи реализации - генерируется исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveRealized_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveRealized.h"

namespace VirtualElementsFuncionsImpl {

RemoveRealized_factory::RemoveRealized_factory () {
}

void RemoveRealized_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string RemoveRealized_factory::key () const {
	return "_remove_realized";
}

TemplateFunctions::InternalStereotypeFunction* RemoveRealized_factory::make () {
	RemoveRealized_var ret = new RemoveRealized ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

