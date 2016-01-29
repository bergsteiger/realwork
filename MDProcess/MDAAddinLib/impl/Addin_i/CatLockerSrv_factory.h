////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatLockerSrv_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatLockerSrv
// Заголовк реализации фабрик интерфеса CatLocker для серванта CatLockerSrv
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERSRV_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERSRV_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"


/// Interface-factory implementation for CatLockerSrv
class CatLockerSrv_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public MDPSupport::CatLockerAbstractFactory
{
public:
	CatLockerSrv_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MDPSupport::CatLocker* make (IRoseCategoryPtr cat);

};

typedef ::Core::Var<CatLockerSrv_factory> CatLockerSrv_factory_var;



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERSRV_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

