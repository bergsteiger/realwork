////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/Variant_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::Variant_i
// Заголовк реализации фабрик интерфеса Variant для серванта Variant_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_I_VARIANT_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_I_VARIANT_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseTypes_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for Variant_i
class Variant_i_factory: virtual public ::Core::RefCountObjectBase, virtual public VariantAbstractFactory {
public:
	Variant_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Variant* make ();

	Variant* make_long (long value);

	Variant* make_bool (bool value);

	Variant* make_string (GCI::IO::String* value);

	Variant* make_object (Core::IObject* value);

};

typedef ::Core::Var<Variant_i_factory> Variant_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_I_VARIANT_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

