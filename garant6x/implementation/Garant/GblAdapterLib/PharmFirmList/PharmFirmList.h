////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PharmFirmList
//
// Список фирм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_H__
#define __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garantServer/src/Global/Core/gcdC.h"

namespace GblAdapterLib {

class PharmFirmListEntry;
typedef ::Core::Var<PharmFirmListEntry> PharmFirmListEntry_var;
typedef ::Core::Var<const PharmFirmListEntry> PharmFirmListEntry_cvar;
// Обертка для документа-фирмы из списка
class PharmFirmListEntry
	: virtual public EntityBase
{
public:
	virtual Document* get_document () const = 0;
};

/// factory interface for PharmFirmListEntry
class PharmFirmListEntryFactory {
public:
	static PharmFirmListEntry* make (GCD::ObjectID id)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::PharmFirmListEntry> {
	typedef GblAdapterLib::PharmFirmListEntryFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
