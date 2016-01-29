////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UnderControl_i::ControlManager_i
// Заголовк реализации фабрик интерфеса ControlManager для серванта ControlManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_I_CONTROLMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_I_CONTROLMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControlFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i.h"

/// Servant-factory implementation for ControlManager_i
namespace GblAdapterLib {
	class FoldersNode_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class ControlManager_iServantFactory {
	friend class FoldersNode_i;

	static ControlManager_i& make ();
};

/// Interface-factory implementation for ControlManager_i
class ControlManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ControlManagerAbstractFactory
{
	friend class ControlManager_iServantFactory;

public:
	ControlManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static ControlManager_i_factory* s_instance;

	const char* key () const;

	ControlManager* make ();

};

typedef ::Core::Var<ControlManager_i_factory> ControlManager_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ControlManager_i> {
	typedef GblAdapterLib::ControlManager_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_UNDERCONTROL_I_CONTROLMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

