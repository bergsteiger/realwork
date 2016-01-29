////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::FindElement
// Заголовк реализации фабрик интерфеса  для серванта FindElement
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
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for FindElement
class FindElement_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	FindElement_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<FindElement_factory> FindElement_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

