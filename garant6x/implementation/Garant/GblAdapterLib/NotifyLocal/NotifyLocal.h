////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocal.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::NotifyLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFYLOCAL_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFYLOCAL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
//#UC START# *45F6CA010209_CUSTOM_INCLUDE*
//#UC END# *45F6CA010209_CUSTOM_INCLUDE*

namespace GblAdapterLib {

class DataTransformer;
typedef ::Core::Var<DataTransformer> DataTransformer_var;
typedef ::Core::Var<const DataTransformer> DataTransformer_cvar;
class DataTransformer
	: virtual public ::Core::IObject
{
public:
	virtual Variant* get_variant (const CORBA::Any& data) const = 0;
};

/// factory interface for DataTransformer
class DataTransformerFactory {
public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
public:
	static DataTransformer* make (const char* key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DataTransformer> {
	typedef GblAdapterLib::DataTransformerFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFYLOCAL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
