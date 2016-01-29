////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/RefDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::RefDocument
//
// Документ с http ссылками
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/RefDocument.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RefDocument::RefDocument (const GCD::PID& pid, const char* name)
//#UC START# *52286E8200D9_BASE_INIT*
: Document_i(name)
, DocumentMaster (pid, name)
, SimpleDocument (0)
//#UC END# *52286E8200D9_BASE_INIT*
{
	//#UC START# *52286E8200D9_BODY*
	//#UC END# *52286E8200D9_BODY*
}

RefDocument::RefDocument (GblPilot::Document* document)
//#UC START# *5227269E001E_BASE_INIT*
: Document_i(document)
, DocumentMaster (document)
, SimpleDocument (document)
//#UC END# *5227269E001E_BASE_INIT*
{
	//#UC START# *5227269E001E_BODY*
	//#UC END# *5227269E001E_BODY*
}

RefDocument::~RefDocument () {
	//#UC START# *5227264A0175_DESTR_BODY*
	//#UC END# *5227264A0175_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
DocumentType RefDocument::get_doc_type () const {
	//#UC START# *460B80CF0201_5227264A0175_GET*
	return DT_REF;
	//#UC END# *460B80CF0201_5227264A0175_GET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

