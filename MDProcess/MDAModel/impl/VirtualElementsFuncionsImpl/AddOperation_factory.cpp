////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOperation
//
// 1. %S%f_add_operation(<GUID нового элемента>,<стереотип>, <имя операции>,<тип результата>,<имя
// переменной>) - создает новый элемент - операцию с заданным именем и стереотипом, сохраняет его в
// переменной и добавляет как ребенка к текущему элементу, тип операции задается либо ГУИДОМ
// существующего элемента, либо просто именем типа - в этом случае в дереве будет искаться элемент
// с таким именем.
// 2. %S%f_add_operation(<GUID нового элемента>, <стереотип>,<имя опреации с парметрами и
// результатом>,<имя переменной>) - создает новый элемент - операцию имя операции тип результата, а
// также параметры задаются вторым параметром, в формате: <имя операции> (<спецификатор параметра>
// <имя параметра> : <тип параметра (GUID или строка) = <значение по умолчанию (GUID или
// строка)>>):<GUID или имя возвращемого параметра>
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation.h"

namespace VirtualElementsFuncionsImpl {

AddOperation_factory::AddOperation_factory () {
}

void AddOperation_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddOperation_factory::key () const {
	return "_add_operation";
}

TemplateFunctions::InternalStereotypeFunction* AddOperation_factory::make () {
	AddOperation_var ret = new AddOperation ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

