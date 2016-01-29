////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/Variant_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::Variant_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/Variant_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/Variant_i.h"

namespace GblAdapterLib {

Variant_i_factory::Variant_i_factory () {
}

void Variant_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	VariantFactoryManager::register_factory (this, priority);
}

const char* Variant_i_factory::key () const {
	return "Variant_i";
}

Variant* Variant_i_factory::make () {
	Variant_i_var ret = new Variant_i ();
	return ret._retn ();
}

Variant* Variant_i_factory::make_long (long value) {
	Variant_i_var ret = new Variant_i (value);
	return ret._retn ();
}

Variant* Variant_i_factory::make_bool (bool value) {
	Variant_i_var ret = new Variant_i (value);
	return ret._retn ();
}

Variant* Variant_i_factory::make_string (GCI::IO::String* value) {
	Variant_i_var ret = new Variant_i (value);
	return ret._retn ();
}

Variant* Variant_i_factory::make_object (Core::IObject* value) {
	Variant_i_var ret = new Variant_i (value);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

