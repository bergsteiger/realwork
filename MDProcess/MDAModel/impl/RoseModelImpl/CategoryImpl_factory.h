////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/CategoryImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::CategoryImpl
// Заголовк реализации фабрик интерфеса Category для серванта CategoryImpl
//
// реализация элемента-папка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_CATEGORYIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_CATEGORYIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"

namespace RoseModelImpl {

/// Interface-factory implementation for CategoryImpl
class CategoryImpl_factory: virtual public ::Core::RefCountObjectBase, virtual public CategoryAbstractFactory {
public:
	CategoryImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Category* make (IRoseCategoryPtr cat);

};

typedef ::Core::Var<CategoryImpl_factory> CategoryImpl_factory_var;

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_CATEGORYIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

