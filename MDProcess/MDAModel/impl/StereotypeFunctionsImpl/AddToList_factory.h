////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/AddToList_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::AddToList
// Заголовк реализации фабрик интерфеса  для серванта AddToList
//
// %S%f_add_to_list («значение») - добавляет в список c заданным идентификатором элемент (может
// быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_ADDTOLIST_FCTR_H__
#define __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_ADDTOLIST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StereotypeFunctionsImpl {

/// Interface-factory implementation for AddToList
class AddToList_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory
{
public:
	AddToList_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<AddToList_factory> AddToList_factory_var;

} // namespace StereotypeFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_ADDTOLIST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

