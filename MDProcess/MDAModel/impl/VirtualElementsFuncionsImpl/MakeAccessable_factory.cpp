////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/MakeAccessable_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::MakeAccessable
//
// %S%f_make_accessable(идентификатор элемента) - делает видимым элемент - расставляет необходимые
// связи (виртуальные), при этом связи расставляются между родителями этих элементов, между самими
// элементами никаких новых связей не добавляется!. Пример:
// {code}
// %S%f_make_accessable(%TГ)
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/MakeAccessable_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/MakeAccessable.h"

namespace VirtualElementsFuncionsImpl {

MakeAccessable_factory::MakeAccessable_factory () {
}

void MakeAccessable_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string MakeAccessable_factory::key () const {
	return "_make_accessable";
}

TemplateFunctions::InternalStereotypeFunction* MakeAccessable_factory::make () {
	MakeAccessable_var ret = new MakeAccessable ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

