////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddParameter
//
// %S%f_add_parameter(<GUID нового элемента>, ,<стереотип>,<сигнатура параметра>,<имя переменной>) -
// аналогично _add_attribute, но создается новый параметр .
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter.h"

namespace VirtualElementsFuncionsImpl {

AddParameter_factory::AddParameter_factory () {
}

void AddParameter_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddParameter_factory::key () const {
	return "_add_parameter";
}

TemplateFunctions::InternalStereotypeFunction* AddParameter_factory::make () {
	AddParameter_var ret = new AddParameter ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

