////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SplitToList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SplitToList
//
// реализация встроенной функции генератора _split_to_list
// _split_to_list («идентификатор», «строка», «разделитель») - разбивает строку по разделителям,
// фрагменты помещаются в список c заданным идентификатором.  Например:
// %f_split_to_list(ROOT_RELATIVE_PATH,%Sd,/) - разбивает результат %Sd по разделителям /, помещая
// элементы в список ROOT_RELATIVE_PATH
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SplitToList_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SplitToList.h"

namespace StrFunctionImpl {

SplitToList_factory::SplitToList_factory () {
}

void SplitToList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string SplitToList_factory::key () const {
	return "_split_to_list";
}

TemplateFunctions::InternalFunction* SplitToList_factory::make () {
	SplitToList_var ret = new SplitToList ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

