////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddRealized
//
// %S%f_add_realized(<ГУИД реального элемента или просто имя>, <прозрачность - true | false>) -
// добавляет в список реализуемых элементов элемент, соответствующий гуиду, если задан не ГУИД, а
// просто имя класса - находит в дереве элемент с таким именем и добавляет его, если установлена
// прозрачность связи, то для нее не будут выполняться проверки доступности и видимость, а также,
// такая связь не будет учитываться в графе зависимости
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized.h"

namespace VirtualElementsFuncionsImpl {

AddRealized_factory::AddRealized_factory () {
}

void AddRealized_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddRealized_factory::key () const {
	return "_add_realized";
}

TemplateFunctions::InternalStereotypeFunction* AddRealized_factory::make () {
	AddRealized_var ret = new AddRealized ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

