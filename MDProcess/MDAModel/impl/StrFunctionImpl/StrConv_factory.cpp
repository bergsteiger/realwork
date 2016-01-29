////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrConv_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrConv
//
// реализация встроенной функции генератора "_str_conv".
// _str_conv ("<шаблон>","<строка входного формата>","<строка выходного формата>") - пересобирает
// строку из одного формата в другой
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrConv_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrConv.h"

namespace StrFunctionImpl {

StrConv_factory::StrConv_factory () {
}

void StrConv_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string StrConv_factory::key () const {
	return "_str_conv";
}

TemplateFunctions::InternalFunction* StrConv_factory::make () {
	StrConv_var ret = new StrConv ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

