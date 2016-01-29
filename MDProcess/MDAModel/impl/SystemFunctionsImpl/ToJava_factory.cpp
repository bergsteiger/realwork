////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToJava_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToJava
//
// реализация встроенной функции генератора "_to_java"
// _to_java (<шаблон>) - конвертирует строку <шаблон> в стиль «Java» - составные части склеены и
// начинаются с заглавных букв (кроме первой части)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToJava_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToJava.h"

namespace SystemFunctionsImpl {

ToJava_factory::ToJava_factory () {
}

void ToJava_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ToJava_factory::key () const {
	return "_to_java";
}

TemplateFunctions::InternalFunction* ToJava_factory::make () {
	ToJava_var ret = new ToJava ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

