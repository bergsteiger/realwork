////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalOperation_i/ExternalOperation_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalOperation_i::ExternalOperation_i
// Заголовк реализации фабрик интерфеса ExternalOperation для серванта ExternalOperation_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_I_EXTERNALOPERATION_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_I_EXTERNALOPERATION_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperationFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for ExternalOperation_i
class ExternalOperation_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ExternalOperationAbstractFactory
{
public:
	ExternalOperation_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ExternalOperation* make (ObjectId id);

};

typedef ::Core::Var<ExternalOperation_i_factory> ExternalOperation_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_I_EXTERNALOPERATION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

