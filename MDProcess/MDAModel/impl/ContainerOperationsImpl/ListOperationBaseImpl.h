////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ContainerOperationsImpl::ListOperationBaseImpl
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_LISTOPERATIONBASEIMPL_H__
#define __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_LISTOPERATIONBASEIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace ContainerOperationsImpl {

class ListOperationBaseImpl; // self forward Var
typedef ::Core::Var<ListOperationBaseImpl> ListOperationBaseImpl_var;
typedef ::Core::Var<const ListOperationBaseImpl> ListOperationBaseImpl_cvar;

class ListOperationBaseImpl:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ListOperationBaseImpl)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ListOperationBaseImpl ();

	virtual ~ListOperationBaseImpl ();
}; // class ListOperationBaseImpl

} // namespace ContainerOperationsImpl


#endif //__MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_LISTOPERATIONBASEIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
