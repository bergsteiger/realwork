////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/StereotypeManagerImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::StereotypeManagerImpl
// Заголовк реализации фабрик интерфеса StereotypeManager для серванта StereotypeManagerImpl
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_STEREOTYPEMANAGERIMPL_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_STEREOTYPEMANAGERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/HelpersImpl.h"

namespace HelpersImpl {

/// Interface-factory implementation for StereotypeManagerImpl
class StereotypeManagerImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Helpers::StereotypeManagerAbstractFactory
{
public:
	StereotypeManagerImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Helpers::StereotypeManager* make ();

};

typedef ::Core::Var<StereotypeManagerImpl_factory> StereotypeManagerImpl_factory_var;

} // namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_STEREOTYPEMANAGERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

