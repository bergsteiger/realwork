////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/ErrorManagerImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::ErrorManagerImpl
// Заголовк реализации фабрик интерфеса ErrorManager для серванта ErrorManagerImpl
//
// реалиазция менеджера ошибок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ERRORMANAGERIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ERRORMANAGERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"

namespace GenSupportImpl {

/// Interface-factory implementation for ErrorManagerImpl
class ErrorManagerImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public GenSupport::ErrorManagerAbstractFactory
{
public:
	ErrorManagerImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	GenSupport::ErrorManager* get ();

};

typedef ::Core::Var<ErrorManagerImpl_factory> ErrorManagerImpl_factory_var;

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ERRORMANAGERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

