////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/CountInList_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::CountInList
// Заголовк реализации фабрик интерфеса  для серванта CountInList
//
// реализация встроенной функции генератора _count_in_list.
// _count_in_list(«идентификатор», «значение») - возвращает сколько раз встречается в списке
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COUNTINLIST_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COUNTINLIST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for CountInList
class CountInList_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	CountInList_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<CountInList_factory> CountInList_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COUNTINLIST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

