////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatLockerFacadeImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatLockerFacadeImpl
// Заголовк реализации фабрик интерфеса CatLockerFacade для серванта CatLockerFacadeImpl
//
// реализация интерфейса обертки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERFACADEIMPL_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERFACADEIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"


/// Interface-factory implementation for CatLockerFacadeImpl
class CatLockerFacadeImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public MDPSupport::CatLockerFacadeAbstractFactory
{
public:
	CatLockerFacadeImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MDPSupport::CatLockerFacade* make (IRoseCategoryPtr cat);

	MDPSupport::CatLockerFacade* make (IRoseElementPtr elem);

};

typedef ::Core::Var<CatLockerFacadeImpl_factory> CatLockerFacadeImpl_factory_var;



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERFACADEIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

