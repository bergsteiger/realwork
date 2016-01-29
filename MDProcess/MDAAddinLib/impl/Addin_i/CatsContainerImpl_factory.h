////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatsContainerImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatsContainerImpl
// Заголовк реализации фабрик интерфеса CatsContainer для серванта CatsContainerImpl
//
// реализация интерфейса контэйнера катов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CATSCONTAINERIMPL_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CATSCONTAINERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"


/// Interface-factory implementation for CatsContainerImpl
class CatsContainerImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public MDPSupport::CatsContainerAbstractFactory
{
public:
	CatsContainerImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MDPSupport::CatsContainer* get ();

};

typedef ::Core::Var<CatsContainerImpl_factory> CatsContainerImpl_factory_var;



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CATSCONTAINERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

