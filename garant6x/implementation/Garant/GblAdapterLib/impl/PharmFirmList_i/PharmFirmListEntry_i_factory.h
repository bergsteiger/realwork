////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PharmFirmList_i::PharmFirmListEntry_i
// Заголовк реализации фабрик интерфеса PharmFirmListEntry для серванта PharmFirmListEntry_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMLISTENTRY_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMLISTENTRY_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmListFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmList_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i.h"

/// Servant-factory implementation for PharmFirmListEntry_i
namespace GblAdapterLib {
	class PharmFirmNode_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class PharmFirmListEntry_iServantFactory {
	friend class PharmFirmNode_i;

	static PharmFirmListEntry_i* make (GCD::ObjectID id);
};

/// Interface-factory implementation for PharmFirmListEntry_i
class PharmFirmListEntry_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public PharmFirmListEntryAbstractFactory
{
	friend class PharmFirmListEntry_iServantFactory;

public:
	PharmFirmListEntry_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static PharmFirmListEntry_i_factory* s_instance;

	const char* key () const;

	PharmFirmListEntry* make (GCD::ObjectID id);

};

typedef ::Core::Var<PharmFirmListEntry_i_factory> PharmFirmListEntry_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::PharmFirmListEntry_i> {
	typedef GblAdapterLib::PharmFirmListEntry_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMLISTENTRY_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

