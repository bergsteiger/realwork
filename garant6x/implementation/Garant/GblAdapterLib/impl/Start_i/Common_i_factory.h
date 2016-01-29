////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Common_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::Common_i
// Заголовк реализации фабрик интерфеса Common для серванта Common_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_START_I_COMMON_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_START_I_COMMON_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/StartFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Start_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for Common_i
class Common_i_factory: virtual public ::Core::RefCountObjectBase, virtual public CommonAbstractFactory {
public:
	Common_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Common* make ();

};

typedef ::Core::Var<Common_i_factory> Common_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_START_I_COMMON_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

