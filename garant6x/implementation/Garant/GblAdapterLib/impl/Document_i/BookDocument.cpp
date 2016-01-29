////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::BookDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookDocument.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BookDocument::BookDocument (const GCD::PID& pid, const char* name)
//#UC START# *53E9F4E1012B_BASE_INIT*
	: Document_i(name)
	, DocumentMaster (pid, name)
//#UC END# *53E9F4E1012B_BASE_INIT*
{
	//#UC START# *53E9F4E1012B_BODY*
	//#UC END# *53E9F4E1012B_BODY*
}

BookDocument::BookDocument (GblPilot::Document* document)
//#UC START# *53E9F4D70079_BASE_INIT*
	: Document_i(document)
	, DocumentMaster (document)
//#UC END# *53E9F4D70079_BASE_INIT*
{
	//#UC START# *53E9F4D70079_BODY*
	//#UC END# *53E9F4D70079_BODY*
}

BookDocument::~BookDocument () {
	//#UC START# *53E9F492021F_DESTR_BODY*
	//#UC END# *53E9F492021F_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
DocumentType BookDocument::get_doc_type () const {
	//#UC START# *460B80CF0201_53E9F492021F_GET*
	return DT_BOOK;
	//#UC END# *460B80CF0201_53E9F492021F_GET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

