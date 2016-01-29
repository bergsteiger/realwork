////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::FindElement
//
// реализация встроенной функции стереотипа _find_element.
// _find_element(«идентификатор|имя», «переменная») - находит элемент по имени или по
// идентификатору и записывает его в переменную. Первый параметр сначала интерпретируется как
// идентификатор элемента, если элемент с таким идентификатором не был найден, то параметр
// интерпретируется как имя элемента, причем имя может указываться с частью пути от рута да
// элемента (для уточнения поиска). Если в результате поиска по имени найдено более одного элемента
// - выбрасывается исключение. Например:
// {code}
// %S%f_find_element(%SU, SELF)  - переменная SELF удет указывать на текущий элемент (S)
// %S%f_set_var (A::B::attr, ATTR)  - переменная ATTR будет указывать на элемент, до которого
// полный путь от рута заканчивается на "A::B::attr"
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement.h"

namespace VarFunctionsImpl {

FindElement_factory::FindElement_factory () {
}

void FindElement_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string FindElement_factory::key () const {
	return "_find_element";
}

TemplateFunctions::InternalFunction* FindElement_factory::make () {
	FindElement_var ret = new FindElement ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

