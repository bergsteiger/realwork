////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveInheritable
//
// %S%f_remove_inheritable(<УИД элемента>) - функция удаления связи наследования между текущим
// элементом и элементом, заддным УИД'ом. Если не удалось найти элемент с заданным УИД'ом или с
// этим элементом нет связи наследования - генерируется исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable.h"

namespace VirtualElementsFuncionsImpl {

RemoveInheritable_factory::RemoveInheritable_factory () {
}

void RemoveInheritable_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string RemoveInheritable_factory::key () const {
	return "_remove_inheritable";
}

TemplateFunctions::InternalStereotypeFunction* RemoveInheritable_factory::make () {
	RemoveInheritable_var ret = new RemoveInheritable ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

