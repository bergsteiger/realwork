////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/ProgessIndicatorServiceImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::ProgessIndicatorServiceImpl
// Заголовк реализации фабрик интерфеса ProgessIndicatorService для серванта ProgessIndicatorServiceImpl
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PROGESSINDICATORSERVICEIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PROGESSINDICATORSERVICEIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"

namespace GenSupportImpl {

/// Interface-factory implementation for ProgessIndicatorServiceImpl
class ProgessIndicatorServiceImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public GenSupport::ProgessIndicatorServiceAbstractFactory
{
public:
	ProgessIndicatorServiceImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	GenSupport::ProgessIndicatorService* get ();

};

typedef ::Core::Var<ProgessIndicatorServiceImpl_factory> ProgessIndicatorServiceImpl_factory_var;

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PROGESSINDICATORSERVICEIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

