////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/CountInList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::CountInList
//
// реализация встроенной функции генератора _count_in_list.
// _count_in_list(«идентификатор», «значение») - возвращает сколько раз встречается в списке
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/CountInList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/CountInList.h"

namespace VarFunctionsImpl {

CountInList_factory::CountInList_factory () {
}

void CountInList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string CountInList_factory::key () const {
	return "_count_in_list";
}

TemplateFunctions::InternalFunction* CountInList_factory::make () {
	CountInList_var ret = new CountInList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

