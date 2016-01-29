////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DTPWithCachedData
// Заголовк реализации фабрик интерфеса  для серванта DTPWithCachedData
//
// Провайдер кеширует стиль и текст на адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHCACHEDDATA_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHCACHEDDATA_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData.h"

/// Servant-factory implementation for DTPWithCachedData
namespace GblAdapterLib {
	class ActualAnalyticsContentsDocument; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class ActualAnalyticsDocument; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DTPWithCachedDataServantFactory {
	friend class ActualAnalyticsContentsDocument;
	friend class ActualAnalyticsDocument;

	static DTPWithCachedData* make (
		GblPilot::Document* server_doc
		, const GblPilot::HighlightHandle& handle
		, bool all_at_once
	);

	static DTPWithCachedData* make (GblPilot::Document* server_doc, unsigned long handle, bool all_at_once);
};

/// Interface-factory implementation for DTPWithCachedData
class DTPWithCachedData_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DocumentTextProviderAbstractFactory
{
	friend class DTPWithCachedDataServantFactory;

public:
	DTPWithCachedData_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static DTPWithCachedData_factory* s_instance;

	const char* key () const;

	DocumentTextProvider* make (
		GblPilot::Document* server_doc
		, const GblPilot::HighlightHandle& handle
		, bool all_at_once
	);

	DocumentTextProvider* make (GblPilot::Document* server_doc, unsigned long handle, bool all_at_once);

};

typedef ::Core::Var<DTPWithCachedData_factory> DTPWithCachedData_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DTPWithCachedData> {
	typedef GblAdapterLib::DTPWithCachedDataServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHCACHEDDATA_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

