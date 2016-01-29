////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithDataCleaning_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DTPWithDataCleaning
// Заголовк реализации фабрик интерфеса  для серванта DTPWithDataCleaning
//
// провайдер очищает данные о стиле и тексте после того, как прокидывает их оболочке
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHDATACLEANING_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHDATACLEANING_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for DTPWithDataCleaning
class DTPWithDataCleaning_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DocumentTextProviderAbstractFactory
{
public:
	DTPWithDataCleaning_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DocumentTextProvider* make (
		GblPilot::Document* server_doc
		, const GblPilot::HighlightHandle& handle
		, bool all_at_once
	);

	DocumentTextProvider* make (GblPilot::Document* server_doc, unsigned long handle, bool all_at_once);

};

typedef ::Core::Var<DTPWithDataCleaning_factory> DTPWithDataCleaning_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHDATACLEANING_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

