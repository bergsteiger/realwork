////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/BoolTransformer_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::BoolTransformer_i
// Заголовк реализации фабрик интерфеса DataTransformer для серванта BoolTransformer_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_I_BOOLTRANSFORMER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_I_BOOLTRANSFORMER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocalFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for BoolTransformer_i
class BoolTransformer_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DataTransformerAbstractFactory
{
public:
	BoolTransformer_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DataTransformer* make ();

};

typedef ::Core::Var<BoolTransformer_i_factory> BoolTransformer_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_I_BOOLTRANSFORMER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

