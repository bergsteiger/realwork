////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Banner_i/Banner_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Banner_i::Banner_i
// Заголовк реализации фабрик интерфеса Banner для серванта Banner_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BANNER_I_BANNER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_BANNER_I_BANNER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Banner/BannerFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for Banner_i
class Banner_i_factory: virtual public ::Core::RefCountObjectBase, virtual public BannerAbstractFactory {
public:
	Banner_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Banner* make () /*throw (CanNotFindData)*/;

};

typedef ::Core::Var<Banner_i_factory> Banner_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BANNER_I_BANNER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

