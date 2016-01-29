////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringFind_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringFind
//
// реализация встроенной функции генератора _string_find
// _string_find(«строка»,«подстрока») - ищет подстроку в строке, возвращает найденную позицию, если
// подстрока не найдена - возвращает -1
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringFind_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringFind.h"

namespace StrFunctionImpl {

StringFind_factory::StringFind_factory () {
}

void StringFind_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string StringFind_factory::key () const {
	return "_string_find";
}

TemplateFunctions::InternalFunction* StringFind_factory::make () {
	StringFind_var ret = new StringFind ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

