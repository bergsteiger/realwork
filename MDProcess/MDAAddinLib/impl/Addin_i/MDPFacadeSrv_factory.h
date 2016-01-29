////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MDPFacadeSrv_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::MDPFacadeSrv
// Заголовк реализации фабрик интерфеса MDPFacade для серванта MDPFacadeSrv
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MDPFACADESRV_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MDPFACADESRV_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"


/// Interface-factory implementation for MDPFacadeSrv
class MDPFacadeSrv_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public MDPSupport::MDPFacadeAbstractFactory
{
public:
	MDPFacadeSrv_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MDPSupport::MDPFacade* get ();

};

typedef ::Core::Var<MDPFacadeSrv_factory> MDPFacadeSrv_factory_var;



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MDPFACADESRV_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

