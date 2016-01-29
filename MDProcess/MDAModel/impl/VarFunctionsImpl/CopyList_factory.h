////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::CopyList
// Заголовк реализации фабрик интерфеса  для серванта CopyList
//
// реализация встроенной функции генератора _copy_list
// _copy_list(«идентификатор списка1», «идентификатор списка2») - копирует список1 в список2.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COPYLIST_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COPYLIST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for CopyList
class CopyList_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	CopyList_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<CopyList_factory> CopyList_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COPYLIST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

