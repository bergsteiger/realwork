////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ImplementedItemImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ImplementedItemImpl
// Заголовок реализации класса серванта для интерфеса ImplementedItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_IMPLEMENTEDITEMIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_IMPLEMENTEDITEMIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemImpl.h"

namespace RoseModelImpl {

class ImplementedItemImpl; // self forward Var
typedef ::Core::Var<ImplementedItemImpl> ImplementedItemImpl_var;
typedef ::Core::Var<const ImplementedItemImpl> ImplementedItemImpl_cvar;

class ImplementedItemImpl_factory;

class ImplementedItemImpl:
	virtual public ImplementedItem
	, virtual public InheritedItemImpl
{
	SET_OBJECT_COUNTER (ImplementedItemImpl)
	friend class ImplementedItemImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ImplementedItemImpl (const std::string& uid, bool need_collect_child);

	virtual ~ImplementedItemImpl ();
}; // class ImplementedItemImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_IMPLEMENTEDITEMIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
