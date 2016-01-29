////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/CutPostfix_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::CutPostfix
//
// реализация встроенной функции генератора "_cut_postfix"
// _cut_postfix(<строка>,<постфикс>) - удаляет постфикс у строчки, если она на него заканчивается.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/CutPostfix_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/CutPostfix.h"

namespace StrFunctionImpl {

CutPostfix_factory::CutPostfix_factory () {
}

void CutPostfix_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string CutPostfix_factory::key () const {
	return "_cut_postfix";
}

TemplateFunctions::InternalFunction* CutPostfix_factory::make () {
	CutPostfix_var ret = new CutPostfix ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

