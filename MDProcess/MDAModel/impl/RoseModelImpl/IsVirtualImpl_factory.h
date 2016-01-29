////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/IsVirtualImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::IsVirtualImpl
// Заголовк реализации фабрик интерфеса IsVirtual для серванта IsVirtualImpl
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_ISVIRTUALIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_ISVIRTUALIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"

namespace RoseModelImpl {

/// Interface-factory implementation for IsVirtualImpl
class IsVirtualImpl_factory: virtual public ::Core::RefCountObjectBase, virtual public IsVirtualAbstractFactory {
public:
	IsVirtualImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	IsVirtual* get ();

};

typedef ::Core::Var<IsVirtualImpl_factory> IsVirtualImpl_factory_var;

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_ISVIRTUALIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

