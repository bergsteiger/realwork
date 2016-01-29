////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SizeList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SizeList
//
// реализация встроенной функции генератора _size_list
// _size_list(«идентификатор») - возвращаеьт количество элементов в списке
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SizeList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SizeList.h"

namespace VarFunctionsImpl {

SizeList_factory::SizeList_factory () {
}

void SizeList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string SizeList_factory::key () const {
	return "_size_list";
}

TemplateFunctions::InternalFunction* SizeList_factory::make () {
	SizeList_var ret = new SizeList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

