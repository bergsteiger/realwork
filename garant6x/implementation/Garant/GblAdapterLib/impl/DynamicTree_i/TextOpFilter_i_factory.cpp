////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TextOpFilter_i_factory.cpp"
// C++ Interface Factories implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::TextOpFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TextOpFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TextOpFilter_i.h"

namespace GblAdapterLib {

TextOpFilter_i_factory::TextOpFilter_i_factory () {
}

void TextOpFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TextOptFilterFactoryManager::register_factory (this, priority);
}

const char* TextOpFilter_i_factory::key () const {
	return "TextOpFilter_i";
}

TextOptFilter* TextOpFilter_i_factory::make () {
	TextOpFilter_i_var ret = new TextOpFilter_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

