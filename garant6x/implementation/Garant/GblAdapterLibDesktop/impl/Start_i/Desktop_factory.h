////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLibDesktop/impl/Start_i/Desktop_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLibDesktop::Start_i::Desktop
// Заголовк реализации фабрик интерфеса  для серванта Desktop
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIBDESKTOP_START_I_DESKTOP_FCTR_H__
#define __GARANT6X_GBLADAPTERLIBDESKTOP_START_I_DESKTOP_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/StartFactories.h"

namespace GblAdapterLibDesktop {
namespace Start_i {

/// Interface-factory implementation for Desktop
class Desktop_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public GblAdapterLib::ComponentManagerAbstractFactory
{
public:
	Desktop_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	GblAdapterLib::ComponentManager* make ();

};

typedef ::Core::Var<Desktop_factory> Desktop_factory_var;

} // namespace Start_i
} // namespace GblAdapterLibDesktop


#endif //__GARANT6X_GBLADAPTERLIBDESKTOP_START_I_DESKTOP_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

