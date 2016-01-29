////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynList_i
// Заголовк реализации фабрик интерфеса DynList для серванта DynList_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLIST_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLIST_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.h"

/// Servant-factory implementation for DynList_i
namespace GblAdapterLib {
	class FoldersNode_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class LogEventData_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DynList_iServantFactory {
	friend class FoldersNode_i;
	friend class LogEventData_i;

	static DynList_i* make (GblDocList::DocListTree* server_list);

	static DynList_i* make (
		GblPilot::LegalDocument* legal_document
		, const GblPilotQueryDef::Query& query
		, DynListType type
	);

	static DynList_i* make (SpecialListKey key);
};

/// Interface-factory implementation for DynList_i
class DynList_i_factory: virtual public ::Core::RefCountObjectBase, virtual public DynListAbstractFactory {
	friend class DynList_iServantFactory;

public:
	DynList_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static DynList_i_factory* s_instance;

	const char* key () const;

	DynList* make (GblDocList::DocListTree* server_list);

	DynList* make (GblPilot::LegalDocument* legal_document, const GblPilotQueryDef::Query& query, DynListType type);

	DynList* make (SpecialListKey key);

};

typedef ::Core::Var<DynList_i_factory> DynList_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DynList_i> {
	typedef GblAdapterLib::DynList_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLIST_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

