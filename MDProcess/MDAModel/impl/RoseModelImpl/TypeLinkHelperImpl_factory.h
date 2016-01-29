////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/TypeLinkHelperImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::TypeLinkHelperImpl
// Заголовк реализации фабрик интерфеса TypeLinkHelper для серванта TypeLinkHelperImpl
//
// сервант
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_TYPELINKHELPERIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_TYPELINKHELPERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"

namespace RoseModelImpl {

/// Interface-factory implementation for TypeLinkHelperImpl
class TypeLinkHelperImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TypeLinkHelperAbstractFactory
{
public:
	TypeLinkHelperImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	TypeLinkHelper* get ();

};

typedef ::Core::Var<TypeLinkHelperImpl_factory> TypeLinkHelperImpl_factory_var;

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_TYPELINKHELPERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

