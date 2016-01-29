////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/OverloadedItemImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::OverloadedItemImpl
// Заголовок реализации класса серванта для интерфеса OverloadedItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_OVERLOADEDITEMIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_OVERLOADEDITEMIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemImpl.h"

namespace RoseModelImpl {

class OverloadedItemImpl; // self forward Var
typedef ::Core::Var<OverloadedItemImpl> OverloadedItemImpl_var;
typedef ::Core::Var<const OverloadedItemImpl> OverloadedItemImpl_cvar;

class OverloadedItemImpl_factory;

class OverloadedItemImpl:
	virtual public OverloadedItem
	, virtual public InheritedItemImpl
{
	SET_OBJECT_COUNTER (OverloadedItemImpl)
	friend class OverloadedItemImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	OverloadedItemImpl (const std::string& uid, bool need_collect_child);

	virtual ~OverloadedItemImpl ();
}; // class OverloadedItemImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_OVERLOADEDITEMIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
