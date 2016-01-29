////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOperation
// Заголовк реализации фабрик интерфеса  для серванта AddOperation
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
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_FCTR_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"

namespace VirtualElementsFuncionsImpl {

/// Interface-factory implementation for AddOperation
class AddOperation_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory
{
public:
	AddOperation_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<AddOperation_factory> AddOperation_factory_var;

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

