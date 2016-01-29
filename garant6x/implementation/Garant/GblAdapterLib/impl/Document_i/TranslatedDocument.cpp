////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::TranslatedDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TranslatedDocument::TranslatedDocument (GblPilot::Document* document)
//#UC START# *4610D40C010F_BASE_INIT*
	: Document_i(document)
	, DocumentMaster (document)
	, SimpleDocument (document)
//#UC END# *4610D40C010F_BASE_INIT*
{
	//#UC START# *4610D40C010F_BODY*
	//#UC END# *4610D40C010F_BODY*
}

TranslatedDocument::~TranslatedDocument () {
	//#UC START# *4610D2060105_DESTR_BODY*
	//#UC END# *4610D2060105_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
// Присутствие предупреждения.
bool TranslatedDocument::has_warning () const {
	//#UC START# *45EEB65201CA_4610D2060105*
	return this->Document_i::has_warning ();
	//#UC END# *45EEB65201CA_4610D2060105*
}

// overloaded method from Document
// Предупреждение к документу.
const GCI::IO::String& TranslatedDocument::get_warning () const {
	//#UC START# *45EEB65201E5_4610D2060105_GET*
	return this->Document_i::get_warning ();
	//#UC END# *45EEB65201E5_4610D2060105_GET*
}

GCI::IO::String& TranslatedDocument::get_warning () {
	return const_cast<GCI::IO::String&>(((const TranslatedDocument*)this)->get_warning ());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

