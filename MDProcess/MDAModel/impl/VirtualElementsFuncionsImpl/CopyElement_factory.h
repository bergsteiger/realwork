////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyElement_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::CopyElement
// Заголовк реализации фабрик интерфеса  для серванта CopyElement
//
// %S%f_copy_element(<УИД нового элемента>, <УИД или имя родителя>,<стереотип нового элемента>,<имя
// нового элемента>,<полное копирование (с детьми) или нет>,<имя перененной в которую запишется
// новый элемент>) - функция копирования элемента, если задано полное копирование - то копируются
// все дети элемента рекурсивно. Пример использования:
// {code}
// %S%f_copy_element(_COPY,,factory,new_make,true,VAR) - копиреует элемент в родителя копируемого
// элемента, с копированием всех детей
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYELEMENT_FCTR_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYELEMENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"

namespace VirtualElementsFuncionsImpl {

/// Interface-factory implementation for CopyElement
class CopyElement_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory
{
public:
	CopyElement_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<CopyElement_factory> CopyElement_factory_var;

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYELEMENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

